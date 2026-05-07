# Floor Plan Customization
3D-printable floor plan generator: Convert SVG layouts into 3D models.

# Required Software
This code is part of my Floor Plan Generator project on MakerWorld. For more details and to access the full project, please visit the link below:

[Generative 3D Floor Plans @Makerworld](https://makerworld.com/en/models/2746484-generative-3d-floor-plans#profileId-3046420)


To get started, you will need to download `OpenSCAD`. Simply search for "OpenSCAD" to find the official website and download links.

# General Workflow

The program requires standardized **SVG** **files** to determine the coordinates of walls, doors, and windows.

- **If you know SVG**: Follow the drawing specifications below.
    
- **If you are new to SVG**: **Send this tutorial to an AI** ; it can easily teach you the basic skills needed for this project.

The Step-by-Step Process:
1. Draw Walls: Use SVG line segments (Paths).
    - Draw the exterior outline.
    - Draw internal partition walls.
2. Cut Door Openings: Use SVG rectangles.
3. Cut Window Openings: Use SVG rectangles.

|   |   |   |   |
|---|---|---|---|
|1-a outline|1-b internal walls|2 door cuts|3 window cuts|
|![](./assets/tutorial/1.png)<br><br>(Exterior wall outline completed; floor is automatically generated.)|![](./assets/tutorial/2.png)<br><br>(Internal load-bearing walls added.)<br><br>![](./assets/tutorial/3.png)<br><br>(Interior partition walls added.)|![](./assets/tutorial/4.png)|![](./assets/tutorial/5.png)|

# Getting Started & Software Setup

## OpenSCAD Basics

You <u>don't need to write or even read a single line of code</u> to run this. Here is a quick guide to the interface:

  

**The Interface:**

- **Left:** Code Editor (No need to touch).
    
- **Right:** Customizer (Adjust your parameters here).
    
- **Top Center:** Model Preview (Yellow background).
    
- **Bottom Center:** Console/Log (Displays errors; red "import failed" text is normal until you add your SVG files).
    

![](./assets/tutorial/6.png)


## SVG Import Guide

1. **Storage:**
    

SVG files **must** be <u>saved in the same folder</u> as the `.scad` file.

2. **Naming Convention:**
    

Files must <u>follow these exact names</u> for the program to recognize them:

|   |   |
|---|---|
|Category|Filenames|
|walls|walls_outline.svg|
||walls_1.svg|
||walls_2.svg|
|doors|doors_1.svg|
||doors_2.svg|
||doors_3.svg|
|windows|windows_1.svg|
||windows_2.svg|
||windows_3.svg|
||windows_4.svg|


3. **Canvas** **Consistency:**

**Crucial:** All SVG files must <u>use the exact same canvas size</u>. The program determines coordinates based on the relative position of objects on the canvas.

  

## Running and Exporting

- **F5 (Preview):** Use this after saving an SVG or changing a parameter.
    
- **F6 (Render):** Renders the final high-quality model. Required before exporting.
    
- **F7 (Export as** **STL**): Saves the file for your 3D printer. **Ensure you Render (F6) first!**
    

  

# Step-by-Step Drawing Guide

## Step 1: Drawing Walls

### 1. Exterior Outline (`walls_outline.svg`)
    

In your drawing software (e.g., Inkscape), use the **Bezier Curve** tool to draw a **closed path** along the center line of your exterior walls using **REAL-WORLD DIMENSIONS** (mm).

  

![](./assets/tutorial/7.png)

**Key Parameters in the Customizer:**

|   |   |   |   |
|---|---|---|---|
|Group|Parameter|Description|Default|
|1. Global Configuration|`scale_f`|Scales the model to printable size|default 0.02 for 1:50|
||`floor_thickness`|Sets the thickness of the base floor|4|
|2. Wall Settings - Exterior Outline|`use_walls_outline`|Enables the program to render the exterior outline; this is set to **true** by default.|true|
||`wall_outline_height`|Real-world height in mm<br><br>If your home has a suspended ceiling, subtract its height from this value. Otherwise, the scale of subsequent furniture/cabinets may be inaccurate.|2800 for 2.8m|
||`wall_outline_offset`|Wall half-thickness (Offset radius) (If the wall is 240mm, enter `120`)|120|


Exterior wall preview (F5) in OpenSCAD:
![](./assets/tutorial/8.png)

Once you preview with F5, you can export via F6 & F7 and <u>verify the size in your slicer</u> (e.g., BambuStudio).

### 2. Internal Walls (`walls_x.svg`)
    

Draw internal walls along their center lines (indicated by the **green lines** in the tutorial diagram). These **do not** need to be closed paths.
![](./assets/tutorial/9.png)

> **Note:** Because the program expands lines by the "offset" distance, you should "retract" the end of a line by the offset amount where it meets another wall to prevent overlap:


![](./assets/tutorial/10.png)

**Key Parameters:**

|   |   |   |
|---|---|---|
|Group|Parameter|Description|
|3. Wall Settings - Interior Walls|`use_walls_1`|Defaults to **false**; you must check this to **true** to enable.|
||`wall_1_height`|-|
||`wall_1_offset`|-|

_If you have walls with different thicknesses, enable_ _`walls_2`_ _and repeat the process._

3D Preview:

|   |   |
|---|---|
|SVG Layout|3D Preview|
|![](./assets/tutorial/11.png)<br><br>(The three colors represent `walls_outline`, `walls_1`, and `walls_2`; export these as three separate files.)|![](./assets/tutorial/12.png)|

## Step 2: Cutting Door Openings (`doors_x.svg`)

On the same canvas, draw **`rectangles`** where doors are located (light green rectangles in the diagram).

![](./assets/tutorial/13.png)

> **IMPORTANT:** These rectangles MUST be converted to Paths (e.g., in Inkscape, use Path > Object to Path) for the script to recognize the openings correctly.

> **IMPORTANT:** The thickness of the rectangle must be significantly wider than the wall it is cutting through:

|   |   |
|---|---|
|![](./assets/tutorial/14.png)|![](./assets/tutorial/15.png)|


**Key Parameters:**

- **`use_doors_1`**: Check to enable.
    
- **`doors_1_h`**: Height of the door opening (Default `2100mm`).

My SVG Layouts:

|   |   |   |   |
|---|---|---|---|
|Full Overview|doors_1.svg|doors_2.svg|doors_3.svg|
|![](./assets/tutorial/16.png)|![](./assets/tutorial/17.png)|![](./assets/tutorial/18.png)|![](./assets/tutorial/19.png)|

Final Rendered Result:

|   |   |
|---|---|
|F5|F6|
|![](./assets/tutorial/20.png)|![](./assets/tutorial/21.png)|

## Step 3: Cutting Window Openings (`windows_x.svg`)

Similar to doors, use rectangles.

- **`win_x_z`**: This parameter defines the distance from the floor to the bottom of the window (Sill height).
    

|   |   |   |
|---|---|---|
|SVG|F5|F6|
|![](./assets/tutorial/22.png)|![](./assets/tutorial/23.png)|![](./assets/tutorial/24.png)|

The final 3D printed floor plan shell:

![](./assets/tutorial/25.jpg)

## Optional: Floor Cutting Template

If you want to apply "wood floor" stickers, enable **"Floor Cutting Template"** in the **Render Mode**. This generates a thin template (green sheet in the example) that fits perfectly inside your rooms.

![](./assets/tutorial/26.jpg)

**Key Parameters:**

|   |   |   |   |
|---|---|---|---|
|Group|Parameter|Description|Default|
|0. Render Mode|`view_mode`|Select "Floor Cutting Template"|Full House Model|
|1+. Global Configuration - cutting template mode|`sticker_thickness`|Thickness of the sticker|0.4|
||`sticker_tolerance_mm`|Gap between sticker and wall in real mm|0.2|

_Tip: After cutting, you can slice the template at door openings to fit individual rooms. In practice, it may be easier to leave the adhesive backing on while positioning._

# Parametric Doors, Windows, and Cabinets

Once your "shell" is printed, you can generate perfectly fitting components. Since these don't require SVG imports, you can use the **web-based Customizer** on MakerWorld to get:

1. Doors sized exactly to your openings.
    

![](./assets/tutorial/27.jpg)

2. Windows with frames and "glass".
    

![](./assets/tutorial/28.jpg)

3. Custom cabinets with adjustable shelving.
    

![](./assets/tutorial/29.jpg)

Detailed instructions for these components are in the next tutorial.