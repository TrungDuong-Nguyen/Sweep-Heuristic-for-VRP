% --------------------------------------------------------------------- %
% @Function    info_table
% @Brief       Build a table for each group that collects some important
%              information
% @Input Parameters
%              n           Total quantity of client
%              W           Capacity of the vehicles
%              xo, yo      Coordinate of the depot
%              newX, newY  Coordinates of the clients (increasing angle order)
%              G           Matrix that show the first and the last client in        %                          each group
%              C           Matrix that show the distance between clients in
%                          each group
% @Output Parameters
%              Info        “Structure array” data type that specifies the
%                          distances of edges (increasing order), the
%                          coordinates of their starting and ending nodes
%
% @Author      NGUYEN Trung Duong – Student Master OSS - UTT
% @Date        2013/01/04
% --------------------------------------------------------------------- %

function [Info] = info_table(n, N, xo, yo, G, C, newX, newY)

NewG = horzcat(0,cumsum(N(1,1:length(N)-1)+1));

% Add the depot to each group
CoorY = []; CoorX = [];
for i=1:length(N)
    CoorY = horzcat(CoorY,yo,newY(1,G(i,1):G(i,2)));
    CoorX = horzcat(CoorX,xo,newX(1,G(i,1):G(i,2)));
end

% Extract to many matrix corresponding to each group, and that contain the %distance between clients inside this group
NewC = triu(C);
H = extract_matrix(NewC,N);

% Calculate the distances between clients and the depot in each group
for i = 1:n
    Depot_Client(1,i) = sqrt((30 - newX(i))^2 + (40 - newY(i))^2);
end

for i = 1:length(N)
    H(i).Mat = vertcat(Depot_Client(1,G(i,1):G(i,2)),H(i).Mat);
    H(i).Mat = horzcat(zeros(1,N(i)+1)',H(i).Mat);
end

for i = 1:length(N)
    Tmp(i).Row = sort(reshape(H(i).Mat,1,size(H(i).Mat,1)^2));
    Groupe(i).Liste = [];
    
    for j = 1:size(Tmp(i).Row,2)
        if Tmp(i).Row(1,j)~= 0
            Groupe(i).Liste = horzcat(Groupe(i).Liste, Tmp(i).Row(1,j));
        end
    end
    
    for x = 1:N(i)+1
        for y = 1:N(i)+1
            Arete(i).Liste((N(i)+1)*(x-1)+y,:) = [x y];
        end
    end
    
    [tmp1, index] = sort(reshape(H(i).Mat,1,size(H(i).Mat,1)^2));
    A = Arete(i).Liste(index,:);
    tmp2 = find(tmp1);
    Arete(i).Liste = A(tmp2,:);
    
    for j = 1:size(Arete(i).Liste,1)
        % Coordinate of the starting node of each edge
        Coor_Node(j,1)= CoorX(1,NewG(1,i)+ Arete(i).Liste(j,1));
        Coor_Node(j,2)= CoorY(1,NewG(1,i)+ Arete(i).Liste(j,1));
        % Coordinate of the ending node of each edge
        Coor_Node(j,3)= CoorX(1,NewG(1,i)+ Arete(i).Liste(j,2));
        Coor_Node(j,4)= CoorY(1,NewG(1,i)+ Arete(i).Liste(j,2));
    end
    
    % Build a table for each group that collects important informations
    Info(i).Table = horzcat(Arete(i).Liste,Coor_Node,(Groupe(i).Liste)');
    Coor_Node = [];
    
end

end