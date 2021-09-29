%CSC4630 Matlab Semester Project
%MATLAB-based inspection system
%Group Member: Chengpeng Wu, Rachel Abraham, Sahba Atarodi

choice = menu('Choose the type of code you want to scan','Barcode','QR code');
if (choice == 1);
    I = imread("barcode1D.png");
    [msg,detectedFormat,loc] = readBarcode(I,'1D');
    disp("Barcode format: " + detectedFormat);
    xyBegin = loc(1,:);
    Imsg = insertText(I,xyBegin,msg,'BoxOpacity',1,'FontSize',30);
    imSize = size(Imsg);
    Imsg = insertShape(Imsg,'Line',[1 xyBegin(2) imSize(2) xyBegin(2)],'LineWidth',5);
    imshow(Imsg);

elseif  (choice == 2);
    I = imread("download.jfif");
    [msg, ~, loc] = readBarcode(I);
    xyText =  loc(2,:);
    Imsg = insertText(I, xyText, msg, "BoxOpacity", 1, "FontSize", 25);
    Imsg = insertShape(Imsg, "FilledCircle", [loc, ...
    repmat(10, length(loc), 1)], "Color", "red", "Opacity", 1);
    imshow(Imsg)
end
