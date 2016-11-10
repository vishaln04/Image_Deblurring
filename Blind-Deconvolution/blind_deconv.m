%This matlab script demonstrates the effectiveness of deblurring
%with the blind deconvolution algorithm. The blind deconvolution algorithm
%requires a guessed value for the point spread function. The initial guess
%was found manually by guessing and checking with different values for the
%radius of a disk filter, as well as different values for the number of
%iterations of the blind deconvolution algorithm. Then for values near the
%initial guess, we systematically iterated through those values to find an
%arguably better guess. 

close all; 
clear all; 


%actual image
y = rgb2gray((imread('note.jpg'))); 
y = im2double(y); 

%image preprocessing
yblur = rgb2gray((imread('note_blurred_s.jpg')));
yblur = im2double(yblur); 

%define the blur kernel
% PSF = fspecial('disk', 8);

%create blurred image
% yblur = imfilter(y, PSF, 'circular','conv'); 
figure(); 
%plot the unblurred and blurred image
subplot(2,1,1); imshow(y); title('original image'); 
subplot(2,1,2); imshow(yblur); title('blurred image');




%deconvolve with different sized psf to determine best psfsize for
%restoring image
figure(); 
%manual guess for PSF
PSFG = fspecial('disk',5.4) 
ydeblurred = deconvblind(yblur,PSFG, 18); 
imshow(ydeblurred); 
title('blind deconvolution: Disk Radius =5.4, number of iterations = 18'); 

%deconvolving at varying values of Disk radius

figure();suptitle('Varying values of PSF disk radius'); 
subplot(2,2,1); imshow(ydeblurred); 
title('number of iterations = 18 and disk radius = 5.4');

PSFG1 = fspecial('disk', 1); 
subplot(2,2,2); imshow(deconvblind(yblur,PSFG1,18));
title('number of iterations = 18 and disk radius = 1'); 

PSFG2 = fspecial('disk', 100); 
subplot(2,2,3); imshow(deconvblind(yblur,PSFG2,18));
title('number of iterations = 18 and disk radius = 100'); 

PSFG3 = fspecial('disk', 150); 
subplot(2,2,4); imshow(deconvblind(yblur,PSFG3,18));
title('number of iterations = 18 and disk radius = 150'); 

%deconvolution at varying values for number of blind deconvolution
%iterations

figure();suptitle('Varying values of number of blind deconvolution iterations'); 
subplot(2,2,1); imshow(ydeblurred); 
title('number of iterations = 18 and disk radius = 5.4');
 
subplot(2,2,2); imshow(deconvblind(yblur,PSFG,1));
title('number of iterations = 1 and disk radius = 5.4'); 

subplot(2,2,3); imshow(deconvblind(yblur,PSFG,50));
title('number of iterations = 50 and disk radius = 5.4'); 
 
subplot(2,2,4); imshow(deconvblind(yblur,PSFG,100));
title('number of iterations = 100 and disk radius = 5.4'); 
