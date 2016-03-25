function tgNew = tgRemoveTier(tg, tierInd)
% function tgNew = tgRemoveTier(tg, tierInd)
% Odstran� vrstvu (tier) textgridu s dan�m indexem (1 = prvn�).
% v1.0, Tom� Bo�il, borilt@gmail.com

if nargin ~= 2
    error('Wrong number of arguments.')
end

% if ~isInt(tierInd)
%     error(['index tier mus� b�t cel� ��slo od 1 v��e [' num2str(tierInd) ']']);
% end
tierInd = tgI(tg, tierInd);

ntiers = tgGetNumberOfTiers(tg);
% if tierInd < 1 || tierInd>ntiers
%     error(['index tier mimo rozsah, tierInd = ' num2str(tierInd) ', ntiers = ' num2str(ntiers)]);
% end

tgNew = tg;

for I = tierInd: ntiers - 1
    tgNew.tier{I} = tgNew.tier{I+1};
end

tgNew.tier(ntiers) = [];
