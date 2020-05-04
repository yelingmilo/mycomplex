function solvechimera(N,A,k)


G = couplecore(A,k);
%%��������
rng(1,'twister');
theta = rand(N,1);
t=0;
loop=1;
quit=4000;
stop=0;
%%%��⶯��ѧ����
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
            %����ϵ������
            axis([0,N,-pi,pi])
            hold on
            title(['time (' sprintf('%6.3f',t(j)) ')'])
            hold on
            if loop == 0
                break
            end
            %%%%���
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
%%����ER���������ٽ����
m=nchoosek(N,2);%%%�����
z=rand(1,m);
ind=(z<=p);
a=squareform(ind);%��0-1����ת�����ڽӾ���
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
a=cER(N,4/N);%%%�����������Ӹ���pΪ4/N
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
