use <../../tv-stand/perlegear.scad>
use <../../jabra/jabra-510.scad>

w = 12;
function extension_arm_length() = 60;
function extension_arm_w() = w;
function extension_arm_h() = 12;
function extension_arm_margin_top() = 4;
function extension_arm_margin_bottom() = 6;

function perlegear_mount_w() = w;
function perlegear_mount_t() = 14;
function perlegear_mount_u() = extension_arm_h() + extension_arm_margin_top() + extension_arm_margin_bottom();

function extension_groove_depth() = 3;
function safety_pin_d() = 3;

function jabra_swivel_bore_d() = 3;
function jabra_swivel_overhang() = 1;
function jabra_arm_hook_stretch() = 10;
function jabra_arm_hook_center_x() = extension_arm_h() / 2;
function jabra_arm_hook_center_y() = extension_arm_h() / 2 + jabra_arm_hook_stretch();

module perlegear_mount() {
    mount_offset_y = - extension_arm_h() / 2 - extension_arm_margin_bottom();
    translate([0, mount_offset_y, 0])
        perlegear_screw_mount(w = perlegear_mount_w(), t = perlegear_mount_t(), u = perlegear_mount_u());
}

module perlegear_mount_w_extension_groove() {
    x = extension_groove_depth();
    y = extension_arm_h();
    z = perlegear_mount_t();
    
    offset_x = w / 2 - extension_groove_depth() / 2;
    offset_z = perlegear_mount_t() / 2;
    
    pin_h = w;
    pin_offset_x = -w / 2;
    pin_offset_z = perlegear_mount_t() / 2;
    
    difference() {
        perlegear_mount();
        translate([-offset_x, 0, offset_z]) cube([x, y, z], center = true); 
        translate([offset_x, 0, offset_z]) cube([x, y, z], center = true);
        
        translate([pin_offset_x, 0, pin_offset_z])
            rotate([0, 90, 0]) cylinder(h = pin_h, d = safety_pin_d());
    }
}

module extension_arm_2d_shape() {
    perlegear_cutout_y = perlegear_mount_w() - 2 * extension_groove_depth();
    cutout_offset_x = extension_arm_length() / 2 - perlegear_mount_t() / 2;

    difference() {
        square([extension_arm_length(), extension_arm_w()], center = true);
        translate([-cutout_offset_x, 0, 0])
            square([perlegear_mount_t(), perlegear_cutout_y], center = true);
    }
}

module extension_arm_jabra_end() {
    swivel_d = extension_arm_h();
    swivel_offset_x = swivel_d / 2 + jabra_swivel_overhang();
    swivel_w = extension_arm_w() - 2 * extension_groove_depth();

    rotate([90, 0, 0])
        linear_extrude(swivel_w) {
            difference() {
                hull() {
                    square([1, extension_arm_h()], center = true);
                    translate([swivel_offset_x, 0, 0]) circle(d = swivel_d);
                }
                translate([swivel_offset_x, 0, 0]) circle(d = jabra_swivel_bore_d());
            }
        }
}

module extension_arm() {
    pin_h = extension_arm_w();
    pin_offset_x = - (extension_arm_length() - perlegear_mount_t()) / 2;
    pin_offset_y = extension_arm_h() / 2;
    pin_offset_z = extension_arm_w() / 2;

    swivel_offset_x = extension_arm_length() / 2;
    swivel_offset_y = extension_groove_depth();
   
    perlegear_tube_offset_x = perlegear_screw_mount_tube_carve_depth() - (extension_arm_length() + perlegear_upper_tube_diameter()) / 2;
    perlegear_tube_offset_z = extension_arm_h() / 2;
    
    union() {
        difference() {
            linear_extrude(extension_arm_h()) extension_arm_2d_shape();
            translate([pin_offset_x, pin_offset_y, pin_offset_z])
                rotate([90, 0, 0]) cylinder(h = pin_h, d = safety_pin_d());
            translate([perlegear_tube_offset_x, 0, perlegear_tube_offset_z]) cylinder(d = perlegear_upper_tube_diameter(), h = extension_arm_h(), center = true);

        }
        translate([swivel_offset_x, swivel_offset_y, extension_arm_w() / 2]) extension_arm_jabra_end();
    }
}


module jabra_extension_arm_hook_2d() {
    curviture_r = 13;
    curviture_offset_x = curviture_r + jabra510_holder_baseplate_thickness();
    
    difference() {
        hull() {
            square(jabra510_holder_baseplate_thickness());
            translate([jabra_arm_hook_center_x(), jabra_arm_hook_center_y(), 0]) circle(d = extension_arm_h());
        }
        translate([jabra_arm_hook_center_x(), jabra_arm_hook_center_y(), 0]) circle(d = jabra_swivel_bore_d());
        translate([curviture_offset_x, 0]) circle(r = curviture_r);
    }
}

module jabra_extension_arm_hook() {
    hook_w = extension_arm_w() - 2 * extension_groove_depth();
    reinforcement_offset = extension_groove_depth();

    translate([hook_w / 2, 0])
    rotate([0, -90, 0])
        linear_extrude(hook_w) jabra_extension_arm_hook_2d();
}

module jabra_console_extension() {
    offset_x_min = extension_arm_w() - 2 * extension_groove_depth() -3;
    hook_overlap = jabra_arm_hook_stretch();
    console_overlap_y = -15; // extension will overlap with console. Must have enough clearance though
    console_overlap_offset_x = jabra510_footplate_diameter() / 3;

    y = jabra510_footplate_holder_slide_in_clearance();
    hook_overlap_y = jabra510_footplate_holder_slide_in_clearance() + hook_overlap;

    points = [
        [-console_overlap_offset_x, console_overlap_y],
        [-offset_x_min, hook_overlap_y],
        [offset_x_min, hook_overlap_y],
        [console_overlap_offset_x, console_overlap_y]
    ];
    
    union() {
        linear_extrude(jabra510_holder_baseplate_thickness())
            difference() {
                polygon(points = points);
                translate([0, -jabra510_footplate_diameter() / 2, 0]) circle(d = jabra510_footplate_diameter());
        }
        translate([0, y, 0]) jabra_extension_arm_hook();
    }
}

module jabra510_console() {
    union() {
        rotate([0, 0, 180]) jabra510_footplate_holder();
        translate([0, jabra510_footplate_diameter() / 2, 0]) jabra_console_extension();
    }
}

translate([perlegear_mount_w() / 2, extension_arm_h(), perlegear_mount_t()]) rotate([0, 180, 0]) perlegear_mount_w_extension_groove();
translate([30, extension_arm_length() / 2, 0]) rotate([0, 0, 90]) extension_arm();

jabra510_holder_y = jabra510_footplate_diameter() / 2 + jabra510_footplate_holder_thickness();
translate([100, jabra510_holder_y, 0]) jabra510_console();
