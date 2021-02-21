// Square Cropper
// ImageJ Macro
// Jeffrey N. Murphy, 2021. @MurphysLab.

temp_title = "temp"

// These are squares, so dimensions width_px * height_px:
width_px = 380;
height_px = 380;
area_px_target = width_px * height_px;

// Varies by 0.05 = 5% (95% of area to 105% of area)
fraction_variable = 0.05; 

area_max_px = (1.00 + fraction_variable) * area_px_target;
area_min_px = (1.00 - fraction_variable) * area_px_target;


id_original = getImageID();

run("Duplicate...", "title="+temp_title);
selectWindow(temp_title);
id_temp = getImageID();

// Needs to be 8-bit for thresholding:
run("8-bit");

// Auto-local thresholding. Many options... Phansalkar works best for this particular image:
run("Auto Local Threshold", "method=Phansalkar radius=30 parameter_1=0 parameter_2=0");

// Really the LUT needs to be inverted, but this is quicker to write:
run("Invert");
wait(50);
run("Invert");
wait(50);

// Ensure that desired measurements are collected
run("Set Measurements...", "area mean standard modal min center bounding median redirect=None decimal=3");

// Use Particle Analysis to find squares:
run("Clear Results");
run("Analyze Particles...", "size="+area_min_px+"-"+area_max_px+" show=Masks display exclude include record add");
id_mask = getImageID();


// Close extraneous images. No longer needed:
selectImage(id_mask); close();
selectImage(id_temp); close();

prefix = "rect_";
buffer_px = 10;

for(n=0; n<nResults; n++){
	selectImage(id_original);
	xo = getResult("BX", n) - buffer_px;
	yo = getResult("BY", n) - buffer_px;
	crop_width = width_px + 2 * buffer_px;
	crop_height = height_px + 2 * buffer_px;
	makeRectangle(xo, yo, crop_width, crop_height);
	run("Duplicate...", "title="+prefix+(n+1));
}




//run("Invert");