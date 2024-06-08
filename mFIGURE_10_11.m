

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

%% plot
fig10=figure(10); 
subplot (1,2,1)
plot(xy(1,:) ,xy(2,:),'LineWidth',1.5)
axis equal
xlim([-200 250])
ylim([-300 420])
xlabel('Displacement East (km)')
ylabel('Displacement North (km)')
set(gca,'FontName','Times New Roman','FontSize',12);
hold on
plot(real(u1(:,1)),imag(u1(:,1)),'.','color','#D95319','LineWidth',1.5)
title('(a)','FontSize',12);
set(gca,'FontName','Times New Roman');

subplot (3,2,2)
plot(real(u1(:,2)),imag(u1(:,2)),'.','color','#D95319','LineWidth',1.5)
axis equal
ylim([-80 80])
% xlim([-50 50])
title('(b)','FontSize',12);
set(gca,'FontName','Times New Roman');

subplot (3,2,4)
plot(real(u1(:,3)),imag(u1(:,3)),'.','color','#D95319','LineWidth',1.5)
axis equal
ylim([-40 40])
% xlim([-50 50])
title('(c)','FontSize',12);
set(gca,'FontName','Times New Roman');

subplot (3,2,6)
plot(real(u1(:,4)),imag(u1(:,4)),'.','color','#D95319','LineWidth',1.5)
axis equal
ylim([-30 30])
% xlim([-50 50])
title('(d)','FontSize',12);
set(gca,'FontName','Times New Roman');



fig11=figure(11);
subplot (5,1,1)
plot(xy(1,:),'LineWidth',1.2)
xlim([0 540])
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
xlim([0 540])
ylabel(['mode ',num2str(i)])
set(gca,'FontName','Times New Roman','FontSize',11);
end
xlabel('Time')

