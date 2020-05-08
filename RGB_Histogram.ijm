// Macro for Drawing RGB Histograms using Overlays
// Jeffrey N. Murphy, @MurphysLab
// Created: 2020-05-07
// Revised: 2020-05-08

// Notes:
// - will still draw a small square bar for zero values. 

// Stroke Colours & Width:
rgb_stroke = newArray("80FF4040", "8088FF40", "804040FF");
strokeWidth = 2;

// Create arrays to hold the data: 
rgb_counts = newArray(0); // 3*256

// Properties of Selected Image:
w = getWidth();
h = getHeight();
area = w*h;

title = getTitle();

// Obtain Colour-Channel Histograms for Selected Image
run("Split Channels");

for(i=0; i<3; i++){
	selectWindow(title + " " + channel[i]); // Select RGB channel iamges
	nBins = 256;
	getHistogram(values, counts, nBins); // Get individual histograms
	rgb_counts = Array.concat(rgb_counts, counts); // sequentially append histograms
}

// Re-Constitute Selected Image
channel = newArray("(red)", "(green)", "(blue)");
run("Merge Channels...", "c1=["+title+" "+channel[0]+"] c2=["+title+" "+channel[1]+"] c3=["+title+" "+channel[2]+"] create");
composite_ID = getImageID();
run("RGB Color");
rename(title);
selectImage(composite_ID);
close();

//selectWindow("Overlay_Histogram");
newImage("Overlay_Histogram", "RGB white", 1024, 1024, 1);
h_hist = getHeight();
colour_hist_ID = getImageID();


// Set a Scale 
// Max height of the bars
// This can be played with / adjusted
// Currently uses the max value of the histogram
// To scale consistently: 
// use images of the same area or div by image area rather than peak value (& mult by some constant)
Array.getStatistics(rgb_counts, min, max, mean, stdDev);
y_scale = floor(h_hist/max);
print("y_scale: ", y_scale, (h_hist/max));

// Plot the Histogram Bars
for(i=0; i<3; i++){
	strokeColor = rgb_stroke[i];
	for(j=0; j<256; j++){
		// X-axis Position. 
		// For strokeWidth = 2, the bars will each overlap by half. 
		// Need to set a larger "Overlay_Histogram" image size to use wider bars or greater spacing
		x = i+4*j;        
		// Y-axis Position
		y_bottom = h_hist; // bottom of the image (remember: y = 0 is the top of the image)
		y_top = h_hist-y_scale*rgb_counts[j+i*256]; // point above the bottom to which we plot a bar.
		makeLine(x, y_bottom, x, y_top);
		Overlay.addSelection(strokeColor, strokeWidth);
	}
}
run("Select None");
Overlay.show();










