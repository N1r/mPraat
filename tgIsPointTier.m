function b = tgIsPointTier(tg, tierInd)
% function b = tgIsPointTier(tg, tierInd)
% Vr�t� true/false, zda tier je typus PointTier
% v1.0, Tom� Bo�il, borilt@gmail.com
%
% tierInd ... index vrstvy (tier)

% ntiers = length(tg.tier);

% if ~isInt(tierInd)
%     error(['index tier mus� b�t cel� ��slo od 1 v��e [' num2str(tierInd) ']']);
% end
tierInd = tgI(tg, tierInd);

% if tierInd < 1 || tierInd>ntiers
%     error(['index tier mimo rozsah, tierInd = ' num2str(tierInd) ', ntiers = ' num2str(ntiers)]);
% end

if strcmp(tg.tier{tierInd}.type, 'point') == 1
    b = true;
else
    b = false;
end