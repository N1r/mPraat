function lab = tgGetLabel(tg, tierInd, index)
% function lab = tgGetLabel(tg, tierInd, index)
% Vr�t� label intervalu �i bodu s dan�m indexem ve vybran� vrstv� (tier) typu IntervalTier �i PointTier.
% v1.0, Tom� Bo�il, borilt@gmail.com

if nargin ~= 3
    error('nespr�vn� po�et argument�')
end

% if ~isInt(tierInd)
%     error(['index tier mus� b�t cel� ��slo od 1 v��e [' num2str(tierInd) ']']);
% end
tierInd = tgI(tg, tierInd);
% ntiers = tgGetNumberOfTiers(tg);
% if tierInd < 1 || tierInd > ntiers
%     error(['index tier mimo rozsah, tierInd = ' num2str(tierInd) ', ntiers = ' num2str(ntiers)]);
% end


if tgIsIntervalTier(tg, tierInd)
    nint = tgGetNumberOfIntervals(tg, tierInd);
    if index < 1 || index > nint
        error(['index intervalu mimo rozsah, index = ' num2str(index) ', nint = ' num2str(nint)]);
    end
elseif tgIsPointTier(tg, tierInd)
    npoints = tgGetNumberOfPoints(tg, tierInd);
    if index < 1 || index > npoints
        error(['index bodu mimo rozsah, index = ' num2str(index) ', npoints = ' num2str(npoints)]);
    end
else
    error('unknown tier type')
end

if ~isInt(index)
    error(['index mus� b�t cel� ��slo od 1 v��e [' num2str(index) ']']);
end

lab = tg.tier{tierInd}.Label{index};