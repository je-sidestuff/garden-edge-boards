//////////////////////////////////////////////////////////////////////
//
// Filename: garden_edge_board_holder_presets.scad
//   The garden edge board holder joins multiple boards together at an edge post.
//   The post may be anchored to the ground with rebar or a dowel through a conduit.
//   The _presets.scad provides sets of constant values for size presets.
// Author:
//   Jordan Edsall
// Date:
//   2024-09-18
// License:
//   https://opensource.org/licenses/MIT
//
//////////////////////////////////////////////////////////////////////

include <garden_edge_board_holder_lib.scad>

////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////// v0.0.1 1-by-6
////////////////////////////////////////////////////////////////////////////////////////////////////////

gebp_v0011b6_mating_gap = 0.975;

// Non-printed component variables
gebp_v0011b6_board_width = 1_by_6_width;
gebp_v0011b6_board_width_gap = 0.625;
gebp_v0011b6_board_height = 1_by_6_height;
gebp_v0011b6_board_height_gap = 0.9375;

gebp_v0011b6_mate_dowel_radius = 3_8th_inch_dowel_radius;
gebp_v0011b6_mate_dowel_gap = 0.225;

// Structure Variables
gebp_v0011b6_holder_hollow_delta = 10;
gebp_v0011b6_holder_width = gebp_v0011b6_board_width + 20;
gebp_v0011b6_holder_height = gebp_v0011b6_board_height + 16;
gebp_v0011b6_holder_transition_board_depth = 15;
gebp_v0011b6_holder_flat_board_depth = 45;
gebp_v0011b6_holder_board_backing_depth = 5;
gebp_v0011b6_holder_post_backing_width = 60;
gebp_v0011b6_holder_post_backing_depth = 12.5;
gebp_v0011b6_holder_body_depth = gebp_v0011b6_holder_transition_board_depth + gebp_v0011b6_holder_flat_board_depth + gebp_v0011b6_holder_board_backing_depth;
gebp_v0011b6_holder_wall_thickness = 1;

// Tongue Variables
gebp_v0011b6_tongue_start_depth = 20;
gebp_v0011b6_tongue_front_depth = 50;
gebp_v0011b6_tongue_back_depth = 40;
gebp_v0011b6_tongue_start_width = gebp_v0011b6_holder_post_backing_width * 0.45;
gebp_v0011b6_tongue_front_width = gebp_v0011b6_holder_post_backing_width * 0.2;
gebp_v0011b6_tongue_back_width = gebp_v0011b6_holder_post_backing_width * 0.35;
gebp_v0011b6_tongue_start_height = gebp_v0011b6_tongue_start_depth;
gebp_v0011b6_tongue_back_height = gebp_v0011b6_holder_height - 2*gebp_v0011b6_tongue_start_height;
gebp_v0011b6_tongue_front_height = gebp_v0011b6_tongue_back_height * 0.4;

// Groove Variables
gebp_v0011b6_groove_connector_depth = gebp_v0011b6_tongue_front_depth + 5;
gebp_v0011b6_groove_start_depth = gebp_v0011b6_tongue_start_depth;
gebp_v0011b6_groove_front_depth = gebp_v0011b6_tongue_back_depth;
gebp_v0011b6_groove_back_depth = gebp_v0011b6_tongue_front_depth;
gebp_v0011b6_groove_front_width = gebp_v0011b6_tongue_back_width;
gebp_v0011b6_groove_back_width = gebp_v0011b6_tongue_front_width;
gebp_v0011b6_groove_front_height = gebp_v0011b6_tongue_back_height;
gebp_v0011b6_groove_back_height = gebp_v0011b6_tongue_front_height;

// Post Variables
gebp_v0011b6_post_fill_strategy = "braced"; // Allowed values are 'filled', 'hollow', and 'braced'
gebp_v0011b6_post_fill_brace_thickness = 0.15;

gebp_v0011b6_connector_toptube_inner_radius = 12;
gebp_v0011b6_connector_toptube_depth = 15;
gebp_v0011b6_connector_midtube_inner_radius = 8;
gebp_v0011b6_connector_transition_depth = 15;
gebp_v0011b6_connector_offset = 15;
gebp_v0011b6_connector_tooth_intrusion = (gebp_v0011b6_connector_toptube_inner_radius - gebp_v0011b6_connector_midtube_inner_radius) * 0.4;
gebp_v0011b6_connector_tooth_width = 4;

