function animate_er(se)
%%%%seΪ����ER������ʱ��仯��������λͼ��Ϊ����BA�ޱ������ġ�
if se
    load data er_t er_theta;
    [a,b]=size(er_theta);
    x=1:b;
    h=plot(x,er_theta(1,:),'b.');
    axis([1,b,-pi-0.5,pi+0.5]);
    set(h,'EraseMode','xor');
    for i=1:a
        title(['time=',num2str(er_t(i))]);
        set(h,'Xdata',x,'Ydata',er_theta(i,:));
        drawnow;
        pause(0.05);
    end
else
    load data ba_t ba_theta;
    [a,b]=size(ba_theta);
    x=1:b;
    h=plot(x,ba_theta(1,:),'r.');
    axis([1,b,-pi-0.5,pi+0.5]);
    set(h,'EraseMode','xor');
    for i=1:a
        title(['time=',num2str(ba_t(i))]);
        set(h,'Xdata',x,'Ydata',ba_theta(i,:));
        drawnow;
        pause(0.05);
    end
end
end