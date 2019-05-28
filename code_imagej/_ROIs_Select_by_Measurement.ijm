// visually select and count ROIs according to 1 threshold

  parameters=split(Table.headings);

  Dialog.create("Colorize ROIs");
  Dialog.addChoice("Colorize ROIs by", parameters, "StdDev");
  Dialog.addNumber("Seuil", 1100);
  Dialog.show();

  parameter = Dialog.getChoice();
  thr = Dialog.getNumber();

  count = roiManager('count');

  Stack.setActiveChannels("00");

  n=0;

  for (i=0; i<count; i++) {
      roiManager('select', i);
      value = getValue(parameter);
      color = 'blue';
      if (value>thr) {
	color = 'red';
        n++;
      }
      Roi.setStrokeColor(color);
      Roi.setStrokeWidth(2);
      roiManager('update');
  }

  Stack.setActiveChannels("11");

  roiManager("Show All");
  
print (count,n);
  

