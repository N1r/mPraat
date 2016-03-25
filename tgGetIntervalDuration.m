function t = tgGetIntervalDuration(tg, tierInd, index)
% function t = tgGetIntervalEndTime(tg, tierInd, index)
% Vr�t� �as konce intervalu s dan�m indexem ve vybran� vrstv� (tier) typu IntervalTier.
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
if ~tgIsIntervalTier(tg, tierInd)
    error(['tier ' num2str(tierInd) ' nen� IntervalTier']);
end

if ~isInt(index)
    error(['index mus� b�t cel� ��slo od 1 v��e [' num2str(index) ']']);
end

nint = tgGetNumberOfIntervals(tg, tierInd);
if index < 1 || index>nint
    error(['index intervalu mimo rozsah, index = ' num2str(index) ', nint = ' num2str(nint)]);
end


t = tg.tier{tierInd}.T2(index) - tg.tier{tierInd}.T1(index);
