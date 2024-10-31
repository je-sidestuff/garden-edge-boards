//////////////////////////////////////////////////////////////////////
//
// Filename: garden_edge_board_holder.scad
//   The garden edge board holder joins multiple boards together at an edge post.
//   The edge may be anchored to the ground with rebar or a dowel.
// Author:
//   Jordan Edsall
// Date:
//   2024-09-18
// License:
//   https://opensource.org/licenses/MIT
// 
//////////////////////////////////////////////////////////////////////

// Variables
STD_FN = 128;
SMALL_VAL = 0.0000000000000001;
BIG_VAL = 10000;

geb_mating_gap = 0.975;

// Non-printed component variables
1_by_6_width = 15;
1_by_6_height = 134;

geb_board_width = 1_by_6_width;
geb_board_width_gap = 0.625;
geb_board_height = 1_by_6_height;
geb_board_height_gap = 0.9375;

3_8th_inch_dowel_radius = 4.7625;

geb_mate_dowel_radius = 3_8th_inch_dowel_radius;
geb_mate_dowel_gap = 0.225;

// Structure Variables
geb_holder_hollow_delta = 10;
geb_holder_width = geb_board_width + 20;
geb_holder_height = geb_board_height + 16;
geb_holder_transition_board_depth = 15;
geb_holder_flat_board_depth = 45;
geb_holder_board_backing_depth = 5;
geb_holder_post_backing_width = 60;
geb_holder_post_backing_depth = 12.5;
geb_holder_body_depth = geb_holder_transition_board_depth + geb_holder_flat_board_depth + geb_holder_board_backing_depth;
geb_holder_wall_thickness = 1;

// Tongue Variables
geb_tongue_start_depth = 20;
geb_tongue_front_depth = 50;
geb_tongue_back_depth = 40;
geb_tongue_start_width = geb_holder_post_backing_width * 0.45;
geb_tongue_front_width = geb_holder_post_backing_width * 0.2;
geb_tongue_back_width = geb_holder_post_backing_width * 0.35;
geb_tongue_start_height = 20;
geb_tongue_back_height = geb_holder_height - 2*geb_tongue_start_height;
geb_tongue_front_height = geb_tongue_back_height * 0.4;

// Groove Variables
geb_groove_connector_depth = geb_tongue_front_depth + 5;
geb_groove_start_depth = geb_tongue_start_depth;
geb_groove_front_depth = geb_tongue_back_depth;
geb_groove_back_depth = geb_tongue_front_depth;
geb_groove_front_width = geb_tongue_back_width;
geb_groove_back_width = geb_tongue_front_width;
geb_groove_front_height = geb_tongue_back_height;
geb_groove_back_height = geb_tongue_front_height;

// Post Variables
geb_connector_toptube_inner_radius = 12;
geb_connector_toptube_depth = 15;
geb_connector_midtube_inner_radius = 8;
geb_connector_transition_depth = 15;
geb_connector_offset = 15;
geb_connector_tooth_intrusion = (geb_connector_toptube_inner_radius - geb_connector_midtube_inner_radius) * 0.4;
geb_connector_tooth_width = 4;

// Shell Variables
geb_shell_wall_thickness = 1;



// Board Holder Modules

// Module: geb_board_holder_body()
// Description:
//   Creates a volume where a board can be inserted standing vertically with a backing of equal or greater width.
//   The [0, 0, 0] point is at the bottom of the volume, with all geometry in the +X region, and the front facing in the +X direction.
// Arguments:
//   bh_body_depth         - The depth of the board holder body, including the post backing.
//   bh_width              - The width of the board holder portion of the board holder body.
//   bh_height             - The height of the board holder body and post backing (+Z). 
//   bh_trans_hollow_depth - The depth of the transition section of the hollow the board sits in.
//   bh_flat_hollow_depth  - The depth of the flat back section of the hollow the board sits in.
//   bh_hollow_width       - The width of the flat back section of hollow where the board sits.
//   bh_hollow_height      - The height of the flat back section of hollow where the board sits.
//   bh_hollow_delta       - The difference in hollow width and height of the front and back.
//   bh_post_backing_depth - The depth of the body section that butts up against another object.
//   bh_post_backing_width - The width of the body section that butts up against another object.
module geb_board_holder_body(
        bh_body_depth = geb_holder_body_depth,
        bh_width = geb_holder_width,
        bh_height = geb_holder_height,
        bh_trans_hollow_depth = geb_holder_transition_board_depth,
        bh_flat_hollow_depth = geb_holder_flat_board_depth,
        bh_hollow_width = geb_board_width + geb_board_width_gap,
        bh_hollow_height = geb_board_height + geb_board_height_gap,
        bh_hollow_delta = geb_holder_hollow_delta,
        bh_post_backing_depth = geb_holder_post_backing_depth,
        bh_post_backing_width = geb_holder_post_backing_width
        ) {
            
    bh_full_hollow_depth = bh_trans_hollow_depth + bh_flat_hollow_depth;
    
    // The board holder volume
    translate([bh_body_depth/2, 0, bh_height/2]) {
        difference() {
            
            translate([0,0,0]) {
                cube([bh_body_depth, bh_width, bh_height], center = true);
                translate([(bh_post_backing_depth - bh_body_depth)/2,0,0])
                    cube([bh_post_backing_depth, bh_post_backing_width, bh_height], center = true);
            }
            
            translate([bh_body_depth/2,0,0]) {
                cube([bh_full_hollow_depth*2, bh_hollow_width, bh_hollow_height], center = true);

                hull() {
                    cube([bh_trans_hollow_depth*2, bh_hollow_width, bh_hollow_height], center = true);
                    cube([SMALL_VAL, bh_hollow_width + bh_hollow_delta, bh_hollow_height + bh_hollow_delta], center = true);
                }
            }
        }
    }
}

