 function ER_a(N,p)
    %%����ER���������ٽ����
        m=nchoosek(N,2);%%%�����
        z=rand(1,m);
        ind=(z<=p);
        a=squareform(ind);%��0-1����ת�����ڽӾ���
        er_a=a;save data er_a -append;   %%%%���½���BA�ޱ��������ڽӾ���ba_a����data.mat�ļ��
end