// Shell Variables
gebp_v0011b6_shell_wall_thickness = 1;

module gebp_v0011b6_board_holder(
        bh_body_depth = gebp_v0011b6_holder_body_depth,
        bh_width = gebp_v0011b6_holder_width,
        bh_height = gebp_v0011b6_holder_height,
        bh_trans_hollow_depth = gebp_v0011b6_holder_transition_board_depth,
        bh_flat_hollow_depth = gebp_v0011b6_holder_flat_board_depth,
        bh_hollow_width = gebp_v0011b6_board_width + gebp_v0011b6_board_width_gap,
        bh_hollow_height = gebp_v0011b6_board_height + gebp_v0011b6_board_height_gap,
        bh_hollow_delta = gebp_v0011b6_holder_hollow_delta,
        bh_post_backing_depth = gebp_v0011b6_holder_post_backing_depth,
        bh_post_backing_width = gebp_v0011b6_holder_post_backing_width,
        bh_tongue_start_depth = gebp_v0011b6_tongue_start_depth,
        bh_tongue_back_depth = gebp_v0011b6_tongue_back_depth,
        bh_tongue_front_depth = gebp_v0011b6_tongue_front_depth,
        bh_tongue_back_width = gebp_v0011b6_tongue_back_width,
        bh_tongue_front_width = gebp_v0011b6_tongue_front_width,
        bh_tongue_back_height = gebp_v0011b6_tongue_back_height,
        bh_tongue_front_height = gebp_v0011b6_tongue_front_height,
        bh_mating_gap = gebp_v0011b6_mating_gap,
        bh_dowel_cutout_radius = gebp_v0011b6_mate_dowel_radius + gebp_v0011b6_mate_dowel_gap
        ) {

    geb_board_holder(
        bh_body_depth = bh_body_depth,
        bh_width = bh_width,
        bh_height = bh_height,
        bh_trans_hollow_depth = bh_trans_hollow_depth,
        bh_flat_hollow_depth = bh_flat_hollow_depth,
        bh_hollow_width = bh_hollow_width,
        bh_hollow_height = bh_hollow_height,
        bh_hollow_delta = bh_hollow_delta,
        bh_post_backing_depth = bh_post_backing_depth,
        bh_post_backing_width = bh_post_backing_width,
        bh_tongue_start_depth = bh_tongue_start_depth,
        bh_tongue_back_depth = bh_tongue_back_depth,
        bh_tongue_front_depth = bh_tongue_front_depth,
        bh_tongue_back_width = bh_tongue_back_width,
        bh_tongue_front_width = bh_tongue_front_width,
        bh_tongue_back_height = bh_tongue_back_height,
        bh_tongue_front_height = bh_tongue_front_height,
        bh_mating_gap = bh_mating_gap,
        bh_dowel_cutout_radius = bh_dowel_cutout_radius
        );
}