// Module: geb_board_holder_tongue_positive() 
// Description:
//   Creates a tongue which stands vertically, pointing in the -X direction, meant to mate with a groove. The tongue has a flat section at the back and a tapered section at the front.
//   This module is the positive volume without any joining holes subtracted.
//   The [0, 0, 0] point is at the bottom of the volume, with all geometry in the -X region, and the front facing in the -X direction.
// Arguments:
//   btp_height              - The height of the board holder body and post backing (+Z).
//   btp_tongue_start_depth  - The depth at which the flat section stops and the tapered section begins.
//   btp_tongue_back_depth   - The maximum depth of the outsides of the tapered section.
//   btp_tongue_front_depth  - The maximum depth of the inside of the tapered section.
//   btp_tongue_back_width   - The width of the flat section and outside of the tapered section.
//   btp_tongue_front_width  - The width of the tapered ridge in the middle of the tongue in the Y dimension.
//   btp_tongue_back_height  - The maximum Z dimension of the tapered section.
//   btp_tongue_front_height - The Z dimension of the front of the tapered section.
module geb_board_holder_tongue_positive(
        btp_height = geb_holder_height,
        btp_tongue_start_depth = geb_tongue_start_depth,
        btp_tongue_back_depth = geb_tongue_back_depth,
        btp_tongue_front_depth = geb_tongue_front_depth,
        btp_tongue_back_width = geb_tongue_back_width,
        btp_tongue_front_width = geb_tongue_front_width,
        btp_tongue_back_height = geb_tongue_back_height,
        btp_tongue_front_height = geb_tongue_front_height
        ) {

    btp_delta_depth = btp_tongue_front_depth - btp_tongue_back_depth;

    difference() {
        translate([0, 0, btp_height/2]) {
            translate([btp_tongue_start_depth/-2, 0, 0]) {
                cube([btp_tongue_start_depth, btp_tongue_back_width, btp_height], center = true);
            }
            hull() {
                hull() {
                    translate([(btp_tongue_start_depth + btp_delta_depth)/-2, 0, 0])
                        cube([(btp_tongue_start_depth + btp_delta_depth), btp_tongue_front_width, btp_tongue_back_height], center = true);
                    translate([btp_tongue_front_depth/-2 , 0, 0])
                        cube([btp_tongue_front_depth, btp_tongue_front_width, btp_tongue_front_height], center = true);
                }
                hull() {
                    translate([btp_tongue_start_depth/-2, 0, 0])
                        cube([btp_tongue_start_depth, btp_tongue_back_width, btp_tongue_back_height], center = true);
                    translate([btp_tongue_back_depth/-2, 0, 0])
                        cube([btp_tongue_back_depth, btp_tongue_back_width, btp_tongue_front_height], center = true);
                }
            }
        }
        translate([btp_tongue_start_depth*-1, 0, btp_height/2]) {
            hull() {
                translate([btp_delta_depth*-1, 0, btp_tongue_back_height/2 + btp_delta_depth])
                    cube([btp_delta_depth*2, btp_tongue_back_width*2, btp_delta_depth*2], center = true);
                translate([btp_delta_depth*-3, 0, btp_tongue_back_height/2])
                    cube([btp_delta_depth*2, btp_tongue_back_width*2, btp_delta_depth*2], center = true);
            }
            hull() {
                translate([btp_delta_depth*-1, 0, btp_tongue_back_height/-2 - btp_delta_depth])
                    cube([btp_delta_depth*2, btp_tongue_back_width*2, btp_delta_depth*2], center = true);
                translate([btp_delta_depth*-3, 0, btp_tongue_back_height/-2])
                    cube([btp_delta_depth*2, btp_tongue_back_width*2, btp_delta_depth*2], center = true);
            }
        }
    } 
}

// Module: geb_board_holder_tongue() 
// Description:
//   Creates a tongue which stands vertically, pointing in the -X direction, meant to mate with a groove. The tongue has a flat section at the back and a tapered section at the front.
//   The [0, 0, 0] point is at the bottom of the volume, with all geometry in the -X region, and the front facing in the -X direction.
// Arguments:
//   bht_height               - The height of the board holder body and post backing (+Z).
//   bht_tongue_start_depth  - The depth at which the flat section stops and the tapered section begins.
//   bht_tongue_back_depth   - The maximum depth of the outsides of the tapered section.
//   bht_tongue_front_depth  - The maximum depth of the inside of the tapered section.
//   bht_tongue_back_width   - The width of the flat section and outside of the tapered section.
//   bht_tongue_front_width  - The width of the tapered ridge in the middle of the tongue in the Y dimension.
//   bht_tongue_back_height  - The maximum Z dimension of the tapered section.
//   bht_tongue_front_height - The Z dimension of the front of the tapered section.
//   bht_mating_gap          - The extra distance given to mating components to create a snug fit.
//   bht_dowel_cutout_radius - The radius of the cutout where the mating dowel will be inserted.
module geb_board_holder_tongue(
        bht_height = geb_holder_height,
        bht_tongue_start_depth = geb_tongue_start_depth,
        bht_tongue_back_depth = geb_tongue_back_depth,
        bht_tongue_front_depth = geb_tongue_front_depth,
        bht_tongue_back_width = geb_tongue_back_width,
        bht_tongue_front_width = geb_tongue_front_width,
        bht_tongue_back_height = geb_tongue_back_height,
        bht_tongue_front_height = geb_tongue_front_height,
        bht_mating_gap = geb_mating_gap,
        bht_dowel_cutout_radius = geb_mate_dowel_radius + geb_mate_dowel_gap
        ) {

    bht_delta_depth = bht_tongue_front_depth - bht_tongue_back_depth;

    difference() {
        geb_board_holder_tongue_positive(
            btp_height = bht_height,
            btp_tongue_start_depth = bht_tongue_start_depth - bht_mating_gap/2,
            btp_tongue_back_depth = bht_tongue_back_depth - bht_mating_gap/2,
            btp_tongue_front_depth = bht_tongue_front_depth - bht_mating_gap/2,
            btp_tongue_back_width = bht_tongue_back_width - bht_mating_gap,
            btp_tongue_front_width = bht_tongue_front_width - bht_mating_gap,
            btp_tongue_back_height = bht_tongue_back_height - bht_mating_gap,
            btp_tongue_front_height = bht_tongue_front_height - bht_mating_gap
            );
        translate([bht_tongue_start_depth*-1, 0, bht_height/2]) {
            translate([0,0,bht_tongue_front_height/2]) {
                rotate([90, 0, 0])
                   cylinder(h = bht_tongue_back_width, r = bht_dowel_cutout_radius, center = true, $fn = STD_FN);
                rotate([90, 0, 0])
                   translate([0, 0, bht_tongue_back_width*3/8]) cylinder(h = bht_tongue_back_width/4, r1 = bht_dowel_cutout_radius, r2 = bht_dowel_cutout_radius*1.25, center = true, $fn = STD_FN);
                rotate([90, 0, 0])
                   translate([0, 0, bht_tongue_back_width*3/-8]) cylinder(h = bht_tongue_back_width/4, r2 = bht_dowel_cutout_radius, r1 = bht_dowel_cutout_radius*1.25, center = true, $fn = STD_FN);
            }
            translate([0,0,bht_tongue_front_height/-2]) {
                rotate([90, 0, 0])
                   cylinder(h = bht_tongue_back_width, r = bht_dowel_cutout_radius, center = true, $fn = STD_FN);
                rotate([90, 0, 0])
                   translate([0, 0, bht_tongue_back_width*3/8]) cylinder(h = bht_tongue_back_width/4, r1 = bht_dowel_cutout_radius, r2 = bht_dowel_cutout_radius*1.25, center = true, $fn = STD_FN);
                rotate([90, 0, 0])
                   translate([0, 0, bht_tongue_back_width*3/-8]) cylinder(h = bht_tongue_back_width/4, r2 = bht_dowel_cutout_radius, r1 = bht_dowel_cutout_radius*1.25, center = true, $fn = STD_FN);
            }
        }
    } 
}

