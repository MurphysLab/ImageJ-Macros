// Let's draw a scalebar!


// Sample image to open:
run("Leaf");

// Gets rid of existing overlays
Overlay.clear;

// This is the image's internal scale
// There's a ruler in the "Leaf" image, but it can be stored internally
px_per_cm = 53; 

// This are my choices 
scalebar_length_cm = 2;
aspect = 8;

// Scale bar width & height:
bar_width = scalebar_length_cm * px_per_cm;
bar_height  = bar_width / aspect;

// Places selection in top left corner:
makeRectangle(0, 0, bar_width, bar_height);

// Makes selection into an overlay:
Overlay.addSelection("", 0, "#882288AA");