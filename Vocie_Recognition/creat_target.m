function [target_1,target_2,target_3]=creat_target(target_name)

target_1=zeros(length(target_name),19);
target_2=zeros(length(target_name),19);
target_3=zeros(length(target_name),19);

%% 1=W, 2=AH1, 3=N, 4=T, 5=UW1, 6=TH, 7=R, 8=IY1, 9=F, 10=AO1, 11=AY1, 12=V;
%% 13=S, 14=IH1 15=K, 16=EH1, 17=AH0, 18=EY1 19=NAN

for i=1:length(target_name)
  
    % one=W'AH1'N == 1'2'3
    if(strfind(target_name{i},'one')==1)
        target_1(i,1)=1;
        target_2(i,2)=1;
        target_3(i,3)=1;

    % two=T'UW1'NAN == 4'5'19
    elseif(strfind(target_name{i},'two')==1)
        target_1(i,4)=1;
        target_2(i,5)=1;
        target_3(i,19)=1;
        
    % three=TH'R'IY1 == 6'7'8
    elseif(strfind(target_name{i},'three')==1)
        target_1(i,6)=1;
        target_2(i,7)=1;
        target_3(i,8)=1;
        
    % four=F'AO1'NAN == 9'10'19
    elseif(strfind(target_name{i},'four')==1)
        target_1(i,9)=1;
        target_2(i,10)=1;
        target_3(i,19)=1;
    
    % five=F'AY1'V == 9'11'12
    elseif(strfind(target_name{i},'five')==1)
        target_1(i,9)=1;
        target_2(i,11)=1;
        target_3(i,12)=1;
        
    % six=S'IH1'K'S == 13'14'15'12
    elseif(strfind(target_name{i},'six')==1)
        target_1(i,13)=1;
        target_2(i,14)=1;
        target_2(i,15)=1;
        target_3(i,12)=1;
        
    % seven=S'EH1'V'AH0'N == 13'16'12'17'3 
    elseif(strfind(target_name{i},'seven')==1)
        target_1(i,13)=1;
        target_1(i,16)=1;
        target_2(i,12)=1;
        target_2(i,17)=1;
        target_3(i,3)=1;
        
    % eight=EY1'T'NAN  == 18'4'19
    elseif(strfind(target_name{i},'eight')==1)
        target_1(i,18)=1;
        target_2(i,4)=1;
        target_3(i,19)=1;
        
    % nine=N'AY1'N == 3'11'3
    elseif(strfind(target_name{i},'nine')==1)
        target_1(i,3)=1;
        target_2(i,11)=1;
        target_3(i,3)=1;
    end
end
target_1=target_1';
target_2=target_2';
target_3=target_3';
end