module geb_board_holder() {
}



// Board Holder Post Modules

// Module: geb_board_holder_post_groove_solid() 
// Description:
//   Creates the solid of a groove recepticle for a board holder tongue. This solid may be subtracted from to create a hollow structure.
//   The [0, 0, 0] point is at the bottom of the volume, with all geometry in the +X region, and the grooved front facing in the +X direction.
// Arguments:
//   bhg_body_depth          - The distance from the front of the face the groove is cut into to the back face.
//   bhg_width               - The width of the full structure.
//   bhg_height              - The height of the full structure.
//   bhg_groove_start_depth  - The distance the front face is cut into for the vertical section of the groove.
//   bhg_groove_front_depth  - The distance to the deepest cut on the outside-Y of the groove.
//   bhg_groove_back_depth   - The distance to the deepest cut on the Y==0 plane of the groove.
//   bhg_groove_front_width  - The width of the vertical section of the groove.
//   bhg_groove_back_width   - The width of the deepest cut face of the groove.
//   bhg_groove_front_height - The height of the portion in the middle of the groove that is not purely vertical.
//   bhg_groove_back_height  - The height of the deepest cut face of the groove.
//   bhg_mating_gap          - The extra distance given to mating components to create a snug fit.
//   bhg_dowel_cutout_radius - The radius of the cutout where the mating dowel will be inserted.
module geb_board_holder_post_groove_solid(
        bhg_body_depth = geb_groove_connector_depth,
        bhg_width = geb_holder_post_backing_width,
        bhg_height = geb_holder_height,
        bhg_groove_start_depth = geb_groove_start_depth,
        bhg_groove_front_depth = geb_groove_front_depth,
        bhg_groove_back_depth = geb_groove_back_depth,
        bhg_groove_front_width = geb_groove_front_width,
        bhg_groove_back_width = geb_groove_back_width,
        bhg_groove_front_height = geb_groove_front_height,
        bhg_groove_back_height = geb_groove_back_height,
        bhg_mating_gap = geb_mating_gap,
        bhg_dowel_cutout_radius = geb_mate_dowel_radius + geb_mate_dowel_gap
        ) {
            
    groove_side_width = (bhg_width - bhg_groove_back_width)/2;

    difference() {
        translate([(bhg_body_depth - bhg_mating_gap)/2, 0, bhg_height/2]) {
            cube([bhg_body_depth - bhg_mating_gap, bhg_width, bhg_height], center = true);
        }
        translate([bhg_body_depth, 0, 0]) {
            geb_board_holder_tongue_positive(
                btp_height = bhg_height,
                btp_tongue_start_depth = bhg_groove_start_depth + bhg_mating_gap/2,
                btp_tongue_back_depth = bhg_groove_front_depth + bhg_mating_gap/2,
                btp_tongue_front_depth = bhg_groove_back_depth + bhg_mating_gap/2,
                btp_tongue_back_width = bhg_groove_front_width + bhg_mating_gap,
                btp_tongue_front_width = bhg_groove_back_width + bhg_mating_gap,
                btp_tongue_back_height = bhg_groove_front_height + bhg_mating_gap,
                btp_tongue_front_height = bhg_groove_back_height + bhg_mating_gap
                );
            translate([geb_groove_start_depth*-1, 0, bhg_height/2]) {
                translate([0,0,bhg_groove_back_height/2]) {
                    rotate([90, 0, 0])
                       cylinder(h = bhg_width, r = bhg_dowel_cutout_radius, center = true, $fn = STD_FN);
                    rotate([90, 0, 0])
                       translate([0, 0, bhg_width/2 - groove_side_width/8]) cylinder(h = groove_side_width/4, r1 = bhg_dowel_cutout_radius, r2 = bhg_dowel_cutout_radius*1.25, center = true, $fn = STD_FN);
                    rotate([270, 0, 0])
                       translate([0, 0, bhg_width/2 - groove_side_width/8]) cylinder(h = groove_side_width/4, r1 = bhg_dowel_cutout_radius, r2 = bhg_dowel_cutout_radius*1.25, center = true, $fn = STD_FN);
                }
                translate([0,0,bhg_groove_back_height/-2]) {
                    rotate([90, 0, 0])
                       cylinder(h = bhg_width, r = bhg_dowel_cutout_radius, center = true, $fn = STD_FN);
                    rotate([90, 0, 0])
                       translate([0, 0, bhg_width/2 - groove_side_width/8]) cylinder(h = groove_side_width/4, r1 = bhg_dowel_cutout_radius, r2 = bhg_dowel_cutout_radius*1.25, center = true, $fn = STD_FN);
                    rotate([270, 0, 0])
                       translate([0, 0, bhg_width/2 - groove_side_width/8]) cylinder(h = groove_side_width/4, r1 = bhg_dowel_cutout_radius, r2 = bhg_dowel_cutout_radius*1.25, center = true, $fn = STD_FN);
                }
            }
        }
    }
}

