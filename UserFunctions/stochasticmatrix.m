% function y = stochasticmatrix(N)
% creates NxN stochastic matrix
% mean value of off-diag elements equals 1/N

function y = stochasticmatrix(N)

U = randunitary(N);
U2 = abs(U).^2;

y = 0.5*(U2 + U2');

