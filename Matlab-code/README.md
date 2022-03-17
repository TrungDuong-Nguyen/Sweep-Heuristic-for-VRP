This flowchart demonstrates the coding solution for our VRP problem.

![](/Figures/Solution-Flow-Chart.jpg)

<br>

Hereafter, I briefly describe the Matlab functions and program that are used to implement our heuristic approach. 

- Function `read_data.m` reads data from [test file](/Test-data) to get the total number of clients, the capacity of the vehicle, the coordinates of the depot and all clients. Next, it sort the clients according to the increasing angle order of their coordinates (in order to divide, afterward, the clients into multiple groups). Finally, the function plots the position of the depot and all clients.

- Function `divide_group.m` divides the set of clients into different groups so that the cumulative clients's demand of each group do not surpass the capacity of the vehicle.

- Function `distance_matrix.m` computes a matrix presenting the distances between clients in each group. 

- Function `extract_matrix.m` extracts a given matrix into many small square matrices. This function will be called inside the function `info_table.m`. 

- Function `info_table.m` computes a structure array that contains relevant information of each group, which are the length of the internal edges (in an increasing order), and the coordinates of these edges's starting & ending node.

- Function `update_invalid_edge.m` takes as input the structure array as the output of function `info_table.m` and provide a list of invalid edges within the group, i.e. the edges that may create a cycle that do not encompass all the clients and depot in the group.

- Function `shortest_valid_edge.m` searchs for the shortest valid edge after eliminating all the invalid edges pointed out by function `update_invalid_edge.m`

- Function `add_distance.m` calculates the current cycle's aggregate distance after adding into it the edge selected in function `shortest_valid_edge.m`.

- Program `Main.m` computes the total distance that the vehicles will travel in order to serve all the clients. It also plots the journey inside each group of clients.