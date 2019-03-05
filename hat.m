function skewMatrix = hat(x)

w1 = x(1);

w2 = x(2);

w3 = x(3);

skewMatrix = [0 -w3 w2; w3 0 -w1; -w2 w1 0];

end
