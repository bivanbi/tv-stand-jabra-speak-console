# tv-stand-jabra-speak-console
Simplistic Jabra Speak 510 console for TV stand

## Recommended Print Settings
* Filament: PLA+ / PLA Tough / PETG
* Wall loops: 3 or more
* Infill density: 100%

## Dependencies
### OpenSCAD (required)
Required to render the `.scad` files into STL or other model file format.
Download OpenSCAD from [OpenSCAD](https://www.openscad.org/downloads.html)

### Gotask (optional)
Optional tool to render multiple `.scad` files with ease.

## Render into STL or other model file format

### OpenSCAD - GUI
1. Start OpenSCAD
2. Open the `.scad` file of your choice or create one to customize arrangement
3. Adjust render resolution by setting the `$fn` variable within the `.scad` file.
   A resolution of at least 100 is recommended, e.g.: `$fn = 100;`
4. Do render (keyboard shortcut: `F6`)
5. Export to STL (keyboard shortcut: `F7`) or other format understood by your slicer software

### OpenSCAD - Command line
1. Open a terminal
2. Run OpenSCAD with the `.scad` file of your choice, e.g.:
   ```bash
   openscad -o output.stl -D '$fn=<render resolution>' input.scad
   ```
   You can use any [export format supported by OpenSCAD](https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Export).
   
A render resolution of at least 100 is recommended, e.g.:
```bash
openscad -o output.stl -D '$fn=100' input.scad
```

### Render all `.scad` files in a directory from command line with Gotask
1. Open a terminal
2. Run Gotask with the directory containing the `.scad` files, e.g.:
   ```bash
   cd path/to/directory
   task all
   # or simply
   task
   ```

*This will also create a PNG preview and an STL file for each `.scad` file in the directory.*

### Render a single `.scad` file from command line with Gotask
1. Open a terminal
2. Run Gotask with the directory containing the `.scad` files, e.g.:
   ```bash
   cd path/to/directory
   task render -- <SCAD filename>
   # or
   task render -- <path/to/filename.scad>
   ```

### Create PNG image of a single `.scad` file from command line with Gotask
1. Open a terminal
2. Run Gotask with the directory containing the `.scad` files, e.g.:
   ```bash
   cd path/to/directory
   task bitmap -- <SCAD filename>
   # or
   task bitmap -- <path/to/filename.scad>
   ```

#### Override default settings
##### On commandline:
Invoke Gotask with environment variables set, e.g.:
```bash
RENDER_FORMAT=stl RENDER_RESOLUTION=100 BITMAP_SIZE_X=1920 BITMAP_SIZE_Y=1080 task

# or
export RENDER_FORMAT=stl
export RENDER_RESOLUTION=100
export BITMAP_SIZE_X=1920
export BITMAP_SIZE_Y=1080
task
```

##### Using .env file
**Note**: This is a global setting that cannot be overridden on commandline.

2. Copy the `env.example` file to `.env`:
   ```bash
   cp env.example .env
   ```
2. Edit as needed
3. Run Gotask like normal
