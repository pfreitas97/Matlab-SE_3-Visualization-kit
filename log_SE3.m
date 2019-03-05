
function [u , w] = log_SE3(T) %T is a 4x4 member of SE(3)

    R = T(1:3,1:3);
    
    theta = acos( (trace(R) - 1)/2);
    
    if(theta < 1e-9)
            
    u = [T(1,4);T(2,4);T(3,4)];
    w = [0,0,0];
    disp("THETA = ZERO");
    
    return
    end
    
    
    
    lnR = (theta/(2*sin(theta)))*(R - R');
    
    w1 = lnR(1,1);
    w2 = lnR(2,2);
    w3 = lnR(3,3);
    
    w = [w1; w2; w3];
    
    t = [T(1,4);T(2,4);T(3,4)];
    
    wHat = hat(w);
    
    I = eye(3);
    
    A = (sin(theta))/(theta);
 
    B = (1 - cos(theta))/(theta*theta);    
    
    Vinverse = I - (0.5)*wHat + (1/(theta*theta))*(1 - (A/(2*B)))*wHat*wHat;

    u = Vinverse * t;



end