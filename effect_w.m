function effect_w

%%%%%%BA�ޱ���������ЧƵ�ʼ���
load data ba_t ba_w;
effect_ba_w=trapz(ba_t(1000:end),ba_w(1000:end,:))./(ba_t(end)-ba_t(1000));
%%%%%
save data effect_ba_w -append;
%%%%%%%ER����������ЧƵ�ʼ���
load data er_t er_w;
effect_er_w=trapz(er_t(1000:end),er_w(1000:end,:))./(er_t(end)-er_t(1000));
%%%%%
save data effect_er_w -append;
end
