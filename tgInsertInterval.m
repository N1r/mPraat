function tgNew = tgInsertInterval(tg, tierInd, tStart, tEnd, label)
% function tgNew = tgInsertInterval(tg, tierInd, tStart, tEnd, label)
% Vlo�� nov� interval do pr�zdn�ho m�sta v IntervalTier, tedy
% a) Do ji� existuj�c�ho intervalu (mus� m�t pr�zdn� label):
%    Nej�ast�j�� p��pad, proto�e samotn� nov� vrstva IntervalTier je cel�
%    jeden pr�zdn� interval od za��tku do konce.
% b) Mimo existuj�c� intervaly nalevo �i napravo, vznikl� mezera bude
%    zapln�na pr�zdn�m intervalem.
% Intervalu tStart a� tEnd je p�i�azen label (nepovinn� parametr) �i z�stane
% s pr�zdn�m labelem.
%
% Tato funkce je ve v�t�in� p��pad� tot�, jako 1. tgInsertBoundary(tEnd)
% a 2. tgInsertBoundary(tStart, nov� label). Ale nav�c je prov�d�na kontrola,
% a) zda tStart a tEnd n�le�ej� do stejn�ho p�vodn�ho pr�zdn�ho intervalu,
% b) nebo jsou oba mimo existuj�c� intervaly nalevo �i napravo.
%
% Pr�niky nov�ho intervalu s v�ce ji� existuj�c�mi i pr�zdn�mi intervaly
% ned�vaj� smysl a jsou zak�z�ny.
%
% Je t�eba si uv�domit, �e ve skute�nosti tato funkce �asto
% vytv��� v�ce interval�. Nap�. m�me zcela novou IntervalTier s jedn�m pr�zdn�m
% intervalem 0 a� 5 sec. Vlo��me interval 1 a� 2 sec s labelem '�ekl'.
% V�sledkem jsou t�i intervaly: 0-1 '', 1-2 '�ekl', 2-5 ''.
% Pak znovu vlo��me touto funkc� interval 7 a� 8 sec s labelem 'j�',
% v�sledkem bude p�t interval�: 0-1 '', 1-2 '�ekl', 2-5 '', 5-7 '' (vkl�d� se
% jako v�pl�, proto�e jsme mimo rozsah p�vodn� vrstvy), 7-8 'j�'.
% Pokud v�ak nyn� vlo��me interval p�esn� 2 a� 3 'to', p�id� se ve
% skute�nosti jen jeden interval, kde se vytvo�� prav� hranice intervalu a
% lev� se jen napoj� na ji� existuj�c�, v�sledkem bude �est interval�:
% 0-1 '', 1-2 '�ekl', 2-3 'to', 3-5 '', 5-7 '', 7-8 'j�'.
% M��e tak� nastat situace, kdy nevytvo�� ��dn� nov� interval, nap�. kdy�
% do p�edchoz�ho vlo��me interval 3 a� 5 'asi'. T�m se pouze p�vodn� pr�zdn�mu
% intervalu 3-5 nastav� label na 'asi', v�sledkem bude op�t jen �est interval�:
% 0-1 '', 1-2 '�ekl', 2-3 'to', 3-5 'asi', 5-7 '', 7-8 'j�'.
%
% Tato funkce v Praatu nen�, zde je nav�c a je vhodn� pro situace,
% kdy chceme nap�. do pr�zdn� IntervalTier p�idat n�kolik odd�len�ch interval�
% (nap�. intervaly detekovan� �e�ov� aktivity).
% Naopak nen� zcela vhodn� pro p�id�v�n� na sebe p��mo napojen�ch
% interval� (nap�. postupn� segmentujeme slovo na jednotliv� navazuj�c�
% hl�sky), proto�e kdy� nap�. vlo��me intervaly 1 a� 2.1 a 2.1 a� 3,
% kde ob� hodnoty 2.1 byly vypo�teny samostatn� a d�ky zaokrouhlovac�m chyb�m
% se zcela p�esn� nerovnaj�, ve skute�nosti t�m vznikne bu� je�t� pr�zdn�
% interval 'p�ibli�n�' 2.1 a� 2.1, co� nechceme, a nebo naopak funkce skon��
% s chybou, �e tStart je v�t�� ne� tEnd, pokud zaokrouhlen� dopadlo opa�n�.
% Pokud v�ak hranice byla spo�tena jen jednou a ulo�ena do prom�nn�, kter�
% byla pou�ita jako kone�n� hranice p�edch�zej�c�ho intervalu, a z�rove� jako
% po��te�n� hranice nov�ho intervalu, nem�l by b�t probl�m a nov� interval
% se vytvo�� jako napojen� bez vlo�en�ho 'mikrointervalu'.
% Ka�dop�dn�, bezpe�n�j�� pro takov� ��ely je zp�sob, jak se postupuje
% v Praatu, tedy vlo�it hranici se  za��tkem prvn� hl�sky pomoc�
% tgInsertBoundary(�as, labelHl�sky), pak stejn� �asy za��tk� a labely v�ech
% n�sleduj�c�ch hl�sek, a nakonec vlo�it je�t� kone�nou hranici posledn� hl�sky
% (tedy ji� bez labelu) pomoc� tgInsertBoundary(�as).
%
% v1.0, Tom� Bo�il, borilt@gmail.com

