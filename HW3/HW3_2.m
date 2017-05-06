% Zack Allen
% Gyro Extrapolator

gyro = load('gyro.txt');
time = load('timestamp.txt')

p = gyro(:,1);
q = gyro(:,2);
r = gyro(:,3);
dt1 = 0;
dt2 = 0;
for i = 2 : length(gyro)
    dt1(i-1) = time(i,1) - time(i-1,1);
    dt2(i-1) = time(i,2) - time(i-1,2);
end

roll = 0;
pitch = 0;
yaw = 0;


roll1 = 0;
pich1 = 0;
yaw1 = 0;
for i = 2 : length(p)
    roll(i) = roll(i-1) + ((p(i-1) +q(i-1)*sind(roll(i-1))*tand(pitch(i-1)) + r(i)*cosd(roll(i-1))*tand(pitch(i-1))))*dt1(i-1);
    roll1(i) = roll(i-1) + ((p(i-1) +q(i-1)*sind(roll(i-1))*tand(pitch(i-1)) + r(i)*cosd(roll(i-1))*tand(pitch(i-1))))*dt2(i-1);
    pitch(i) = pitch(i-1) + (q(i-1)*cosd(roll(i-1)) - yaw(i-1)*sind(roll(i-1)))*dt1(i-1);
    pitch1(i) = pitch(i-1) + (q(i-1)*cosd(roll(i-1)) - yaw(i-1)*sind(roll(i-1)))*dt2(i-1);
    yaw(i) = yaw(i-1) + (q(i-1)*(sind(roll(i-1))/cosd(pitch(i-1))) + r(i-1)*(cosd(roll(i-1))/cosd(pitch(i-1))))*dt1(i-1);
    yaw1(i) = yaw(i-1) + (q(i-1)*(sind(roll(i-1))/cosd(pitch(i-1))) + r(i-1)*(cosd(roll(i-1))/cosd(pitch(i-1))))*dt2(i-1);
end

figure(1)
plot(time(:,1),roll)
hold on
plot(time(:,1),pitch)
plot(time(:,1),yaw)
legend('Roll','Pitch','Yaw','Location','Best')
xlabel('Time [s]')
ylabel('Projected Value [Deg]')
title('Kalman Filter Gladiator State Estimation 1')

figure(2)
plot(time(:,2),roll1)
hold on
plot(time(:,2),pitch1)
plot(time(:,2),yaw1)
legend('Roll','Pitch','Yaw','Location','Best')
xlabel('Time [s]')
ylabel('Projected Value [Deg]')
title('Kalman Filter Gladiator State Estimation 2')