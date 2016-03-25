function tgNew = tgRemovePoint(tg, tierInd, index)
% function tgNew = tgRemovePoint(tg, tierInd, index)
% Odstran� bod s dan�m indexem z PointTier.
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
if ~tgIsPointTier(tg, tierInd)
    error(['tier ' num2str(tierInd) ' nen� PointTier']);
end

npoints = tgGetNumberOfPoints(tg, tierInd);
if index < 1 || index>npoints
    error(['index bodu mimo rozsah, index = ' num2str(index) ', npoints = ' num2str(npoints)]);
end

if ~isInt(index)
    error(['index mus� b�t cel� ��slo od 1 v��e [' num2str(index) ']']);
end

tgNew = tg;
for I = index: npoints - 1
    tgNew.tier{tierInd}.T(I) = tgNew.tier{tierInd}.T(I+1);
    tgNew.tier{tierInd}.Label{I} = tgNew.tier{tierInd}.Label{I+1};
end

tgNew.tier{tierInd}.T(end) = [];
tgNew.tier{tierInd}.Label(end) = [];
