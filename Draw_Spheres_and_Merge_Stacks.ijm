// Sphere A

newImage("A", "8-bit white", 100, 100, 100);
run("Invert", "stack");
a = getImageID();

r = 30;
rr = r*r;

y_offset = 30
x_offset = 30
z_offset = 50.5

w = getWidth();
h = getHeight();
d = nSlices();

for(z=1; z<=d; z++){
	setSlice(z);
	zo = z_offset-z;
	zz = zo*zo;
	for(x=0; x<w; x++){
		xo = x_offset - x;
		xx = xo*xo;
		for(y=0; y<h; y++){
			yo = y_offset - y;
			yy = yo*yo;
			if( (xx+yy+zz) < rr){
				setPixel(x,y,255);
			}
			else{setPixel(x,y,0);}
		}
	}
}

// Sphere B

newImage("B", "8-bit white", 100, 100, 100);
run("Invert", "stack");
b = getImageID();

r = 40;
rr = r*r;

y_offset = 60
x_offset = 60
z_offset = 50.5

w = getWidth();
h = getHeight();
d = nSlices();

for(z=1; z<=d; z++){
	setSlice(z);
	zo = z_offset-z;
	zz = zo*zo;
	for(x=0; x<w; x++){
		xo = x_offset - x;
		xx = xo*xo;
		for(y=0; y<h; y++){
			yo = y_offset - y;
			yy = yo*yo;
			if( (xx+yy+zz) < rr){
				setPixel(x,y,255);
			}
			else{setPixel(x,y,0);}
		}
	}
}

// Overlay Image

newImage("C", "RGB white", 100, 100, 100);
c = getImageID();

w = getWidth();
h = getHeight();
d = nSlices();

// Overlay Data

setBatchMode(true);

for(z=1; z<=d; z++){
	selectImage("A"); setSlice(z);
	selectImage("B"); setSlice(z);
	selectImage("C"); setSlice(z);
	for(x=0; x<w; x++){
		for(y=0; y<h; y++){
			
			selectImage(a);
			//setSlice(z);
			value_A = getPixel(x,y);
			
			selectImage(b);
			//setSlice(z);
			value_B = getPixel(x,y);

			selectImage(c);
			//setSlice(z);
			setPixel(x,y,value_A*256*256+value_B*256);
		}
	}
	showProgress(z/d);
}

setBatchMode(false);

// 3D image Viewer

run("3D Viewer");
call("ij3d.ImageJ3DViewer.setCoordinateSystem", "false");
call("ij3d.ImageJ3DViewer.add", "C", "None", "C", "0", "true", "true", "true", "2", "0");