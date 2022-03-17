% --------------------------------------------------------------------- %
% @Function    update_invalid_edge
% @Brief       [1]. Search for the invalid edges within the group
%              [2]. Update the information table
% @Input Parameters
%              Info          Structure array that specifies the length of edges (increasing order),...
%                            and the coordinates of their starting and ending node
%              SetGroup, t   Temporary variables
% @Output Parameters
%              Info          Table updated 
%              Invalid_Edge  List of edges that may create an incorrect cycle...
%                            (i.e., that do not pass all clients and depot within the group)
% 
% @Programmer  NGUYEN Trung Duong
% --------------------------------------------------------------------- %

function [Info, Invalid_Edge] = update_invalid_edge(SetGroup, Info, t)

    Invalid_Edge = [];
    Degree_2 = [];

    for i = 1:sum(~cellfun(@iscell,{SetGroup.Liste}))

        if ~isempty(SetGroup(i).Liste)
            Temp1.Liste = reshape(SetGroup(i).Liste,1,[]);
            Temp2.Liste = reshape(SetGroup(i).Liste,1,[]);
            Temp3.Liste = reshape(SetGroup(i).Liste,1,[]);

            for j = 1:size(Temp1.Liste,2)
                if sum(Temp1.Liste == Temp1.Liste(1,j))== 1
                    Temp1.Liste(1,j) = 0;
                    indice = find(Temp1.Liste == 0);

                    % Invalid_Edge which may create an incorrect cycle
                    Invalid_Edge(i,1:2)= Temp2.Liste(1,indice);
                end
            end

            % List of nodes whose degree equals to 2 in each group
            Degree_2Temp = Temp3.Liste;
            Degree_2Temp(:,indice) = [];
            Degree_2 = horzcat(Degree_2,Degree_2Temp);

            Degree_2 = sort(Degree_2);
            for l = 1:size(Degree_2,2)-1
                if Degree_2(1,l) == Degree_2(1,l+1)
                   Degree_2(1,l) = 0;
                end
            end
            [~,~,Degree_2] = find(Degree_2);
 
            %In the Info().Table, delete edges which create a vertex > 2
            row = [];
            for l = 1:size(Info(t).Table,1)
                for m = 1:size(Degree_2,2)
                    if sum(Info(t).Table(l,1:2) == Degree_2(1,m))== 1
                         row = horzcat(row,l);
                    end
                end
            end
            Info(t).Table(row,:) = [];
        end
    end

end