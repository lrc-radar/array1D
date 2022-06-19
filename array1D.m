clear;
clc;
close all;
%% Basic Electromagnetic Parameters
Frequency = 10e9;
Lightspeed = physconst('LightSpeed');
Wavelength = Lightspeed/Frequency;
Wavenumber = 2*pi/Wavelength;

%% Array Parameters
N =12;
X = (1:N)*Wavelength/2;
I =  ones(1,N);
alpha = zeros(1,N);

%% ArrayFactor Samping
Ns =500;% Sampling number
theta = linspace(-90,90,Ns);
E =zeros(1,Ns);

for num = 1:Ns
    E(num)=sum(I.*exp(1j*(Wavenumber*X*sind(theta(num))+alpha)))+1e-3;
end
%% plot figure
figure()
plot(theta,db(E),'LineWidth',2);
gird on
figure()
plot(theta,db(E)-max(db(E)),'LineWidth',2);%normalized
grid on 