// Module: geb_board_holder_post_groove_hollow() 
// Description:
//   Creates the hollowing cutout for a groove recepticle for a board holder tongue.
//   The [0, 0, 0] point is at the bottom of the volume, with all geometry in the +X region, and the grooved front facing in the +X direction.
// Arguments:
//   bhg_body_depth          - The distance from the front of the face the groove is cut into to the back face.
//   bhg_width               - The width of the full structure.
//   bhg_height              - The height of the full structure.
//   bhg_groove_start_depth  - The distance the front face is cut into for the vertical section of the groove.
//   bhg_groove_front_depth  - The distance to the deepest cut on the outside-Y of the groove.
//   bhg_groove_back_depth   - The distance to the deepest cut on the Y==0 plane of the groove.
//   bhg_groove_front_width  - The width of the vertical section of the groove.
//   bhg_groove_back_width   - The width of the deepest cut face of the groove.
//   bhg_groove_front_height - The height of the portion in the middle of the groove that is not purely vertical.
//   bhg_groove_back_height  - The height of the deepest cut face of the groove.
//   bhg_mating_gap          - The extra distance given to mating components to create a snug fit.
//   bhg_dowel_cutout_radius - The radius of the cutout where the mating dowel will be inserted.
//   bhg_wall_thickness      - The thickness of walls to leave in the final solid after subtraction.
module geb_board_holder_post_groove_hollow(
        bhg_body_depth = geb_groove_connector_depth,
        bhg_width = geb_holder_post_backing_width,
        bhg_height = geb_holder_height,
        bhg_groove_start_depth = geb_groove_start_depth,
        bhg_groove_front_depth = geb_groove_front_depth,
        bhg_groove_back_depth = geb_groove_back_depth,
        bhg_groove_front_width = geb_groove_front_width,
        bhg_groove_back_width = geb_groove_back_width,
        bhg_groove_front_height = geb_groove_front_height,
        bhg_groove_back_height = geb_groove_back_height,
        bhg_mating_gap = geb_mating_gap,
        bhg_dowel_cutout_radius = geb_mate_dowel_radius + geb_mate_dowel_gap,
        bhg_wall_thickness = geb_holder_wall_thickness
        ) {
            
    groove_side_width = (bhg_width - bhg_groove_back_width)/2;
    
    // Local variables for the body of the hollow
    bhh_width = bhg_width - 2*bhg_wall_thickness;
    bhh_body_depth = bhg_body_depth - bhg_wall_thickness;
    bhh_mating_gap = bhg_mating_gap;
    bhh_height = bhg_height - 2*bhg_wall_thickness;
            
    // Local variables for the goove cut-out of the hollow
    bgh_height = bhg_height + 2*bhg_wall_thickness;
    bgh_groove_start_depth = bhg_groove_start_depth + bhg_wall_thickness/2;
    bgh_groove_front_depth = bhg_groove_front_depth + bhg_wall_thickness/2;
    bgh_groove_back_depth = bhg_groove_back_depth + bhg_wall_thickness/2;
    bgh_groove_front_width = bhg_groove_front_width + 2*bhg_wall_thickness;
    bgh_groove_back_width = bhg_groove_back_width + 2*bhg_wall_thickness;
    bgh_groove_front_height = bhg_groove_front_height + 2*bhg_wall_thickness;
    bgh_groove_back_height = bhg_groove_back_height + 2*bhg_wall_thickness;
    bgh_dowel_cutout_radius = bhg_dowel_cutout_radius + bhg_wall_thickness;

    difference() {
        translate([(bhh_body_depth - bhh_mating_gap)/2, 0, bhh_height/2 + bhg_wall_thickness]) {
            difference() {
                cube([bhh_body_depth - bhh_mating_gap, bhh_width, bhh_height], center = true);
                translate([0, 0, 0]) {
                    cube([BIG_VAL, 0.3, BIG_VAL], center = true);
                    cube([0.3, BIG_VAL, BIG_VAL], center = true);
                }
            }
        }
        translate([bhg_body_depth, 0, 0]) {
            translate([0, 0, -bhh_mating_gap]) geb_board_holder_tongue_positive(
                btp_height = bgh_height,
                btp_tongue_start_depth = bgh_groove_start_depth + bhh_mating_gap,
                btp_tongue_back_depth = bgh_groove_front_depth + bhh_mating_gap,
                btp_tongue_front_depth = bgh_groove_back_depth + bhh_mating_gap,
                btp_tongue_back_width = bgh_groove_front_width + bhh_mating_gap,
                btp_tongue_front_width = bgh_groove_back_width + bhh_mating_gap,
                btp_tongue_back_height = bgh_groove_front_height + bhh_mating_gap,
                btp_tongue_front_height = bgh_groove_back_height + bhh_mating_gap
                );
            translate([geb_groove_start_depth*-1, 0, bhg_height/2]) {
                translate([0,0,bhg_groove_back_height/2]) {
                    rotate([90, 0, 0])
                    cylinder(h = bhg_width, r = bgh_dowel_cutout_radius, center = true, $fn = STD_FN);
                    rotate([90, 0, 0])
                    translate([0, 0, bhg_width/2 - groove_side_width/8]) cylinder(h = groove_side_width/4, r1 = bgh_dowel_cutout_radius, r2 = bgh_dowel_cutout_radius*1.25, center = true, $fn = STD_FN);
                    rotate([270, 0, 0])
                    translate([0, 0, bhg_width/2 - groove_side_width/8]) cylinder(h = groove_side_width/4, r1 = bgh_dowel_cutout_radius, r2 = bgh_dowel_cutout_radius*1.25, center = true, $fn = STD_FN);
                }
                translate([0,0,bhg_groove_back_height/-2]) {
                    rotate([90, 0, 0])
                    cylinder(h = bhg_width, r = bgh_dowel_cutout_radius, center = true, $fn = STD_FN);
                    rotate([90, 0, 0])
                    translate([0, 0, bhg_width/2 - groove_side_width/8]) cylinder(h = groove_side_width/4, r1 = bgh_dowel_cutout_radius, r2 = bgh_dowel_cutout_radius*1.25, center = true, $fn = STD_FN);
                    rotate([270, 0, 0])
                    translate([0, 0, bhg_width/2 - groove_side_width/8]) cylinder(h = groove_side_width/4, r1 = bgh_dowel_cutout_radius, r2 = bgh_dowel_cutout_radius*1.25, center = true, $fn = STD_FN);
                }
            }
        }
    }
}

