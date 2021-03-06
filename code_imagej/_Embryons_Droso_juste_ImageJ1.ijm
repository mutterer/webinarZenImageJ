// segmentation simple juste avec ImageJ1

setSlice(2);
run("Duplicate...", "duplicate channels=2-2");
run("Gaussian Blur...", "sigma=2");
setAutoThreshold("Huang dark");
setOption("BlackBackground", false);
run("Convert to Mask");
run("Watershed");
run("Analyze Particles...", "exclude add");
close();
roiManager("Show All");
