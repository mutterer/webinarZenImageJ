run("ROI Manager...");
roiManager("reset");
setBatchMode(true);
id=getImageID;
run("Duplicate...", "title=temp");

run("RGB Stack");
run("32-bit");
Stack.setChannel(1);
run("Multiply...", "value=-1 stack");
Stack.setChannel(2);
run("Multiply...", "value=-2 slice");
run("Z Project...", "projection=[Sum Slices]");

setAutoThreshold("Default dark");

run("Analyze Particles...", "add stack");

selectImage(id);
setBatchMode(false);

roiManager("show all with labels");
run("Set Measurements...", "area mean display slice redirect=None decimal=6");

