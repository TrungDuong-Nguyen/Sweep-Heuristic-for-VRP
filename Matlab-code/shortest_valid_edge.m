% --------------------------------------------------------------------- %
% @Function    shortest_valid_edge
% @Brief       Search for the shortest valid_edge in the information table
% @Input Parameters     
%              Info          “Structure array” data type that specifies the 
%                            distances of edges (increasing order), the  
%                            coordinates of their starting and ending nodes 
%              Invalid_Edge  List of edges that make an incorrect cycle (do 
%                            not pass all clients and depot in each group)
%              t             Intermediate parameters
% @Output Parameters       
%              node1          Starting node of the selected edge 
%              node2          Ending node of the selected edge 
%              Row            Position of the selected edge in the information %                             table    
%
% @Author      NGUYEN Trung Duong – Student Master OSS - UTT
% @Date        2013/01/04
% --------------------------------------------------------------------- %

function [node1, node2, Row] = shortest_valid_edge(Info, Invalid_Edge, t)

Row = 1; Edge = 0;

while(Edge == 0)
    a = 0;
    node1 = Info(t).Table(Row,1);   
    node2 = Info(t).Table(Row,2);   
    
    for line = 1:size(Invalid_Edge,1)
        if isequal(Invalid_Edge(line,:),[node1 node2])||isequal(Invalid_Edge(line,:),[node2 node1])
            Row = Row + 1;
            a = 1;
            break
        end
    end
 
    if a == 0
       Edge = 1; 
    end
end

end