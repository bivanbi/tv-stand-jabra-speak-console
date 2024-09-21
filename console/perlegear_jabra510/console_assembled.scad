use <perlegear_jabra510.scad>

$fn = 100;
arm_offset_y = extension_arm_margin_bottom();
arm_offset_z = extension_arm_length() / 2;

jabra_console_offset_y = - jabra_swivel_bore_center_y_offset();
jabra_console_offset_z = extension_arm_length() + jabra_swivel_overhang();

color("orange") perlegear_mount_w_extension_groove();

color("gray") 
translate([0, arm_offset_y, extension_arm_length() / 2])
rotate([90, -90, 0])
extension_arm();

function jabra_swivel_bore_center_y_offset() = extension_arm_length() + jabra_arm_hook_stretch() + 14;

translate([0, jabra_console_offset_y, jabra_console_offset_z]) color("lightblue") jabra_console();
