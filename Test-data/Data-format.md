We find here 2 test files for our project (`vrpnc1.txt`: 50 clients and `vrpnc2.txt`: 75 clients). The format of the data in the test files is explained below.

## CHRISTOFIDES VRP FILE FORMAT (VRPNC):

<br>

![](/Test-data/vrpnc1-extract.PNG)

In the above image is an extract of `vrpnc1.txt`

**Line 1:**
- Number of clients: _N = 50_.
- Vehicle capacity: _Q = 160_.
- "Autonomy", or the maximum cost of a routing: _L = 999999_ means "no limit".
- Service cost per client: _S = 0_ (_S_ is different to 0 only if _L < 999999_).
- Ignore the last numbers.

**Line 2:**
- Coordinate of the depot: _(_x0_, _y0_) = (30, 40)_.

**N following lines:**
- Coordinates (_xi_, _yi_) and demand (_qi_) of each client _i_ (_i = 1, 2, ..., N_). For example, the first client has coordinates _(_x1_, _y1_) = (37, 52)_ and demand _(_q1_) = 7_.

📌 Notice that within this project that takes the instances `vrpnc1` and `vrpnc2` as test data, we only need to pay attention to the value of _N_, _Q_, (_x0_, _y0_), (_xi_, _yi_) and (_qi_).

<br>

## Cost calculation
- The journey "cost" between 2 nodes _i_ and _j_ (clients or depot) is equal to the euclidean distance.
- If _L = 999999_, the cost of a routing is the sum of the journey cost.
- All the data (coordinates, demands, capacity) are integer, but we must calculate the distances and the solution costs in real number with double precision.