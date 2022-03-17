# Sweep Heuristic for vehicle routing problem

## Approach
The goal is to program the sweep heuristic for a Vehicle Routing Problem (VRP). 

Suppose that we already have the coordinates (_x0_, _y0_) of the depot, and the coordinates (_xi_, _yi_) of each client (_i = 1, 2, ..., N_). We also know the demands (_qi_) of the clients and the capacity _Q_ of the vehicles. The number of vehicles is sufficiently large. 

The heuristic determines groups of clients (angular sectors) that are compatible with the capacity of the vehicles, then solves a TSP problem for each group. To determine the groups, we create a half-line that starts from the depot and passes through any client, then we rotate this half-line in a chosen direction (counter-clockwise direction, see the Figure below). Each time the cumulative demands of the clients within the current group exceed the vehicle’s capacity, we create a new group. The simplest way is to rank the clients following the increasing order of their polar angles relative to the repository (which corresponds to a horizontal half-line leading to the right of the depot), and to cut the sorted list got. Next, we apply the multi-fragment heuristic to solve the TSP problem for each group.

<br>

![](/Figures/Sweep-Heuristic_Illustration.png)

<br>

## Test data and Matlab code
Folder [Test-data](/Test-data/) contains 2 files `vrpnc1.txt` (50 clients) and `vrpnc2.txt` (75 clients) used to test the Sweep Heuristic algorithm. I also provide an explanation of the text files's format in this folder.

The Matlab implementation of this algorithm is at folder [Matlab-code](/Matlab-code/). We also found there the solution flowchart together with a short recapitulation of the built-in Matlab functions.

<br>

## Test Results

### Test file `vrpnc1.txt` (50 clients)



|   | Optimal solution | Solution found with <br /> Sweep Heuristic algorithm|
|:---:|:---:|:---:|
| Aggregate distance  | 524.61  |541.3742 <br /> (3.2 % larger)|

We see that following the Sweep Heuristic Algorithm, the aggregate distance traveled by the vehicles are a little larger than the optimal one.

The figure below shows the route of the vehicles:

![](/Figures/vrpnc1.jpg)

The blue circles are the positions of the clients. The position of the depot is identified by the green square. 

The red lines show the path of a vehicle that starts from the depot and passes successively through all the clients within the group before returning to the depot.

By applying Sweep Heuristic algorithm, we get 6 groups of clients. So, we need 6 vehicles to make the delivery. The table below shows the number of clients in each group and the aggregate distance covered by each vehicle.

|Group| I | II | III | IV | V | VI |
|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| Number of clients  | 10  | 11 | 6 | 11 | 10 | 2 |
| Distance  | 102.7469|110.6773|89.0586|88.9029|91.2404|58.7481|

Although it is not reported here, the computation could obviously provide us with a list of client in each group, thus we can calculate the clients's total demand within the group. We can verify that this value is smaller than the capicity _Q_ of the vehicle.

<br>

### Test file `vrpnc2.txt` (75 clients)

|   | Given solution| Solution found with <br /> Sweep Heuristic algorithm|
|:---:|:---:|:---:|
| Aggregate distance  | 835.26  |702.4725 <br /> (15.9 % shorter)

The figure below shows the route of the vehicles:

![](/Figures/vrpnc2.jpg)

In this case, we get 11 client groups. Therefore, 11 vehicles are needed to make the delivery. The number of clients in each group and the aggregate distance traveled by each vehicle are presented in the table below.

|Group| I | II | III | IV | V | VI | VII | VIII | IX | X | XI |
|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| Number of clients  | 7 | 5 | 6 | 7 | 7 | 8 | 8 | 7 | 8 | 7 | 5 |
| Distance  |53.6364| 71.8022| 57.8458| 66.9568| 56.0461| 71.3027| 74.1698| 63.8445| 75.3476| 59.2166| 52.3067|