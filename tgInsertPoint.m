function tgNew = tgInsertPoint(tg, tierInd, time, label)
% function tgNew = tgInsertPoint(tg, tierInd, time, label)
% Vlo�� nov� bod do PointTier.
% v1.0, Tom� Bo�il, borilt@gmail.com

if nargin ~= 4
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
if ~tgIsPointTier(tg, tierInd)
    error(['tier ' num2str(tierInd) ' nen� PointTier']);
end

tgNew = tg;

indPosun = tgGetPointIndexHigherThanTime(tg, tierInd, time);
npoints = tgGetNumberOfPoints(tg, tierInd);

if ~isnan(indPosun)
    for I = npoints: -1: indPosun
        tgNew.tier{tierInd}.T(I+1) = tgNew.tier{tierInd}.T(I);
        tgNew.tier{tierInd}.Label{I+1} = tgNew.tier{tierInd}.Label{I};
    end
end

if isnan(indPosun)
    indPosun = length(tgNew.tier{tierInd}.T) + 1;
end
tgNew.tier{tierInd}.T(indPosun) = time;
tgNew.tier{tierInd}.Label{indPosun} = label;

tgNew.tmin = min(tgNew.tmin, time);
tgNew.tmax = max(tgNew.tmax, time);