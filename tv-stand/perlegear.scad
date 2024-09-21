// Perlegear TV Stand Rollable TV Trolley for 13-50 Inch TVs with 30° Tilt,
// https://www.amazon.de/dp/B0BPG8PY1R
// --------------------------------------------------------

function perlegear_upper_tube_diameter() = 38;
function perlegear_upper_tube_bore_distance() = 40;
function perlegear_upper_tube_bore_diameter() = 7;
function perlegear_screw_mount_tube_carve_depth() = 1;

function perlegear_screw_mount_default_width() = 12;
function perlegear_screw_mount_default_thickness() = 10;

module perlegear_screw_mount_2d_shape(
    w = perlegear_screw_mount_default_width(),
    o = 0, // top overhang
    u = 0  // bottom overhang
) {
    d = perlegear_upper_tube_bore_diameter();
    o = o + perlegear_upper_tube_bore_distance();

    difference() {
        hull() {
            translate([0, -u, 0]) circle(d = w);
            translate([0, o, 0]) circle(d = w);
        }
        translate([0, 0, 0]) circle(d = d); // bottom bore
        translate([0, perlegear_upper_tube_bore_distance(), 0]) circle(d = d); // top bore
    }
}

module perlegear_screw_mount_base(
    w = perlegear_screw_mount_default_width(),
    t = perlegear_screw_mount_default_thickness(),
    o = 0, // top overhang
    u = 0  // bottom overhang
){
    linear_extrude(t) {
        perlegear_screw_mount_2d_shape(w = w, o = o, u = u);
    }
}

module perlegear_upper_tube(h){
    z = perlegear_screw_mount_tube_carve_depth() - perlegear_upper_tube_diameter() / 2;

    translate([0, 0, z])
        rotate([-90, 0, 0])
            cylinder(h = h, d = perlegear_upper_tube_diameter());
}

module perlegear_screw_mount(
    w = perlegear_screw_mount_default_width(),
    t = perlegear_screw_mount_default_thickness(),
    o = 0, // top overhang
    u = 0  // bottom overhang
){
    h = w + perlegear_upper_tube_bore_distance() + u + o;
    y_offset = w / 2 + u;

    difference() {
        translate([0, y_offset, 0])
        perlegear_screw_mount_base(w = w, t = t, o = o, u = u);
        perlegear_upper_tube(h = h);
    }
}

perlegear_screw_mount();
translate([30, 0, 0]) perlegear_screw_mount(o = 10);
translate([60, 0, 0]) perlegear_screw_mount(u = 10);
translate([90, 0, 0]) perlegear_screw_mount(o = 10, u = 10);
