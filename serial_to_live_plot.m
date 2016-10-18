clc
clear all
myserial=serial('COM4','BaudRate',115200);
fopen(myserial);
%circbuff(1,100)=0
i=0;
j=1;

%while i<=100 
while 1
    dataFromSerial=fscanf(myserial);
    i=i+1;
    dataFromSerial=strtrim(dataFromSerial);
   if(strncmpi(dataFromSerial, 'acc', 3))
      acc=strsplit(dataFromSerial,',');
      b(1,j)=str2double(acc(1,3))
      a(1,j)=str2double(acc(1,2))
      c(1,j)=str2double(acc(1,4))
      plot(b,'g-o')
      drawnow;
   %% axis([0,100,-500,500])
      j=j+1;
   end
end
fclose(instrfind)