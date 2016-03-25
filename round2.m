function res = round2(x, order)
% function res = round2(x, order)
% Zaoukrouhl� na dan� po�et desetinn�ch m�st (order 1: des�tky, 0:
% jednotky, -1 desetiny, -2 setiny apod.)
%
% P�. round2(pi*100, -2), round2(pi*100, 2)
%
% v1.0, Tom� Bo�il, borilt@gmail.com

res = round(x / 10^order) * 10^order;