module gebp_v0011b6_board_holder_simple_post(
        bsp_groove_connector_depth = gebp_v0011b6_groove_connector_depth,
        bsp_connector_offset = gebp_v0011b6_connector_offset,
        bsp_width = gebp_v0011b6_holder_post_backing_width,
        bsp_height = gebp_v0011b6_holder_height,
        bsp_groove_start_depth = gebp_v0011b6_groove_start_depth,
        bsp_groove_front_depth = gebp_v0011b6_groove_front_depth,
        bsp_groove_back_depth = gebp_v0011b6_groove_back_depth,
        bsp_groove_front_width = gebp_v0011b6_groove_front_width,
        bsp_groove_back_width = gebp_v0011b6_groove_back_width,
        bsp_groove_front_height = gebp_v0011b6_groove_front_height,
        bsp_groove_back_height = gebp_v0011b6_groove_back_height,
        bsp_mating_gap = gebp_v0011b6_mating_gap,
        bsp_dowel_cutout_radius = gebp_v0011b6_mate_dowel_radius + gebp_v0011b6_mate_dowel_gap,
        bsp_post_angles = [0, 90],
        bsp_toptube_inner_radius = gebp_v0011b6_connector_toptube_inner_radius,
        bsp_toptube_depth = gebp_v0011b6_connector_toptube_depth,
        bsp_midtube_inner_radius = gebp_v0011b6_connector_midtube_inner_radius,
        bsp_transition_depth = gebp_v0011b6_connector_transition_depth,
        bsp_wall_thickness = gebp_v0011b6_holder_wall_thickness) {

    geb_board_holder_simple_post(
        bsp_groove_connector_depth = bsp_groove_connector_depth,
        bsp_connector_offset = bsp_connector_offset,
        bsp_width = bsp_width,
        bsp_height = bsp_height,
        bsp_groove_start_depth = bsp_groove_start_depth,
        bsp_groove_front_depth = bsp_groove_front_depth,
        bsp_groove_back_depth = bsp_groove_back_depth,
        bsp_groove_front_width = bsp_groove_front_width,
        bsp_groove_back_width = bsp_groove_back_width,
        bsp_groove_front_height = bsp_groove_front_height,
        bsp_groove_back_height = bsp_groove_back_height,
        bsp_mating_gap = bsp_mating_gap,
        bsp_dowel_cutout_radius = bsp_dowel_cutout_radius,
        bsp_post_angles = bsp_post_angles,
        bsp_toptube_inner_radius = bsp_toptube_inner_radius,
        bsp_toptube_depth = bsp_toptube_depth,
        bsp_midtube_inner_radius = bsp_midtube_inner_radius,
        bsp_transition_depth = bsp_transition_depth,
        bsp_wall_thickness = bsp_wall_thickness);
}

module gebp_v0011b6_board_holder_post_shell(
        bps_width = gebp_v0011b6_holder_post_backing_width,
        bps_height = gebp_v0011b6_holder_height,
        bps_connector_offset = gebp_v0011b6_connector_offset,
        bh_width = gebp_v0011b6_holder_width,
        bh_height = gebp_v0011b6_holder_height,
        bh_post_backing_depth = gebp_v0011b6_holder_post_backing_depth,
        bps_mating_gap = gebp_v0011b6_mating_gap,
        bps_groove_body_depth = gebp_v0011b6_groove_connector_depth,
        bps_post_angles = [0, 90],
        bps_shell_thickness = gebp_v0011b6_shell_wall_thickness
        ) {

    geb_board_holder_post_shell(
        bps_width = bps_width,
        bps_height = bps_height,
        bps_connector_offset = bps_connector_offset,
        bh_width = bh_width,
        bh_height = bh_height,
        bh_post_backing_depth = bh_post_backing_depth,
        bps_mating_gap = bps_mating_gap,
        bps_groove_body_depth = bps_groove_body_depth,
        bps_post_angles = bps_post_angles,
        bps_shell_thickness = bps_shell_thickness
        );
}

////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////// v0.0.1 1-by-6 planner (1/6 scale)
////////////////////////////////////////////////////////////////////////////////////////////////////////

gebp_v0011b6pln_mating_gap = 0.25;

// Non-printed component variables
gebp_v0011b6pln_board_width = 1_by_6_width/6;
gebp_v0011b6pln_board_width_gap = 0.3125;
gebp_v0011b6pln_board_height = 1_by_6_height/6;
gebp_v0011b6pln_board_height_gap = 0.375;

gebp_v0011b6pln_mate_dowel_radius = 1;
gebp_v0011b6pln_mate_dowel_gap = 0.225;

// Structure Variables
gebp_v0011b6pln_holder_hollow_delta = 2;
gebp_v0011b6pln_holder_width = gebp_v0011b6pln_board_width + 20/6;
gebp_v0011b6pln_holder_height = gebp_v0011b6pln_board_height + 16/6;
gebp_v0011b6pln_holder_transition_board_depth = 15/6;
gebp_v0011b6pln_holder_flat_board_depth = 45/6;
gebp_v0011b6pln_holder_board_backing_depth = 1;
gebp_v0011b6pln_holder_post_backing_width = 60/6;
gebp_v0011b6pln_holder_post_backing_depth = 12.5/6;
gebp_v0011b6pln_holder_body_depth = gebp_v0011b6pln_holder_transition_board_depth + gebp_v0011b6pln_holder_flat_board_depth + gebp_v0011b6pln_holder_board_backing_depth;
gebp_v0011b6pln_holder_wall_thickness = 1;

