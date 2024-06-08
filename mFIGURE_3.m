clear
Fall1=zeros(1024,12);
for i=1:4000
fs=1;
ts=1024;
N=fs*ts;
x=randn(1,N)+1j*randn(1,N);
f=(-N/2:N/2-1)/(N/fs);

[Z] = MCVMD(x,fs,12);

F1=abs(fftshift(fft(Z)));
Fall1=F1+Fall1;

end
fig3=figure(3);
plot(f*2,Fall1/(N/2)/240,'LineWidth',1.6)
xlabel('Normalized frequency ')
ylabel('Amptitude')
set(gca,'FontName','Times New Roman','FontSize',12);
