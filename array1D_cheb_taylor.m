clear;
clc;
close all;
%% Basic Electromagnetic Parameters
Frequency = 10e9;
Lightspeed = physconst('LightSpeed');
Wavelength = Lightspeed/Frequency;
Wavenumber = 2*pi/Wavelength;

%% Array Parameters
N =25;
X = (1:N)*Wavelength*0.5;
I0 =  ones(1,N);
alpha = zeros(1,N);
%% ArrayFactor Samping
Ns =500;% Sampling number
theta = linspace(-90,90,Ns);
%% Uniform Array
E0 =zeros(1,Ns);
for num = 1:Ns
    E0(num)=sum(I0.*exp(1j*(Wavenumber*X*sind(theta(num))+alpha)))+1e-3;
end
E0_dB = db(E0)-max(db(E0));
%% cheb array


E1 =zeros(1,Ns);
I1 = chebwin(N,30)';
for num = 1:Ns
    E1(num)=sum(I1.*exp(1j*(Wavenumber*X*sind(theta(num))+alpha)))+1e-3;
end
E1_dB = db(E1)-max(db(E1));
%% taylor array
E2 =zeros(1,Ns);
I2 = taylorwin(N,4,-30)';
for num = 1:Ns
    E2(num)=sum(I2.*exp(1j*(Wavenumber*X*sind(theta(num))+alpha)))+1e-3;
end
E2_dB = db(E2)-max(db(E2));

%% plot figure

figure()
% plot(theta,E0_dB,'LineWidth',2);
hold on
plot(theta,E1_dB,'LineWidth',2);
hold on
plot(theta,E2_dB,'LineWidth',2);
ylim([-40,0]);
grid on 
xlabel('\theta(\circ)');ylabel('dB');
axis  tight;
%%
figure()
scatter(1:25,I1)
hold on
scatter(1:25,I2)