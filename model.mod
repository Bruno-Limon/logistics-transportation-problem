set nodes;
set links within (nodes cross nodes);
set vehicles;

param supplydemand {nodes};
param cost {vehicles};
param capacity {vehicles};

var flow {(i,j) in links, k in vehicles} integer >= 0;
var numbervehiclelink {(i,j) in links, k in vehicles} integer >= 0;
var chosenvehicle {k in vehicles} binary;

minimize totalcost: sum {(i,j) in links, k in vehicles} cost[k]*numbervehiclelink[i,j,k];

subject to supply {i in nodes, k in vehicles}:
- sum{(i,j) in links} flow[i,j,k] + sum{(j,i) in links} flow[j,i,k] >= supplydemand[i]*chosenvehicle[k];

subject to demand {i in nodes, k in vehicles}: 
- sum{(i,j) in links} flow[i,j,k] + sum{(j,i) in links} flow[j,i,k] == supplydemand[i]*chosenvehicle[k];

subject to vehiclesneededlink {(i,j) in links, k in vehicles}:
numbervehiclelink[i,j,k]*capacity[k] >= flow[i,j,k];

subject to onetypevehicle:
sum{k in vehicles} chosenvehicle[k] == 1;

#subject to congestion {(i,j) in links, k in vehicles}:
#numbervehiclelink[i,j,k] <= 4;





