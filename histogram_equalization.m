originalImage=imread('Chinese-peony.jpg');
greyImage=rgb2gray(originalImage);
figure;
imshow(greyImage);

[row,col]=size(greyImage);
pixelCountArray=[];
for i=1:256
    pixelCountArray(i)=0;
end
for x=1:col
    for y=1:row
        index=greyImage(y,x)+1;
        pixelCountArray(index)=pixelCountArray(index)+1;
    end
end
figure;
bar(pixelCountArray);



pixelGammaRectifyImage=[];
gamma=10;
for x=1:col
    for y=1:row
        pixelGammaRectifyImage(y,x)=((double(greyImage(y,x))/255)^gamma)*255;
    end
end
figure;
imshow(pixelGammaRectifyImage);


pixelPdfArray=[];
pixelNum=row*col;
for i=1:256
    pixelPdfArray(i)=pixelCountArray(i)/pixelNum;
end

pixelCdfArray=[];
freqSum=0;
for i=1:256
    pixelCdfArray(i)=freqSum+pixelPdfArray(i);
    freqSum=pixelCdfArray(i);
end
figure;
plot(pixelCdfArray);
remapArray=[];
for i=1:256
    remapArray(i)=int32(255*pixelCdfArray(i)+0.5);
    freqSum=pixelCdfArray(i);
end


for x=1:col
    for y=1:row
        greyImage(y,x)=remapArray(greyImage(y,x)+1);
    end
end
figure;
imshow(greyImage);

equalizedPixelCountArray=[];
for i=1:256
    equalizedPixelCountArray(i)=0;
end
for x=1:col
    for y=1:row
        index=greyImage(y,x)+1;
        equalizedPixelCountArray(index)=equalizedPixelCountArray(index)+1;
    end
end
figure;
bar(equalizedPixelCountArray);
