clear
close all

%% signal generate
fs=100; 
ts=5;
N=fs*ts;
nfft=N;
t=(0:N-1)/fs;
index1=5:N-6;
x10=cos(0.2*t).*exp(1j*2*pi*1*(-1*t+0.5*t.^2));
x20=0.2*(1*t).*exp(1j*2*pi*(28*t-sin(1*pi*t)));
x=x10+x20;
% x=awgn(x,10);
f=(-N/2:N/2-1)/(N/fs);
tu=tiledlayout(1,3);
tu.TileSpacing = 'compact';
tu.Padding = 'compact';
nexttile
plot(f,abs(fftshift(fft(x))/(N/2)),'LineWidth',1.8)
xlabel('Frequency (Hz)')

%% MCVMD numm=1;
numm=1;
[Z] = MCVMD(x,fs,numm);
leg_str1{1}='Origin';
for i=1:numm
hold on
plot(f,abs(fftshift(fft(Z(:,i))))/(N/2),'-.','LineWidth',1.2)
leg_str1{i+1} = ['Mode ',num2str(i)];  
end
legend(leg_str1,'Location','northwest')
title(['Decomposition number K=',num2str(numm)]);
set(gca,'FontName','Times New Roman','FontSize',12);
xlim([-39 49])
ylabel('Magnitude')
xlabel({'Frequency (Hz)';'(a)'});
mse1(1,1)=mse(real(Z(index1,1)),real(x10(index1)).');
mse1(1,2)=mse(imag(Z(index1,1)),imag(x10(index1)).');
mse1(1,3)=NaN;
mse1(1,4)=NaN;

%% numm=2;
numm=2;
[Z] = MCVMD(x,fs,numm);
leg_str2{1}='Origin';
nexttile
plot(f,abs(fftshift(fft(x))/(N/2)),'LineWidth',1.8)
xlabel('Frequency (Hz)')

for i=1:numm
hold on
plot(f,abs(fftshift(fft(Z(:,i))))/(N/2),'-.','LineWidth',1.2)
leg_str2{i+1} = ['Mode ',num2str(i)];  
end
legend(leg_str2,'Location','northwest')
set(gca,'FontName','Times New Roman','FontSize',12);
xlim([-39 49])
xlabel({'Frequency (Hz)';'(b)'});
title(['Decomposition number K=',num2str(numm)]);
mse1(2,1)=mse(real(Z(index1,2)),real(x10(index1)).');
mse1(2,2)=mse(imag(Z(index1,2)),imag(x10(index1)).');
mse1(2,3)=mse(real(Z(index1,1)),real(x20(index1)).');
mse1(2,4)=mse(imag(Z(index1,1)),imag(x20(index1)).');
%% numm=3;
numm=3;
[Z] = MCVMD(x,fs,numm);
leg_str3{1}='Origin';
nexttile
plot(f,abs(fftshift(fft(x))/(N/2)),'LineWidth',1.8)
xlabel('Frequency (Hz)')

for i=1:numm
hold on
plot(f,abs(fftshift(fft(Z(:,i))))/(N/2),'-.','LineWidth',1.2)
leg_str3{i+1} = ['Mode ',num2str(i)];  
end
legend(leg_str3,'Location','northwest')
set(gca,'FontName','Times New Roman','FontSize',12);
xlim([-39 49])
title(['Decomposition number K=',num2str(numm)]);
xlabel({'Frequency (Hz)';'(c)'});
set(gcf,'unit','centimeters','position',[1 5 36 11]);
mse1(3,1)=mse(real(sum(Z(index1,2:3),2)),real(x10(index1)).');
mse1(3,2)=mse(imag(sum(Z(index1,2:3),2)),imag(x10(index1)).');
mse1(3,3)=mse(real(Z(index1,1)),real(x20(index1)).');
mse1(3,4)=mse(imag(Z(index1,1)),imag(x20(index1)).');
%% numm=4;
numm=4;
[Z] = MCVMD(x,fs,numm);
mse1(4,1)=mse(real(sum(Z(index1,3:4),2)),real(x10(index1)).');
mse1(4,2)=mse(imag(sum(Z(index1,3:4),2)),imag(x10(index1)).');
mse1(4,3)=mse(real(sum(Z(index1,1:2),2)),real(x20(index1)).');
mse1(4,4)=mse(imag(sum(Z(index1,1:2),2)),imag(x20(index1)).');

%% numm=5;
numm=5;
[Z] = MCVMD(x,fs,numm);
mse1(5,1)=mse(real(sum(Z(index1,4:5),2)),real(x10(index1)).');
mse1(5,2)=mse(imag(sum(Z(index1,4:5),2)),imag(x10(index1)).');
mse1(5,3)=mse(real(sum(Z(index1,1:3),2)),real(x20(index1)).');
mse1(5,4)=mse(imag(sum(Z(index1,1:3),2)),imag(x20(index1)).');

%% numm=6;
numm=6;
[Z] = MCVMD(x,fs,numm);
mse1(6,1)=mse(real(sum(Z(index1,5:6),2)),real(x10(index1)).');
mse1(6,2)=mse(imag(sum(Z(index1,5:6),2)),imag(x10(index1)).');
mse1(6,3)=mse(real(sum(Z(index1,1:4),2)),real(x20(index1)).');
mse1(6,4)=mse(imag(sum(Z(index1,1:4),2)),imag(x20(index1)).');
%% 
% numm=7;
% [Z] = MCVMD(x,fs,numm);
% mse1(7,1)=mse(real(Z((index1),1)+Z((index1),2)+Z((index1),3)+Z((index1),4)),real(x10(index1)).');
% mse1(7,2)=mse(imag(Z((index1),1)+Z((index1),2)+Z((index1),3)+Z((index1),4)),imag(x10(index1)).');
% mse1(7,3)=mse(real(Z((index1),6)+Z((index1),7)+Z((index1),5)),real(x20(index1)).');
% mse1(7,4)=mse(imag(Z((index1),6)+Z((index1),7)+Z((index1),5)),imag(x20(index1)).');

%% PLOT RMSE
mse3=sqrt(mse1);
figure;
y1=mean(mse3(:,1:2),2);
plot(1:6,y1,'*-.','LineWidth',1.2)
hold on
y2=mean(mse3(:,3:4),2);
plot(1:6,y2,'s-.','LineWidth',1.2)
hold on;
hi=plot(1,0,'s','color','#D95319','LineWidth',1.2);
text(1-0.2,-0.02,' Fail','color','#D95319','FontSize',12)
set(gca,'FontName','Times New Roman','FontSize',12);
xlim([0.5 6.5])
ylim([-0.1 0.55])
set(gca,'xtick',1:6)
str={'1','2','3','4','5','6'};
set(gca,'xticklabel',str,'FontSize',12)
ylabel('RMSE')
xlabel({'Decomposition number K';'(a)'});
title('The RMSE of decomposed modes')
set(gca,'FontName','Times New Roman','FontSize',12);
legend('Mode 1','Mode 2')
grid on
set(hi,'handlevisibility','off');
 
 