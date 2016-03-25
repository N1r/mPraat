function ptPlot(pt)
% function ptPlot(pt)
% Vykresl� PitchTier.
% v1.0, Tom� Bo�il, borilt@gmail.com

if nargin  ~= 1
    error('nespr�vn� po�et argument�')
end

plot(pt.t, pt.f, 'ok', 'MarkerSize', 2)

if isfield(pt, 'tmin') && isfield(pt, 'tmax')
    xlim([pt.tmin pt.tmax])
end

ylim([min(pt.f)*0.95 max(pt.f)*1.05])
