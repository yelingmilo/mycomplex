function BA_a(N,m0,m,se)%%%m0δ����ǰ�Ľڵ�����ÿ����һ���½ڵ����ӵı���Ϊm��m<m0
        %%%%%se=1��ʾ�����㣬2Ϊ���ͼ��3Ϊ���ͼ��
		%%%%%%%%%��֤����
        if nargin<4
            se=1;
            if nargin<3
                m=1;
                if nargin<2
                    m0=1;
                    if nargin<1
                        error(message('�������̫��'));
                    end
                end
            end
        end
        rng(3,'twister');
		%%%%%%%%%%%%��֤δ����ǰ�Ľڵ�����������һ���½ڵ��ı�����		
        if m>m0
            disp('�������m���Ϸ�');return;
        end
		%%%%%%%%����ǰ��ͼ�����͡�
        if se==1
            A=zeros(m0);
        elseif se==2
            A=ones(m0);A(1:m0+1:m0^2)=0;
        else
            A=zeros(m0);B=rand(m0);B=tril(B);
            A(B<=0.1)=1;
            A=A+A';
        end
		%%%%%%%%%%����
        for kk=m0+1:N
            p=(sum(A)+1)/sum(sum(A)+1);   %%%�������бߵ����Ӹ���p.
            pp=cumsum(p);    %%���ۻ��ֲ���
            A(kk,kk)=0;    %%�����µ�����֮ǰ���ڽӾ�������ά����
            ind=[];        %%�½ڵ������ڵ�ĳ�ʼ���ϡ�
            while length(ind)<m
                jj=find(pp>rand);jj=jj(1);   %%%�ö��ַ�ѡ�����߽ڵ�ı�š�
                ind=union(ind,jj);         %%%ʹ��union��֤ѡ��Ľڵ㲻�ظ���
            end
            A(kk,ind)=1;A(ind,kk)=1;           %%����ӱ��Ժ��µľ���
        end
		ba_a=A;save data ba_a;   %%%%���½���BA�ޱ��������ڽӾ���ba_a����data.mat�ļ��
    end