% --------------------------------------------------------------------- %
% @Function    add_distance
% @Brief       Add the length of the selected edge to the aggregate distance
% @Input Parameters
%              Info          Structure array that specifies the length of edges (increasing order),...
%                            and the coordinates of their starting and ending node
%              Invalid_Edge  List of edges that may create an incorrect cycle...
%                            (i.e., that do not pass all clients and depot within the group)
%              node1         Starting node of the selected edge 
%              node2         Ending node of the selected edge 
%              Row           Row index of the selected edge in the information table
%              Distance, SetGroup, t  Temporary variables
%
% @Output Parameters       
%              Distance      Aggregate distance after adding the newly selected edge into the cycle
%              Info          Table updated
%              SetGroup      Temporary variable
%
% @Programmer  NGUYEN Trung Duong
% --------------------------------------------------------------------- %

function [Distance, Info, SetGroup] = add_distance(node1, node2, Invalid_Edge, Distance, Info, Row, t, SetGroup)

% Get the selected edge
Min_Edge = Info(t).Table(Row,7);
[r1,~] = find(Invalid_Edge == node1);
[r2,~] = find(Invalid_Edge == node2);

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

    % Aggregate distance
    Distance = Distance + Min_Edge;

    % Draw line
    line (Info(t).Table(Row,[3 5]), Info(t).Table(Row,[4 6]),'Color','r','LineWidth',1);

    % Reduce Info().Table
    Info(t).Table(Row,:) = [];

end