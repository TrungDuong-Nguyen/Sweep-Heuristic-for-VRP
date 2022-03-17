% --------------------------------------------------------------------- %
% @Function    shortest_valid_edge
% @Brief       Search for the shortest valid_edge in the information table
% @Input Parameters
%              Info          Structure array that specifies the length of edges (increasing order),...
%                            and the coordinates of their starting and ending node
%              Invalid_Edge  List of edges that may create an incorrect cycle...
%                            (i.e., that do not pass all clients and depot within the group)
%              t             Temporary variable
% @Output Parameters
%              node1          Starting node of the selected edge
%              node2          Ending node of the selected edge
%              Row            Row index of the selected edge in the information table
%
% @Programmer  NGUYEN Trung Duong
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