%CSC4630 Matlab Semester Project
%MATLAB-based inspection system
%Group Member: Chengpeng Wu, Rachel Abraham, Sahba Atarodi

video = "test.mp4";
vidObj = VideoReader(video);
a=2;
nFrames = vidObj.NumberOfFrames;
vFrameRate = vidObj.FrameRate;
fs=44100;
[audio_input, fs] = audioread(video);
fprintf('Generating different frames\n');
for i = 1 : nFrames
     frame = read(vidObj,i);
     frame=rgb2gray(frame);
     thresh = graythresh(frame);     
     frame = imbinarize(frame,0.6);       
     
     w = fspecial('gaussian',[3,3],2);
     frame = imfilter(frame,w,'replicate');

     frame=medfilt2(frame,[5 5]);

     imwrite(frame,fullfile('frame\',[num2str(i) '.jpg']));
     fprintf('Converting the %d frame...\n',i);
end
fprintf('Completed\n');
fprintf('Start playing ...\n');
readPic();
fprintf('End of playing\n');