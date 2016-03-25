function c = tgGetNumberOfPoints(tg, tierInd)
% function c = tgGetNumberOfPoints(tg, tierInd)
% Vr�t� po�et bod� v dan� vrstv� (tier) typu PointTier.
% v1.0, Tom� Bo�il, borilt@gmail.com

if nargin ~= 2
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

c = length(tg.tier{tierInd}.T);