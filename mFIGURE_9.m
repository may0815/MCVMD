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
f=(-N/2:N/2-1)/(N/fs);
k=0;

for j=0:3
    for i=0:3
        if i+j==0
            continue;
        end
     
        num_n=i;
        num_p=j;
        [imf_p,imf_n] = CVMD(x,num_p,num_n);
        k=k+1;   knkp(k,:)=([i,j]);
        str1(k)=string(['(',num2str(i),',',num2str(j),')']);
        Z=[imf_p,imf_n];
        if j>=3  
            mse1(k,1)=mse(real(sum(Z(index1,2:end),2)),real(x10(index1)).');
            mse1(k,2)=mse(imag(sum(Z(index1,2:end),2)),imag(x10(index1)).');
            mse1(k,3)=mse(real(sum(Z(index1,1),2)),real(x20(index1)).');
            mse1(k,4)=mse(imag(sum(Z(index1,1),2)),imag(x20(index1)).');
        end
        
        if j<3
            mse1(k,1)=mse(real(sum(Z(index1,1:end),2)),real(x10(index1)).');
            mse1(k,2)=mse(imag(sum(Z(index1,1:end),2)),imag(x10(index1)).');
            mse1(k,3)=NaN;
            mse1(k,4)=NaN;
        end
        
        if j==2 && i==2
          figure
            leg_str1{1}='Origin';
%             figure
            plot(f,abs(fftshift(fft(x))/(N/2)),'LineWidth',1.8)
            xlabel({'Frequency (Hz)';'(a)'});
            ylabel('Magnitude')
            for d=1:num_p+num_n
                hold on
                plot(f,abs(fftshift(fft(Z(:,d))))/(N/2),'-.','LineWidth',1.2)
                leg_str1{d+1} = ['Mode ',num2str(d)];
            end
            legend(leg_str1,'Location','northwest')
            set(gca,'FontName','Times New Roman','FontSize',12);
            xlim([-39 49])
            title(['Decomposition number K_-=',num2str(num_n),', K_+=',num2str(num_p)])
        end
        if j==3 && i==1
          figure
            leg_str1{1}='Origin';
%             figure
            plot(f,abs(fftshift(fft(x))/(N/2)),'LineWidth',1.8)
            xlabel({'Frequency (Hz)';'(b)'});
            ylabel('Magnitude')
            for d=1:num_p+num_n
                hold on
                plot(f,abs(fftshift(fft(Z(:,d))))/(N/2),'-.','LineWidth',1.2)
                leg_str1{d+1} = ['Mode ',num2str(d)];
            end
            legend(leg_str1,'Location','northwest')
            set(gca,'FontName','Times New Roman','FontSize',12);
            xlim([-39 49])
            title(['Decomposition number K_-=',num2str(num_n),', K_+=',num2str(num_p)])
        end
        
    end
    
end

mse2=sqrt(mse1);
figure;
plot(1:15,mean(mse2(:,1:2),2),'*-.','LineWidth',1.2)
hold on
plot(1:15,mean(mse2(:,3:4),2),'s-.','LineWidth',1.2)
hold on;
hi2=plot(1:11,zeros(1,11),'s','color','#D95319','LineWidth',1.2);
ylim([-0.1 0.55])
xlim([0.5 15.5])
ylabel('RMSE')
xlabel({'Decomposition number K_- and K_+';'(b)'});
title('The RMSE of decomposed modes')
% legend('mode 1','mode 2','mode 3','mode 4')
text(1-0.4:11-0.4,zeros(1,11)-0.03,' Fail','color','#D95319','FontSize',12)
% str1=string(num2str(knkp));
set(gca,'FontName','Times New Roman','FontSize',12);
set(gca,'xtick',1:15)
set(gca,'xticklabel',str1)
grid on
legend('mode 1','mode 2')
set(hi2,'handlevisibility','off');
