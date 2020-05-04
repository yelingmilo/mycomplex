function plotnet(a)
N=length(a);
t=0:2*pi/N:2*pi-2*pi/N;  %%������������������ڵ�����Ĳ������̵ĽǶȡ�
x=N*sin(t);y=N*cos(t);
plot(x,y,'ko','MarkerEdgeColor','k','MarkerFaceColor','r','markersize',4);
for i = 1:N-1
    for j = i+1:N
        if a(i,j)~=0
            plot([x(i),x(j)],[y(i),y(j)],'linewidth',1);
            hold on;
        end
    end
end
end