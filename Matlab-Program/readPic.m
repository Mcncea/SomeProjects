%CSC4630 Matlab Semester Project
%MATLAB-based inspection system
%Group Member: Chengpeng Wu, Rachel Abraham, Sahba Atarodi

function test_cxk_readpic();
video = "test.mp4";
vidObj = VideoReader(video);


a=2;
nFrames = vidObj.NumberOfFrames;
vFrameRate = vidObj.FrameRate;

%[audio_input, fs] = audioread(video);
%sound(audio_input, fs);


    for i = 1 : nFrames
    
        t1=clock;
        frame = imread(fullfile('frame\',[num2str(i) '.jpg']));
        image(frame);
        colormap(gray);
        t2=clock;
        pause(0.00015);
    end

close;
end
