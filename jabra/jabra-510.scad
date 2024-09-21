// Jabra Speak 510

function jabra510_footplate_diameter() = 96; // mm
function jabra510_footplate_edge_thickness() = 5; // hard to measure precisely because of soft material
function jabra510_groove_diameter() = 71;
function jabra510_groove_height() = 5;

function jabra510_holder_baseplate_thickness() = 3;
function jabra510_footplate_holder_thickness() = 2;
function jabra510_footplate_holder_groove_depth() = 4;

function jabra510_footplate_holder_tolerance_x() = 0.5; // provide somewhat loose fit
function jabra510_footplate_holder_tolerance_y() = 0.2; // provide somewhat loose fit

footplate_radius = jabra510_footplate_diameter() / 2 + jabra510_footplate_holder_tolerance_x();
hollow_footplate_outer_skirt_width = 10;
hollow_footplate_spoke_width = 10;

module jabra510_footplate_holder_cross_section() {    
    clamp_section_width = jabra510_footplate_holder_groove_depth() + jabra510_footplate_holder_thickness();
    clamp_section_x = footplate_radius - jabra510_footplate_holder_groove_depth();
    clamp_section_y = jabra510_holder_baseplate_thickness() + jabra510_footplate_edge_thickness() + jabra510_footplate_holder_tolerance_y();
    
    union() {
        translate([footplate_radius, 0, 0]) square([jabra510_footplate_holder_thickness(), clamp_section_y]);
        translate([clamp_section_x, clamp_section_y, 0]) square([clamp_section_width, jabra510_footplate_holder_thickness()]);
    }
}

module jabra510_footplate_cutout() {
    r = footplate_radius - hollow_footplate_outer_skirt_width;
    
    difference() {
        circle(r = r);
        square([2 * r, hollow_footplate_spoke_width], center = true);
        square([hollow_footplate_spoke_width, 2 * r], center = true);
    }
}

module jabra510_hollow_footplate() {
    r = footplate_radius + 0.1; // resolve 'Object may not be a valid 2-manifold and may need repair' issue

    linear_extrude(jabra510_holder_baseplate_thickness())
    difference() {
        circle(r = r);
        jabra510_footplate_cutout();
    }
}

module jabra510_footplate_holder() {
    union() {
        jabra510_hollow_footplate();
        rotate_extrude(angle = 180) jabra510_footplate_holder_cross_section();
    }
}

jabra510_footplate_holder();
