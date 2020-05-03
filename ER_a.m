 function ER_a(N,p)
    %%建立ER随机网络的临界矩阵
        m=nchoosek(N,2);%%%组合数
        z=rand(1,m);
        ind=(z<=p);
        a=squareform(ind);%把0-1向量转化成邻接矩阵
        er_a=a;save data er_a -append;   %%%%把新建的BA无标度网络的邻接矩阵ba_a放入data.mat文件里。
end