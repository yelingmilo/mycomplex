function solve_er_eq(quit,alpha,omega)
%%%%%%ER网络的动力学方程的求解
load data er_G;
G=er_G;
N=length(G);
tspan=[0 quit];
y0=pi*rand(N,1)-2*pi;%%%%%初始条件
[t,theta]=ode45(@ode,tspan,y0);
er_t=t;er_theta=angle(exp(1i.*theta));
%%%%%%%求频率ba_w
er_t=gpuArray(er_t);%%%gpu
er_theta=gpuArray(er_theta);%%%gpu
[a,b]=size(er_theta);%%%%%
er_w=gpuArray(zeros(a,b));%%%%%%gpu
for i=1:a
    er_w(i,:)=feval(@ode,er_t,(er_theta(i,:))');
end
er_t=gather(er_t);%%%%%传回cpu
er_theta=gather(er_theta);%%%%%传回cpu
er_w=gather(er_w);%%%%%传回cpu
save data er_t er_theta er_w -append;%%%%保存


function theta_dot=ode(~,theta)
%%%动力学方程
    theta_dot = omega-gradv(theta)./N;
end
function g = gradv(theta)
    % theta-theta' is a matrix with elements theta(j)-theta(k).
    % The sum is by colums and produces a column vector.

    g = sum(G.*sin(theta-theta'+alpha),2);
end

end