// Module: geb_board_holder_post_groove() 
// Description:
//   Creates a groove recepticle for a board holder tongue.
//   The [0, 0, 0] point is at the bottom of the volume, with all geometry in the +X region, and the grooved front facing in the +X direction.
// Arguments:
//   bhg_body_depth          - The distance from the front of the face the groove is cut into to the back face.
//   bhg_width               - The width of the full structure.
//   bhg_height              - The height of the full structure.
//   bhg_groove_start_depth  - The distance the front face is cut into for the vertical section of the groove.
//   bhg_groove_front_depth  - The distance to the deepest cut on the outside-Y of the groove.
//   bhg_groove_back_depth   - The distance to the deepest cut on the Y==0 plane of the groove.
//   bhg_groove_front_width  - The width of the vertical section of the groove.
//   bhg_groove_back_width   - The width of the deepest cut face of the groove.
//   bhg_groove_front_height - The height of the portion in the middle of the groove that is not purely vertical.
//   bhg_groove_back_height  - The height of the deepest cut face of the groove.
//   bhg_mating_gap          - The extra distance given to mating components to create a snug fit.
//   bhg_dowel_cutout_radius - The radius of the cutout where the mating dowel will be inserted.
//   bhg_wall_thickness      - The thickness of walls to leave in the final solid after subtraction.
module geb_board_holder_post_groove(
        bhg_body_depth = geb_groove_connector_depth,
        bhg_width = geb_holder_post_backing_width,
        bhg_height = geb_holder_height,
        bhg_groove_start_depth = geb_groove_start_depth,
        bhg_groove_front_depth = geb_groove_front_depth,
        bhg_groove_back_depth = geb_groove_back_depth,
        bhg_groove_front_width = geb_groove_front_width,
        bhg_groove_back_width = geb_groove_back_width,
        bhg_groove_front_height = geb_groove_front_height,
        bhg_groove_back_height = geb_groove_back_height,
        bhg_mating_gap = geb_mating_gap,
        bhg_dowel_cutout_radius = geb_mate_dowel_radius + geb_mate_dowel_gap,
        bhg_wall_thickness = geb_holder_wall_thickness
        ) {

    difference() {
        geb_board_holder_post_groove_solid(
            bhg_body_depth = bhg_body_depth,
            bhg_width = bhg_width,
            bhg_height = bhg_height,
            bhg_groove_start_depth = bhg_groove_start_depth,
            bhg_groove_front_depth = bhg_groove_front_depth,
            bhg_groove_back_depth = bhg_groove_back_depth,
            bhg_groove_front_width = bhg_groove_front_width,
            bhg_groove_back_width = bhg_groove_back_width,
            bhg_groove_front_height = bhg_groove_front_height,
            bhg_groove_back_height = bhg_groove_back_height,
            bhg_mating_gap = bhg_mating_gap,
            bhg_dowel_cutout_radius = bhg_dowel_cutout_radius
            );
        geb_board_holder_post_groove_hollow(
            bhg_body_depth = bhg_body_depth,
            bhg_width = bhg_width,
            bhg_height = bhg_height,
            bhg_groove_start_depth = bhg_groove_start_depth,
            bhg_groove_front_depth = bhg_groove_front_depth,
            bhg_groove_back_depth = bhg_groove_back_depth,
            bhg_groove_front_width = bhg_groove_front_width,
            bhg_groove_back_width = bhg_groove_back_width,
            bhg_groove_front_height = bhg_groove_front_height,
            bhg_groove_back_height = bhg_groove_back_height,
            bhg_mating_gap = bhg_mating_gap,
            bhg_dowel_cutout_radius = bhg_dowel_cutout_radius,
            bhg_wall_thickness = bhg_wall_thickness
            );
    }
}

