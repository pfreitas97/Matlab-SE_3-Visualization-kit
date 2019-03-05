
function resultant = concat_SE3( prev, next) %Previous SE_3s


resultRotation = prev(1:3,1:3) * next(1:3,1:3);


% result translation is from R1*t2 + t1

resultTrans = prev(1:3,1:3) * next(1:3,4) + prev(1:3,4);


resultant = [resultRotation, resultTrans; 0 0 0 1];


end

