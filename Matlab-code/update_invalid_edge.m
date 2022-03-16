% --------------------------------------------------------------------- %
% @Function    update_invalid_edge
% @Brief       Build a table for each group that collects some important 
%              information
% @Input Parameters     
%              Info          “Structure array” data type that specifies the 
%                            distances of edges (increasing order), the  
%                            coordinates of their starting and ending nodes 
%              SetGroup, t   Intermediate parameters
% @Output Parameters       
%              Info          Table updated 
%              Invalid_Edge  List of edges that make an incorrect cycle (do 
%                            not pass all clients and depot in each group)
% 
% @Author      NGUYEN Trung Duong – Student Master OSS - UTT
% @Date        2013/01/04
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
               
                    % Invalid_Edge which make an incorrect cycle
                    Invalid_Edge(i,1:2)= Temp2.Liste(1,indice);                            
                end
            end
        
            % List of nodes whose degree equal to 2 in each group (~multiples % SetGroup.Liste)
            Degree_2Temp = Temp3.Liste;
            Degree_2Temp(:,indice) = [];
            Degree_2 = horzcat(Degree_2,Degree_2Temp);
        
            Degree_2 = sort(Degree_2);
            for l = 1:size(Degree_2,2)-1
                if Degree_2(1,l) == Degree_2(1,l+1)
                   Degree_2(1,l) = 0;
                end
            end
            [o,p,Degree_2] = find(Degree_2);
 
            %In the Info().Table, delete edges which create a vertex>2
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