function tgNew = tgInsertBoundary(tg, tierInd, time, label)
% function tgNew = tgInsertBoundary(tg, tierInd, time, label)
% Vlo�� novou hranici do IntervalTier, ��m� v�dy vznikne nov� interval,
% kter�mu je p�i�azen label (nepovinn� parametr) �i z�stane s pr�zdn�m
% labelem.
% Mo�n� jsou r�zn� situace um�st�n� nov� hranice:
% a) Do ji� existuj�c�ho intervalu:
%    Interval se novou hranic� rozd�l� na dv� ��sti. Lev� si zachov�
%    label p�vodn�ho intervalu, prav� je nastaven nepovinn� nov� label.
%
% b) Vlevo od existuj�c�ch interval�:
%    Nov� interval za��n� zadanou hranic� a kon�� v m�st� za��tku prvn�ho
%    ji� d��ve existuj�c�ho intervalu. Nov�me intervalu je nastaven
%    nepovinn� nov� label.
%
% c) Vpravo od existuj�c�ch interval�:
%    Nov� interval za��n� v m�st� konce posledn�ho ji� existuj�c�ho
%    intervalu a kon�� zadanou novou hranic�. Tomuto nov�m intervalu je
%    nastaven nepovinn� nov� label. Situace je tak tedy pon�kud odli�n� od
%    situac� a) a b), kde nov� label byl nastavov�n v�dy intervalu, kter�
%    le�el napravo od nov� hranice. V situaci c) le�� label naopak nalevo
%    od hranice. Ale je to jedin� logick� mo�nost ve smyslu p�id�v�n�
%    nov�ch interval� za konec ji� existuj�c�ch.
%
% Situace, kdy by se vkl�dala hranice mezi existuj�c� intervaly na pozici,
% kde je�t� ��dn� interval nen�, nen� z hlediska logiky Praatu mo�n�.
% Nen� toti� p��pustn�, aby existoval jeden interval, pak nic, a pak dal�� interval.
% Nic mezi intervaly Praat d�sledn� zna�� jako interval s pr�zdn�m labelem.
% Nov� vrstva IntervalTier v�dy obsahuje pr�zdn� interval
% p�es celou dobu trv�n�. Tento interval je mo�n� hranicemi d�lit na
% podintervaly �i roz�i�ovat na ob� strany. Mezery bez interval� tak
% nemohou vzniknout.
%
% v1.0, Tom� Bo�il, borilt@gmail.com

if nargin < 3 || nargin > 4
    error('Wrong number of arguments.')
end
if nargin == 3
    label = '';
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
    error(['tier ' num2str(tierInd) ' is not IntervalTier']);
end

tgNew = tg;

index = tgGetIntervalIndexAtTime(tg, tierInd, time);
nint = tgGetNumberOfIntervals(tg, tierInd);

if nint == 0
    error('strange situation, tier does not have any interval.')
end

if isnan(index)
    if time > tg.tier{tierInd}.T2(end)   % p��pad c) vpravo od existuj�c�ch interval�
        tgNew.tier{tierInd}.T1(nint+1) = tg.tier{tierInd}.T2(nint);
        tgNew.tier{tierInd}.T2(nint+1) = time;
        tgNew.tier{tierInd}.Label{nint+1} = label;
        tgNew.tmax = max(tg.tmax, time);
    elseif time < tg.tier{tierInd}.T1(1) % p��pad b) vlevo od existuj�c�ch interval�
        for I = nint: -1: 1
            tgNew.tier{tierInd}.T1(I+1) = tgNew.tier{tierInd}.T1(I);
            tgNew.tier{tierInd}.T2(I+1) = tgNew.tier{tierInd}.T2(I);
            tgNew.tier{tierInd}.Label{I+1} = tgNew.tier{tierInd}.Label{I};
        end
        tgNew.tier{tierInd}.T1(1) = time;
        tgNew.tier{tierInd}.T2(1) = tgNew.tier{tierInd}.T1(2);
        tgNew.tier{tierInd}.Label{1} = label;
        tgNew.tmin = min(tg.tmin, time);
    elseif time == tg.tier{tierInd}.T2(end) % pokus o nesmysln� vlo�en� hranice p�esn� na konec tier
        error(['cannot insert boundary because it already exists at the same position (tierInd ' num2str(tierInd) ', time ' num2str(time) ')'])
    else
        error('strange situation, cannot find any interval and ''time'' is between intervals.')
    end
else % p��pad a) do ji� existuj�c�ho intervalu
    for I = 1: nint
        if ~isempty(find(tgNew.tier{tierInd}.T1 == time, 1)) || ~isempty(find(tgNew.tier{tierInd}.T2 == time, 1))
            error(['cannot insert boundary because it already exists at the same position (tierInd ' num2str(tierInd) ', time ' num2str(time) ')'])
        end
    end
    
    for I = nint: -1: index+1
        tgNew.tier{tierInd}.T1(I+1) = tgNew.tier{tierInd}.T1(I);
        tgNew.tier{tierInd}.T2(I+1) = tgNew.tier{tierInd}.T2(I);
        tgNew.tier{tierInd}.Label{I+1} = tgNew.tier{tierInd}.Label{I};
    end
    tgNew.tier{tierInd}.T1(index) = tg.tier{tierInd}.T1(index);
    tgNew.tier{tierInd}.T2(index) = time;
    tgNew.tier{tierInd}.Label{index} = tg.tier{tierInd}.Label{index};
    tgNew.tier{tierInd}.T1(index+1) = time;
    tgNew.tier{tierInd}.T2(index+1) = tg.tier{tierInd}.T2(index);
    tgNew.tier{tierInd}.Label{index+1} = label;
end
