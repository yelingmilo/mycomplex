function solve_ba_eq(quit,alpha,omega)

%%%%%BA����Ķ���ѧ�������
load data ba_G;
G=ba_G;
N=length(G);
tspan=[0 quit];
y0=pi*rand(N,1)-2*pi;%%%%%��ʼ����
[t,theta]=ode45(@ode,tspan,y0); %%%ode���
ba_t=t;ba_theta=angle(exp(1i.*theta));%%%%%ʹ��λ��-pi��pi֮�䡣
%%%%%%%��Ƶ��ba_w
ba_t=gpuArray(ba_t);%%%gpu
ba_theta=gpuArray(ba_theta);%%%gpu
[a,b]=size(ba_theta);%%%%%
ba_w=gpuArray(zeros(a,b));%%%%%%gpu
for i=1:a
    ba_w(i,:)=feval(@ode,ba_t,(ba_theta(i,:))');
end
ba_t=gather(ba_t);%%%%%����cpu
ba_theta=gather(ba_theta);%%%%%����cpu
ba_w=gather(ba_w);%%%%%����cpu
save data ba_t ba_theta ba_w -append;%%%%����

function theta_dot=ode(~,theta)
%%%����ѧ����
    theta_dot = omega-gradv(theta)./N;
end
function g = gradv(theta)
    % theta-theta' is a matrix with elements theta(i)-theta(j).
    % The sum is by colums and produces a column vector.

    g = sum(G.*sin(theta-theta'+alpha),2);
end

end