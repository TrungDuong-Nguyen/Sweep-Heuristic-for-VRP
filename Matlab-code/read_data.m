% --------------------------------------------------------------------- %
% @Function     read_data
% @Brief        [1]. Read data from text file
%               [2]. Sort the clients according to the increasing angle order of their coordinates
%               [3]. Plot the position of all clients and the depot
% @Input Parameters
%               filename    Path name to text file
% @Output Parameters
%               n           Total number of clients
%               W           Capacity of the vehicles
%               x0, y0      Coordinate of the depot
%               newX, newY  Coordinates of the clients (increasing angle order)
%               newQ        Demands of the clients (increasing angle order)
%
% @Programmer   NGUYEN Trung Duong
% --------------------------------------------------------------------- %

function [n, W, x0, y0, newX, newY, newQ] = read_data(filename)

A = textscan(filename,'%n %n %u32 %n %n');

n = A{1}(1,1); W = A{2}(1,1);
x0 = A{1}(2,1); y0 = A{2}(2,1);

X = zeros(1,n);
Y = zeros(1,n);
Q = zeros(1,n);
Angle = zeros(1,n);

for i = 3:(n+2)
    X(i-2)= A{1}(i,1);
    Y(i-2)= A{2}(i,1);
    Q(i-2)= A{3}(i,1);
    Angle(i-2) = atan2(Y(i-2)-y0,X(i-2)-x0)*180/pi;
    if(Angle(i-2) < 0)
       Angle(i-2)= Angle(i-2)+ 360;
    end
end

Liste = zeros(1,n);
newQ = zeros(1,n);
newX = zeros(1,n);
newY = zeros(1,n);

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

% Plot the position of all clients and the depot.
%
plot(newX,newY,'o','MarkerEdgeColor','k','MarkerFaceColor','b','MarkerSize',8);
hold on
grid
plot(x0,y0,'s','MarkerEdgeColor','k','MarkerFaceColor','g','MarkerSize',12);

end