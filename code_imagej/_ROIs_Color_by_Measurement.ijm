// This macro uses the getValue(measurement) function
// (added in 1.52p) to paint ROI Manager ROIs according 
// to a chosen results table column.
// Author: Jerome Mutterer

 if (!isOpen("Results")||(nImages==0)||roiManager('count')==0) {
     run("Blobs (25K)");
     setAutoThreshold("Default");
     run("Analyze Particles...", "clear include add");
     resetThreshold;
  }

  luts = getList("LUTs");
  parameters=split(Table.headings);

  Dialog.create("Colorize ROIs");
  Dialog.addChoice("Colorize ROIs by", parameters, parameters[0]);
  Dialog.addChoice("Color scheme", luts, luts[0]);
  Dialog.show();
  parameter = Dialog.getChoice();
  lut = Dialog.getChoice();

  setBatchMode(true);
  newImage("lut","8-bit",1,1,1);
  run(lut);
  getLut(reds, greens, blues);
  close();
  setBatchMode(false);

  n = roiManager('count');
  values = Table.getColumn(parameter);
  Array.getStatistics(values, min, max, mean, stdDev);

  for (i=0; i<n; i++) {
      roiManager('select', i);
      value = getValue(parameter);
      index = 255*(value-min)/(max-min);
      Roi.setFillColor(reds[index], greens[index], blues[index]);
      roiManager('update');
  }

  roiManager("Show All");