if nargin < 4 || nargin > 5
    error('Wrong number of arguments.')
end
if nargin == 4
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

if tStart >= tEnd
    error(['tStart [' num2str(tStart) '] must be lower than tEnd [' num2str(tEnd) ']']);
end
% pozn. d�ky t�to podm�nce nemohou nastat n�kter� situace podchycen� n�e
% (tStart == tEnd), leccos se t�m zjednodu�uje a Praat stejn� nedovoluje
% m�t dv� hranice ve stejn�m �ase, tak�e je to alespo� kompatibiln�.

% tgNew = tg;

nint = length(tg.tier{tierInd}.T1);
if nint == 0
    % Zvl�tn� situace, tier nem� ani jeden interval.
    tgNew = tg;
    tgNew.tier{tierInd}.T1 = tStart;
    tgNew.tier{tierInd}.T2 = tEnd;
    tgNew.tier{tierInd}.Label{1} = label;
    tgNew.tmin = min(tgNew.tmin, tStart);
    tgNew.tmax = max(tgNew.tmax, tEnd);
    return
end

tgNalevo = tg.tier{tierInd}.T1(1);
tgNapravo = tg.tier{tierInd}.T2(end);
if tStart < tgNalevo && tEnd < tgNalevo
%     disp('vkl�d�m �pln� nalevo + pr�zdn� interval jako v�pl�')
    tgNew = tgInsertBoundary(tg, tierInd, tEnd);
    tgNew = tgInsertBoundary(tgNew, tierInd, tStart, label);
    return
elseif tStart <= tgNalevo && tEnd == tgNalevo
%     disp('vkl�d�m �pln� nalevo, plynule navazuji')
    tgNew = tgInsertBoundary(tg, tierInd, tStart, label);
    return
