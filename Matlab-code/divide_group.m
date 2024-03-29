% --------------------------------------------------------------------- %
% @Function     divide_group
% @Brief        Divide the set of clients into multiple groups
% @Input Parameters
%               n     Total number of clients
%               W     Capacity of the vehicles
%               newQ  Demands of the clients (increasing angle order)
% @Output Parameters
%               N     Vector that indicates the number of clients in each group
%               G     Matrix that shows the first and the last client in each group
%
% @Programmer   NGUYEN Trung Duong
% --------------------------------------------------------------------- %

function [N, G] = divide_group(n, W, newQ)

S = 0;  g = 0;
f = 1;

for i = 0:(n-1)
    S = S + newQ(i+1);        % S: total demands of the clients
    if S >= W
        g = g + 1;
        G(g,1) = f;           % f: first client of group (g)
        G(g,2) = i;           % k: last client of group (g)
        N(g) = i - f + 1;     % Number of client in group (g)
        f = i+1;
        S = newQ(i+1);
    end
end
[l, ~] = size(G);

if G(l,2)~= n
    G(l+1, :) = [G(l,2)+1 n];
    N(g+1) = G(l+1,2) - G(l+1,1) + 1;
end

end