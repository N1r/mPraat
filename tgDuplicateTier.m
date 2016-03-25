function tgNew = tgDuplicateTier(tg, originalInd, newInd)
% function tgNew = tgDuplicateTier(tg, originalInd, newInd)
% Duplikuje vrstvu (tier) textgridu s dan�m indexem originalInd (1 = prvn�) na pozici nov�ho indexu.
% P�vodn� vrstvy od pozice newInd v��e posune o jednu d�l.
% Po duplikaci doporu�ujeme zavolat funkci tgSetTierName a nov� vrstv�
% zm�nit jm�no, i kdy� to nen� nutn�, proto�e dv� vrstvy se mohou jmenovat stejn�.
% v1.0, Tom� Bo�il, borilt@gmail.com

if nargin ~= 3
    error('nespr�vn� po�et argument�')
end

% if ~isInt(originalInd)
%     error(['index tier mus� b�t cel� ��slo od 1 v��e [' num2str(originalInd) ']']);
% end
originalInd = tgI(tg, originalInd);
if ~isInt(newInd)
    error(['index tier mus� b�t cel� ��slo od 1 v��e [' num2str(newInd) ']']);
end

ntiers = tgGetNumberOfTiers(tg);
% if originalInd < 1 || originalInd>ntiers
%     error(['index tier mimo rozsah, originalInd = ' num2str(originalInd) ', ntiers = ' num2str(ntiers)]);
% end
if newInd < 1 || newInd>ntiers+1
    error(['index tier mimo rozsah <1; ntiers+1>, newInd = ' num2str(newInd) ', ntiers = ' num2str(ntiers)]);
end

tgNew = tg;

tOrig = tg.tier{originalInd};

for I = ntiers + 1: -1: newInd+1
    tgNew.tier{I} = tgNew.tier{I-1};
end

tgNew.tier{newInd} = tOrig;
