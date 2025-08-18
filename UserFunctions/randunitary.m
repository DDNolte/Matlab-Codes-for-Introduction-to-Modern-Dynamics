% function U = randunitary(N)
% Generates NxN random unitary matrix
% See also ranrealunitary.m

function U = randunitary(N)

A = rand(N,N) + i*rand(N,N);

H = 0.5*(A + A');

U = expm(i*H);
