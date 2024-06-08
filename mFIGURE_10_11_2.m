

close all
clear
load('float462.mat')
lat462=lat462(1:548);
lon462=lon462(1:548);
xy=zeros(3,length(lon462));
for i=1:length(lon462)
  xy(:,i) = lla2enu([lat462(i),lon462(i),0],[mean(lat462),mean(lon462),0], 'flat')/1000;
end

N=length(lat462);

%% MCVMD2
x=xy(1,:)+1j*xy(2,:);
u1= MCVMD(x,1,4);
%% CVMD
[imf_p0,imf_n0] = CVMD(x,4,4);
imf_p0=flip(imf_p0,2);
imf_n0=flip(imf_n0,2);
%% plot
fig10=figure(10); 
subplot (1,3,1)
plot(xy(1,:) ,xy(2,:),'LineWidth',1.8)
axis equal
xlim([-200 270])
ylim([-400 500])
xlabel('Displacement East (km)')
ylabel('Displacement North (km)')
set(gca,'FontName','Times New Roman','FontSize',12);
hold on
plot(real(u1(:,1)),imag(u1(:,1)),'.','color','#D95319','LineWidth',1.2)
title('(a)','FontSize',12);
set(gca,'FontName','Times New Roman');
hold on
plot((imf_p0(:,1)+imf_n0(:,1)),'.','color',	'#EDB120','LineWidth',1.2)

subplot (3,3,2)
plot(real(u1(:,2)),imag(u1(:,2)),'.','color','#D95319','LineWidth',1.5)
axis equal
ylim([-80 80])
% xlim([-50 50])
title('(b)','FontSize',12);
set(gca,'FontName','Times New Roman');

subplot (3,3,5)
plot(real(u1(:,3)),imag(u1(:,3)),'.','color','#D95319','LineWidth',1.5)
axis equal
ylim([-40 40])
% xlim([-50 50])
title('(c)','FontSize',12);
set(gca,'FontName','Times New Roman');

subplot (3,3,8)
plot(real(u1(:,4)),imag(u1(:,4)),'.','color','#D95319','LineWidth',1.5)
axis equal
ylim([-30 30])
% xlim([-50 50])
title('(d)','FontSize',12);
set(gca,'FontName','Times New Roman');


subplot (3,3,3)
plot((imf_p0(:,2)+imf_n0(:,2)),'.','color',	'#EDB120','LineWidth',1.5)
axis equal
ylim([-80 80])
% xlim([-50 50])
title('(e)','FontSize',12);
set(gca,'FontName','Times New Roman');

subplot (3,3,6)
plot((imf_p0(:,3)+imf_n0(:,3)),'.','color',	'#EDB120','LineWidth',1.5)
axis equal
ylim([-40 40])
% xlim([-50 50])
title('(f)','FontSize',12);
set(gca,'FontName','Times New Roman');

subplot (3,3,9)
plot((imf_p0(:,4)+imf_n0(:,4)),'.','color',	'#EDB120','LineWidth',1.5)
axis equal
ylim([-30 30])
% xlim([-50 50])
title('(g)','FontSize',12);
set(gca,'FontName','Times New Roman');
 set(gcf,'unit','centimeters','position',[5 5 18 12]);
% saveas(gcf,'H:\OneDrive - zju.edu.cn\aa课题信号处理\论文2-DESKTOP-R78QIVD\第一篇3\图片MCVMD\Figure6.fig')
% fileout = 'H:\OneDrive - zju.edu.cn\aa课题信号处理\论文2-DESKTOP-R78QIVD\第一篇3\图片MCVMD\Figure6.'; % 输出图片的文件名
% print(fig10,[fileout,'tif'],'-r600','-dtiff'); % 设置图片格式、分辨率

fig11=figure(11);
subplot (5,1,1)
plot(xy(1,:),'LineWidth',1.2)
xlim([6 543])
hold on
plot(xy(2,:),'LineWidth',1.2)
ylabel('Origin')
set(gca,'FontName','Times New Roman','FontSize',11);
for i=1:4
figure(11)
subplot (5,1,i+1)
plot(real(u1(:,i)),'LineWidth',1.2)
hold on
plot(imag(u1(:,i)),'LineWidth',1.2)
xlim([6 543])
ylabel(['mode ',num2str(i)])
set(gca,'FontName','Times New Roman','FontSize',11);
end
xlabel('Time')
