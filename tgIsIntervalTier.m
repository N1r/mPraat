function b = tgIsIntervalTier(tg, tierInd)
% function b = tgIsIntervalTier(tg, tierInd)
% Vr�t� true/false, zda tier je typu IntervalTier
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

if strcmp(tg.tier{tierInd}.type, 'interval') == 1
    b = true;
else
    b = false;
end