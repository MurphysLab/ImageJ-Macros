/*  Point-Line Distance Distribution
 *  Jeffrey N. Murphy
 *  2017-04-04
 *  
 *  Before you start:
 *  1. Have the image open
 *  2. Have a line marked on it.
 */


/* User input values
 * These values need to be set according to the range of values
 * expected for your data.
 */

MinValue = 0;
MaxValue = 255;
MaxDist = 500;

// Image dimensions
w = getWidth;
h = getHeight;

// Obtain the line coordinates
getLine(x1, y1, x2, y2, lineWidth);

// Choose a corner as a side
xc = maxOf(0,w*(x2-x1)/abs(x2-x1));
yc = maxOf(0,-1*h*(y2-y1)/abs(y2-y1));


// Record all pixel values

all_values = newArray(w*h);
i = 0;
for(y=0; y<h; y++){
	for(x=0; x<w; x++){
		all_values[i] = getPixel(x,y); 
		i++;
	}
}

// Output window
setBatchMode(true);
newImage("Output", "8-bit black", (MaxDist+1), (MaxValue-MinValue+1), 2);
selectImage("Output");
output = getImageID;

i = 0;
for(y=0; y<h; y++){
	for(x=0; x<w; x++){
		if(all_values[i] >= MinValue && all_values[i] <= MaxValue){
			dist = PointToLineSegment(x1,y1,x2,y2,x,y);
			if(dist[0] <= MaxDist){
				if( (dist[1]-xc)*(dist[1]-xc)+(dist[2]-yc)*(dist[2]-yc) < (x-xc)*(x-xc)+(y-yc)*(y-yc) ){
					setSlice(2);
				}
				else{
					setSlice(1);
				}
				current = getPixel(round(dist[0]),round(all_values[i]));
				current++;
				setPixel(round(dist[0]),round(all_values[i]),current);
			}
		}
		i++;
	}
	showProgress(y,h);
}

open(getDirectory("luts") + "mpl-viridis.lut"); 
run("Enhance Contrast", "saturated=0.35");
setBatchMode(false);

// Functions

/* The below function has been modified from its original
 * Commenting-out the if statement returns this to being for
 * an infinite line, rather than for a finite line segment.
 */

// Actual shortest distance between a finite line segment and a point
// (x1,y1) & (x2,y2) are the line segment (x3,y3) is the point.
// based on quano's answer: http://stackoverflow.com/questions/849211/shortest-distance-between-a-point-and-a-line-segment
function PointToLineSegment(x1,y1,x2,y2,x3,y3){
	px = x2 - x1; py = y2 - y1;
	something = px * px + py * py;
	u = ((x3 - x1) * px + (y3 - y1) * py) / something;
	//if(u>1){u = 1;} else if(u<0){u = 0;}
	x = x1 + u * px; y = y1 + u * py;
	dx = x - x3; dy = y - y3;
	dist = sqrt(dx*dx + dy*dy);
	result = newArray(dist,x,y);
	return result;
}
