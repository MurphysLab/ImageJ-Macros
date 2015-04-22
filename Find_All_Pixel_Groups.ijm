// Macro For Finding All Groups of Connected Pixels
// Jeffrey N. Murphy
// 2015.04.22

option_one = true; // SLOW
option_two = true; // FAST

if(is("binary")==0){ exit("Image needs to be binary!"); }

w = getWidth();
h = getHeight();


// Option 1
if(option_one){
x_array = newArray(w*h);
y_array = newArray(w*h);
group_array = newArray(w*h);

start = getTime();
i = 0;
for(y=0; y<h; y++){
	for(x=0; x<w; x++){
		if(getPixel(x,y)==255){
			x_array[i] = x;
			y_array[i] = y;
			i++;
		}
	}
	showProgress(y/h);
}

//print("Number of points: " i);

x_array = Array.trim(x_array,i);
y_array = Array.trim(y_array,i);
group_array = Array.trim(group_array,i);
Array.fill(group_array,-1);


group = 0;
for(i=0; i<x_array.length; i++){
	x_temp = newArray(1); 
	y_temp = newArray(1);
	if(group_array[i]==-1){
		group_array[i] = group;
		x_temp[0] = x_array[i];
		y_temp[0] = y_array[i];
		setPixel(x_array[i],y_array[i],100);
		k = 0;
		while(k<x_temp.length){
			for(j=i+1; j<x_array.length; j++){
				if(group_array[j]==-1){
					distance = pow(x_temp[k]-x_array[j],2) + pow(y_temp[k]-y_array[j],2);
					if(distance<3){
						x_temp = Array.concat(x_temp,x_array[j]);
						y_temp = Array.concat(y_temp,y_array[j]);
						group_array[j] = group;
						setPixel(x_array[j],y_array[j],100);
					}
				}
			}
			k++;
		}
		group++;
	}
	showProgress(i/x_array.length);
}

//for(i=0; i<x_array.length; i++){
//	print(group_array[i] + " " + x_array[i] + ", " + y_array[i]);
//}
end = getTime();

print("\nOption 1");
print("Groups: " + group);
print("Time: " + ((end-start)/1000) + " s");

changeValues(100,100,255);
}

// Option 2
if(option_two){
x_array = newArray(w*h);
y_array = newArray(w*h);
group_array = newArray(w*h);
Array.fill(group_array,-1);

xd = newArray(0,1,1,1,0,-1,-1,-1);
yd = newArray(1,1,0,-1,-1,-1,0,1);

start = getTime();
i = 0;
group = 0;
for(y=0; y<h; y++){
	for(x=0; x<w; x++){
		if(getPixel(x,y)==255){
			x_array[i] = x;
			y_array[i] = y;
			group_array[i] = group;
			setPixel(x,y,254);
			k = i;
			i++;
			while(k < i){
				xk = x_array[k];
				yk = y_array[k];
				for(j=0; j<8; j++){
					if(getPixel(xk+xd[j],yk+yd[j])==255){
						x_array[i] = xk+xd[j];
						y_array[i] = yk+yd[j];
						
						group_array[i] = group;
						setPixel(xk+xd[j],yk+yd[j],254);
						i++;
					}
				}
				k++;
			}
			group++;	
		}
	}
	showProgress(y/h);
}
//print(i);
end = getTime();
changeValues(254,255,255);

print("\nOption 2");
print("Groups: " + group);
print("Time: " + ((end-start)/1000) + " s");

print("\nNumber of points: " + i);
}

		
		
	