

close all
clear
load('AXA1.mat');
AXA1=AXA1(1:1000,:);
figure(12)
subplot 211
plot(AXA1(:,2));

xlabel('Time')
ylabel('Wind Speed (knots)')
set(gca,'FontName','Times New Roman','FontSize',12);
subplot 212
plot(AXA1(:,1));

xlabel('Time')
ylabel('Wind Direction (degrees)')
set(gca,'FontName','Times New Roman','FontSize',12);
set(gcf,'unit','centimeters','position',[5 5 18 14]);
 
x=AXA1(:,2).*exp(1j*AXA1(:,1)/360*2*pi);
x=x.';

figure(14)
f=(-length(x)/2:length(x)/2-1)/(length(x)/2);
F1=fftshift(abs(fft(x)))/(length(x)/2);
plot(f,F1,'b','LineWidth',1.6)

z= MCVMD(x,1,8);
fig13=figure(13);
ha = tight_subplot(8,2,[.05 .05],[.09 .03],[.1 .05]);%(行数, 列数, [上下间距 左右间距],[下边距 上边距 ], [左边距 右边距 ])

z=flip(z,2);
for i=1:8
    figure(13)
    axes(ha(i*2-1));
    plot(real(z(:,i)));
    hold on;plot(imag(z(:,i)));
    ylabel(['mode ',num2str(i)])
    xlim([5 996])
%     figure(2);
%     hold on
%     plot(f,fftshift(abs(fft(z(:,i)))))

end
xlabel({'Time';'(a)'})

z0=sum(z,2);
figure(14);
hold on
F2=fftshift(abs(fft(z0)))/(length(x)/2);
plot(f,F2,'r:','LineWidth',1.6)


% figure
[imf_p0,imf_n0] = CVMD(x,4,4);
imf_p0=flip(imf_p0,2);
% imf_n0=flip(imf_n0,2);
z=[imf_n0,imf_p0];
for i=1:8
    figure(13)
    axes(ha(i*2));
    plot(real(z(:,i)));
    hold on;plot(imag(z(:,i)));
    xlim([5 996])
    %         figure(2);
    % hold on
    % plot(f,fftshift(abs(fft(z(:,i)))))
end
xlabel({'Time';'(b)'})
set(gcf,'unit','centimeters','position',[5 5 18 16]);
figure(13)
axes(ha(5));
ylim([-5 5])
axes(ha(6));
ylim([-5 5])


z0=sum(z,2);

figure(14);
hold on
F3=fftshift(abs(fft(z0)))/(length(x)/2);
plot(f,F3,'g-.','LineWidth',1.6)
legend('Origin','MCVMD','CVMD','Location','northwest')

figure(14);
h1=axes('position',[0.58 0.58 0.3 0.3]);
axis(h1);
plot(f(480:522),F1(480:522),'b','LineWidth',1.6)
hold on
plot(f(480:522),F2(480:522),'r:','LineWidth',1.6)
hold on
plot(f(480:522),F3(480:522),'g-.','LineWidth',1.6)
xlim([-0.04 0.04])
ylim([0 10.8])
set(gcf,'unit','centimeters','position',[5 5 18 14]);

