function RGB = HSI2RGB(image)
% spectral data visualization especially for MIID dataset
%% Get the color matching functions. 
% ref1: http://cvrl.ioo.ucl.ac.uk/cmfs.htm
% ref2: https://ww2.mathworks.cn/matlabcentral/fileexchange/7021-spectral-and-xyz-color-functions?focused=5172027&tab=function

	[row,col,band] = size(image);
	[lambda, xFcn, yFcn, zFcn] = colorMatchFcn('1931_FULL');

%% Process color matching functions.
    wavelength = [451.485717773438; 452.468750000000; 453.459259033203;
                  454.457366943359; 455.463165283203; 456.476806640625;
                  457.498352050781; 458.527984619141; 459.565795898438;
                  460.611938476563; 461.666503906250; 462.729644775391;
                  463.801483154297; 464.882171630859; 465.971862792969;
                  467.070678710938; 468.178771972656; 469.296295166016;
                  470.423431396484; 471.560302734375; 472.707092285156;
                  473.863983154297; 475.031097412109; 476.208648681641;
                  477.396850585938; 478.595794677734; 479.805755615234;
                  481.026916503906; 482.259429931641; 483.503540039063;
                  484.759460449219; 486.027374267578; 487.307525634766;
                  488.600158691406; 489.905487060547; 491.223754882813;
                  492.555206298828; 493.900115966797; 495.258697509766;
                  496.631286621094; 498.018127441406; 499.419464111328;
                  500.835662841797; 502.266998291016; 503.713745117188;
                  505.176269531250; 506.654907226563; 508.149932861328;
                  509.661773681641; 511.190734863281; 512.737243652344;
                  514.301635742188; 515.884277343750; 517.485717773438;
                  519.106201171875; 520.746276855469; 522.406372070313;
                  524.086975097656; 525.788513183594; 527.511535644531;
                  529.256530761719; 531.024047851563; 532.814575195313;
                  534.628784179688; 536.467224121094; 538.330505371094;
                  540.219238281250; 542.134155273438; 544.075805664063;
                  546.045043945313; 548.042541503906; 550.069091796875;
                  552.125427246094; 554.212463378906; 556.330993652344;
                  558.481872558594; 560.666137695313; 562.884643554688;
                  565.138488769531; 567.428710937500; 569.756347656250;
                  572.122558593750; 574.528564453125; 576.975585937500;
                  579.464904785156; 581.997863769531; 584.575866699219;
                  587.200500488281; 589.873168945313; 592.595520019531;
                  595.369323730469; 598.196228027344; 601.078186035156;
                  604.017150878906; 607.015075683594; 610.074157714844;
                  613.196655273438; 616.384826660156; 619.641296386719;
                  622.968566894531; 626.369445800781; 629.846679687500;
                  633.403442382813; 637.042846679688; 640.768310546875;
                  644.583251953125; 648.491455078125; 652.496887207031;
                  656.603637695313; 660.815979003906; 665.138610839844;
                  669.576354980469; 674.134216308594; 678.817626953125;
                  683.632202148438; 688.583923339844; 693.678955078125;
                  698.923889160156];
              switch(band)
                  case 40
                      wavelength = wavelength(1:3:118);
                  otherwise
                      wavelength = wavelength(1:118);
                  
              end
    
	xFcn = interp1(lambda,xFcn,wavelength,'linear')';
    yFcn = interp1(lambda,yFcn,wavelength,'linear')';
	zFcn = interp1(lambda,zFcn,wavelength,'linear')';  
    
    xFcn = xFcn/sum(xFcn);
    yFcn = yFcn/sum(yFcn);
    zFcn = zFcn/sum(zFcn);
    
%% Convert the hyperspectral image to XYZ image

    A = reshape(image,row*col,band);
    XYZ = A*[xFcn',yFcn',zFcn'];
    
	XYZ = max(XYZ,0);
    XYZ = XYZ/max(max(XYZ(:)),1);

    RGB = xyz2rgb(reshape(XYZ,row,col,3),'WhitePoint','e');
    RGB = max(RGB,0);
    RGB = RGB/max(max(RGB(:)),1);
    %figure;imshow(RGB);

end

