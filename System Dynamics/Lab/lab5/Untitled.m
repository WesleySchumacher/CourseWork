



x = -0.005:0.00001:0;
y = (12000.*x + 60);
plot(x,y'b','Linewidth',2)

grid on
xlabel('Time (s)')
ylabel('Voltage (V)')
title('Theoredtical result and Simulation')
legend('Theory','Simulation(dt = 0.001)')
