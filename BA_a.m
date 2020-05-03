function BA_a(N,m0,m,se)%%%m0未增长前的节点数，每引入一个新节点增加的边数为m，m<m0
        %%%%%se=1表示孤立点，2为完成图，3为随机图。
		%%%%%%%%%保证输入
        if nargin<4
            se=1;
            if nargin<3
                m=1;
                if nargin<2
                    m0=1;
                    if nargin<1
                        error(message('输入参数太少'));
                    end
                end
            end
        end
        rng(3,'twister');
		%%%%%%%%%%%%保证未增长前的节点数大于引进一个新节点多的边数。		
        if m>m0
            disp('输入参数m不合法');return;
        end
		%%%%%%%%连边前的图的类型。
        if se==1
            A=zeros(m0);
        elseif se==2
            A=ones(m0);A(1:m0+1:m0^2)=0;
        else
            A=zeros(m0);B=rand(m0);B=tril(B);
            A(B<=0.1)=1;
            A=A+A';
        end
		%%%%%%%%%%连边
        for kk=m0+1:N
            p=(sum(A)+1)/sum(sum(A)+1);   %%%计算所有边的连接概率p.
            pp=cumsum(p);    %%求累积分布。
            A(kk,kk)=0;    %%加入新的连边之前，邻接矩阵扩充维数。
            ind=[];        %%新节点所连节点的初始集合。
            while length(ind)<m
                jj=find(pp>rand);jj=jj(1);   %%%用赌轮法选择连边节点的编号。
                ind=union(ind,jj);         %%%使用union保证选择的节点不重复。
            end
            A(kk,ind)=1;A(ind,kk)=1;           %%构造加边以后新的矩阵。
        end
		ba_a=A;save data ba_a;   %%%%把新建的BA无标度网络的邻接矩阵ba_a放入data.mat文件里。
    end