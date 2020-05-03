function eff_w_sort
%%%%%%BAÎŞ±ê¶ÈÍøÂçÅÅĞò
load data effect_ba_w effect_er_w;
[ba_ww,ba_id]=sort(abs(effect_ba_w),'descend');
[er_ww,er_id]=sort(abs(effect_er_w),'descend');
save data ba_id er_id -append;
end

