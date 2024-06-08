function [imf_p,imf_n] = CVMD(x,nump,numn)

N=length(x);
nfft1=100000;
Xw=fftshift(fft(x.',nfft1));               %第一步fft，目的是把左右频谱分开，还会ifft回去的
Hw=[zeros((nfft1/2),1);ones((nfft1/2),1)];     %第二步左右分开，因为解析信号只有右半频谱。
Xw_p=Hw.*Xw;
Xw_n=Hw.*conj(flip(Xw));
xw_p=real(ifft(fftshift(Xw_p)));         %此时它就是解析信号，取了实部          
xw_n=real(ifft(fftshift(Xw_n)));         %此时它就是解析信号，取了实部        
xw_p=xw_p(1:N);
xw_n=xw_n(1:N);
imf_p=[];
imf_n=[];
if nump>0
[imf_p0] = vmd(xw_p,'NumIMFs',nump); 
for j=1:nump
imf_p(:,j) = (hilbert(imf_p0(:,j)));
end

end


if numn>0
[imf_n0] = vmd(xw_n,'NumIMFs',numn); 
for j=1:numn
imf_n(:,j) = (conj(hilbert(imf_n0(:,j))));        %瞬时相位
end

end




end

