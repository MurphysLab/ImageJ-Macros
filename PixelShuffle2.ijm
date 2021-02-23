// Shuffle Pixel Data 2
// Jeffrey N. Murphy 2021-02-23

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
shuffleFY(values);

// Shuffle Function
// http://en.wikipedia.org/wiki/Fisher-Yates_shuffle
function shuffleFY(array) {
   n = array.length;  // n = number of items to shuffle
   while (n > 1) {
      m = Math.floor(n * random());     // 0 <= m < n. 
      n--; // n = length; the last item in array (0.... n-1) 
      // swap elements array[m], array[n] = array[n], array[m]
      temp = array[n];  
      array[n] = array[m];
      array[m] = temp;
   }
}

// Re-Draw
i = 0;
for(y=0; y<h; y++){
	for(x=0; x<w; x++){
		setPixel(x,y,values[i]);
		i++;
	}
}