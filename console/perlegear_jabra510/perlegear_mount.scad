use <perlegear_jabra510.scad>

$fn = 100;

translate([perlegear_mount_w() / 2, extension_arm_h(), perlegear_mount_t()]) rotate([0, 180, 0]) perlegear_mount_w_extension_groove();
