/* [0. Render Mode] */
// Select which part to display
view_mode = "house"; // [house: Full House Model, sticker: Floor Cutting Template]

/* [1. Global Configuration] */
// Overall model scale (default 0.02 for 1:50)
scale_f = 0.02; // [0.01:0.01:1]
// Base floor thickness (mm)
floor_thickness = 4;
// Real thickness for the floor cutting template (mm). (Only for "Sticker" mode)

/* [1+. Global Configuration - cutting template mode] */
sticker_thickness = 0.4;
// Gap between sticker and wall in real mm (0.2 is recommended)
sticker_tolerance_mm = 0.2; // [0:0.05:0.6]

/* [2. Wall Settings - Exterior Outline] */
// Toggle exterior wall outline
use_walls_outline = true; 
// SVG must contain a CLOSED path for the exterior boundary
walls_outline_file = "walls_outline.svg"; 
// Real-world height in mm (e.g., 2800 for 2.8m)
wall_outline_height = 2800; 
// Wall half-thickness (Offset radius)
wall_outline_offset = 120; 

/* [3. Wall Settings - Interior Walls] */
// --- Load-bearing Walls (Walls 1) ---
use_walls_1 = false; 
// SVG path for main interior walls (Closed path not required)
walls_1_file = "walls_1.svg"; 
wall_1_height = 2800; 
// Half of the wall's total thickness
wall_1_offset = 120;

// --- Partition Walls (Walls 2) ---
use_walls_2 = false; 
// SVG path for thinner partition walls
walls_2_file = "walls_2.svg"; 
wall_2_height = 2800; 
wall_2_offset = 60; 

// --- Partition Walls (Walls 3) ---
use_walls_3 = false; 
walls_3_file = "walls_3.svg"; 
wall_3_height = 2800; 
wall_3_offset = 60; 

// --- Partition Walls (Walls 4) ---
use_walls_4 = false; 
walls_4_file = "walls_4.svg"; 
wall_4_height = 2800; 
wall_4_offset = 60; 



/* [4. Door Openings] */
// --- Standard Interior Doors (Doors 1) ---
use_doors_1 = false; 
// SVG should use rectangles. Ensure rectangle width exceeds wall thickness.
doors_1_file = "doors_1.svg"; 
doors_1_h = 2100; 

// --- Entrance Door (Doors 2) ---
use_doors_2 = false; 
doors_2_file = "doors_2.svg"; 
doors_2_h = 2400; 

// --- Custom / High Doors (Doors 3) ---
use_doors_3 = false; 
doors_3_file = "doors_3.svg"; 
doors_3_h = 2450; 

/* [5. Window Openings] */
// --- Primary Windows (Windows 1) ---
use_windows_1 = false; 
windows_1_file = "windows_1.svg"; 
// Total vertical height of the window opening
win_1_h = 1500;
// Sill height (Distance from floor to window bottom)
win_1_z = 900;

// --- Secondary Windows (Windows 2) ---
use_windows_2 = false; 
windows_2_file = "windows_2.svg"; 
win_2_h = 900;
win_2_z = 1400;

// --- Kitchen/Bath Windows (Windows 3) ---
use_windows_3 = false; 
windows_3_file = "windows_3.svg"; 
win_3_h = 1200;
win_3_z = 1100;

// --- Balcony / Floor-to-Ceiling Windows (Windows 4) ---
use_windows_4 = false; 
windows_4_file = "windows_4.svg"; 
win_4_h = 2400;
win_4_z = 150;

// --- Internal calculation: Convert real mm back to SVG scale ---
_sticker_tol_svg = sticker_tolerance_mm / scale_f;

// --- [Modeling Engine] ---
module build_house() {
    // 1. Generate Floor Base
    color("White") {
        linear_extrude(height = floor_thickness) {
            scale([scale_f, scale_f, 1]) {
                offset(delta = wall_outline_offset) 
                    import(walls_outline_file);
            }
        }
    }

