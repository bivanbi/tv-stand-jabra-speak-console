use <perlegear_jabra510.scad>

$fn = 100;

translate([extension_arm_w() / 2, extension_arm_length() / 2, 0]) rotate([0, 0, 90]) extension_arm();
