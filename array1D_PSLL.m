
clear;
clc;
close all;
%% Basic Electromagnetic Parameters
Frequency = 10e9;
Lightspeed = physconst('LightSpeed');
Wavelength = Lightspeed/Frequency;
Wavenumber = 2*pi/Wavelength;

%% Array Parameters
N =20;
X = (1:N)*Wavelength/2;
I =  ones(1,N);
alpha = zeros(1,N);

%% ArrayFactor Samping
Ns =1000;% Sampling number
theta = linspace(-90,90,Ns);
E =zeros(1,Ns);

for num = 1:Ns
    E(num)=sum(I.*exp(1j*(Wavenumber*X*sind(theta(num))+alpha)))+1e-3;
end
%% plot figure
E_dB = db(E)-max(db(E));
figure()
plot(theta,E_dB,'LineWidth',2);%normalized
xlabel('\theta(\circ)');ylabel('dB');
ylim([-70,0]);
grid on 
set(gca,'Fontsize',19)
axis tight
%% calc PSLL
[peaks,locs] = findpeaks(E_dB,'SortStr','descend');
psll = peaks(2)-peaks(1);

hold on 
scatter(theta(locs(2)),psll,100,'v');
hold off
