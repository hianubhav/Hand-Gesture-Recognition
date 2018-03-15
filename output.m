a=[1 0 0 0 0];
b=[0 1 0 0 0];
c=[0 0 1 0 0];
d=[0 0 0 1 0];
e=[0 0 0 0 1];

r=repmat(a',1,20);
s=repmat(b',1,28);
t=repmat(c',1,29);
u=repmat(d',1,31);
v=repmat(e',1,37);
outputv=[r,s,t,u,v];
save('outputv.mat','outputv');
a=load('outputv.mat')
load('input.mat');
%t=[r;s];