function tgNew = tgRepairContinuity(tg, verbose)
% function tgNew = tgInsertNewIntervalTier(tg, verbose)
% Oprav� probl�m s n�vaznost� T2 a T1 v intervalov�ch vrstv�ch, kter� vznikl d�ky chybn�mu zaokrouhlov�n�
% nap�. v automatick�m segment�toru Prague Labeller, d�ky �emu nebylo mo�n� tyto hranice v Praatu manu�ln� p�esunovat.
% 
% Parametrem verbose = true lze vypnout v�pis probl�mov�ch m�st.
% v1.0, Tom� Bo�il, borilt@gmail.com
%     tgProblem = tgRead('demo/H_problem.TextGrid')
%     tgNew = tgRepairContinuity(tgProblem)
%     tgWrite(tgNew, 'demo/H_problem_OK.TextGrid')



if nargin ~= 1 && nargin ~= 2
    error('nespr�vn� po�et argument�')
end

if nargin == 1
    verbose = false;
end

ntiers = tgGetNumberOfTiers(tg);

tgNew = tg;

for I = 1: ntiers
    if strcmp(tgNew.tier{I}.type, 'interval') == 1
        for J = 1: length(tgNew.tier{I}.Label)-1
            if tgNew.tier{I}.T2(J) ~= tgNew.tier{I}.T1(J+1)
                newVal = mean([tgNew.tier{I}.T2(J), tgNew.tier{I}.T1(J+1)]);
                if ~verbose
                    disp(['Problem found [tier: ', num2str(I), ', int: ', num2str(J), ', ', num2str(J+1), '] t2 = ', sprintf('%.12f', tgNew.tier{I}.T2(J)), ...
                        ', t1 = ', sprintf('%.12f', tgNew.tier{I}.T1(J+1)), '. New value: ', sprintf('%.12f', newVal), '.'])
                end

                tgNew.tier{I}.T2(J) = newVal;
                tgNew.tier{I}.T1(J+1) = newVal;
            end
        end
    end
end
