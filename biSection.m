function [xRoot, numIter] = biSection(f, a, b, tol)
% Inputs:
% f: a function handle, standing for the function written above
% a: the left boundary of the range
% b: the right boundary of the range
% tol: the tolerance within which the program can stop
% Outputs:
% xRoot: the numerical value of the root
% numIter: the number of iterations after which the root is found

epsilon = b - a;
nMax = (log(epsilon) - log(tol))/(log(2));
k = 1;

while (k<=nMax)
    p = (a+b)/2;
    if f(p)==0 || ((b-a)/2)<tol
        break
    end
    k = k + 1;
    if sign(f(p))==sign(f(a))
        a = p;
    else
        b = p;
    end
end

xRoot = p;
numIter = k;
end