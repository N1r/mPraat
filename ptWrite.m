function ptWrite(pt, fileNamePitchtier)
% function ptWrite(pt, fileNamePitchtier)

% Ulo�� PitchTier jako spreadSheet. PitchTier je struct a mus� obsahovat
% alespo� vektory t a f stejn� d�lky. Pokud nejsou v PitchTier specifikov�ny
% tmin a tmax, jsou br�ny jako min a max z t.
% v0.1 Tom� Bo�il, borilt@gmail.com

% pt = ptRead("maminka_TextFile.PitchTier");
% ptWrite(pt, "demo/vystup.PitchTier")


if ~isfield(pt, 't') || ~isfield(pt, 'f')
    error('pt must be a structure with fields ''t'' and ''f'' and optionally ''tmin'' and ''tmax''')
end

if length(pt.t) ~= length(pt.f)
    error('t and f lengths mismatched.')
end
    
N = length(pt.t);

if ~isfield(pt, 'tmin')
    xmin = min(pt.t);
else
    xmin = pt.tmin;
end

if ~isfield(pt, 'tmax')
    xmax = max(pt.t);
else
    xmax = pt.tmax;
end


[fid, message] = fopen(fileNamePitchtier, 'w', 'ieee-be', 'UTF-8');
if fid == -1
    error(['cannot open file [' fileNamePitchTier ']: ' message]);
end


fprintf(fid, '"ooTextFile"\n');
fprintf(fid, '"PitchTier"\n');
fprintf(fid, [num2str(round2(xmin, -20)), ' ', num2str(round2(xmax, -20)), ' ', num2str(N), '\n']);

for n = 1: N
    fprintf(fid, [num2str(round2(pt.t(n), -20)), '\t', num2str(round2(pt.f(n), -20)), '\n']);
end

fclose(fid);
