

close all 

lim = 5;

ax = axes('XLim',[-lim lim],'YLim',[-lim lim],'ZLim',[-lim lim]);

view(3)

xlabel("X axis");
ylabel("Y axis");
zlabel("Z axis");
grid minor
hold on

pause(1);

[x,y,z] = cylinder([0.08 0.1]);

size = 1;

x = x * size;
y = y * size;
z = z * size;


[xc, yc, zc] = cylinder([0.12 0]);

xc = xc * size;
yc = yc * size;
zc = zc * size;

h(1) = surface(x,y,z,'FaceColor','blue','EdgeColor','none');
h(2) = surface(x,y,-z,'FaceAlpha',0,'EdgeColor','none');

h(3) = surface(z,x,y,'FaceColor','red','EdgeColor','none');
h(4) = surface(-z,x,y,'FaceAlpha',0,'EdgeColor','none');

h(5) = surface(y,z,x,'FaceColor','green','EdgeColor','none');
h(6) = surface(y,-z,x,'FaceAlpha',0,'EdgeColor','none');


h(7) = surface(xc,yc,zc + size, 'FaceColor', 'blue','EdgeColor','none');

h(8) = surface(zc + size,xc,yc, 'FaceColor', 'red','EdgeColor','none');

h(9) = surface(yc,zc + size,xc, 'FaceColor', 'green','EdgeColor','none');

t = hgtransform('Parent',ax);
set(h,'Parent',t)



R = eye(4);
Tx = R;

w0 = [0; 0; 0];
t0 = [0; 0; 0];

w1 = [0; 0; 2];
t1 = [1; 5; -8];

w2 = [1; 0; 5];
t2 = [5; 0; 0];

T0 = expSE3(t0,w0);
T1 = expSE3(t1,w1)

[ln1, w] = log_SE3(T1)

T2 = expSE3(t2,w2);

axang1 = rotm2axang(T1(1:3,1:3))

axang2 = rotm2axang(T2(1:3,1:3))

dt = 0.05;
T = 5;

Npoints1 = T/dt;


tx1 = linspace(0,T1(1,4),Npoints1);
ty1 = linspace(0,T1(2,4),Npoints1);
tz1 = linspace(0,T1(3,4),Npoints1);
r1 =  linspace(0,axang1(4),Npoints1); %The translation/rotation between
                                      %Two SE(3) states is assumed steady



for i = 1:Npoints1

    %Next Point transformation matrix
    R = makehgtform('translate',[tx1(i) ty1(i) tz1(i)],'axisrotate',axang1(1:3),r1(i));
    

    % Concatenate the transforms and use set the transform Matrix property
    
    set(t,'Matrix',R*Tx);
    
    
    %Trace path of Center of Mass
    
    plot3(R(1,4),R(2,4),R(3,4),'.','Color','blue');
    
        
    %Chase object with axis
    
    set(ax,'XLim',[(R(1,4) - lim) (R(1,4) + lim)],'YLim',[(R(2,4) - lim) (R(2,4) + lim)],'ZLim',[(R(3,4) - lim) (R(3,4) + lim)]);
    
    
    drawnow
    
end
pause(1);






