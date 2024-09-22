use <perlegear_jabra510.scad>

$fn = 100;
arm_offset_y = extension_arm_margin_bottom();
arm_offset_z = extension_arm_length() / 2;

// rotate jabra console around hook bore for easy showcase
center_rotation_y = - (extension_arm_length() + jabra_arm_hook_stretch() + 14);
center_rotation_z = - extension_arm_h() / 2;
center_rotation_to_jabra_console_hook = [0, center_rotation_y, center_rotation_z];

rotate = -55; // degrees

jabra_console_offset_z = extension_arm_length() + extension_arm_h() / 2 + jabra_swivel_overhang(); 

color("orange")
    perlegear_mount_w_extension_groove();

color("gray") 
    translate([0, arm_offset_y, extension_arm_length() / 2])
    rotate([90, -90, 0])
    extension_arm();

color("pink")
    translate([0,  0, jabra_console_offset_z]) 
    rotate([rotate, 0, 0,])
    translate(center_rotation_to_jabra_console_hook)
    jabra_console();
