clear;
clc;
close all;
%% Basic Electromagnetic Parameters
Frequency = 10e9;
Lightspeed = physconst('LightSpeed');
Wavelength = Lightspeed/Frequency;
Wavenumber = 2*pi/Wavelength;

%% Array Parameters
N =33;
X = (0:(N-1))*Wavelength/2;
% xrand = cumsum(rand(1,(N-1)));
% X=[0,xrand]/max(xrand)*(N-1)*Wavelength;
I =  ones(1,N);
theta0 = 45;
alpha = -Wavenumber*X*sind(theta0);
%% ArrayFactor Samping
Ns =500;% Sampling number
theta = linspace(-90,90,Ns);
E =zeros(1,Ns);

for num = 1:Ns
    E(num)=sum(I.*exp(1j*(Wavenumber*X*(sind(theta(num))-sind(theta0)))))+1e-3;
end
%% plot figure
E_dB = db(E)-max(db(E));
% figure()
% plot(theta,db(E),'LineWidth',2);
% grid on
figure()
plot(theta,E_dB,'LineWidth',2);%normalized
axis tight
grid on 
xlabel('\theta(\circ)');ylabel('(dB)');
% set(gca,'FontSize',14);
% figure()
% polarplot(deg2rad(theta),abs(E),'LineWidth',2);

%% calc PSLL
[peaks,locs] = findpeaks(E_dB,'SortStr','descend');
psll = peaks(2)-peaks(1);

hold on 
scatter(theta(locs(2)),psll,100,'rv');
hold off
hold on 
scatter(theta(locs(1)),peaks(1),100,'rv');
hold off