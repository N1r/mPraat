function ind = tgGetPointIndexNearestTime(tg, tierInd, time)
% function ind = tgGetPointIndexNearestTime(tg, tierInd, time)
% Vr�t� index bodu, kter� je nejbl�e dan�mu �asu (z obou sm�r�), vybran� vrstva (tier) mus� b�t typu PointTier.
% Pokud nenalezne, vr�t� NaN.
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
if ~tgIsPointTier(tg, tierInd)
    error(['tier ' num2str(tierInd) ' nen� PointTier']);
end

npoints = length(tg.tier{tierInd}.T);
minDist = inf;
minInd = NaN;
for I = 1: npoints
    dist = abs(tg.tier{tierInd}.T(I) - time);
    if dist < minDist
        minDist = dist;
        minInd = I;
    end
end

ind = minInd;