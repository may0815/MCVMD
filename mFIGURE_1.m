

clear
close all
%% signal generate
fs=50; 
ts=3;
N=fs*ts;
nfft=N;
t=(0:N-1)/fs;
x10=0.5*exp(-1j*2*pi*8*t);
x20=exp(1j*2*pi*(-1*t+0.6*t.^2));
x30=0.8*exp(1j*2*pi*(16*t+0.2*t.^2));

x=x10+x20+x30;

%% CVM
nfft1=10000;
nump=3;
numn=3;
Xw=fftshift(fft(x.',nfft1));               %第一步fft，目的是把左右频谱分开，还会ifft回去的
Hw=[zeros(nfft1/2,1);ones(nfft1/2,1)];     %第二步左右分开，因为解析信号只有右半频谱。
Xw_p=Hw.*Xw;
Xw_n=Hw.*conj(flip(Xw));
xw_p=real(ifft(fftshift(Xw_p)));         %此时它就是解析信号，取了实部          
xw_n=real(ifft(fftshift(Xw_n)));         %此时它就是解析信号，取了实部        
xw_p=xw_p(1:N);
xw_n=xw_n(1:N);

[imf_p0,residual1,info1] = vmd(xw_p,'NumIMFs',nump);  %此时把实信号分成多个imf
[imf_n0,residual2,info2] = vmd(xw_n,'NumIMFs',numn);

for i=1:nump
    imf_p(:,i) = (hilbert(imf_p0(:,i)));
end
for i=1:numn
    imf_n(:,i) = (conj(hilbert(imf_n0(:,i))));  
end

xnew=sum(imf_p,2)+sum(imf_n,2);

%% plot
f=(-N/2:N/2-1)/(N/fs);
fig1=figure(1);
plot(f,abs(fftshift(fft(x))/(N/2)),'LineWidth',1.6)
xlabel('Frequency (Hz)')
ylabel('Magnitude')
hold on
plot(f,abs(fftshift(fft(xnew)))/(N/2),'-.','LineWidth',1.6)
xlim([-25 25])
legend('Origin','CVMD','Location','northwest')
set(gca,'FontName','Times New Roman','FontSize',12);