// Module: geb_board_holder_post_groove_subtract()
// Description:
//   Creates a subtractive volume used to attach grooves to a post at a 90 degree-incremented angle.
//   The volume may be intersected with the groove and subtracted from the post core.
//   The back wall of the volume is spaced away from [0, 0, 0] at a distance of bgs_connector_offset.
//   The volume faces in the +X direction and may be rotated to align with the post it is used for.
// Arguments:
//   bgs_connector_offset - How far the groove connector is offset from [0, 0, 0].
module geb_board_holder_post_groove_subtract(
        bgs_connector_offset = geb_connector_offset
        ) {
    difference() {
        translate([bgs_connector_offset + BIG_VAL/2, 0, 0])
            cube([BIG_VAL, BIG_VAL, BIG_VAL], center = true);
        translate([0,0,0]) {
            rotate([0, 0, 45]) translate([BIG_VAL, BIG_VAL, 0]) cube([BIG_VAL*2, BIG_VAL*2, BIG_VAL*2], center = true);
            rotate([0, 0, -45]) translate([BIG_VAL, -BIG_VAL, 0]) cube([BIG_VAL*2, BIG_VAL*2, BIG_VAL*2], center = true);
        }
    }
}

// Module: geb_board_holder_simple_post_core()
// Description:
//   Creates the core of a post which may serve as a center for one or more groove recepticles at 90 or 180 degree increments.
//   The stake connector may be embedded in the center of the post.
//   The [0, 0, 0] point is at the bottom of the volume, in the middle of the bottom face.
// Arguments:
//   bpc_core_depth     - The dimension of the core in the X dimension. Usually the same as the width.
//   bpc_core_width     - The dimension of the core in the Y dimension.
//   bpc_core_height    - The height of the structure.
//   bpc_wall_thickness - The wall thickness of the structure.
module geb_board_holder_simple_post_core(
        bpc_core_depth = geb_holder_post_backing_width,
        bpc_core_width = geb_holder_post_backing_width,
        bpc_core_height = geb_holder_height,
        bpc_wall_thickness = geb_holder_wall_thickness
        ) {

    difference() {
        translate([0, 0, bpc_core_height/2]) {
            cube([bpc_core_depth, bpc_core_width, bpc_core_height], center = true);
        }
        translate([0, 0, bpc_core_height/2]) {
            difference() {
                cube([bpc_core_depth - bpc_wall_thickness * 2,
                    bpc_core_width - bpc_wall_thickness * 2,
                    bpc_core_height - bpc_wall_thickness * 2], center = true);
                translate([0, 0, 0]) {
                    cube([BIG_VAL, 0.3, BIG_VAL], center = true);
                    cube([0.3, BIG_VAL, BIG_VAL], center = true);
                }
            }
        }
    }
}

// Module: geb_board_holder_simple_post_connector_positive()
// Description:
//   Creates the positive volume for a tube where a stake is inserted through a post.
//   The [0, 0, 0] point is at the bottom of the volume, in the middle of the bottom face.
// Arguments:
//   bpc_core_height          - The height of the structure.
//   bpc_toptube_inner_radius - The inner radius of the upper-and-lowermost portions of the stake tube.
//   bpc_toptube_depth        - The distance from the top of the connector until the tube tapering begins.
//   bpc_midtube_inner_radius - The inner radius of the narrower middle section of tube.
//   bpc_transition_depth     - The distance over which the transition of radius takes place.
//   bpc_wall_thickness       - The wall thickness of the structure.
module geb_board_holder_simple_post_connector_positive(
        bpc_core_height = geb_holder_height,
        bpc_toptube_inner_radius = geb_connector_toptube_inner_radius,
        bpc_toptube_depth = geb_connector_toptube_depth,
        bpc_midtube_inner_radius = geb_connector_midtube_inner_radius,
        bpc_transition_depth = geb_connector_transition_depth,
        bpc_wall_thickness = geb_holder_wall_thickness
        ) {
    
    bpc_midtube_outer_radius = bpc_midtube_inner_radius + bpc_wall_thickness;
    bpc_toptube_outer_radius = bpc_toptube_inner_radius + bpc_wall_thickness;
    bpc_midtube_depth = bpc_core_height - 2*bpc_toptube_depth - 2*bpc_transition_depth;

    translate([0, 0, bpc_core_height/2]) {
        cylinder(r = bpc_midtube_outer_radius, h = bpc_core_height, center = true, $fn = STD_FN);
        hull() {
            translate([0, 0, (bpc_midtube_depth + SMALL_VAL)/2])
                cylinder(r = bpc_midtube_outer_radius, h = SMALL_VAL, center = true, $fn = STD_FN);
            translate([0, 0, bpc_midtube_depth/2 + bpc_transition_depth + bpc_toptube_depth/2])
                cylinder(r = bpc_toptube_outer_radius, h = bpc_toptube_depth, center = true, $fn = STD_FN);
        }
        rotate([180, 0, 0]) hull() {
            translate([0, 0, (bpc_midtube_depth + SMALL_VAL)/2])
                cylinder(r = bpc_midtube_outer_radius, h = SMALL_VAL, center = true, $fn = STD_FN);
            translate([0, 0, bpc_midtube_depth/2 + bpc_transition_depth + bpc_toptube_depth/2])
                cylinder(r = bpc_toptube_outer_radius, h = bpc_toptube_depth, center = true, $fn = STD_FN);
        }
    }
}

