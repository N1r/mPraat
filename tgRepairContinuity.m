function tgNew = tgRepairContinuity(tg, verbose)
% function tgNew = tgInsertNewIntervalTier(tg, verbose)
% Opravi problem s navaznosti T2 a T1 v intervalovych vrstvach, ktery vznikl diky chybnemu zaokrouhlovani
% napr. v automatickem segmentatoru Prague Labeller, diky cemu nebylo mozne tyto hranice v Praatu manualne presunovat.
% 
% Parametrem verbose = true lze vypnout vypis problemovych mist.
% v1.0, Tomas Boril, borilt@gmail.com
%     tgProblem = tgRead('demo/H_problem.TextGrid')
%     tgNew = tgRepairContinuity(tgProblem)
%     tgWrite(tgNew, 'demo/H_problem_OK.TextGrid')



if nargin ~= 1 && nargin ~= 2
    error('Wrong number of arguments.')
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
