function t = tgGetTotalDuration(tg, tierInd)
% function t = tgGetTotalDuration(tg, tierInd)
% Vr�t� celkov� trv�n�. Bu� maximum v�ech vrstev (default)
% �i konkr�tn� vrstvy - tier (v takov�m p��pad� vrac� NaN, kdy� vrsta nic
% neobsahuje).
% v1.0, Tom� Bo�il, borilt@gmail.com

if nargin  == 1
    t = tgGetEndTime(tg) - tgGetStartTime(tg);
elseif nargin == 2
    t = tgGetEndTime(tg, tierInd) - tgGetStartTime(tg, tierInd);
else
    error('nespr�vn� po�et argument�')
end