function tgPlot(tg, subPlotStartIndex)
% function tgPlot(tg, subPlotStartIndex)
% Vykresl� textgrid, nepovinn� parametr subPlotStartIndex ud�v�, od kter�ho
% indexu v subplotu za��t kreslit (v�hodn�, pokud nap�. do prvn� ��sti
% chceme vykreslit zvuk, od dal��ho pak textgrid)
% v1.0, Tom� Bo�il, borilt@gmail.com

if nargin  == 1
    subPlotStartIndex = 1;
elseif nargin  == 2
    if ~isInt(subPlotStartIndex) || subPlotStartIndex < 1
        error(['subPlotStartIndex mus� b�t cel� ��slo od 1 v��e [' num2str(subPlotStartIndex) ']']);
    end
else
    error('nespr�vn� po�et argument�')
end

ntiers = tgGetNumberOfTiers(tg);
if ntiers == 0
    subplot 111
    title('Empty TextGrid')
end

for I = 1: ntiers
    subplot(ntiers + subPlotStartIndex - 1, 1, I + subPlotStartIndex - 1)
    
    if tgIsPointTier(tg, I)
%         title('point tier')
        StemHandle = stem(tg.tier{I}.T, 2*0.5*ones(size(tg.tier{I}.T)), 'fill', 'MarkerSize', 2);
        
        Xd = get(StemHandle, 'XData');
        Yd = get(StemHandle, 'YData');
        for K = 1 : length(Xd)
            lab = tg.tier{I}.Label{K};
            lab = strrep(lab, '\', '\\'); lab = strrep(lab, '_', '\_');
            lab = strrep(lab, '^', '\^'); lab = strrep(lab, '{', '\{');
            lab = strrep(lab, '}', '\}');
            text(Xd(K), Yd(K) * 1.3, lab, 'HorizontalAlignment', 'center');
        end
        axis([tg.tmin tg.tmax 0 2])
        set(gca,'YTick',[])
        
    elseif tgIsIntervalTier(tg, I)
%         title('interval tier')
        StemHandle = stem(tg.tier{I}.T1, 2*0.8*ones(size(tg.tier{I}.T1)), 'MarkerSize', 1);
        hold on
        stem(tg.tier{I}.T2, 2*0.5*ones(size(tg.tier{I}.T2)), 'MarkerSize', 1);
        for K = 1: length(tg.tier{I}.T1)
            plot([tg.tier{I}.T1(K) tg.tier{I}.T2(K)], 2*[0.5 0.5]);
        end
        hold off
        
        Xd = get(StemHandle, 'XData');
        Yd = get(StemHandle, 'YData');
        for K = 1 : length(Xd)
            lab = tg.tier{I}.Label{K};
            lab = strrep(lab, '\', '\\'); lab = strrep(lab, '_', '\_');
            lab = strrep(lab, '^', '\^'); lab = strrep(lab, '{', '\{');
            lab = strrep(lab, '}', '\}');
            text(Xd(K), Yd(K) * (1.3*0.5)/(0.8), lab, 'HorizontalAlignment', 'left');
        end
        axis([tg.tmin tg.tmax 0 2])
        set(gca,'YTick',[])
    else
        error('unknown tier type')
    end
    
    ylabel(tg.tier{I}.name);
end