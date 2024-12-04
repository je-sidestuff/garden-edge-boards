//////////////////////////////////////////////////////////////////////
//
// Filename: garden_edge_board_holder_builder.scad
//   The garden edge board holder joins multiple boards together at an edge post.
//   The post may be anchored to the ground with rebar or a dowel through a conduit.
//   The _lib.scad provides the methods needed to create the assemblies.
// Author:
//   Jordan Edsall
// Date:
//   2024-09-18
// License:
//   https://opensource.org/licenses/MIT
//
//////////////////////////////////////////////////////////////////////

include <garden_edge_board_holder_lib.scad>
include <garden_edge_board_holder_presets.scad>

// Variables

/*[Select Component to Build]*/
// This value selects the component to build.
geb_component_to_build = "Board Holder Tongue"; //["Board Holder Tongue", "Post with Grooves", "Assembly Shell"]

/*[Select Built-in Preset]*/
// This value selects from the options for fully defined configs.
geb_builtin_preset = "v_001_1_by_6"; //["v_001_1_by_6", "v_001_1_by_6_planner", "v_001_1_by_6_tiny_planner"]

echo("Building")
echo(geb_component_to_build)
echo("with preset")
echo(geb_builtin_preset)

if (geb_component_to_build == "Board Holder Tongue") {
    if (geb_builtin_preset == "v_001_1_by_6") {
        gebp_v0011b6_board_holder();
    }
    if (geb_builtin_preset == "v_001_1_by_6_planner") {
        gebp_v0011b6pln_board_holder();
    }
    if (geb_builtin_preset == "v_001_1_by_6_tiny_planner") {
        gebp_v0011b6tpln_board_holder();
    }
}
if (geb_component_to_build == "Post with Grooves") {
    if (geb_builtin_preset == "v_001_1_by_6") {
        gebp_v0011b6_board_holder_simple_post();
    }
    if (geb_builtin_preset == "v_001_1_by_6_planner") {
        gebp_v0011b6pln_board_holder_simple_post();
    }
    if (geb_builtin_preset == "v_001_1_by_6_tiny_planner") {
        gebp_v0011b6tpln_board_holder_simple_post();
    }
}
if (geb_component_to_build == "Assembly Shell") {
    if (geb_builtin_preset == "v_001_1_by_6") {
        gebp_v0011b6_board_holder_post_shell();
    }
    if (geb_builtin_preset == "v_001_1_by_6_planner") {
        gebp_v0011b6pln_board_holder_post_shell();
    }
    if (geb_builtin_preset == "v_001_1_by_6_tiny_planner") {
        gebp_v0011b6tpln_board_holder_post_shell();
    }
}
