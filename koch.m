% Written by Aniket Ravan
% Runs one iteration of Koch's snowflake for a pair of points
% Last modified : 4/26/2016
function [cnew] = koch(carg)
c(1) = carg(1) + (carg(2) - carg(1))/3;
c(2) = carg(1) + (carg(2) - carg(1))*2/3;
arg = angle(c(2) - c(1));
mod = abs(c(2) - c(1));
c(3) = real(c(1)) + mod*cos((pi/3) + arg) + 1i*(imag(c(1)) + mod*sin((pi/3) + arg));;
cnew = [carg(1),c(1),c(3),c(2),carg(2)];
%plot(real(cnew(:)),imag(cnew(:)));
%axis('equal');
%hold on 
%plot(real(cnew(1:2)),imag(cnew(1:2)),'o');