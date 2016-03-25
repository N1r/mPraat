close all
clear all
clc

tg = tgRead('demo/H.TextGrid');

tg = tgInsertNewIntervalTier(tg, 1, 'moje');
tg = tgInsertBoundary(tg, 1, 1, 'ahoj');
tg = tgInsertBoundary(tg, 1, 2);
tg = tgInsertBoundary(tg, 1, 3, 'u�ivateli');
tg = tgInsertBoundary(tg, 1, 3.5);

pocitadloE = 0;
pocitadloVokaly = 0;
for I = 1: tgGetNumberOfIntervals(tg, 3)
    lab = tgGetLabel(tg, 3, I);
    
    if strcmp(lab, 'a') || strcmp(lab, 'a:')
        pocitadloE = pocitadloE + 1;
    end
    if ~isempty(strfind('i:e:a:o:u:', lab)) % kr�tk� i dlouh� vok�ly
        pocitadloVokaly = pocitadloVokaly + 1;
        trvani = tgGetIntervalDuration(tg, 3, I);
        fprintf([num2str(pocitadloVokaly) '. vok�l [' lab ']\ttrv�\t' num2str(round2(trvani*1000, -1), '%05.1f') ' ms.\n']);
    end
end

tgPlot(tg)
disp(['Nalezeno ' num2str(pocitadloE) ' a-ov�ch vok�l� a ' num2str(pocitadloVokaly) ' vok�l� celkov�.'])

tg = tgInsertInterval(tg, 1, -0.5, -0.25, 'tady'); % vlo�en� mimo vlevo + automatick� pr�zdn� interval jako v�pl�
tg = tgInsertInterval(tg, 1, -1, -0.5, 'Tak'); % vlo�en� mimo vlevo pln� navazuj�c�
tg = tgInsertInterval(tg, 1, 0, 0.25, 'to'); % vlo�en� do existuj�c�ho intervalu �pln� nalevo (vznikne jen jedna nov� hranice)
tg = tgInsertInterval(tg, 1, 0.75, 1, 'je:'); % vlo�en� do existuj�c�ho intervalu �pln� napravo (vznikne jen jedna nov� hranice)
tg = tgInsertInterval(tg, 1, 2.25, 2.75, 'v�en�'); % vlo�en� do existuj�c�ho intervalu doprost�ed (vzniknou dv� nov� hranice)
tg = tgInsertInterval(tg, 1, 3.616, 4, 'te�ka'); % vlo�en� mimo vpravo pln� navazuj�c�
tg = tgInsertInterval(tg, 1, 4.25, 4.5, 'konec'); % vlo�en� mimo vpravo + automatick� pr�zdn� interval jako v�pl�

figure, tgPlot(tg)

tgWrite(tg, 'demo/vystup.TextGrid')


tg = tgRead('demo/H.TextGrid');
figure
[snd, fs] = audioread('demo/H.wav');
t = 0: 1/fs: (length(snd)-1)/fs;
subplot(tgGetNumberOfTiers(tg) + 1, 1, 1)
plot(t, snd, 'k')
axis([t(1) t(end) -1 1])
tgPlot(tg, 2)
subplot(tgGetNumberOfTiers(tg) + 1, 1, 3)
hold on
plot(t, snd, 'k')
axis([t(1) t(end) -1 2])
hold off

tgProblem = tgRead('demo/H_problem.TextGrid');
tgNew = tgRepairContinuity(tgProblem);
tgNew2 = tgRepairContinuity(tgNew);

