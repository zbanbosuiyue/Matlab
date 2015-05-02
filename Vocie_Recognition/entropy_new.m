len=length(voice);
j=1;
ent=0;
for i=1:100:len
    ent(j)=entropy(voice(i:i+99));
    j=j+1;
    disp(i);
end
ent=abs(ent);
subplot(211),plot(voice);
subplot(212),plot(ent);