    // 2. Wall Logic
    translate([0, 0, floor_thickness]) {
        difference() {
            // --- Generate All Wall Structures ---
            union() {
                if (use_walls_outline) {
                    color("Gray")
                    linear_extrude(height = wall_outline_height * scale_f)
                        scale([scale_f, scale_f, 1])
                            difference() {
                                offset(delta = wall_outline_offset) import(walls_outline_file);
                                offset(delta = -wall_outline_offset) import(walls_outline_file);
                            }
                }
                if (use_walls_1) {
                    color("Gray")
                    linear_extrude(height = wall_1_height * scale_f)
                        scale([scale_f, scale_f, 1])
                            offset(delta = wall_1_offset) import(walls_1_file);
                }
                if (use_walls_2) {
                    color("LightGray")
                    linear_extrude(height = wall_2_height * scale_f)
                        scale([scale_f, scale_f, 1])
                            offset(delta = wall_2_offset) import(walls_2_file);
                }
                if (use_walls_3) {
                    color("LightGray")
                    linear_extrude(height = wall_3_height * scale_f)
                        scale([scale_f, scale_f, 1])
                            offset(delta = wall_3_offset) import(walls_3_file);
                }
                if (use_walls_4) {
                    color("LightGray")
                    linear_extrude(height = wall_4_height * scale_f)
                        scale([scale_f, scale_f, 1])
                            offset(delta = wall_4_offset) import(walls_4_file);
                }
            }

            // --- Cutout Doorways ---
            // translate z-offset of -0.05 ensures a clean cut through the floor/wall junction
            if (use_doors_1) {
                color("Red", 0.5) 
                translate([0, 0, -0.05]) {
                    linear_extrude(height = doors_1_h * scale_f + 0.1)
                        scale([scale_f, scale_f, 1])
                            // offset 设为 0，直接使用 Inkscape 里的厚矩形
                            offset(delta = 0) 
                                import(doors_1_file);
                }
            }
            if (use_doors_2) {
                color("Red", 0.5) 
                translate([0, 0, -0.05]) {
                    linear_extrude(height = doors_2_h * scale_f + 0.1)
                        scale([scale_f, scale_f, 1])
                            offset(delta = 0) 
                                import(doors_2_file);
                }
            }
            if (use_doors_3) {
                color("Red", 0.5) 
                translate([0, 0, -0.05]) {
                    linear_extrude(height = doors_3_h * scale_f + 0.1)
                        scale([scale_f, scale_f, 1])
                            offset(delta = 0) 
                                import(doors_3_file);
                }
            }

            // --- Cutout Windows ---
            if (use_windows_1) {
                color("SkyBlue", 0.5) 
                translate([0, 0, win_1_z * scale_f - 0.05]) {
                    linear_extrude(height = win_1_h * scale_f + 0.1)
                        scale([scale_f, scale_f, 1])
                            offset(delta = 0) 
                                import(windows_1_file);
                }
            }
            if (use_windows_2) {
                color("SkyBlue", 0.5) 
                translate([0, 0, win_2_z * scale_f - 0.05]) {
                    linear_extrude(height = win_2_h * scale_f + 0.1)
                        scale([scale_f, scale_f, 1])
                            offset(delta = 0) 
                                import(windows_2_file);
                }
            }
            if (use_windows_3) {
                color("SkyBlue", 0.5) 
                translate([0, 0, win_3_z * scale_f - 0.05]) {
                    linear_extrude(height = win_3_h * scale_f + 0.1)
                        scale([scale_f, scale_f, 1])
                            offset(delta = 0) 
                                import(windows_3_file);
                }
            }
            if (use_windows_4) {
                color("SkyBlue", 0.5)
                translate([0, 0, win_4_z * scale_f - 0.05]) {
                    linear_extrude(height = win_4_h * scale_f + 0.1)
                        scale([scale_f, scale_f, 1])
                            offset(delta = 0) 
                                import(windows_4_file);
                }
            }
        }
    }
}

// --- [Module: Floor Template] ---
module draw_floor_sticker() {
    color("SaddleBrown")
    linear_extrude(height = sticker_thickness) {
        scale([scale_f, scale_f, 1]) {
            union() {
                // Part 1: Net Floor Space (Calculating the printable floor area)
                difference() {
                    // Base Area: Inward offset by the physical tolerance to ensure a loose fit
                    offset(delta = wall_outline_offset - _sticker_tol_svg) import(walls_outline_file);
                    
                    // Clear Exterior Residue: Subtracting everything outside the inner wall boundary
                    // (10/scale_f ensures the 'cutter' is large enough to clean all artifacts)
                    difference() {
                        offset(delta = wall_outline_offset + 10/scale_f) import(walls_outline_file); 
                        offset(delta = -wall_outline_offset - _sticker_tol_svg) import(walls_outline_file);
                    }
                    
                    // Subtract Interior Walls: Expanded by the physical tolerance to prevent buckling
                    if (use_walls_1) offset(delta = wall_1_offset + _sticker_tol_svg) import(walls_1_file);
                    if (use_walls_2) offset(delta = wall_2_offset + _sticker_tol_svg) import(walls_2_file);
                    if (use_walls_3) offset(delta = wall_3_offset + _sticker_tol_svg) import(walls_3_file);
                    if (use_walls_4) offset(delta = wall_4_offset + _sticker_tol_svg) import(walls_4_file);
                }
                
                // Part 2: Doorway Footprints (Extends floor coverage into doorways)
                if (use_doors_1) offset(delta = 0) import(doors_1_file);
                if (use_doors_2) offset(delta = 0) import(doors_2_file);
                if (use_doors_3) offset(delta = 0) import(doors_3_file);
            }
        }
    }
}

// Execution logic
if (view_mode == "house") {
    build_house();
} else if (view_mode == "sticker") {
    draw_floor_sticker();
}
