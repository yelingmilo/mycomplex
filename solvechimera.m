function solvechimera(N,A,k)


G = couplecore(A,k);
%%参数设置
rng(1,'twister');
theta = rand(N,1);
t=0;
loop=1;
quit=4000;
stop=0;
%%%求解动力学方程
while loop
    s = 0.01;
    options = odeset('outputfcn',@outputfcn);
    tspan = t:s:t+quit;
    [t,theta] = ode45(@equa,tspan,theta,options);
end

function status = outputfcn(t,theta,odeflag)
    % Called after each successful step of the ode solver.
    if isempty(odeflag)  % Not 'init' or 'last'.
        for j = 1:length(t)
            %坐标系的设置
            axis([0,N,-pi,pi])
            hold on
            title(['time (' sprintf('%6.3f',t(j)) ')'])
            hold on
            if loop == 0
                break
            end
            %%%%描点
            plot(1:N,asin(sin(theta(:,j))),'r.');
            if t(j) >= quit
                    loop = 0;
                    stop = 1;
            end
            grid on
            drawnow 
            clf
        end
    end
    status = flag + stop;
end

function [a]=cER(N,p)
%%建立ER随机网络的临界矩阵
m=nchoosek(N,2);%%%组合数
z=rand(1,m);
ind=(z<=p);
a=squareform(ind);%把0-1向量转化成邻接矩阵
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
a=cER(N,4/N);%%%这里设置连接概率p为4/N
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