// Tongue Variables
gebp_v0011b6pln_tongue_start_depth = 20/6;
gebp_v0011b6pln_tongue_front_depth = 50/6;
gebp_v0011b6pln_tongue_back_depth = 40/6;
gebp_v0011b6pln_tongue_start_width = gebp_v0011b6pln_holder_post_backing_width * 0.45;
gebp_v0011b6pln_tongue_front_width = gebp_v0011b6pln_holder_post_backing_width * 0.2;
gebp_v0011b6pln_tongue_back_width = gebp_v0011b6pln_holder_post_backing_width * 0.35;
gebp_v0011b6pln_tongue_start_height = gebp_v0011b6pln_tongue_start_depth;
gebp_v0011b6pln_tongue_back_height = gebp_v0011b6pln_holder_height - 2*gebp_v0011b6pln_tongue_start_height;
gebp_v0011b6pln_tongue_front_height = gebp_v0011b6pln_tongue_back_height * 0.4;

// Groove Variables
gebp_v0011b6pln_groove_connector_depth = gebp_v0011b6pln_tongue_front_depth + 1;
gebp_v0011b6pln_groove_start_depth = gebp_v0011b6pln_tongue_start_depth;
gebp_v0011b6pln_groove_front_depth = gebp_v0011b6pln_tongue_back_depth;
gebp_v0011b6pln_groove_back_depth = gebp_v0011b6pln_tongue_front_depth;
gebp_v0011b6pln_groove_front_width = gebp_v0011b6pln_tongue_back_width;
gebp_v0011b6pln_groove_back_width = gebp_v0011b6pln_tongue_front_width;
gebp_v0011b6pln_groove_front_height = gebp_v0011b6pln_tongue_back_height;
gebp_v0011b6pln_groove_back_height = gebp_v0011b6pln_tongue_front_height;

// Post Variables
gebp_v0011b6pln_post_fill_strategy = "fiilled"; // Allowed values are 'filled', 'hollow', and 'braced'
gebp_v0011b6pln_post_fill_brace_thickness = 0.15;

gebp_v0011b6pln_connector_toptube_inner_radius = 12/6;
gebp_v0011b6pln_connector_toptube_depth = 15/6;
gebp_v0011b6pln_connector_midtube_inner_radius = 8/6;
gebp_v0011b6pln_connector_transition_depth = 15/6;
gebp_v0011b6pln_connector_offset = 15/6;
gebp_v0011b6pln_connector_tooth_intrusion = (gebp_v0011b6pln_connector_toptube_inner_radius - gebp_v0011b6pln_connector_midtube_inner_radius) * 0.4;
gebp_v0011b6pln_connector_tooth_width = 4/6;

// Shell Variables
gebp_v0011b6pln_shell_wall_thickness = 1;

module gebp_v0011b6pln_board_holder(
        bh_body_depth = gebp_v0011b6pln_holder_body_depth,
        bh_width = gebp_v0011b6pln_holder_width,
        bh_height = gebp_v0011b6pln_holder_height,
        bh_trans_hollow_depth = gebp_v0011b6pln_holder_transition_board_depth,
        bh_flat_hollow_depth = gebp_v0011b6pln_holder_flat_board_depth,
        bh_hollow_width = gebp_v0011b6pln_board_width + gebp_v0011b6pln_board_width_gap,
        bh_hollow_height = gebp_v0011b6pln_board_height + gebp_v0011b6pln_board_height_gap,
        bh_hollow_delta = gebp_v0011b6pln_holder_hollow_delta,
        bh_post_backing_depth = gebp_v0011b6pln_holder_post_backing_depth,
        bh_post_backing_width = gebp_v0011b6pln_holder_post_backing_width,
        bh_tongue_start_depth = gebp_v0011b6pln_tongue_start_depth,
        bh_tongue_back_depth = gebp_v0011b6pln_tongue_back_depth,
        bh_tongue_front_depth = gebp_v0011b6pln_tongue_front_depth,
        bh_tongue_back_width = gebp_v0011b6pln_tongue_back_width,
        bh_tongue_front_width = gebp_v0011b6pln_tongue_front_width,
        bh_tongue_back_height = gebp_v0011b6pln_tongue_back_height,
        bh_tongue_front_height = gebp_v0011b6pln_tongue_front_height,
        bh_mating_gap = gebp_v0011b6pln_mating_gap,
        bh_dowel_cutout_radius = gebp_v0011b6pln_mate_dowel_radius + gebp_v0011b6pln_mate_dowel_gap
        ) {

echo("buiiding witth bh_tongue_back_height");
echo(bh_tongue_back_height);

    geb_board_holder(
        bh_body_depth = bh_body_depth,
        bh_width = bh_width,
        bh_height = bh_height,
        bh_trans_hollow_depth = bh_trans_hollow_depth,
        bh_flat_hollow_depth = bh_flat_hollow_depth,
        bh_hollow_width = bh_hollow_width,
        bh_hollow_height = bh_hollow_height,
        bh_hollow_delta = bh_hollow_delta,
        bh_post_backing_depth = bh_post_backing_depth,
        bh_post_backing_width = bh_post_backing_width,
        bh_tongue_start_depth = bh_tongue_start_depth,
        bh_tongue_back_depth = bh_tongue_back_depth,
        bh_tongue_front_depth = bh_tongue_front_depth,
        bh_tongue_back_width = bh_tongue_back_width,
        bh_tongue_front_width = bh_tongue_front_width,
        bh_tongue_back_height = bh_tongue_back_height,
        bh_tongue_front_height = bh_tongue_front_height,
        bh_mating_gap = bh_mating_gap,
        bh_dowel_cutout_radius = bh_dowel_cutout_radius
        );
}

