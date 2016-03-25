function tgNew = tgSetTierName(tg, tierInd, name)
% function tgNew = tgSetTierName(tg, tierInd, name)
% Nastav� (zm�n�) jm�no vrstvy (tier) s dan�m indexem.
% v1.0, Tom� Bo�il, borilt@gmail.com

if nargin ~= 3
    error('Wrong number of arguments.')
end

% if ~isInt(tierInd)
%     error(['index tier mus� b�t cel� ��slo od 1 v��e [' num2str(tierInd) ']']);
% end
tierInd = tgI(tg, tierInd);

% ntiers = tgGetNumberOfTiers(tg);
% if tierInd < 1 || tierInd>ntiers
%     error(['index tier mimo rozsah, tierInd = ' num2str(tierInd) ', ntiers = ' num2str(ntiers)]);
% end

tgNew = tg;
tgNew.tier{tierInd}.name = name;
