[col_1,row_1]=size(voice);
new_col=round(col_1/1000-0.5);
ent=zeros(new_col);
j=1;
len=length(voice);
len=fix(len/1000)*1000;
for i=1:100:len
    ent(j,1)=entropy(voice(i:i+99));
    j=j+1;
end

ent=abs(ent);
c=min(ent);
b=max(ent);
c=c(1);
b=b(1);
delta=c+(b-c)/2;

j=1;
[col,row]=size(ent);
for i=1:col
    if ent(i,1)>delta
        new_ent(j)=i;
        j=j+1;
    end
end
for i=1:length(new_ent)
    new_ent2(i)=new_ent(i)*1000;
end

s=min(new_ent2);
sb=max(new_ent2);
new_voice=voice(min(new_ent2):max(new_ent2));
%subplot(4,1,1);
%subplot(4,1,2);
%plot(ent);
%subplot(4,1,3);
%plot(new_voice);

f=abs(fft(voice(13000:14000)));
f_2=abs(fft(voice(15000:16000)));

nfft= 2^nextpow2(length(f));
nfft_2= 2^nextpow2(length(f_2));

y=fft(f,nfft);
y_2=fft(f_2,nfft_2);

p=y.*conj(y)/nfft;
fs=500;

y2=abs(y(1:nfft/2));
y2_2=abs(y_2(1:nfft_2/2));

ff=fs*(0:nfft/2-1)/nfft;
subplot(412);plot(ff,abs(y(1:nfft/2)));
ylabel('Amplitude');xlabel('Frequency');title('Frequency-Domain');
subplot(411);
plot(new_voice);
ylabel('Amplitude');xlabel('Time');title('Time-Domain');
subplot(413);
plot(ent);
subplot(414);
plot(voice);

abc=melcepst(y);
abc_2=melcepst(y_2);
f2=figure();
subplot(211);
plot(abc')
subplot(212);
plot(abc_2');