module gebp_v0011b6pln_board_holder_simple_post(
        bsp_groove_connector_depth = gebp_v0011b6pln_groove_connector_depth,
        bsp_connector_offset = gebp_v0011b6pln_connector_offset,
        bsp_width = gebp_v0011b6pln_holder_post_backing_width,
        bsp_height = gebp_v0011b6pln_holder_height,
        bsp_groove_start_depth = gebp_v0011b6pln_groove_start_depth,
        bsp_groove_front_depth = gebp_v0011b6pln_groove_front_depth,
        bsp_groove_back_depth = gebp_v0011b6pln_groove_back_depth,
        bsp_groove_front_width = gebp_v0011b6pln_groove_front_width,
        bsp_groove_back_width = gebp_v0011b6pln_groove_back_width,
        bsp_groove_front_height = gebp_v0011b6pln_groove_front_height,
        bsp_groove_back_height = gebp_v0011b6pln_groove_back_height,
        bsp_mating_gap = gebp_v0011b6pln_mating_gap,
        bsp_dowel_cutout_radius = gebp_v0011b6pln_mate_dowel_radius + gebp_v0011b6pln_mate_dowel_gap,
        bsp_post_angles = [0, 90],
        bsp_toptube_inner_radius = gebp_v0011b6pln_connector_toptube_inner_radius,
        bsp_toptube_depth = gebp_v0011b6pln_connector_toptube_depth,
        bsp_midtube_inner_radius = gebp_v0011b6pln_connector_midtube_inner_radius,
        bsp_transition_depth = gebp_v0011b6pln_connector_transition_depth,
        bsp_wall_thickness = gebp_v0011b6pln_holder_wall_thickness) {

    geb_board_holder_simple_post(
        bsp_groove_connector_depth = bsp_groove_connector_depth,
        bsp_connector_offset = bsp_connector_offset,
        bsp_width = bsp_width,
        bsp_height = bsp_height,
        bsp_groove_start_depth = bsp_groove_start_depth,
        bsp_groove_front_depth = bsp_groove_front_depth,
        bsp_groove_back_depth = bsp_groove_back_depth,
        bsp_groove_front_width = bsp_groove_front_width,
        bsp_groove_back_width = bsp_groove_back_width,
        bsp_groove_front_height = bsp_groove_front_height,
        bsp_groove_back_height = bsp_groove_back_height,
        bsp_mating_gap = bsp_mating_gap,
        bsp_dowel_cutout_radius = bsp_dowel_cutout_radius,
        bsp_post_angles = bsp_post_angles,
        bsp_toptube_inner_radius = bsp_toptube_inner_radius,
        bsp_toptube_depth = bsp_toptube_depth,
        bsp_midtube_inner_radius = bsp_midtube_inner_radius,
        bsp_transition_depth = bsp_transition_depth,
        bsp_wall_thickness = bsp_wall_thickness);
}

