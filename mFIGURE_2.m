clear
Fall1=zeros(1024,6);
Fall2=zeros(1024,6);
for i=1:4000

fs=1;
ts=1024;
N=fs*ts;
x=randn(1,N)+1j*randn(1,N);
f=(-N/2:N/2-1)/(ts);
nfft1=100000;
Xw=fftshift(fft(x.',nfft1));               %第一步fft，目的是把左右频谱分开，还会ifft回去的
Hw=[zeros((nfft1/2),1);ones((nfft1/2),1)];     %第二步左右分开，因为解析信号只有右半频谱。
Xw_p=Hw.*Xw;
Xw_n=Hw.*conj(flip(Xw));
xw_p=real(ifft(fftshift(Xw_p)));         %此时它就是解析信号，取了实部          
xw_n=real(ifft(fftshift(Xw_n)));         %此时它就是解析信号，取了实部        
xw_p=xw_p(1:N);
xw_n=xw_n(1:N);

[imf_p0] = vmd(xw_p,'NumIMFs',6); 
[imf_n0] = vmd(xw_n,'NumIMFs',6); 

for j=1:6
imf_p(:,j) = (hilbert(imf_p0(:,j)));
end

for j=1:6
imf_n(:,j) = (conj(hilbert(imf_n0(:,j))));        %瞬时相位
end

F1=abs(fftshift(fft(imf_p)));
Fall1=F1+Fall1;
F2=abs(fftshift(fft(imf_n)));
Fall2=F2+Fall2;
end

fig2=figure(2);
plot(f*2,Fall1/(N/2)/120/2,'LineWidth',1.6)
hold on
plot(f*2,Fall2/(N/2)/120/2,'LineWidth',1.6)
xlabel('Normalized frequency ')
ylabel('Amptitude')
set(gca,'FontName','Times New Roman','FontSize',12);

