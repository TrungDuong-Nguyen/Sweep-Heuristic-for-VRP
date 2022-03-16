% --------------------------------------------------------------------- %
% @Function     Main
% @Brief        [1]. Calculate the total distance
%               [2]. Plot the journey inside each group 
%     
% @Author       NGUYEN Trung Duong – Student Master OSS - UTT
% @Date         2013/01/04
% --------------------------------------------------------------------- %

%filename = fopen('C:\Users\DUONG\Desktop\OS11 projet\vrpnc2.txt');
filename = fopen('vrpnc1.txt');

% Read and Process data for the main task
% =====================================================
[n, W, xo, yo, newX, newY, newQ] = read_data(filename);
[N, G] = divide_group(n, W, newQ);
C = distance_matrix(newX, newY, G);
[Info] = info_table(n, N, xo, yo, G, C, newX, newY);
% =====================================================
 

% Main loop
Distance = 0;
for t = 1:length(N)   %length(N): quantity of group 
    
   % if the group have only one client + depot
   % =========================================
    if size(Info(t).Table,1) == 1
       % Total Distance
       Distance = Info(t).Table(1,7);
    
       % Draw Line
       line (Info(t).Table(1,[3 5]), Info(t).Table(1,[4 6]),'Color','r','LineWidth',1);
    
       % Go to next iteration of for loop
       continue
    end
    % =========================================


    % if the group have multiple clients + depot
   % =========================================
    k = 1; 

   % First Edge of the cycle
    if (k == 1)   
        % Find least longest edge
        Min_Edge = Info(t).Table(1,7);
        n1 = Info(t).Table(1,1);    
        n2 = Info(t).Table(1,2);
    
        % Update SetGroups
        SetGroup(1).Liste(1,:) = [n1 n2];
            
        % Draw Line
        line (Info(t).Table(1,[3 5]), Info(t).Table(1,[4 6]),'Color','r','LineWidth',1);
    
        % Reduce Info().Table
        Info(t).Table(1,:) = [];
    
        % Total Distance
        Distance = Distance + Min_Edge;
       
        k  = k+1;
    end
 
   % Second Edge of the cycle
    if(k == 2)
        % Find least longest edge
        Min_Edge = Info(t).Table(1,7);
        n1 = Info(t).Table(1,1);    
        n2 = Info(t).Table(1,2);
    
        % Update SetGroups
        if sum(SetGroup(1).Liste == n1)|sum(SetGroup(1).Liste == n2)
            SetGroup(1).Liste = vertcat(SetGroup(1).Liste, [n1 n2]) ;
        else
            SetGroup(2).Liste(1,:) = [n1 n2];
        end
 
        % Draw Line
        line (Info(t).Table(1,[3 5]), Info(t).Table(1,[4 6]),'Color','r','LineWidth',1);
    
        % Reduce Info().Table
        Info(t).Table(1,:) = [];
    
        % Total Distance
        Distance = Distance + Min_Edge;
        k = k+1;
    end
    
   % Find the third edge to the last edge of the cycle
    while (k>=3)
        [Info, Invalid_Edge] = update_invalid_edge(SetGroup, Info, t);
        
        if size(Info(t).Table,1) > 1
            [node1, node2, Row] = shortest_valid_edge(Info, Invalid_Edge, t);  
            [Distance, Info, SetGroup] = add_distance(node1, node2, Invalid_Edge, Distance, Info, Row, t, SetGroup);
        
        else % We have here the last egde to complete the cycle
            % The final total Distance
            Distance = Distance + Min_Edge;
    
            % Draw Line
            line (Info(t).Table(1,[3 5]), Info(t).Table(1,[4 6]),'Color','r','LineWidth',1);
            
            % Exit the while loop
            k = 0;
         
            % Delete SetGroup and Invalid_Edge for next loop i = 1:length(N)
            SetGroup = [];
        end
     end
    % =========================================

end