module gebp_v0011b6pln_board_holder_post_shell(
        bps_width = gebp_v0011b6pln_holder_post_backing_width,
        bps_height = gebp_v0011b6pln_holder_height,
        bps_connector_offset = gebp_v0011b6pln_connector_offset,
        bh_width = gebp_v0011b6pln_holder_width,
        bh_height = gebp_v0011b6pln_holder_height,
        bh_post_backing_depth = gebp_v0011b6pln_holder_post_backing_depth,
        bps_mating_gap = gebp_v0011b6pln_mating_gap,
        bps_groove_body_depth = gebp_v0011b6pln_groove_connector_depth,
        bps_post_angles = [0, 90],
        bps_shell_thickness = gebp_v0011b6pln_shell_wall_thickness
        ) {

    geb_board_holder_post_shell(
        bps_width = bps_width,
        bps_height = bps_height,
        bps_connector_offset = bps_connector_offset,
        bh_width = bh_width,
        bh_height = bh_height,
        bh_post_backing_depth = bh_post_backing_depth,
        bps_mating_gap = bps_mating_gap,
        bps_groove_body_depth = bps_groove_body_depth,
        bps_post_angles = bps_post_angles,
        bps_shell_thickness = bps_shell_thickness
        );
}

////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////// v0.0.1 1-by-6 tiny planner (1/12 scale)
////////////////////////////////////////////////////////////////////////////////////////////////////////

gebp_v0011b6tpln_mating_gap = 0.25;

// Non-printed component variables
gebp_v0011b6tpln_board_width = 1_by_6_width/12;
gebp_v0011b6tpln_board_width_gap = 0.3125;
gebp_v0011b6tpln_board_height = 1_by_6_height/12;
gebp_v0011b6tpln_board_height_gap = 0.375;

gebp_v0011b6tpln_mate_dowel_radius = 1;
gebp_v0011b6tpln_mate_dowel_gap = 0.225;

// Structure Variables
gebp_v0011b6tpln_holder_hollow_delta = 1.25;
gebp_v0011b6tpln_holder_width = gebp_v0011b6tpln_board_width + 20/12;
gebp_v0011b6tpln_holder_height = gebp_v0011b6tpln_board_height + 16/12;
gebp_v0011b6tpln_holder_transition_board_depth = 15/12;
gebp_v0011b6tpln_holder_flat_board_depth = 45/12;
gebp_v0011b6tpln_holder_board_backing_depth = 1;
gebp_v0011b6tpln_holder_post_backing_width = 60/12;
gebp_v0011b6tpln_holder_post_backing_depth = 1;
gebp_v0011b6tpln_holder_body_depth = gebp_v0011b6tpln_holder_transition_board_depth + gebp_v0011b6tpln_holder_flat_board_depth + gebp_v0011b6tpln_holder_board_backing_depth;
gebp_v0011b6tpln_holder_wall_thickness = 1;

// Tongue Variables
gebp_v0011b6tpln_tongue_start_depth = 20/12;
gebp_v0011b6tpln_tongue_front_depth = 50/12;
gebp_v0011b6tpln_tongue_back_depth = 40/12;
gebp_v0011b6tpln_tongue_start_width = gebp_v0011b6tpln_holder_post_backing_width * 0.45;
gebp_v0011b6tpln_tongue_front_width = gebp_v0011b6tpln_holder_post_backing_width * 0.2;
gebp_v0011b6tpln_tongue_back_width = gebp_v0011b6tpln_holder_post_backing_width * 0.35;
gebp_v0011b6tpln_tongue_start_height = gebp_v0011b6tpln_tongue_start_depth;
gebp_v0011b6tpln_tongue_back_height = gebp_v0011b6tpln_holder_height - 2*gebp_v0011b6tpln_tongue_start_height;
gebp_v0011b6tpln_tongue_front_height = gebp_v0011b6tpln_tongue_back_height * 0.4;

// Groove Variables
gebp_v0011b6tpln_groove_connector_depth = gebp_v0011b6tpln_tongue_front_depth + 1;
gebp_v0011b6tpln_groove_start_depth = gebp_v0011b6tpln_tongue_start_depth;
gebp_v0011b6tpln_groove_front_depth = gebp_v0011b6tpln_tongue_back_depth;
gebp_v0011b6tpln_groove_back_depth = gebp_v0011b6tpln_tongue_front_depth;
gebp_v0011b6tpln_groove_front_width = gebp_v0011b6tpln_tongue_back_width;
gebp_v0011b6tpln_groove_back_width = gebp_v0011b6tpln_tongue_front_width;
gebp_v0011b6tpln_groove_front_height = gebp_v0011b6tpln_tongue_back_height;
gebp_v0011b6tpln_groove_back_height = gebp_v0011b6tpln_tongue_front_height;

