function tgNew = tgCreateNewTextGrid(tStart, tEnd)
% function tgNew = tgCreateNewTextGrid(tStart, tEnd)
% Vytvo�� nov� zcela pr�zdn� textgrid. Parametry tStart a tEnd
% nastav� tmin a tmax, kter� jsou nap�. pou��v�ny, kdy� se p�id� nov�
% vrstva IntervaTier bez udan�ho rozsahu.
% Tento pr�zdn� textgrid je samostatn� nepou�iteln�, je pot�eba do n�j
% p�idat alespo� jednu vrstvu pomoc� tgInsertNewIntervalTier nebo
% tgInsertNewPointTier.
% v1.0, Tom� Bo�il, borilt@gmail.com

if nargin ~= 2
    error('Wrong number of arguments.')
end

tgNew.tier = {};

if tStart > tEnd
    error(['tStart [' num2str(tStart) '] must be lower than tEnd [' num2str(tEnd) ']']);
end

tgNew.tmin = tStart;
tgNew.tmax = tEnd;
