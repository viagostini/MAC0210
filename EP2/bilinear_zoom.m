function bilinear_zoom(file,fac)
im0=imread(file);

% due to im0 is a uint8 type, im0 does not support negative
% values and integers grater than 255
im=cast(im0,'int16');
%imshow(cast(im,'uint8')); %due to %imshow does not support int16 
%pause;
[h,v,d]=size(im);

im1 = expand(im, fac-1);

%imshow(cast(im1,'uint8')); %displaying image being mapped from original image.
%bilinear interpolation
for i=1:1+(h-2)*fac     %row number
    x0 = ceil(i/fac)*fac-fac+1;
    for j=1:1+(v-2)*fac %column number
      y0 = ceil(j/fac)*fac-fac+1;

       % maped values from the original picture should not be recalculated.     
       if ((rem(i-1,fac)==0) && (rem(j-1,fac)==0)) 
       
       else  %for pixels that should be calculated.

           % nearest four known pixels for the pixel being calculated.
           h00=im1( x0, y0, :);
           h10=im1( x0 + fac, y0, :);
           h01=im1( x0, y0 + fac, :);
           h11=im1( x0 + fac, y0 + fac, :);
           
           % coordinates of calculating pixel.
           x=rem(i-1,fac);
           y=rem(j-1,fac);  
           % localizing the  pixel being calculated to the nearest
           % four know pixels.        
           dx=x/fac;
           dy=y/fac;
          
           % constants of bilinear interpolation.
           b1=h00;
           b2=h10-h00;
           b3=h01-h00;
           b4=h00-h10-h01+h11;           
           im1(i,j,:)=b1+b2*dx+b3*dy+b4*dx*dy; %equation of bilinear interpolation.
         end
        end
  
end
%imshow(cast(im1,'uint8'));
imwrite(cast(im1,'uint8'),'zoomed_pic_3.png');