// Post Variables
gebp_v0011b6tpln_post_fill_strategy = "filled"; // Allowed values are 'filled', 'hollow', and 'braced'
gebp_v0011b6tpln_post_fill_brace_thickness = 0.15;

gebp_v0011b6tpln_connector_toptube_inner_radius = 12/12;
gebp_v0011b6tpln_connector_toptube_depth = 15/12;
gebp_v0011b6tpln_connector_midtube_inner_radius = 8/12;
gebp_v0011b6tpln_connector_transition_depth = 15/12;
gebp_v0011b6tpln_connector_offset = 15/12;
gebp_v0011b6tpln_connector_tooth_intrusion = (gebp_v0011b6tpln_connector_toptube_inner_radius - gebp_v0011b6tpln_connector_midtube_inner_radius) * 0.4;
gebp_v0011b6tpln_connector_tooth_width = 4/12;

// Shell Variables
gebp_v0011b6tpln_shell_wall_thickness = 1;

module gebp_v0011b6tpln_board_holder(
        bh_body_depth = gebp_v0011b6tpln_holder_body_depth,
        bh_width = gebp_v0011b6tpln_holder_width,
        bh_height = gebp_v0011b6tpln_holder_height,
        bh_trans_hollow_depth = gebp_v0011b6tpln_holder_transition_board_depth,
        bh_flat_hollow_depth = gebp_v0011b6tpln_holder_flat_board_depth,
        bh_hollow_width = gebp_v0011b6tpln_board_width + gebp_v0011b6tpln_board_width_gap,
        bh_hollow_height = gebp_v0011b6tpln_board_height + gebp_v0011b6tpln_board_height_gap,
        bh_hollow_delta = gebp_v0011b6tpln_holder_hollow_delta,
        bh_post_backing_depth = gebp_v0011b6tpln_holder_post_backing_depth,
        bh_post_backing_width = gebp_v0011b6tpln_holder_post_backing_width,
        bh_tongue_start_depth = gebp_v0011b6tpln_tongue_start_depth,
        bh_tongue_back_depth = gebp_v0011b6tpln_tongue_back_depth,
        bh_tongue_front_depth = gebp_v0011b6tpln_tongue_front_depth,
        bh_tongue_back_width = gebp_v0011b6tpln_tongue_back_width,
        bh_tongue_front_width = gebp_v0011b6tpln_tongue_front_width,
        bh_tongue_back_height = gebp_v0011b6tpln_tongue_back_height,
        bh_tongue_front_height = gebp_v0011b6tpln_tongue_front_height,
        bh_mating_gap = gebp_v0011b6tpln_mating_gap,
        bh_dowel_cutout_radius = gebp_v0011b6tpln_mate_dowel_radius + gebp_v0011b6tpln_mate_dowel_gap
        ) {

echo("buiiding witth bh_tongue_back_height");
echo(bh_tongue_back_height);

    geb_board_holder(
        bh_body_depth = bh_body_depth,
        bh_width = bh_width,
        bh_height = bh_height,
        bh_trans_hollow_depth = bh_trans_hollow_depth,
        bh_flat_hollow_depth = bh_flat_hollow_depth,
        bh_hollow_width = bh_hollow_width,
        bh_hollow_height = bh_hollow_height,
        bh_hollow_delta = bh_hollow_delta,
        bh_post_backing_depth = bh_post_backing_depth,
        bh_post_backing_width = bh_post_backing_width,
        bh_tongue_start_depth = bh_tongue_start_depth,
        bh_tongue_back_depth = bh_tongue_back_depth,
        bh_tongue_front_depth = bh_tongue_front_depth,
        bh_tongue_back_width = bh_tongue_back_width,
        bh_tongue_front_width = bh_tongue_front_width,
        bh_tongue_back_height = bh_tongue_back_height,
        bh_tongue_front_height = bh_tongue_front_height,
        bh_mating_gap = bh_mating_gap,
        bh_dowel_cutout_radius = bh_dowel_cutout_radius
        );
}

