(1) TRAINING
	To Execute the Training Procedure, Open the Training Folder and run the "RunMeTrain.m" file, this procedure will take about 30-45mins. It'll generate 2 files namely, 	"AvgFace.mat" and "gbestFinal.mat", which will be used for Training purposes. For Demo these files have been already included and Training need not be done again.

(2) TESTING
	To try out the Face Detection Code, Open the Testing Folder and run the "TESTINGWrapper.m" file, this will display the output detected face if the code has found any 	face. The Bounding Box of the face is stored in BBox in the format [x, y, width, height].

(3) OUTPUTS
	For ease of evaulation, we have included the Outputs of our face detection algorithm in a folder named "Out".

(4) EXTRA OUTPUTS
	We tried our algorithm on some extra group images, these outputs are included in a foler named "ExtraOutputs".

NOTE: Our FD Code uses matlab's inbuilt eyes, nose and mouth detector to decrease false positives, as we did not have the time to re-train our system to detect eyes, nose and mouth. However, same procedure can be used to train for eyes, nose and mouth.
