/*

PolyLine Equidistant Points Macro

version: 1.00

Jeffrey N. Murphy / @MurphysLab

2022-11-03

Macro draws points (small circles) which are
equidistant, with respect to the length of a polyline,
along its edge.


*/

// User Input:

N = 7; // Number of points

spot_radius = 5; // radius of circle
spot_colour = "#BBFF00BB"; // AARRGGBB (Alpha-Red-Green-Blue)
polyline_colour = "#AA88EE33";

// Clear old overlays & results table

Overlay.clear;
run("Clear Results");
id = getImageID();

// Get Selection Coordinates:

getSelectionCoordinates(xpoints, ypoints);
roiManager("Add"); // Add to ROI Manager

// Calculate total length of line segments:

dist_markers = newArray(xpoints.length);
dist_markers[0] = 0;
dist_total = 0;
for(i=1; i<xpoints.length; i++){
	dist = sqrt( pow(xpoints[i]-xpoints[i-1], 2) + pow(ypoints[i]-ypoints[i-1], 2) );
	dist_total += dist;
	dist_markers[i] = dist_total;
}

fraction_nodes = newArray(xpoints.length);
for(i = 0; i < dist_markers.length; i++) {
	fraction_nodes[i] = dist_markers[i] / dist_total;
}


// Find Positions

N_fractions = newArray(N);
for(i=0; i<N; i++){ N_fractions[i] = (i+1)/(N+1);}

slice_x_pts = newArray(N);
slice_y_pts = newArray(N);


for(i=0; i<N; i++){
	f_target = N_fractions[i];
	j = 0;
	loop = true;
	while (loop) {
		if(fraction_nodes[j] >= f_target){ loop = false; }
		else{ j++; }
	}

	interpolation_fraction = (f_target - fraction_nodes[j-1]) / (fraction_nodes[j] - fraction_nodes[j-1]);

	// Positions of slices:
	
	slice_x_pts[i] = interpolation_fraction*(xpoints[j]-xpoints[j-1]) + xpoints[j-1];
	slice_y_pts[i] = interpolation_fraction*(ypoints[j]-ypoints[j-1]) + ypoints[j-1];

}

// Draw prospective slice points

for(i=0; i<N; i++){
	selectImage(id);
	x = slice_x_pts[i];
	y = slice_y_pts[i];
	xo = x - spot_radius;
	yo = y - spot_radius;
	
	makeOval(xo,yo,2*spot_radius,2*spot_radius);
	Overlay.addSelection(spot_colour, 2);
	Overlay.show;

}

// Draw original
selectImage(id);
makeSelection("polyline", xpoints, ypoints);
Overlay.addSelection(polyline_colour, 2);
Overlay.show;
//run("Select None");

