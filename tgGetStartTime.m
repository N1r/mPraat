function t = tgGetStartTime(tg, tierInd)
% function t = tgGetStartTime(tg, tierInd)
% Vr�t� po��te�n� �as. Bu� minimum v�ech vrstev (default)
% �i konkr�tn� vrstvy - tier (v takov�m p��pad� vrac� NaN, kdy� vrsta nic
% neobsahuje).
% v1.0, Tom� Bo�il, borilt@gmail.com

if nargin  == 1
    t = tg.tmin;
    return;
end

if nargin ~= 2
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

if tgIsPointTier(tg, tierInd)
    if length(tg.tier{tierInd}.T) < 1
        t = NaN;
    else
        t = tg.tier{tierInd}.T(1);
    end
elseif tgIsIntervalTier(tg, tierInd)
    if length(tg.tier{tierInd}.T1) < 1
        t = NaN;
    else
        t = tg.tier{tierInd}.T1(1);
    end
else
    error('unknown tier type')
end