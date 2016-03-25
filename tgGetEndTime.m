function t = tgGetEndTime(tg, tierInd)
% function t = tgGetEndTime(tg, tierInd)
% Vr�t� kone�n� �as. Bu� maximum v�ech vrstev (default)
% �i konkr�tn� vrstvy - tier (v takov�m p��pad� vrac� NaN, kdy� vrsta nic
% neobsahuje).
% v1.0, Tom� Bo�il, borilt@gmail.com

if nargin  == 1
    t = tg.tmax;
    return;
end

if nargin ~= 2
    error('Wrong number of arguments.')
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
        t = tg.tier{tierInd}.T(end);
    end
elseif tgIsIntervalTier(tg, tierInd)
    if length(tg.tier{tierInd}.T2) < 1
        t = NaN;
    else
        t = tg.tier{tierInd}.T2(end);
    end
else
    error('unknown tier type')
end