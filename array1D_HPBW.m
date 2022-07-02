

clear;
clc;
close all;
%% Basic Electromagnetic Parameters
Frequency = 10e9;
Lightspeed = physconst('LightSpeed');
Wavelength = Lightspeed/Frequency;
Wavenumber = 2*pi/Wavelength;

%% Array Parameters
N =6;
X = (1:N)*Wavelength/2;
I =  ones(1,N);
alpha = zeros(1,N);

%% ArrayFactor Samping
Ns =1000;% Sampling number
theta = linspace(-60,60,Ns);
E =zeros(1,Ns);

for num = 1:Ns
    E(num)=sum(I.*exp(1j*(Wavenumber*X*sind(theta(num))+alpha)));
end
%% plot figure
E_dB = db(E)-max(db(E));
figure()
plot(theta,E_dB,'LineWidth',2);%normalized
xlabel('\theta(\circ)');ylabel('dB');
ylim([-40,0]);
grid on 
set(gca,'Fontsize',19)
%%
% hold on 
% [hpbw,ang_max,ang_left,ang_right,E_left,E_right]  = cal_hpbw_2d(E_dB,theta);
[hpbw,ang_max]  = cal_hpbw_2d(E_dB,theta);
% plot([ang_left+1j*(-60),ang_left+1j*E_left],'--');
% hold on
% plot([ang_right+1j*(-60),ang_right+1j*E_right],'--');
% hold off
%%
function [hpbw,ang_max] = cal_hpbw_2d(E_dB,theta)
[E_dB_max,ang_loc] = max(E_dB);%find the max power and its angle
i=0;
while E_dB_max-3<E_dB(ang_loc+i)%search the 3dB point right to the max power
    i=i+1;
    if ang_loc+i==length(E_dB)
        break;
    end
end
j=0;
while E_dB_max-3<E_dB(ang_loc-j)%search the 3dB point right to the max power
    j=j+1;
    if ang_loc-j==0
        break;
    end
end
% hpbw=(i+j)*step;
ang_max = theta(ang_loc);
ang_left = theta(ang_loc-j);%the left angle 
ang_right = theta(ang_loc+i);%the right angle 
hpbw = ang_right- ang_left;% get the HPBW
end
%%
function [hpbw,ang_max,ang_left,ang_right,E_left,E_right] = cal_hpbw_2d_1(E_dB,theta)
[E_dB_max,ang_loc] = max(E_dB);%find the max power and its angle
i=0;
while E_dB_max-3<E_dB(ang_loc+i)%search the 3dB point right to the max power
    E_dB(ang_loc+i)
    i=i+1;
    if ang_loc+i==length(E_dB)
        break;
    end
end
j=0;
while E_dB_max-3<E_dB(ang_loc-j)%search the 3dB point right to the max power
    j=j+1;
    if ang_loc-j==0
        break;
    end
end
% hpbw=(i+j)*step;
ang_max = theta(ang_loc);
ang_left = theta(ang_loc-j);%the left angle 
ang_right = theta(ang_loc+i);%the right angle 
E_left = E_dB(ang_loc-j);
E_right = E_dB(ang_loc+i);
hpbw = ang_right- ang_left;% get the HPBW
end