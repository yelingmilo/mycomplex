function couplecoreG(A,k)
load data ba_a er_a;
%%%%BA网络邻接矩阵的最短距离
ba_a(ba_a==0)=inf;
ba_a=ba_a-diag(diag(ba_a));%%%对角元素取0.
ba_a=sparse(ba_a);
ba_spaths=graphallshortestpaths(ba_a);
%%%%ER网络邻接矩阵的最短距离
er_a(er_a==0)=inf;
er_a=er_a-diag(diag(er_a));%%%对角元素取0.
er_a=sparse(er_a);
er_spaths=graphallshortestpaths(er_a);
%%%%%%%%耦合核的计算
ba_G=A.*exp(-k.*ba_spaths);
er_G=A.*exp(-k.*er_spaths);
save data ba_spaths er_spaths ba_G er_G -append;%%%%%存入data.
end



