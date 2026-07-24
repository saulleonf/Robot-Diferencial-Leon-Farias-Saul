clear all;
clc;
close all;

% PROGRAMA QUE CALCULA [x,y,theta] a partir del [u, w]   
% para un ROBOT DIFERENCIAL

% Condiciones iniciales
t(1)= 0;
x(1) = 0; % vector posicion x
y(1) = 0; % vector posicion y
theta(1) = 0; % vector orientacion theta
ts = 50; % tiempo de simulacion en segundos
ti = 0.01; % tiempo de integracion metdodo euler

% PARAMETROS DEL CARRITO DIFERENCIAL 
L = 0.38; % distancia entre ruedas RD y RI
r = 0.06; % radio RUEDAS RD RI[m]

for k= 1: ts/ti
    if t(k) < 5
        dot_theta_RD = 2;
        dot_theta_RI = 2;
    elseif t(k) < 10 
        dot_theta_RD = 0.9425;
        dot_theta_RI = -0.9425;
    elseif t(k) < 40
        dot_theta_RD = 2.2689;
        dot_theta_RI = 1.2217;
    elseif t(k) < 45 
        dot_theta_RD = 0.9425;
        dot_theta_RI = -0.9425;
    elseif t(k) < 50 
        dot_theta_RD = 2;
        dot_theta_RI = 2;
    else  
        dot_theta_RD = 0;
        dot_theta_RI = 0;
    end

    VRD = dot_theta_RD * r;
    VRI = dot_theta_RI * r;
    u = (VRD + VRI) / 2; % m/s
    w = (VRD - VRI) / L; % rad/s

    x(k+1) = x(k) + ti*( u*cos(theta(k) ));
    y(k+1) = y(k) + ti*( u*sin(theta(k) ));
    theta(k+1) = theta(k) + ti*(w) ;
    t(k+1) = t(k) + ti;
end
z = zeros(1,length(t));

figure(1)
plot(x,y,'LineWidth',5); 
hold on
% Punto de partida
plot(x(1),y(1),'o', ...
    'MarkerSize',12, ...
    'LineWidth',3, ...
    'MarkerFaceColor','g');
plot(x(end),y(end),'s', ...
    'MarkerSize',12, ...
    'LineWidth',3, ...
    'MarkerFaceColor','r');
xlabel("POSICION EN X [m]")
ylabel("POSICION EN Y [m]")
title("TRAYECTORIA DEL ROBOT")
grid on
axis equal
set(gca, 'FontSize', 23);

figure(2)
subplot(3,1,1)
plot(t,x,'LineWidth',5); grid on;
ylabel("posicion x (m)"); xlabel("tiempo (s)");
subplot(3,1,2)
plot(t,y,'LineWidth',5); grid on;
ylabel("posicion y (m)"); xlabel("tiempo (s)");
subplot(3,1,3)
plot(t,theta,'LineWidth',5); grid on;
ylabel("orientacion (radianes)"); xlabel("tiempo (s)");