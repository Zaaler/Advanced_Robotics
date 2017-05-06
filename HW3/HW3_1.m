% Zack Allen
% Data Set #1
% Gyro Extrapolator
clear all
close all
clc

gyro = load('gyro.txt');
time = load('timestamp.txt');

p = gyro(:,1);
q = gyro(:,2);
r = gyro(:,3);

for i = 2 : length(gyro)
    dt(i-1) = time(i,2) - time(i-1,1);
end

roll = 0;
pitch = 0;
yaw = 0;

for i = 2 : length(p)
    roll(i) = roll(i-1) + ((p(i-1) +q(i-1)*sin(roll(i-1))*tan(pitch(i-1)) + r(i)*cos(roll(i-1))*tan(pitch(i-1))))*dt(i-1);
    pitch(i) = pitch(i-1) + (q(i-1)*cos(roll(i-1)) - yaw(i-1)*sin(roll(i-1)))*dt(i-1);
    yaw(i) = yaw(i-1) + (q(i-1)*(sin(roll(i-1))/cos(pitch(i-1))) + r(i-1)*(cos(roll(i-1))/cos(pitch(i-1))))*dt(i-1);
end

roll = rad2deg(roll);
pitch = rad2deg(pitch);
yaw = rad2deg(yaw);

figure(1)
plot(time(:,1), roll,'.')
hold on
plot(time(:,1), pitch,'.')
plot(time(:,1), yaw,'.')
legend('Roll','Pitch','Yaw','location','Best')
title('Kalman Filter Simulated State Estimation')
xlabel('Time [s]')
ylabel('Projected Value [Deg]')