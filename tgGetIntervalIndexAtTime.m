function ind = tgGetIntervalIndexAtTime(tg, tierInd, time)
% function ind = tgGetIntervalIndexAtTime(tg, tierInd, time)
% Vr�t� index intervalu obsahuj�c� dan� �as, vybran� vrstva (tier) mus� b�t typu IntervalTier.
% Interval mus� spl�ovat tStart <= time < tEnd. Pokud nenalezne, vr�t� NaN.
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

ind = NaN;
nint = length(tg.tier{tierInd}.T1);
for I = 1: nint
    if tg.tier{tierInd}.T1(I) <= time  && time < tg.tier{tierInd}.T2(I)
        ind = I;
        break;
    end
end