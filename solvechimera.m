function solvechimera(N,A,k)
%%%��⶯��ѧ����
G = couplecore(A,k);
theta0 = rand(N,1);
[t,theta] = ode45(@equa,[0,1000],theta0);
plot(1:N,asin(sin(theta(400,:))),'.r')


function [a]=cER(N,p)
%%����ER���������ٽ����
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
%%%����ѧ����

omega = 0;
alpha = pi/2-0.1;
theta_dot = omega-(sum(G.*sin(theta.*ones(N)-(theta)'.*ones(N)+alpha)))'/N;
end

function [G] = couplecore(A,k)
%%%������Ϻ�G
%%aΪ�ڽӾ���AΪȫ�����ǿ�ȣ�kΪ�ֲ����ǿ�ȡ�
a=cER(N,0.5);%%%�����������Ӹ���Ϊ
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
