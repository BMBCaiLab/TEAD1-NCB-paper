// This is a semi-automated script that uses Trainable Weka Segmentation to segment 
// an image stack using a 'mask' image as reference.
// November 11, 2025
// Written by Choon Leng So, adapted by Eleanor Liu

path="/Volumes/Elements EL/SPT/TEAD1/260123/";

movPath = "260123_mov/";
maskPath = "260123_mask/";

//file name
CellType = "260123_UOK342_HaloH2B_slow_cell5";

CellNo = ".nd2] autoscale color_mode=Default stack_order=Default";

run("Bio-Formats Importer", "open=["+ path + maskPath + CellType  + "_m" + CellNo);

//make folder that results will populate to
outPath = path + "260123_analysis/"
inPath = path + "260123_analysis/"


//if ROI
roiManager("reset");

//duplicate for use
run("Duplicate...", "duplicate");

run("Gaussian Blur...", "sigma=2");

// if using weka
run("Trainable Weka Segmentation");

waitForUser("Do Weka", "click ok to load results"); //do assisted segmentation

//get mask
call("trainableSegmentation.Weka_Segmentation.getResult");
selectImage("Classified image");

setAutoThreshold("Default no-reset");
//setThreshold(0, 0);
setOption("BlackBackground", false);
run("Convert to Mask");


waitForUser("Verify ROI", "Like this ROI?"); //test check


/*
// if using manual ROI
setAutoThreshold("Default no-reset");
open(path + CellType + "_mask1_roi.roi");
roiManager("add");
*/

run("Analyze Particles...", "size=100-Infinity show=Overlay display exclude include add");

setForegroundColor(0, 0, 0);
setBackgroundColor(0, 0, 0);
close();

//Open stack

run("Bio-Formats Importer", "open=["+ path + movPath + CellType + CellNo);
run("Duplicate...", "duplicate");

roiManager("select", 0);
run("Clear Outside", "stack");
imgtitle = getTitle();
saveAs("Tiff", inPath + "in_" + imgtitle );
close();

run("Close All");

