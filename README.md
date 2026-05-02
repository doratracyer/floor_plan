# Floor Plan Customization
3D-printable floor plan generator: Convert SVG layouts into 3D models.

# Required Software
Due to SVG import restrictions on MakerWorld's cloud tools, this specific script for floor plans must be run locally (though the scripts for doors and windows are available online).
To get started, you will need to download OpenSCAD. Simply search for "OpenSCAD" to find the official website and download links.
Once installed, you can obtain the code in two ways:

1. The ZIP file provided in the project attachments.
2. The GitHub link [Insert Link Here].


# General Workflow

The program requires standardized **SVG** **files** to determine the coordinates of walls, doors, and windows.

- **If you know** **SVG****:** Follow the drawing specifications below.
    
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
