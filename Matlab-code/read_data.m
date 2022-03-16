% --------------------------------------------------------------------- %
% @Function     read_data
% @Brief        [1].Read data from text file
%               [2].Mark the position of all clients and the depot in a figure   
% @Input Parameters     
%               filename    Path name to text file       
% @Output Parameters       
%               n           Total quantity of client 
%               W           Capacity of the vehicles
%               xo, yo      Coordinate of the depot
%               newX, newY  Coordinates of the clients (increasing angle order)
%               newQ        Demands of the clients (increasing angle order)
%        
% @Author       NGUYEN Trung Duong – Student Master OSS - UTT
% @Date         2013/01/04
% --------------------------------------------------------------------- %

function [n, W, xo, yo, newX, newY, newQ] = read_data(filename)
%filename = fopen('vrpnc1.txt');
A = textscan(filename,'%n %n %u32 %n %n');

n = A{1}(1,1); W = A{2}(1,1); 
xo = A{1}(2,1); yo = A{2}(2,1);

for i = 3:(n+2)
    X(i-2)= A{1}(i,1); 
    Y(i-2)= A{2}(i,1); 
    Q(i-2)= A{3}(i,1);
    Angle(i-2) = atan2(Y(i-2)-yo,X(i-2)-xo)*180/pi;
    if(Angle(i-2) < 0) 
       Angle(i-2)= Angle(i-2)+ 360;
    end
end
 
for i = 1:n
    Liste(i) = min(Angle);
    for j = 1:n
        if Angle(j) == min(Angle)
            newQ(i) = Q(j);
            newX(i) = X(j);
            newY(i) = Y(j);
            Angle(:,j) = 400;   % >360 
           break;
        end    
    end    
end
 
% Mark the position of all clients and the position of the depot in a figure
%
plot(newX,newY,'o','MarkerEdgeColor','k','MarkerFaceColor','b','MarkerSize',8);
hold on
grid
plot(xo,yo,'s','MarkerEdgeColor','k','MarkerFaceColor','g','MarkerSize',12);
%} 
end