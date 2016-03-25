function tgNew = tgInsertNewIntervalTier(tg, tierInd, tierName, tStart, tEnd)
% function tgNew = tgInsertNewIntervalTier(tg, tierInd, tierName, tStart, tEnd)
% Vytvo�� novou vrstvu (tier) textgridu typu IntervalTier a vlo�� ji na dan� index (1 = prvn�).
% N�sleduj�c� vrstvy posune o jednu d�l.
% Je t�eba zadat jm�no nov� vrstvy - �et�zec tierName.
% Po vzoru Praatu pr�zdn� intervalov� tier obsahuje jeden interval
% s pr�zdn�m labelem p�es cel� �asov� rozsah tmin a� tmax textgridu,
% jedin� tak je toti� mo�n� v Praatu tento interval "d�lit" na men��, a t�m vlastn�
% vkl�dat nov� intervaly.
% Rozsah tmin a� tmax je mo�n� zadat nepovinn�mi parametry tStart a tEnd.
% v1.0, Tom� Bo�il, borilt@gmail.com

if nargin ~= 3 && nargin ~= 5
    error('Wrong number of arguments.')
end

% if ~isInt(tierInd)
%     error(['index tier mus� b�t cel� ��slo od 1 v��e [' num2str(tierInd) ']']);
% end
tierInd = tgI(tg, tierInd);

ntiers = tgGetNumberOfTiers(tg);
% if tierInd < 1 || tierInd>ntiers+1
%     error(['index tier mimo rozsah <1; ntiers+1>, tierInd = ' num2str(tierInd) ', ntiers = ' num2str(ntiers)]);
% end

tgNew = tg;

tNew.name = tierName;
tNew.type = 'interval';
if nargin == 5
    if tStart >= tEnd
        error(['tStart [' num2str(tStart) '] must be lower than tEnd [' num2str(tEnd) ']']);
    end
    tNew.T1(1) = tStart;
    tNew.T2(1) = tEnd;
    tgNew.tmin = min(tg.tmin, tStart);
    tgNew.tmax = max(tg.tmax, tEnd);
else
    tNew.T1(1) = tg.tmin;
    tNew.T2(1) = tg.tmax;
end
tNew.Label{1} = '';
for I = ntiers + 1: -1: tierInd+1
    tgNew.tier{I} = tgNew.tier{I-1};
end

tgNew.tier{tierInd} = tNew;
