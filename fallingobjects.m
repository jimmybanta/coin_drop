G = 9.8; %gravity constant, m/s
M = .0025; %mass of objects, kg
X = 0; %x-value - keep constant
Y = 381; %starting height, m
V = 0; %starting velocity, m/s
A = 9.8; %starting acceleration, m/s^2

C = 1.1; %drag coefficient
P = 1.225; %density, kg/m^3
Bmax=.00028502295699234;
Bmin=.00002893542;
B = Bmax; %cross sectional area, m^2

 
tmax = 1000;
clockmax = 10000;
dt = tmax / clockmax;
Xsave = zeros(1, clockmax);
Ysave = zeros(1, clockmax);
Vsave = zeros(1,clockmax);
tsave = zeros(1,clockmax);

Weight = M * G;

figure; hold on;
for clock = 1:clockmax
        V = V + A * dt; %new velocity
        Vsave(clock) = V;
        B = Bmin + (Bmax-Bmin)*rand(1,1);
        Drag = C * P * B * (V^2)/2; %drag force
        F = Weight - Drag; %total force
        A = F/M; %new acceleration
        Y = Y - dt * V; %new height
        if Y<0
            return
        end
        Xsave(clock) = X;
        Ysave(clock) = Y;
        tsave(clock)=clock*dt;
        vterminal = sqrt(2*G*M/(P*C*((Bmin+Bmax)/2)));
        
        figure(1)
        plot(Xsave, Ysave, 'r*', 'MarkerSize',5);
        axis equal
        drawnow
        
        figure(2)
        plot(tsave,Vsave,tsave,ones(1,clockmax)*vterminal)
        xlabel('time in sec');
        ylabel('velocity in m/s');
        legend ('Experimental Velocity','Calculated Velocity','location','south');
        drawnow
end