// Module: geb_board_holder_simple_post_connector()
// Description:
//   Creates a tube where a stake may be inserted through a post.
//   The [0, 0, 0] point is at the bottom of the volume, in the middle of the bottom face.
// Arguments:
//   bpc_core_height               - The height of the structure.
//   bpc_toptube_inner_radius      - The inner radius of the upper-and-lowermost portions of the stake tube.
//   bpc_toptube_depth             - The distance from the top of the connector until the tube tapering begins.
//   bpc_midtube_inner_radius      - The inner radius of the narrower middle section of tube.
//   bpc_transition_depth          - The distance over which the transition of radius takes place.
//   bpc_connector_tooth_intrusion - How far the mating teeth stick into the mouth of the tube.
//   bpc_connector_tooth_width     - How wide the mating teeth are.
//   bpc_mating_gap                - The extra distance given to mating components to create a snug fit.
//   bpc_wall_thickness            - The wall thickness of the structure.
module geb_board_holder_simple_post_connector(
        bpc_core_height = geb_holder_height,
        bpc_toptube_inner_radius = geb_connector_toptube_inner_radius,
        bpc_toptube_depth = geb_connector_toptube_depth,
        bpc_midtube_inner_radius = geb_connector_midtube_inner_radius,
        bpc_transition_depth = geb_connector_transition_depth,
        bpc_connector_tooth_intrusion = geb_connector_tooth_intrusion,
        bpc_connector_tooth_width = geb_connector_tooth_width,
        bpc_mating_gap = geb_mating_gap,
        bpc_wall_thickness = geb_holder_wall_thickness
        ) {
    
    bpc_midtube_outer_radius = bpc_midtube_inner_radius + bpc_wall_thickness;
    bpc_toptube_outer_radius = bpc_toptube_inner_radius + bpc_wall_thickness;
    bpc_midtube_depth = bpc_core_height - 2*bpc_toptube_depth - 2*bpc_transition_depth;

    difference() {
        geb_board_holder_simple_post_connector_positive(
            bpc_core_height = bpc_core_height,
            bpc_toptube_inner_radius = bpc_toptube_inner_radius,
            bpc_toptube_depth = bpc_toptube_depth,
            bpc_midtube_inner_radius = bpc_midtube_inner_radius,
            bpc_transition_depth = bpc_transition_depth,
            bpc_wall_thickness = bpc_wall_thickness
            );

        // Subtract the teeth from the hollowing cutter
        difference() {
            translate([0, 0, bpc_core_height/2]) {
                cylinder(r = bpc_midtube_inner_radius, h = bpc_core_height, center = true, $fn = STD_FN);
                hull() {
                    translate([0, 0, (bpc_midtube_depth + SMALL_VAL)/2])
                        cylinder(r = bpc_midtube_inner_radius, h = SMALL_VAL, center = true, $fn = STD_FN);
                    translate([0, 0, bpc_midtube_depth/2 + bpc_transition_depth + bpc_toptube_depth/2])
                        cylinder(r = bpc_toptube_inner_radius, h = bpc_toptube_depth, center = true, $fn = STD_FN);
                }
                rotate([180, 0, 0]) hull() {
                    translate([0, 0, (bpc_midtube_depth + SMALL_VAL)/2])
                        cylinder(r = bpc_midtube_inner_radius, h = SMALL_VAL, center = true, $fn = STD_FN);
                    translate([0, 0, bpc_midtube_depth/2 + bpc_transition_depth + bpc_toptube_depth/2])
                        cylinder(r = bpc_toptube_inner_radius, h = bpc_toptube_depth, center = true, $fn = STD_FN);
                }
            }
            translate([0,0,0]) {
                difference() {
                    translate([0,0,0]) {
                        cube([BIG_VAL, bpc_connector_tooth_width - bpc_mating_gap, BIG_VAL], center = true);
                        cube([bpc_connector_tooth_width - bpc_mating_gap, BIG_VAL, BIG_VAL], center = true);
                    }
                    cylinder(h = BIG_VAL,
                             r = bpc_toptube_inner_radius - bpc_connector_tooth_intrusion - bpc_mating_gap/2, 
                             center = true, $fn = STD_FN);
                }
            }
        }
    }
}

// Module: geb_board_holder_simple_post()
// Description:
//   Creates a post with between 0 and 4 groove holders at 90 or 180 degree spacing.
//   The [0, 0, 0] point is at the bottom of the volume, with the posts present extending an equal distance away.
// Arguments:
//   bsp_groove_connector_depth - The distance from the front of the face the groove is cut into to the back of the connector.
//   bsp_connector_offset       - The distance away from [0, 0, 0] where the connector's back sits.
//   bsp_width                  - The width of the full structure.
//   bsp_height                 - The height of the full structure.
//   bsp_groove_start_depth     - The distance the front face is cut into for the vertical section of the groove.
//   bsp_groove_front_depth     - The distance to the deepest cut on the outside-Y of the groove.
//   bsp_groove_back_depth      - The distance to the deepest cut on the Y==0 plane of the groove.
//   bsp_groove_front_width     - The width of the vertical section of the groove.
//   bsp_groove_back_width      - The width of the deepest cut face of the groove.
//   bsp_groove_front_height    - The height of the portion in the middle of the groove that is not purely vertical.
//   bsp_groove_back_height     - The height of the deepest cut face of the groove.
//   bsp_mating_gap             - The extra distance given to mating components to create a snug fit.
//   bsp_dowel_cutout_radius    - The radius of the cutout where the mating dowel will be inserted.
//   bsp_post_angles            - The angles at which mating grooves exist.
//   bsp_toptube_inner_radius   - The inner radius of the upper-and-lowermost portions of the stake tube.
//   bsp_toptube_depth          - The distance from the top of the connector until the tube tapering begins.
//   bsp_midtube_inner_radius   - The inner radius of the narrower middle section of tube.
//   bsp_transition_depth       - The distance over which the transition of radius takes place.
//   bsp_wall_thickness         - The wall thickness of the structure.
module geb_board_holder_simple_post(
        bsp_groove_connector_depth = geb_groove_connector_depth,
        bsp_width = geb_holder_post_backing_width,
        bsp_height = geb_holder_height,
        bsp_groove_start_depth = geb_groove_start_depth,
        bsp_groove_front_depth = geb_groove_front_depth,
        bsp_groove_back_depth = geb_groove_back_depth,
        bsp_groove_front_width = geb_groove_front_width,
        bsp_groove_back_width = geb_groove_back_width,
        bsp_groove_front_height = geb_groove_front_height,
        bsp_groove_back_height = geb_groove_back_height,
        bsp_mating_gap = geb_mating_gap,
        bsp_dowel_cutout_radius = geb_mate_dowel_radius + geb_mate_dowel_gap,

        bsp_connector_offset = geb_connector_offset,
        bsp_post_angles = [0, 90],

        bsp_toptube_inner_radius = geb_connector_toptube_inner_radius,
        bsp_toptube_depth = geb_connector_toptube_depth,
        bsp_midtube_inner_radius = geb_connector_midtube_inner_radius,
        bsp_transition_depth = geb_connector_transition_depth,
        bsp_wall_thickness = geb_holder_wall_thickness) {

    difference() {
        geb_board_holder_simple_post_core(
            bpc_core_depth = bsp_width,
            bpc_core_width = bsp_width,
            bpc_core_height = bsp_height,
            bpc_wall_thickness = bsp_wall_thickness);
        translate([0, 0, 0]) {
            geb_board_holder_simple_post_connector_positive(
                bpc_core_height = bsp_height,
                bpc_toptube_inner_radius = bsp_toptube_inner_radius,
                bpc_toptube_depth = bsp_toptube_depth,
                bpc_midtube_inner_radius = bsp_midtube_inner_radius,
                bpc_transition_depth = bsp_transition_depth,
                bpc_wall_thickness = bsp_wall_thickness
                );
            
            for(i = [0:len(bsp_post_angles)-1]) {
                rotate([0, 0, bsp_post_angles[i]])
                    geb_board_holder_post_groove_subtract(bgs_connector_offset = bsp_connector_offset);
            }
        }
    }

    geb_board_holder_simple_post_connector(
            bpc_core_height = bsp_height,
            bpc_toptube_inner_radius = bsp_toptube_inner_radius,
            bpc_toptube_depth = bsp_toptube_depth,
            bpc_midtube_inner_radius = bsp_midtube_inner_radius,
            bpc_transition_depth = bsp_transition_depth,
            bpc_wall_thickness = bsp_wall_thickness
            );
    
    for(i = [0:len(bsp_post_angles)-1]) {
        rotate([0, 0, bsp_post_angles[i]])
            intersection() {
            translate([bsp_connector_offset, 0, 0]) geb_board_holder_post_groove(
                bhg_body_depth = bsp_groove_connector_depth,
                bhg_width = bsp_width,
                bhg_height = bsp_height,
                bhg_groove_start_depth = bsp_groove_start_depth,
                bhg_groove_front_depth = bsp_groove_front_depth,
                bhg_groove_back_depth = bsp_groove_back_depth,
                bhg_groove_front_width = bsp_groove_front_width,
                bhg_groove_back_width = bsp_groove_back_width,
                bhg_groove_front_height = bsp_groove_front_height,
                bhg_groove_back_height = bsp_groove_back_height,
                bhg_mating_gap = bsp_mating_gap,
                bhg_dowel_cutout_radius = bsp_dowel_cutout_radius,
                bhg_wall_thickness = bsp_wall_thickness
                );
            geb_board_holder_post_groove_subtract(bgs_connector_offset = bsp_connector_offset);
        }
    }
}



