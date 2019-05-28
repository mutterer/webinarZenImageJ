// prétraitement : lissage du canal 2
setSlice(2);
run("Duplicate...", "title=temp");
run("Gaussian Blur...", "sigma=2");
saveAs("Tiff", getDirectory("home")+"fromij.tif");
close();

// lanceur de Fiji dans plugins/Fiji.app/
fiji = getDirectory("imagej")+"Fiji.app"+File.separator+"ImageJ-win64.exe";

// macro Fiji. Attention dépend du plugin Fiji uniquement : H_Watershed
fijiMacro = "open(getDirectory('home')+'fromij.tif');"
 + "run('H_Watershed', 'impin=['+getTitle()+'] hmin=1000.0 thresh=3000.0 peakflooding=100.0 outputmask=true allowsplitting=true');"
 + "run('Analyze Particles...', 'exclude add');"
 + "roiManager('Deselect');"
 + "roiManager('Save', getDirectory('home')+'RoiSet.zip');"
 + "wait(2000);";

// utiliser Fiji en tant que module
resultat = exec(fiji, "--ij2", "--headless", "--console", "--run", fijiMacro );

// ouvrir les ROIs générées par Fiji
run("ROI Manager...");
roiManager("Open", getDirectory("home")+"RoiSet.zip");
roiManager("Show All");
roiManager("Remove Channel Info");
roiManager("Remove Slice Info");
roiManager("Remove Frame Info");

run("Set Measurements...", "area center mean standard min fit shape redirect=None decimal=3");