module gebp_v0011b6tpln_board_holder_simple_post(
        bsp_groove_connector_depth = gebp_v0011b6tpln_groove_connector_depth,
        bsp_connector_offset = gebp_v0011b6tpln_connector_offset,
        bsp_width = gebp_v0011b6tpln_holder_post_backing_width,
        bsp_height = gebp_v0011b6tpln_holder_height,
        bsp_groove_start_depth = gebp_v0011b6tpln_groove_start_depth,
        bsp_groove_front_depth = gebp_v0011b6tpln_groove_front_depth,
        bsp_groove_back_depth = gebp_v0011b6tpln_groove_back_depth,
        bsp_groove_front_width = gebp_v0011b6tpln_groove_front_width,
        bsp_groove_back_width = gebp_v0011b6tpln_groove_back_width,
        bsp_groove_front_height = gebp_v0011b6tpln_groove_front_height,
        bsp_groove_back_height = gebp_v0011b6tpln_groove_back_height,
        bsp_mating_gap = gebp_v0011b6tpln_mating_gap,
        bsp_dowel_cutout_radius = gebp_v0011b6tpln_mate_dowel_radius + gebp_v0011b6tpln_mate_dowel_gap,
        bsp_post_angles = [0, 90],
        bsp_toptube_inner_radius = gebp_v0011b6tpln_connector_toptube_inner_radius,
        bsp_toptube_depth = gebp_v0011b6tpln_connector_toptube_depth,
        bsp_midtube_inner_radius = gebp_v0011b6tpln_connector_midtube_inner_radius,
        bsp_transition_depth = gebp_v0011b6tpln_connector_transition_depth,
        bsp_wall_thickness = gebp_v0011b6tpln_holder_wall_thickness) {

    geb_board_holder_simple_post(
        bsp_groove_connector_depth = bsp_groove_connector_depth,
        bsp_connector_offset = bsp_connector_offset,
        bsp_width = bsp_width,
        bsp_height = bsp_height,
        bsp_groove_start_depth = bsp_groove_start_depth,
        bsp_groove_front_depth = bsp_groove_front_depth,
        bsp_groove_back_depth = bsp_groove_back_depth,
        bsp_groove_front_width = bsp_groove_front_width,
        bsp_groove_back_width = bsp_groove_back_width,
        bsp_groove_front_height = bsp_groove_front_height,
        bsp_groove_back_height = bsp_groove_back_height,
        bsp_mating_gap = bsp_mating_gap,
        bsp_dowel_cutout_radius = bsp_dowel_cutout_radius,
        bsp_post_angles = bsp_post_angles,
        bsp_toptube_inner_radius = bsp_toptube_inner_radius,
        bsp_toptube_depth = bsp_toptube_depth,
        bsp_midtube_inner_radius = bsp_midtube_inner_radius,
        bsp_transition_depth = bsp_transition_depth,
        bsp_wall_thickness = bsp_wall_thickness);
}

module gebp_v0011b6tpln_board_holder_post_shell(
        bps_width = gebp_v0011b6tpln_holder_post_backing_width,
        bps_height = gebp_v0011b6tpln_holder_height,
        bps_connector_offset = gebp_v0011b6tpln_connector_offset,
        bh_width = gebp_v0011b6tpln_holder_width,
        bh_height = gebp_v0011b6tpln_holder_height,
        bh_post_backing_depth = gebp_v0011b6tpln_holder_post_backing_depth,
        bps_mating_gap = gebp_v0011b6tpln_mating_gap,
        bps_groove_body_depth = gebp_v0011b6tpln_groove_connector_depth,
        bps_post_angles = [0, 90],
        bps_shell_thickness = gebp_v0011b6tpln_shell_wall_thickness
        ) {

    geb_board_holder_post_shell(
        bps_width = bps_width,
        bps_height = bps_height,
        bps_connector_offset = bps_connector_offset,
        bh_width = bh_width,
        bh_height = bh_height,
        bh_post_backing_depth = bh_post_backing_depth,
        bps_mating_gap = bps_mating_gap,
        bps_groove_body_depth = bps_groove_body_depth,
        bps_post_angles = bps_post_angles,
        bps_shell_thickness = bps_shell_thickness
        );
}