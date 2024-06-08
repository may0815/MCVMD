

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
fig5=figure(5);
ha = tight_subplot(6,1,[.05 .05],[.08 .03],[.1 .05]);%(行数, 列数, [上下间距 左右间距],[下边距 上边距 ], [左边距 右边距 ])

set(gca,'FontName','Times New Roman','FontSize',12);
axes(ha(1));
plot(t,real(x10),'r-','LineWidth',1.2)

axes(ha(2));
plot(t,imag(x10),'r-','LineWidth',1.2)

axes(ha(3));
plot(t,real(x20),'r-','LineWidth',1.2)

axes(ha(4));
plot(t,imag(x20),'r-','LineWidth',1.2)

axes(ha(5));
plot(t,real(x30),'r-','LineWidth',1.2)

axes(ha(6));
plot(t,imag(x30),'r-','LineWidth',1.2)

%% CVM
nfft1=10000;
nump=2;
numn=2;
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



axes(ha(1));
hold on
plot(t,real(imf_n(:,1)),'g-.','LineWidth',1.2)
ylim([-1 1 ])

axes(ha(2));
hold on
plot(t,imag(imf_n(:,1)),'g-.','LineWidth',1.2)
ylim([-1 1 ])

axes(ha(3));
hold on
plot(t,real(imf_p(:,2)+imf_n(:,2)),'g-.','LineWidth',1.2)
ylim([-1.5 1.5 ])

axes(ha(4));
hold on
plot(t,imag(imf_p(:,2)+imf_n(:,2)),'g-.','LineWidth',1.2)
ylim([-1.5 1.5 ])

axes(ha(5));
hold on
plot(t,real(imf_p(:,1)),'g-.','LineWidth',1.2)
ylim([-1 1 ])

axes(ha(6));
hold on
plot(t,imag(imf_p(:,1)),'g-.','LineWidth',1.2)
ylim([-1 1 ])
%% resampling
[u2] = MCVMD(x,fs,3);

axes(ha(1));
hold on
plot(t,real(u2(:,3)),'b:','LineWidth',1.5)
ylabel('x_1-R')
set(gca,'FontName','Times New Roman','FontSize',12);

axes(ha(2));
hold on
plot(t,imag(u2(:,3)),'b:','LineWidth',1.5)
ylabel('x_1-I')
set(gca,'FontName','Times New Roman','FontSize',12);

axes(ha(3));
hold on
plot(t,real(u2(:,2)),'b:','LineWidth',1.5)
ylabel('x_2-R')
set(gca,'FontName','Times New Roman','FontSize',12);

axes(ha(4));
plot(t,imag(u2(:,2)),'b:','LineWidth',1.5)
ylabel('x_2-I')
set(gca,'FontName','Times New Roman','FontSize',12);

axes(ha(5));
hold on
plot(t,real(u2(:,1)),'b:','LineWidth',1.5)
ylabel('x_3-R')
set(gca,'FontName','Times New Roman','FontSize',12);

axes(ha(6));
hold on
plot(t,imag(u2(:,1)),'b:','LineWidth',1.5)
ylabel('x_3-I')
xlabel('Time (s)')
set(gcf,'unit','centimeters','position',[5 5 18 18]);
set(gca,'FontName','Times New Roman','FontSize',11);

% saveas(gcf,'H:\OneDrive - zju.edu.cn\aa课题信号处理\论文2-DESKTOP-R78QIVD\第一篇3\图片MCVMD\Figure5.fig')
% fileout = 'H:\OneDrive - zju.edu.cn\aa课题信号处理\论文2-DESKTOP-R78QIVD\第一篇3\图片MCVMD\Figure5.'; % 输出图片的文件名
% print(fig5,[fileout,'tif'],'-r600','-dtiff'); % 设置图片格式、分辨率
%%
index=6:N-5;
mse1(1,1)=mse(real(x10(index)).'-real(imf_n((index),1)));
mse1(1,2)=mse(imag(x10(index)).'-imag(imf_n((index),1)));
mse1(1,3)=mse(real(x20(index)).'-real(imf_p((index),2)+imf_n((index),2)));
mse1(1,4)=mse(imag(x20(index)).'-imag(imf_p((index),2)+imf_n((index),2)));
mse1(1,5)=mse(real(x30(index)).'-real(imf_p((index),1)));
mse1(1,6)=mse(imag(x30(index)).'-imag(imf_p((index),1)));


mse1(2,1)=mse(real(x10(index)).'-real(u2((index),3)));
mse1(2,2)=mse(imag(x10(index)).'-imag(u2((index),3)));
mse1(2,3)=mse(real(x20(index)).'-real(u2((index),2)));
mse1(2,4)=mse(imag(x20(index)).'-imag(u2((index),2)));
mse1(2,5)=mse(real(x30(index)).'-real(u2((index),1)));
mse1(2,6)=mse(imag(x30(index)).'-imag(u2((index),1)));

mse1=sqrt(mse1);
