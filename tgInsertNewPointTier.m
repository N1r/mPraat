function tgNew = tgInsertNewPointTier(tg, tierInd, tierName)
% function tgNew = tgInsertNewPointTier(tg, tierInd, tierName)
% Vytvo�� novou vrstvu (tier) textgridu typu PointTier a vlo�� ji na dan� index (1 = prvn�).
% N�sledujic� vrstvy posune o jednu d�l.
% Je t�eba zadat jm�no nov� vrstvy - �et�zec tierName.
% v1.0, Tom� Bo�il, borilt@gmail.com

if nargin ~= 3
    error('nespr�vn� po�et argument�')
end

% if ~isInt(tierInd)
%     error(['index tier mus� b�t cel� ��slo od 1 v��e [' num2str(tierInd) ']']);
% end
tierInd = tgI(tg, tierInd);

ntiers = tgGetNumberOfTiers(tg);
% if tierInd < 1 || tierInd>ntiers+1
%     error(['index tier mimo rozsah <1; ntiers+1>, tierInd = ' num2str(tierInd) ', ntiers = ' num2str(ntiers)]);
% end

tgNew = tg;

tNew.name = tierName;
tNew.type = 'point';
tNew.T = [];
tNew.Label = {};
for I = ntiers + 1: -1: tierInd+1
    tgNew.tier{I} = tgNew.tier{I-1};
end

tgNew.tier{tierInd} = tNew;
