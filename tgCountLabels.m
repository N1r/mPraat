function c = tgCountLabels(tg, tierInd, label)
% function c = tgCountLabels(tg, tierInd, label)
% Vr�t� po�et label� v dan� vrstv� (tier), kter� se rovnaj� po�adovan�mu �et�zci.
% v1.0, Tom� Bo�il, borilt@gmail.com

if nargin ~= 3
    error('nespr�vn� po�et argument�')
end

% if ~isInt(tierInd)
%     error(['index tier mus� b�t cel� ��slo od 1 v��e [' num2str(tierInd) ']']);
% end
tierInd = tgI(tg, tierInd);
% ntiers = tgGetNumberOfTiers(tg);

% if tierInd < 1 || tierInd>ntiers
%     error(['index tier mimo rozsah, tierInd = ' num2str(tierInd) ', ntiers = ' num2str(ntiers)]);
% end

c = 0; % po�et

for I = 1: length(tg.tier{tierInd}.Label)
    if strcmp(tg.tier{tierInd}.Label{I}, label) == 1
        c = c + 1;
    end
end