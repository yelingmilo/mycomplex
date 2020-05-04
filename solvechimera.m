function [theta,meanw,order]=solvechimera(N,A,k)

G = couplecore(A,k);
%%��������
omega = 0;
alpha = pi/2-0.1;
rng(1,'twister');
theta = 2*pi*rand(N,1)-pi;
quit=10000;
%%%��⶯��ѧ����
[t,theta] = ode45(@equa,[0,quit],theta);
theta=angle(exp(1i*theta));
%%%%%%����ЧƵ��
theta_i=repmat(theta,[1 1 N]);
theta_j=permute(theta_i,[2 3 1]);%%%%%theta_j��ҳ��ʱ��ά��,�����ظ���
theta_i=permute(theta_j,[2 1 3]);%%%%theta_i�����ظ��ġ�
theta_dot=omega-sum(repmat(G,[1 1 length(t)]).*sin(theta_i-theta_j+alpha),2)/N;
theta_dot=reshape(theta_dot,N,length(t));
meanw=trapz(t,theta_dot,2);
%%%%%����
[~,order]=sort(abs(meanw),1,'descend');
            

function [a]=cER(N,p)
%%����ER���������ٽ����
m=nchoosek(N,2);%%%�����
z=rand(1,m);
ind=(z<=p);
a=squareform(ind);%��0-1����ת�����ڽӾ���
end

function theta_dot=equa(~,theta)
%%%����ѧ����

theta_dot = omega-(sum(G.*sin(theta.*ones(N)-(theta)'.*ones(N)+alpha)))'/N;
end

function [G] = couplecore(A,k)
%%%������Ϻ�G
%%aΪ�ڽӾ���AΪȫ�����ǿ�ȣ�kΪ�ֲ����ǿ�ȡ�
a=cER(N,1/N);%%%�����������Ӹ���pΪ4/N
a(a==0)=inf;
a=a-diag(diag(a));%%%�Խ�Ԫ��ȡ0.
n=size(a);
a=sparse(a);
G=A*exp(-k*graphallshortestpaths(a));
end
end
