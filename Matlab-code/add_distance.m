% --------------------------------------------------------------------- %
% @Function    add_distance
% @Brief       Add the distances of the selected edge to the total distance
% @Input Parameters     
%              Info          “Structure array” data type that specifies the 
%                            distances of edges (increasing order), the  
%                            coordinates of their starting and ending nodes 
%              Invalid_Edge  List of edges that make an incorrect cycle (do 
%                            not pass all clients and depot in each group)
%              node1          Starting node of the selected edge 
%              node2          Ending node of the selected edge 
%              Row            Position of the selected edge in the information %                             table
%              Distance, SetGroup, t   Intermediate parameters

% @Output Parameters       
%              Distance       Total distance after addition      
%              Info           Table updated
%              SetGroup       Intermediate parameter   
%
% @Author      NGUYEN Trung Duong – Student Master OSS - UTT
% @Date        2013/01/04
% --------------------------------------------------------------------- %

function [Distance, Info, SetGroup] = add_distance(node1, node2, Invalid_Edge, Distance, Info, Row, t, SetGroup)
 
% Get the selected edge
Min_Edge = Info(t).Table(Row,7);
[r1,c1] = find(Invalid_Edge == node1);
[r2,c2] = find(Invalid_Edge == node2);
 
if ~isempty(r1) && ~isempty(r2)     % r1~=[] and r2~=[]
    SetGroup(r1).Liste = vertcat(SetGroup(r1).Liste, [node1 node2], SetGroup(r2).Liste);
    SetGroup(r2).Liste = [];
elseif ~isempty(r1) && isempty(r2)  % r1~=[] and r2==[]
    SetGroup(r1).Liste = vertcat(SetGroup(r1).Liste, [node1 node2]);
elseif isempty(r1) && ~isempty(r2)  % r1==[] and r2~=[]
    SetGroup(r2).Liste = vertcat(SetGroup(r2).Liste, [node1 node2]);
else                                % r1==[] and r2==[]
    SetGroup(sum(~cellfun(@iscell,{SetGroup.Liste}))+ 1).Liste(1,:) = [node1 node2];   
end
 
    % Total Distance
    Distance = Distance + Min_Edge;
    
    % Draw Line
    line (Info(t).Table(Row,[3 5]), Info(t).Table(Row,[4 6]),'Color','r','LineWidth',1);
 
    % Reduce Info().Table
    Info(t).Table(Row,:) = [];

end