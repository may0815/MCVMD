clear
close all

%% signal generate
fs=100; 
ts=5;
N=fs*ts;
nfft=N;
t=(0:N-1)/fs;

x10=0.2*(1*t).*exp(1j*2*pi*(28*t-sin(1*pi*t)));
x20=cos(0.2*t).*exp(1j*2*pi*1*(-1*t+0.5*t.^2));
x=x10+x20;

%% actual
insP = angle((x10));        %瞬时相位
omega = gradient(unwrap(insP))/(2*pi);% 使用相角计算瞬时频率,转换成Hz
Aa2(1,:)=abs(x10);
theta2(1,:)=omega*fs;

insP = angle((x20));        %瞬时相位
omega = gradient(unwrap(insP))/(2*pi);% 使用相角计算瞬时频率,转换成Hz
Aa2(2,:)=abs(x20);
theta2(2,:)=omega*fs;
[im,tt,ff]=complextoimage(Aa2,theta2+fs/2,fs,t,N,fs*2);
tu=tiledlayout(1,3);
tu.TileSpacing = 'compact';
tu.Padding = 'compact';
nexttile
imagesc(tt,ff-fs/2,im);
colorbar;
ylabel('Frequency (Hz)')
set(gca,'YDir','normal')
xlabel({'Time (s)';'(a)'});
title('Actual Hilbert spectrum')
set(gca,'FontName','Times New Roman','FontSize',12);
caxis([0,1.2]);
colormap(jet);
ylim([-49 49])
%% MCVMD
numm=2;
[Z] = MCVMD(x,fs,numm);
%% CVMD
num_p=3;
num_n=1;
[imf_p,imf_n] = CVMD(x,num_p,num_n);
imf=[imf_p(:,1),sum(imf_p(:,2:end),2)+sum(imf_n(:,1:end),2)];
%% hht MCVMD
k=1;
for i=1:numm
insP = angle((Z(:,i)));        %瞬时相位
omega = gradient(unwrap(insP))/(2*pi);% 使用相角计算瞬时频率,转换成Hz
Aa(k,:)=abs(Z(:,i));
theta(k,:)=omega*fs;
k=k+1;
end
[im,tt,ff]=complextoimage(Aa,theta+fs/2,fs,t,N,fs*2);
nexttile
imagesc(tt,ff-fs/2,im);
colorbar;
% ylabel('Frequency (Hz)')
set(gca,'YDir','normal')
xlabel({'Time (s)';'(b)'});
title('MCVMD Hilbert spectrum')
set(gca,'FontName','Times New Roman','FontSize',12);
caxis([0,1.2]);
colormap(jet);
ylim([-49 49])
%% HHT CVMD
k=1;
for i=1:size(imf,2)
insP = angle((imf(:,i)));        %瞬时相位
omega = gradient(unwrap(insP))/(2*pi);% 使用相角计算瞬时频率,转换成Hz
Aa1(k,:)=abs(imf(:,i));
theta1(k,:)=omega*fs;
k=k+1;
end

[im,tt,ff]=complextoimage(Aa1,theta1+fs/2,fs,t,N,fs*2);

nexttile
imagesc(tt,ff-fs/2,im);
colorbar;
% ylabel('Frequency (Hz)')
set(gca,'YDir','normal')
xlabel({'Time (s)';'(c)'});
title('CVMD Hilbert spectrum')
set(gca,'FontName','Times New Roman','FontSize',12);
caxis([0,1.2]);
colormap(jet);
ylim([-49 49])
set(gcf,'unit','centimeters','position',[1 5 36 11]);
%% mse
index1=5:N-6;
mse1(1,1)=mse(Aa2(1,index1),Aa1(1,index1)) ;
mse1(2,1)=mse(Aa2(1,index1),Aa(1,index1));
mse1(1,2)=mse(theta2(1,index1),theta1(1,index1)) ;
mse1(2,2)=mse(theta2(1,index1),theta(1,index1));
mse1(1,3)=mse(Aa2(2,index1),Aa1(2,index1));
mse1(2,3)=mse(Aa2(2,index1),Aa(2,index1));
mse1(1,4)=mse(theta2(2,index1),theta1(2,index1)) ;
mse1(2,4)=mse(theta2(2,index1),theta(2,index1));
mse1=sqrt(mse1);

