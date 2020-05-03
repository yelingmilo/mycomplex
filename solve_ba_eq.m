function solve_ba_eq(quit,alpha,omega)

%%%%%BA网络的动力学方程求解
load data ba_G;
G=ba_G;
N=length(G);
tspan=[0 quit];
y0=pi*rand(N,1)-2*pi;%%%%%初始条件
[t,theta]=ode45(@ode,tspan,y0); %%%ode求解
ba_t=t;ba_theta=angle(exp(1i.*theta));%%%%%使相位在-pi和pi之间。
%%%%%%%求频率ba_w
ba_t=gpuArray(ba_t);%%%gpu
ba_theta=gpuArray(ba_theta);%%%gpu
[a,b]=size(ba_theta);%%%%%
ba_w=gpuArray(zeros(a,b));%%%%%%gpu
for i=1:a
    ba_w(i,:)=feval(@ode,ba_t,(ba_theta(i,:))');
end
ba_t=gather(ba_t);%%%%%传回cpu
ba_theta=gather(ba_theta);%%%%%传回cpu
ba_w=gather(ba_w);%%%%%传回cpu
save data ba_t ba_theta ba_w -append;%%%%保存

function theta_dot=ode(~,theta)
%%%动力学方程
    theta_dot = omega-gradv(theta)./N;
end
function g = gradv(theta)
    % theta-theta' is a matrix with elements theta(i)-theta(j).
    % The sum is by colums and produces a column vector.

    g = sum(G.*sin(theta-theta'+alpha),2);
end

end