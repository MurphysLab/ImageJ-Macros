// Shuffle Pixel Data
// Jeffrey N. Murphy 2018-02-22 

// Get Values
w = getWidth;
h = getHeight;
values = newArray(w*h);
i = 0;
for(y=0; y<h; y++){
	for(x=0; x<w; x++){
		values[i] = getPixel(x,y);
		i++;
	}
}

// Shuffle
new_values = newArray(w*h);
for(i=0; i<new_values.length; i++){
	j = round(random*(values.length-1));
	new_values[i] = values[j];
	values_a = Array.slice(values,0,j);
	values_b = Array.slice(values,j+1,values.length);
	values = Array.concat(values_a,values_b);
	showProgress(i,new_values.length);
}

// Re-Draw
i = 0;
for(y=0; y<h; y++){
	for(x=0; x<w; x++){
		setPixel(x,y,new_values[i]);
		i++;
	}
}
