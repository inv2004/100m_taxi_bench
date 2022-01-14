/-s 4

\mkdir -p data
\l data

d:2017.01.01+key 365
f:{[x;y] ([]dt:`p#x#y;ct:"x"$x?4;pc:"x"$x?9;am:"e"$x?50e;td:"e"$x?100e)}
{(hsym `$string[.Q.par[`:.;x;`trips]],"/") set delete dt from f[380000;x]} each d

\l .

r:10
min {system"t:1 select count pc by ct from trips"} each key r
min {system"t:1 select avg am by pc from trips"} each key r
min {system"t:1 select count ct by date.month,pc from trips"} each key r
min {system"t:1 select count ct by date.month,pc,floor td from trips"} each key r

\rm -rf ../data

\\
