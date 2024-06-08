

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
x30=0.2*exp(-1j*2*pi*0.5*t);
x=x10+x20+x30;

%% MCVMD
[Z] = MCVMD(x,fs,3);
% xnew1=sum(Z,2);

%% plot
f=(-N/2:N/2-1)/(N/fs);
fig4=figure(4);
plot(f,abs(fftshift(fft(x))/(N/2)),'LineWidth',1.6)
xlabel('Frequency (Hz)')
ylabel('Magnitude')
hold on
plot(f,abs(fftshift(fft(Z)))/(N/2),'-.','LineWidth',1.6)
xlim([-25 25])
legend('Origin','MCVMD','Location','northwest')
set(gca,'FontName','Times New Roman','FontSize',12);

