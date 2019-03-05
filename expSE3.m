
function  T = expSE3(u,w) %Takes in body frame translation and rotation
                          %Returns equivalent transformation matrix
                          

%SE3 is the translation&rotation space, (R|U;0 1)


%u is the translation


theta = sqrt(w' * w)

I = eye(3);

u = reshape(u,3,1);
w = reshape(w,3,1);



if(theta < 1e-9)
        
    R_next = I + hat(w);
    
    V_next = I + hat(w);
    
    T = [R_next, (V_next)*u; 0 0 0 1];
        
    
    return
end

 A = (sin(theta))/(theta);
 
 B = (1 - cos(theta))/(theta*theta);
 
 C = (1 - A)/(theta*theta);
 
 W_x = hat(w); % Skew Symmetric matrix from hat operator
 
 
  R_next = I + A*W_x + B*W_x*W_x;
  
  V_next = I + B*W_x + C*W_x*W_x;

  
  T = [R_next, (V_next)*u; 0 0 0 1];
  
 

end

