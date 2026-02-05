//#@File(label= "Input composite multi channel image" ) image_path 
//
//#@int(label= "Channel A index") channelA
//#@int(label= "Channel A threshold", value=5) thresholdA
//
//#@int(label= "Channel B index") channelB
//#@int(label= "Channel B threshold", value=30) thresholdB


run("Close All");
open("/Volumes/WD_BLACK/Image_Analysis_Cai/Exp9_TRF2_TEAD1/Airyscan/342/"+
"Exp09_20230314_UOK342_TRF2_568_TEAD1_488_Hoeschet_10-Airyscan Processing-01.czi")
title= getTitle();
dir = getDirectory("image");

run("Split Channels");
waitForUser;
//threshold A--> C1
//threshold B -->C2
//threshold C -->C3
//waitForUser;
threshold1 = 8405
threshold2 = 4032
threshold2tead = 2582
//threshold3 = 768


//DIANA segmentation of three channels
C3Title = "C3-"+title ;
C2Title = "C2-"+title ;
C1Title = "C1-"+title ;
//run("DiAna_Segment",  "img=["+C3Title+"] filter=none rad=1.0 thr="+threshold3+"-400-99999-false-false");
//C3LabelTitle = getTitle();

run("DiAna_Segment",  "img=["+C2Title+"] filter=none rad=1.0 thr="+threshold2+"-300-99999-false-false");
C2LabelTitle = getTitle();

run("DiAna_Segment",  "img=["+C2Title+"] filter=none rad=1.0 thr="+threshold2tead+"-3-2000-false-false");
C2TEAD1LabelTitle = getTitle();
rename("TEAD1"+ C2TEAD1LabelTitle);
C2TEAD1LabelTitle = "TEAD1"+ C2TEAD1LabelTitle

run("DiAna_Segment",  "img=["+C1Title+"] filter=none rad=1.0 thr="+threshold1+"-30-99999-false-false");
C1LabelTitle = getTitle();
waitForUser;
//diana analysis of all combinations
////C3C1
//run("DiAna_Analyse", "img1=["+C3Title+
//					"] img2=["+C1Title+
//					"] lab1="+C3LabelTitle+
//					" lab2="+C1LabelTitle+
//					" adja kclosest=9999");			
//saveAs("Results", 
//"/Volumes/WD_BLACK/Image_Analysis_Cai/Ex55_CentromereFISH_TEAD1_H3K9me3#1_20220819/Airyscan/0225_allchannelalaysis/"+"C3C1-"+title+".csv");
//
//run("Close");

////C3C2
//run("DiAna_Analyse", "img1=["+C3Title+
//					"] img2=["+C2Title+
//					"] lab1="+C3LabelTitle+
//					" lab2="+C2LabelTitle+
//					" adja kclosest=9999");			
////saveAs("Results", 
////"/Volumes/WD_BLACK/Image_Analysis_Cai/Ex55_CentromereFISH_TEAD1_H3K9me3#1_20220819/Airyscan/0225_allchannelalaysis/"+"C3C2-"+title+".csv");
////
////run("Close");
////C3C2TEAD1
//run("DiAna_Analyse", "img1=["+C3Title+
//					"] img2=["+C2Title+
//					"] lab1="+C3LabelTitle+
//					" lab2="+C2TEAD1LabelTitle+
//					" adja kclosest=9999");			
//saveAs("Results", 
//"/Volumes/WD_BLACK/Image_Analysis_Cai/Ex55_CentromereFISH_TEAD1_H3K9me3#1_20220819/Airyscan/0225_allchannelalaysis/"+"C3C2_TEAD1-"+title+".csv");
//
//run("Close");
//C2C1
run("DiAna_Analyse", "img1=["+C2Title+
					"] img2=["+C1Title+
					"] lab1="+C2LabelTitle+
					" lab2="+C1LabelTitle+
					" adja kclosest=9999");			
saveAs("Results", 
dir+"C2C1-"+title+".csv");
run("Close");
//C2TEADC1
run("DiAna_Analyse", "img1=["+C2Title+
					"] img2=["+C1Title+
					"] lab1="+C2TEAD1LabelTitle+
					" lab2="+C1LabelTitle+
					" adja kclosest=9999");			
saveAs("Results", dir+"C2TEAD1C1-"+title+".csv");
run("Close");


