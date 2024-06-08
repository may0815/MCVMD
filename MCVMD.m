function [Z] = MCVMD(x,fs,num)

N=length(x);
% x_mirror=x;
x_e(1:N/2) = x(N/2:-1:1);
x_e(N/2+1:3*N/2) = x;
x_e(3*N/2+1:2*N) = x(N:-1:N/2+1);


X_e=fftshift(fft(x_e));
X_ez=[zeros(1,N),X_e,zeros(1,N)];
x_ez=ifft(fftshift(X_ez))*2;

x_z=x_ez(N+1:3*N);%%%%%%%%%%% mirror back


fs0=2*fs;
tt=(0:2*N-1)/fs0;

x_zs=x_z.*exp(1j*2*pi*fs0/4*tt);
x_zsr=real(x_zs);

u = vmd(x_zsr,'NumIMFs',num);

%% Hilbert
z=zeros(length(u),num);
for i=1:num
z(:,i)=hilbert(u(:,i)).*exp(-1j*2*pi*fs0/4*tt.');  
end

Z=resample(z,1,2);

end

