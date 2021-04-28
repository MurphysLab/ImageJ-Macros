// Stack Measurement Demonstration
// Jeffrey N. Murphy (MurphysLab)
// 2021-04-28
// This macro demonstrates how to measure the mean value in an ROI as a function of slice number.


// Make a new stack
newImage("Example Stack", "8-bit white", 200, 200, 40);

// Give each slice in the stack a different value
for(n=0; n<nResults; n++){
	i = floor(255*n/nResults);
	//print(i);
	setSlice(n+1);
	setForegroundColor(i,i,i);
	floodFill(1, 1);
}
setSlice(1);

// Make an ROI selection & Measure the Stack
// Measure Stack can be performed manually: Image > Stack > Measure Stack
makeRectangle(10, 10, 20, 20);
run("Clear Results");
run("Measure Stack...");


// Plot the resulting Data from the Results Table
yValues=newArray(n);
for(i=0;i<n;i++){
	yValues[i]=getResult('Mean',i);
}
Plot.create("Example Plot", "Slice", "Mean Value");
Plot.setLimits(0, n, 0, 255);
Plot.setLineWidth(2);
Plot.setColor("Blue");
Plot.add("circles", yValues);
Plot.show();


// http://imagej.1557.x6.nabble.com/To-plot-mean-values-in-results-table-td5010204.html