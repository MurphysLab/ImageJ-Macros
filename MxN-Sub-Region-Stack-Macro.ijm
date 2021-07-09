// MxN Sub-Region Stack Macro
// author: Jeffrey N. Murphy, @MurphysLab
// created: 2021-07-09
// function: Divides stack into sub-regions using an MxN grid

// Create a stack. Comment this out if you already have a stack:
newImage("Example", "8-bit ramp", 500, 500, 8); 

// User Selects a Directory:
path = getDirectory("Select a Directory"); 

w = getWidth();
h = getHeight();

M = 3;
N = 2;

Lw = round(w/M);
Lh = round(h/N);

stack_id = getImageID();

for(z = 1; z <= nSlices; z++){
	setSlice(z);
	for (m = 0; m < M; m++) {
		for (n = 0; n < N; n++) {

			// Selection Parameters
			x = m*Lw;
			y = n*Lh; 
			Lw_max = minOf(Lw+x,w)-x;
			Lh_max = minOf(Lh+y,h)-y;

			// Make Rectangular Selection
			makeRectangle(x, y, Lw_max, Lh_max);

			// Duplicate Selection and Save
			label = "" + m + "-" + n + "---" + z;
			run("Duplicate...", "title="+label);
			temp_id = getImageID();
			saveAs("Tiff", path + label + ".tif");
			selectImage(temp_id);
			close();
			
			selectImage(stack_id);
		}
	}
}
