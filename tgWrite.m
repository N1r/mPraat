function tgWrite(tgrid, fileNameTextGrid)
% function tgWrite(tgrid, fileNameTextGrid)
% ulo�� textgrid s libovoln�m po�tem tiers (intervalov� i bodov�)
% pokud v tier nen� specifikov�n .type, je automaticky br�na jako
% intervalov� (kv�li zp�tn� kompatibilit�). Jinak je doporu�ov�no .type
% uv�d�t ('interval' nebo 'point').
% Pokud neobsahuje textgrid .tmin a .tmax, jsou ur�eny automaticky jako
% nejkrajn�j�� hodnoty ze v�ech tier.
% Ukl�d� ve form�tu Short text file, UTF-8.
% v1.5 Tom� Bo�il, borilt@gmail.com

% tgrid = readTextGrid('H5a_3_BARA.TextGrid');
% fileNameTextGrid = 'vystup.TextGrid';

nTiers = length(tgrid.tier);  % po�et Tiers

minCasTotal = NaN;
maxCasTotal = NaN;
if isfield(tgrid, 'tmin') && isfield(tgrid, 'tmax')
    minCasTotal = tgrid.tmin;
    maxCasTotal = tgrid.tmax;
end

for I = 1: nTiers
    if isfield(tgrid.tier{I}, 'type')
        if strcmp(tgrid.tier{I}.type, 'interval') == 1
            typInt = true;
        elseif strcmp(tgrid.tier{I}.type, 'point') == 1
            typInt = false;
        else
            error(['unknown tier type [' tgrid.tier{I}.type ']']);
        end
    else
        typInt = true;
    end
    tgrid.tier{I}.typInt = typInt;
    
    if typInt == true
        nInt = length(tgrid.tier{I}.T1); % po�et interval�
        if nInt > 0
            minCasTotal = min(tgrid.tier{I}.T1(1), minCasTotal);
            maxCasTotal = max(tgrid.tier{I}.T2(end), maxCasTotal);
        end
    else
        nInt = length(tgrid.tier{I}.T); % po�et interval�
        if nInt > 0
            minCasTotal = min(tgrid.tier{I}.T(1), minCasTotal);
            maxCasTotal = max(tgrid.tier{I}.T(end), maxCasTotal);
        end
    end
end

[fid, message] = fopen(fileNameTextGrid, 'w', 'ieee-be', 'UTF-8');
if fid == -1
    error(['cannot open file [' fileNameTextGrid ']: ' message]);
end

fprintf(fid, 'File type = "ooTextFile"\n');
fprintf(fid, 'Object class = "TextGrid"\n');
fprintf(fid, '\n');
fprintf(fid, '%.17f\n', minCasTotal); % nejmen�� �as ze v�ech vrstev
fprintf(fid, '%.17f\n', maxCasTotal); % nejv�t�� �as ze v�ech vrstev
fprintf(fid, '<exists>\n');
fprintf(fid, '%d\n', nTiers);  % po�et Tiers

for N = 1: nTiers
    if tgrid.tier{N}.typInt == true
        fprintf(fid, '"IntervalTier"\n');
        fprintf(fid, ['"' tgrid.tier{N}.name '"\n']);

        nInt = length(tgrid.tier{N}.T1); % po�et interval�
        if nInt > 0
            fprintf(fid, '%.17f\n', tgrid.tier{N}.T1(1)); % po��te�n� �as tier
            fprintf(fid, '%.17f\n', tgrid.tier{N}.T2(end)); % fin�ln� �as tier
            fprintf(fid, '%d\n', nInt);  % po�et interval� textgrid

            for I = 1: nInt
                fprintf(fid, '%.17f\n', tgrid.tier{N}.T1(I));
                fprintf(fid, '%.17f\n', tgrid.tier{N}.T2(I));
                fprintf(fid, '"%s"\n', tgrid.tier{N}.Label{I});
            end
        else % vytvo�en� jednoho pr�zdn�ho intervalu
            fprintf(fid, '%.17f\n', minCasTotal); % po��te�n� �as tier
            fprintf(fid, '%.17f\n', maxCasTotal); % fin�ln� �as tier
            fprintf(fid, '%d\n', 1);  % po�et interval� textgrid
            fprintf(fid, '%.17f\n', minCasTotal);
            fprintf(fid, '%.17f\n', maxCasTotal);
            fprintf(fid, '""\n');
        end
    else % je to pointTier
        fprintf(fid, '"TextTier"\n');
        fprintf(fid, ['"' tgrid.tier{N}.name '"\n']);

        nInt = length(tgrid.tier{N}.T); % po�et interval�
        if nInt > 0
            fprintf(fid, '%.17f\n', tgrid.tier{N}.T(1)); % po��te�n� �as tier
            fprintf(fid, '%.17f\n', tgrid.tier{N}.T(end)); % fin�ln� �as tier
            fprintf(fid, '%d\n', nInt);  % po�et interval� textgrid

            for I = 1: nInt
                fprintf(fid, '%.17f\n', tgrid.tier{N}.T(I));
                fprintf(fid, '"%s"\n', tgrid.tier{N}.Label{I});
            end
        else % pr�zdn� pointtier
            fprintf(fid, '%.17f\n', minCasTotal); % po��te�n� �as tier
            fprintf(fid, '%.17f\n', maxCasTotal); % fin�ln� �as tier
            fprintf(fid, '0\n');  % po�et interval� textgrid
        end
    end

end
fclose(fid);

