d:2017.01.01+!365
f:{[x;y] [[]ct:x?4;pc:x?9;am:x?50e;td:x?100e]}
t:d!f[380000]@'d

r:100
min{."\\t:1 select count by ct from t"}'!r
min{."\\t:1 select avg am by pc from t"}'!r
min{."\\t:1 select count by d.month,pc from t"}'!r
min{."\\t:1 select count by d.month,pc,_ td from t"}'!r

\
29
177
61
tab
!nyi