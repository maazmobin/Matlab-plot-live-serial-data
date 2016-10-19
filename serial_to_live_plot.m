clc; close all; clear all;

myserial=serial('COM4','BaudRate',115200);
fopen(myserial);

receivingElements=3; %right now only receiving accelerometer data
bufferSz = 100;
vectorLen= receivingElements;

myVec=zeros(1,vectorLen,'double');
testing=zeros(bufferSz,vectorLen,'double');

cvbuf = circVBuf(int64(bufferSz),int64(vectorLen));
cvbuf.append(testing);

i=0;
figure(1);
lHandle = line(nan, nan); %# Generate a blank line and return the line handle
lHandle2 = line(nan, nan);
lHandle3 = line(nan, nan);
 set(lHandle, 'Color', 'b','LineWidth',2);
   set(lHandle2, 'Color', 'r','LineWidth',2);
   set(lHandle3, 'Color', 'g','LineWidth',2);
axis([0,bufferSz,-2500,2500]);
xlabel('Buffer');
ylabel('Rawdata');
title('Accelerometer X-axis');

while i<=2500 
%while 1
    dataFromSerial=fscanf(myserial);
    dataFromSerial=strtrim(dataFromSerial);
    i=i+1;
   if(strncmpi(dataFromSerial, 'acc', 3))
      acc=strsplit(dataFromSerial,',');
      myVec(1,1)=str2double(acc(1,2));
      myVec(1,2)=str2double(acc(1,3));
      myVec(1,3)=str2double(acc(1,4));
   elseif(strncmpi(dataFromSerial, 'gyro', 4))
      gyro=strsplit(dataFromSerial,',');
      myVec(1,4)=str2double(gyro(1,2));
      myVec(1,5)=str2double(gyro(1,3));
      myVec(1,6)=str2double(gyro(1,4));
   elseif(strncmpi(dataFromSerial, 'mag', 3))
      mag=strsplit(dataFromSerial,',');
      myVec(1,7)=str2double(mag(1,2));
      myVec(1,8)=str2double(mag(1,3));
      myVec(1,9)=str2double(mag(1,4));
   elseif(strncmpi(dataFromSerial, 'temp', 4))
      temp=strsplit(dataFromSerial,',');
      myVec(1,10)=str2double(temp(1,2));
   end
    cvbuf.append(myVec);
    new = cvbuf.new; 
    fst = cvbuf.fst; 
    lst = cvbuf.lst;
  abcd=cvbuf.raw(fst:1:lst,:);



% for i = 1:bufferSz/4
%     X = get(lHandle, 'XData');
%     Y = get(lHandle, 'YData');
%     X = [X i];
%     Y = [Y abcd(i,1)];

    set(lHandle, 'XData', 1:bufferSz, 'YData', abcd(:,1));
    set(lHandle2, 'XData', 1:bufferSz, 'YData', abcd(:,2));
    set(lHandle3, 'XData', 1:bufferSz, 'YData', abcd(:,3));
% end
%     
%    subplot(3,3,1)
%    plot(abcd(:,1),'g','LineWidth',3);
%    axis([0,bufferSz/4,-1500,1500]);
%    xlabel('Buffer');
%    ylabel('Rawdata');
%    title('Accelerometer X-axis');
%    
%    subplot(3,3,2)
%    plot(abcd(:,2),'b','LineWidth',3);
%    axis([0,bufferSz/4,-1500,1500]);
%    xlabel('Buffer');
%    ylabel('Rawdata');
%    title('Accelerometer Y-axis');
%   
%    subplot(3,3,3)
%    plot(abcd(:,3),'r','LineWidth',3);
%    axis([0,bufferSz/4,-1500,1500]);
%    xlabel('Buffer');
%    ylabel('Rawdata');
%    title('Accelerometer Z-axis');
%    
%    subplot(3,3,4)
%    plot(abcd(:,4),'g','LineWidth',3);
%    axis([0,bufferSz/4,-500,500]);
%    xlabel('Buffer');
%    ylabel('Rawdata');
%    title('Gyro x-axis');
%    
%    subplot(3,3,5)
%    plot(abcd(:,5),'b','LineWidth',3);
%    axis([0,bufferSz/4,-500,500]);
%    xlabel('Buffer');
%    ylabel('Rawdata');
%    title('Gyro Y-axis');
%    
%    subplot(3,3,6)
%    plot(abcd(:,6),'r','LineWidth',3);
%    axis([0,bufferSz/4,-500,500]);
%    xlabel('Buffer');
%    ylabel('Rawdata');
%    title('Gyro Z-axis');
%    
%    subplot(3,3,7)
%    plot(abcd(:,7),'g','LineWidth',3);
%    axis([0,bufferSz/4,-300,300]);
%    xlabel('Buffer');
%    ylabel('Rawdata');
%    title('Magneto X-axis');
%    
%    subplot(3,3,8)
%    plot(abcd(:,8),'b','LineWidth',3);
%    axis([0,bufferSz/4,-300,300]);
%    xlabel('Buffer');
%    ylabel('Rawdata');
%    title('Magneto Y-axis');
%    
%    subplot(3,3,9)
%    plot(abcd(:,7),'r','LineWidth',3);
%    axis([0,bufferSz/4,-300,300]);
%    xlabel('Buffer');
%    ylabel('Rawdata');
%    title('Magneto Z-axis');
   drawnow;
end
fclose(instrfind)
%  if(strncmpi(dataFromSerial, 'acc', 3))
%       acc=strsplit(dataFromSerial,',');
%       accy(1,j)=str2double(acc(1,3))
%       accx(1,j)=str2double(acc(1,2))
%       accz(1,j)=str2double(acc(1,4))
%       plot(b,'g-o')
%       drawnow;
%    %% axis([0,100,-500,500])
%       j=j+1;
%    end