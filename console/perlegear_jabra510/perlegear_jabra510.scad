use <../../tv-stand/perlegear.scad>
use <../../jabra/jabra-510.scad>

w = 12;
extension_arm_length = 60;
extension_arm_w = w;
extension_arm_h = 12;
extension_arm_margin_top = 4;
extension_arm_margin_bottom = 6;

perlegear_mount_w = w;
perlegear_mount_t = 14;
perlegear_mount_u = extension_arm_h + extension_arm_margin_top + extension_arm_margin_bottom;

extension_groove_depth = 3;
safety_pin_d = 3;

jabra_swivel_bore_d = 3;
jabra_swivel_overhang = 1;

module perlegear_mount() {
    mount_offset_y = - extension_arm_h / 2 - extension_arm_margin_bottom;
    translate([0, mount_offset_y, 0])
        perlegear_screw_mount(w = perlegear_mount_w, t = perlegear_mount_t, u = perlegear_mount_u);
}

module perlegear_mount_w_extension_groove() {
    x = extension_groove_depth;
    y = extension_arm_h;
    z = perlegear_mount_t;
    
    offset_x = w / 2 - extension_groove_depth / 2;
    offset_z = perlegear_mount_t / 2;
    
    pin_h = w;
    pin_offset_x = -w / 2;
    pin_offset_z = perlegear_mount_t / 2;
    
    difference() {
        perlegear_mount();
        translate([-offset_x, 0, offset_z]) cube([x, y, z], center = true); 
        translate([offset_x, 0, offset_z]) cube([x, y, z], center = true);
        
        translate([pin_offset_x, 0, pin_offset_z])
            rotate([0, 90, 0]) cylinder(h = pin_h, d = safety_pin_d);
    }
}

module extension_arm_2d_shape() {
    perlegear_cutout_y = perlegear_mount_w - 2 * extension_groove_depth;
    cutout_offset_x = extension_arm_length / 2 - perlegear_mount_t / 2;

    difference() {
        square([extension_arm_length, extension_arm_w], center = true);
        translate([-cutout_offset_x, 0, 0])
            square([perlegear_mount_t, perlegear_cutout_y], center = true);
    }
}

module extension_arm_jabra_end() {
    swivel_d = extension_arm_h;
    swivel_offset_x = swivel_d / 2 + jabra_swivel_overhang;
    swivel_w = extension_arm_w - 2 * extension_groove_depth;

    rotate([90, 0, 0])
        linear_extrude(swivel_w) {
            difference() {
                hull() {
                    square([1, extension_arm_h], center = true);
                    translate([swivel_offset_x, 0, 0]) circle(d = swivel_d);
                }
                translate([swivel_offset_x, 0, 0]) circle(d = jabra_swivel_bore_d);
            }
        }
}

module extension_arm() {
    pin_h = extension_arm_w;
    pin_offset_x = - (extension_arm_length - perlegear_mount_t) / 2;
    pin_offset_y = extension_arm_h / 2;
    pin_offset_z = extension_arm_w / 2;

    swivel_offset_x = extension_arm_length / 2;
    swivel_offset_y = extension_groove_depth;
    
    union() {
        difference() {
            linear_extrude(extension_arm_h) extension_arm_2d_shape();
            translate([pin_offset_x, pin_offset_y, pin_offset_z])
                rotate([90, 0, 0]) cylinder(h = pin_h, d = safety_pin_d);
        }
        translate([swivel_offset_x, swivel_offset_y, extension_arm_w / 2]) extension_arm_jabra_end();
    }
}

module jabra510_console() {
    rotate([0, 0, 180]) jabra510_footplate_holder();
}

translate([perlegear_mount_w / 2, extension_arm_h, perlegear_mount_t]) rotate([0, 180, 0]) perlegear_mount_w_extension_groove();
translate([30, extension_arm_length / 2, 0]) rotate([0, 0, 90]) extension_arm();

translate([100, jabra510_footplate_diameter() / 2 + jabra510_footplate_holder_thickness(), 0]) jabra510_console();
