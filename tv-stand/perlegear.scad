// Perlegear TV Stand Rollable TV Trolley for 13-50 Inch TVs with 30° Tilt,
// https://www.amazon.de/dp/B0BPG8PY1R
// --------------------------------------------------------

function perlegear_upper_tube_diameter() = 38;
function perlegear_upper_tube_bore_distance() = 40;
function perlegear_upper_tube_bore_diameter() = 7;

function perlegear_screw_mount_width() = 12;
function perlegear_screw_mount_thickness() = 8;
function perlegear_screw_mount_carve_depth() = 1;
function perlegear_screw_mount_overhang() = 15;

module perlegear_upper_tube_screw_mount_2d_shape() {
    w = perlegear_screw_mount_width();  
    d = perlegear_upper_tube_bore_diameter();
    overhang = perlegear_screw_mount_overhang();
    distance = perlegear_upper_tube_bore_distance() + overhang;

    translate([0, w / 2, 0]) {
        difference() {
            hull() {
                square(w, center=true);
                translate([0, distance, 0]) circle(d = w);
            }
            translate([0, overhang, 0]) circle(d = d);
            translate([0, distance, 0]) circle(d = d);
        }
    }
}

module perlegear_upper_tube_screw_mount_base() {
    linear_extrude(perlegear_screw_mount_thickness()) {
        perlegear_upper_tube_screw_mount_2d_shape();
    }
}

module perlegear_upper_tube() {
    h = perlegear_upper_tube_bore_distance() + perlegear_screw_mount_overhang() + perlegear_screw_mount_width();
    
    rotate([-90, 0, 0])
    cylinder(h = h, d = perlegear_upper_tube_diameter());
}

module perlegear_upper_tube_screw_mount() {
    h = perlegear_upper_tube_bore_distance() + perlegear_screw_mount_overhang() + perlegear_screw_mount_width();
    
    tube_z = perlegear_screw_mount_carve_depth() - perlegear_upper_tube_diameter() / 2;
    
    difference() {
        perlegear_upper_tube_screw_mount_base();
        translate([0, 0, tube_z]) perlegear_upper_tube();
    }
}

perlegear_upper_tube_screw_mount();