function [theta,meanw,order]=solvechimera(N,A,k)

G = couplecore(A,k);
%%参数设置
omega = 0;
alpha = pi/2-0.1;
rng(1,'twister');
theta = 2*pi*rand(N,1)-pi;
quit=10000;
%%%求解动力学方程
[t,theta] = ode45(@equa,[0,quit],theta);
theta=angle(exp(1i*theta));
%%%%%%求有效频率
theta_i=repmat(theta,[1 1 N]);
theta_j=permute(theta_i,[2 3 1]);%%%%%theta_j的页是时间维度,列是重复的
theta_i=permute(theta_j,[2 1 3]);%%%%theta_i行是重复的。
theta_dot=omega-sum(repmat(G,[1 1 length(t)]).*sin(theta_i-theta_j+alpha),2)/N;
theta_dot=reshape(theta_dot,N,length(t));
meanw=trapz(t,theta_dot,2);
%%%%%排序
[~,order]=sort(abs(meanw),1,'descend');
            

function [a]=cER(N,p)
%%建立ER随机网络的临界矩阵
m=nchoosek(N,2);%%%组合数
z=rand(1,m);
ind=(z<=p);
a=squareform(ind);%把0-1向量转化成邻接矩阵
end

function theta_dot=equa(~,theta)
%%%动力学方程

theta_dot = omega-(sum(G.*sin(theta.*ones(N)-(theta)'.*ones(N)+alpha)))'/N;
end

function [G] = couplecore(A,k)
%%%计算耦合核G
%%a为邻接矩阵，A为全局耦合强度，k为局部耦合强度。
a=cER(N,1/N);%%%这里设置连接概率p为4/N
a(a==0)=inf;
a=a-diag(diag(a));%%%对角元素取0.
n=size(a);
a=sparse(a);
G=A*exp(-k*graphallshortestpaths(a));
end
end
