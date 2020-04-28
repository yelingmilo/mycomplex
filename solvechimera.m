function solvechimera(N,A,k)
%%%求解动力学方程
G = couplecore(A,k);
theta0 = rand(N,1);
[t,theta] = ode45(@equa,[0,1000],theta0);
plot(1:N,asin(sin(theta(400,:))),'.r')


function [a]=cER(N,p)
%%建立ER随机网络的临界矩阵
a=zeros(N);
for i=1:N
    for j=1:N
        if rand(1,1)<p
            a(i,j)=1;
            a(j,i)=1;
        end
    end
end
end

function theta_dot=equa(~,theta)
%%%动力学方程

omega = 0;
alpha = pi/2-0.1;
theta_dot = omega-(sum(G.*sin(theta.*ones(N)-(theta)'.*ones(N)+alpha)))'/N;
end

function [G] = couplecore(A,k)
%%%计算耦合核G
%%a为邻接矩阵，A为全局耦合强度，k为局部耦合强度。
a=cER(N,0.5);%%%这里设置连接概率为
a(a==0)=inf;
a=a-diag(diag(a));
n=size(a);
G=zeros(n);
a=sparse(a);
for i=1:n(1)
    for j=1:n(2)
        G(i,j)=A*exp(-k*graphshortestpath(a,i,j));
    end
end 
end
end