// Board Holder Shell Modules

// Module: geb_board_holder_post_shell() 
// Description:
//   Creates the shell of a full post assembly with tongues and grooves connected.
//   The [0, 0, 0] point is at the bottom of the middle of the post core volume, with arm shells for each of the bps_post_angles.
// Arguments:
//   bps_body_depth          - The distance from the front of the face the groove is cut into to the back face.
//   bps_post_angles - The radius of the cutout where the mating dowel will be inserted.
module geb_board_holder_post_shell(
        bps_width = geb_holder_post_backing_width,
        bps_height = geb_holder_height,
        bps_connector_offset = geb_connector_offset,

        
        bh_width = geb_holder_width,
        bh_height = geb_holder_height,
        bh_post_backing_depth = geb_holder_post_backing_depth,

        bps_mating_gap = geb_mating_gap,

        bps_groove_body_depth = geb_groove_connector_depth,
        bps_post_angles = [0, 90],
        bps_shell_thickness = geb_shell_wall_thickness
        ) {

    shell_height = bps_height + bps_mating_gap + bps_shell_thickness;
    shell_core_width = bps_width + 2 * (bps_mating_gap + bps_shell_thickness);
    shell_hollow_height = bps_height + bps_mating_gap;
    shell_core_hollow_width = bps_width + 2 * bps_mating_gap;
    shell_arm_hollow_length = bps_connector_offset + bps_groove_body_depth + bh_post_backing_depth + bps_mating_gap;
    shell_arm_length = shell_arm_hollow_length + bps_shell_thickness;

    difference() {
        translate([0, 0, shell_height/2]) {
            cube([shell_core_width, shell_core_width, shell_height], center = true);

            for(i = [0:len(bps_post_angles)-1]) {
                rotate([0, 0, bps_post_angles[i]]) {
                    translate([shell_arm_length/2, 0, 0])
                        cube([shell_arm_length, shell_core_width, shell_height], center = true);
                }
            }
        }
        translate([0, 0, 0]) {
            translate([0, 0, shell_hollow_height/2]) {
                cube([shell_core_hollow_width, shell_core_hollow_width, shell_hollow_height], center = true);
                
                for(i = [0:len(bps_post_angles)-1]) {
                    rotate([0, 0, bps_post_angles[i]]) {
                        translate([shell_arm_hollow_length/2, 0, 0])
                            cube([shell_arm_hollow_length, shell_core_hollow_width, shell_hollow_height], center = true);
                    }
                }
            }
            translate([0, 0, shell_hollow_height/2]) {
                for(i = [0:len(bps_post_angles)-1]) {
                    rotate([0, 0, bps_post_angles[i]]) {
                        translate([shell_arm_length/2 + SMALL_VAL, 0, 0])
                            cube([shell_arm_length, bh_width + 2*bps_mating_gap, bh_height + bps_mating_gap], center = true);
                    }
                }
            }
        }
    }
}


/*
geb_board_holder_post_groove();
//*/


/*
//translate([120, 0, 0]) {
    geb_board_holder_body();
    geb_board_holder_tongue();
//}
//*/


//geb_board_holder_simple_post();


//rotate([180, 0, 0]) geb_board_holder_post_shell();
