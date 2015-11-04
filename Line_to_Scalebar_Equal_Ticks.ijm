// Sample image:

//newImage("Untitled", "8-bit black", 400, 400, 1);
//makeLine(76, 282, 323, 62);

// how many pieces do you want to divide the line into?

N = 10;

Npts = 2+3*(N-1);

Roi.getCoordinates(xpoints, ypoints);

a = (ypoints[1]-ypoints[0])/(xpoints[1]-xpoints[0]); // slope

scaleby = 10;

if(a!=0){
	ai = -1/a;
	xi = 1;
	yi = ai*xi;
	xn = scaleby*1/(1 + yi*yi);
	yn = scaleby*yi/(1+yi*yi);
}
else{
	xn = 0;
	yn = scaleby*1;
}

xcoord = newArray(Npts);
ycoord = newArray(Npts);

count = 0;

for(i=0; i<Npts; i++){
	if(i==0){
		xcoord[i] = xpoints[0];
		ycoord[i] = ypoints[0];
	}
	else if( (i-1)%3 == 0){
		count++;
		xcoord[i] = (xpoints[1]-xpoints[0])*count/N + xpoints[0];
		ycoord[i] = (ypoints[1]-ypoints[0])*count/N + ypoints[0];
	}
	else if( (i-2)%3 == 0){
		xcoord[i] = xcoord[i-1]+xn;
		ycoord[i] = ycoord[i-1]+yn;
	}
	else if( (i-3)%3 == 0){
		xcoord[i] = xcoord[i-2];
		ycoord[i] = ycoord[i-2];
	}
}

makeSelection("freeline", xcoord, ycoord);
Roi.setStrokeColor("red");