function ind = tgGetPointIndexLowerThanTime(tg, tierInd, time)
% function ind = tgGetPointIndexLowerThanTime(tg, tierInd, time)
% Vr�t� index bodu, kter� je nejbl�e zleva dan�mu �asu (v�etn�), vybran� vrstva (tier) mus� b�t typu PointTier.
% Pokud nenalezne, vr�t� NaN.
% v1.0, Tom� Bo�il, borilt@gmail.com

if nargin ~= 3
    error('Wrong number of arguments.')
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
    error(['tier ' num2str(tierInd) ' is not PointTier']);
end

ind = NaN;
npoints = length(tg.tier{tierInd}.T);
for I = npoints: -1: 1
    if time >= tg.tier{tierInd}.T(I)
        ind = I;
        break;
    end
end