elseif tStart < tgNalevo && tEnd > tgNalevo
    error(['intersection of new interval (' num2str(tStart) ' to ' num2str(tEnd) ' sec, ''' label ''') and several others already existing (region outside ''left'' and the first interval) is forbidden'])
elseif tStart > tgNapravo && tEnd > tgNapravo %%
%     disp('vkl�d�m �pln� napravo + pr�zdn� interval jako v�pl�')
    tgNew = tgInsertBoundary(tg, tierInd, tEnd);
    tgNew = tgInsertBoundary(tgNew, tierInd, tStart, label);
    return
elseif tStart == tgNapravo && tEnd >= tgNapravo
%     disp('vkl�d�m �pln� napravo, plynule navazuji')
    tgNew = tgInsertBoundary(tg, tierInd, tEnd, label);
    return
elseif tStart < tgNapravo && tEnd > tgNapravo
    error(['intersection of new interval (' num2str(tStart) ' to ' num2str(tEnd) ' sec, ''' label ''') and several others already existing (the last interval and region outside ''right'') is forbidden'])
elseif tStart >= tgNalevo && tEnd <= tgNapravo
    % disp('vkl�d�n� n�kam do ji� existuj�c� oblasti, nutn� kontrola stejn�ho a pr�zdn�ho intervalu')
    % nalezen� v�ech interval�, kam �asy spadaj� - pokud se tref�me na
    % hranici, m��e toti� �as n�le�et dv�ma interval�m
    iStart = [];
    iEnd = [];
    for I = 1: nint
        if tStart >= tg.tier{tierInd}.T1(I) && tStart <= tg.tier{tierInd}.T2(I)
            iStart = [iStart I];
        end
        if tEnd >= tg.tier{tierInd}.T1(I) && tEnd <= tg.tier{tierInd}.T2(I)
            iEnd = [iEnd I];
        end
    end
    if ~(length(iStart) == 1 && length(iEnd) == 1)
        prunik = intersect(iStart, iEnd); % nalezen� spole�n�ho intervalu z v�ce mo�n�ch variant
        if isempty(prunik)
            % je to chyba, ale ta bude zachycena d�le podm�nkou 'if iStart == iEnd'
            iStart = iStart(end);
            iEnd = iEnd(1);
        else
            iStart = prunik(1);
            iEnd = prunik(1);
            if length(prunik) > 1 % pokus o nalezen� prvn�ho vhodn�ho kandid�ta
                for I = 1: length(prunik)
                    if isempty(tg.tier{tierInd}.Label{prunik(I)})
                        iStart = prunik(I);
                        iEnd = prunik(I);
                        break;
                    end
                end
            end
        end
    end
    if iStart == iEnd
        if isempty(tg.tier{tierInd}.Label{iStart})
%             disp('vkl�d�m dovnit� intervalu, ot�zka, zda napojit �i ne')
            t1 = tg.tier{tierInd}.T1(iStart);
            t2 = tg.tier{tierInd}.T2(iStart);
            if tStart == t1 && tEnd == t2
%                 disp('jenom nastav�m ji� existuj�c�mu pr�zdn�mu intervalu label');
                tgNew = tg;
                tgNew.tier{tierInd}.Label{iStart} = label;
                return
%             elseif tStart == t1 && tEnd == t1
%                 disp('p�vodn�mu intervalu nastav�m label a vlo��m jednu hranici do t1, t�m vznikne nov� nulov� interval na za��tku s nov�m labelem a cel� p�vodn� interval bude st�le pr�zdn�')
%             elseif tStart == t2 && tEnd == t2
%                 disp('vlo��m jednu hranici do t2 s nov�m labelem, t�m z�stane p�vodn� cel� pr�zdn� interval a vznikne nov� nulov� interval na konci s nov�m labelem')
            elseif tStart == t1 && tEnd < t2
%                 disp('p�vodn�mu intervalu nastav�m label a vlo��m jednu hranici do tEnd, t�m se p�vodn� interval rozd�l� na dv� ��sti, prvn� bude m�t nov� label, druh� z�stane pr�zdn�')
                tgNew = tg;
                tgNew.tier{tierInd}.Label{iStart} = label;
                tgNew = tgInsertBoundary(tgNew, tierInd, tEnd);
                return
            elseif tStart > t1 && tEnd == t2
%                 disp('vlo��m jednu hranici do tStart s nov�m labelem, t�m se p�vodn� interval rozd�l� na dv� ��sti, prvn� z�stane pr�zdn� a druh� bude m�t nov� label')
                tgNew = tgInsertBoundary(tg, tierInd, tStart, label);
                return
            elseif tStart > t1 && tEnd < t2
%                 disp('vlo��m hranici do tEnd s pr�zdn�m labelem, a pak vlo��m hranici do tStart s nov�m labelem, t�m se p�vodn� interval rozd�l� na t�i ��sti, prvn� a posledn� budou pr�zdn�, prost�edn� bude m�t nov� label')
                tgNew = tgInsertBoundary(tg, tierInd, tEnd);
                tgNew = tgInsertBoundary(tgNew, tierInd, tStart, label);
            else
                error('Logical error in this function, this situation must not happened. Contact author, but please, be kind, he is really sorry this happened.')
            end
        else
            error(['Cannot insert new interval (' num2str(tStart) ' to ' num2str(tEnd) ' sec, ''' label ''') into the interval with a non-empty label (' num2str(tg.tier{tierInd}.T1(iStart)) ' to ' num2str(tg.tier{tierInd}.T2(iStart)) ' sec, ''' tg.tier{tierInd}.Label{iStart} '''), it is forbidden.'])
        end
    else
        error(['intersection of new interval (' num2str(tStart) ' to ' num2str(tEnd) ' sec, ''' label ''') and several others already existing (indices ' num2str(iStart) ' to ' num2str(iEnd) ') is forbidden'])
    end
else
    error('Logical error in this function, this situation must not happened. Contact author, but please, be kind, he is really sorry this happened.')
end

return
