% --------------------------------------------------------------------- %
% @Function    divide_group
% @Brief       Calculate the distances between clients in each group
% @Input Parameters
%              newX, newY  Coordinates of the clients (increasing angle
%              order)
%              G           Matrix that shows the first and the last client in each group
% @Output Parameters
%              C           Matrix that shows the distances between clients in each group
%
% @Programmer  NGUYEN Trung Duong
% --------------------------------------------------------------------- %
function C = distance_matrix(newX, newY, G)

for i = 1:size(G,1)
    for j = G(i,1):G(i,2)
        for k = G(i,1):G(i,2)
            C(j,k) = sqrt((newX(j)- newX(k))^2 + (newY(j)- newY(k))^2);
        end
    end
end

end
