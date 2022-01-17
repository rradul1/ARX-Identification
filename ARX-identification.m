clear all
clc
load iddata-16
u=id.u;
y=id.y;
na=2;
nb=na;
nk=1;
m=2;
%formam vectorul de intrari si iesiri pe datele de identificare
N=length(y);
for i=1:N
    for j=1:nb
       if(i==j)
           d1(i,j)=0;         
       else
        if(i>j)
           d1(i,j)=y(i-j);
        else
           d1(i,j)=0;
        end
       end 
    end
end
for i=1:N
    for j=1:na
       if(i==j)
           d2(i,j)=0;
       else
        if(i>j)
           d2(i,j)=u(i-j);
        else
           d2(i,j)=0;
        end
       end 
    end
end
d=[d1,d2]
%formarea polinomului pe datele de identificare
ly=length(id.y);
p=[];
for i=1:ly vec=d(i,:);
for j=1:na+nb
    for i=1:m
        v1(j)=vec(j)^i;
    end
end
if m>1
for i=1:na+nb
    for j=1:na+nb
        for grad=1:m-1
            if i<j v2(j)=vec(i)*(vec(j)^grad);        
            end
        end
    end
end
for i=1:na+nb
    for j=1:na+nb
        for grad=1:m-1
            if i>j 
                    v3(j)=(vec(i)^grad)*vec(j);            
            end
        end
    end
end
v=[v1 v2 v3];
p=[p;v];
else 
    v=v1;
    p=[p;v];
end
end
c(1:1000,1)=1;
p=[c,p];
theta=p\y;
%formam vectorul de intrari si iesiri pe datele de validare 
N=length(val.y);
Y=val.y;
U=val.u;
for i=1:N
    for j=1:nb
       if(i==j)
           d1(i,j)=0;
       else
        if(i>j)
           d1(i,j)=Y(i-j);
        else
           d1(i,j)=0;
        end
       end 
    end
end
for i=1:N
    for j=1:na
       if(i==j)
           d2(i,j)=0;
       else
        if(i>j)
           d2(i,j)=U(i-j);
        else
           d2(i,j)=0;
        end
       end 
    end
end
D=[d1,d2];
ly=length(val.y)
%formam polinomul pe datele de validare
pv=[];
for i=1:ly vec=D(i,:);
for j=1:na+nb
    for i=1:m
        v1(j)=vec(j)^i;
    end
end
if m>1
for i=1:na+nb
    for j=1:na+nb
        for grad=1:m-1
        if i<j 
            v2(j)=vec(i)*(vec(j)^grad);        
        end
        end
    end
end

for i=1:na+nb
    for j=1:na+nb
        for grad=1:m-1
        if i>j 
            v3(j)=(vec(i)^grad)*vec(j);            
        end
    end
    end
end
v=[v1 v2 v3];
pv=[pv;v];
else 
    v=v1;
    pv=[pv;v];
end
end
c(1:1000,1)=1;
pv=[c,pv];

ypredid=p*theta;
yhat=ypredid;
Y2=id.y;
MSEid=1/length(Y2)*sum((Y2-yhat).^2)

ypredval=pv*theta;
yhat=ypredval;
Y2=val.y;
MSEval=1/length(Y2)*sum((Y2-yhat).^2)

plot(id.y)
hold on
plot(ypredid)
figure
plot(val.y)
hold on
plot(ypredval)

lyid=length(id.y);
p=[];
for i=1:ly vec=d(i,:);
for j=1:na+nb
    for i=1:m
        v1(j)=vec(j)^i;
    end
end
if m>1
for i=1:na+nb
    for j=1:na+nb
        for grad=1:m-1
            if i<j v2(j)=vec(i)*(vec(j)^grad);        
            end
        end
    end
end
for i=1:na+nb
    for j=1:na+nb
        for grad=1:m-1
            if i>j 
                    v3(j)=(vec(i)^grad)*vec(j);            
            end
        end
    end
end
v=[v1 v2 v3];
p=[p;v];
else 
    v=v1;
    p=[p;v];
end
end
c(1:1000,1)=1;
p=[c,p];
Y1=id.y;
U1=id.u;
N1=length(Y1);
ysimid=1:N1;
for i=1:N1
    ysimid(i)=p(i,:)*theta;
end        
ysimid=ysimid';

lyval=length(val.y)
pv=[];
for i=1:ly vec=D(i,:);
for j=1:na+nb
    for i=1:m
        v1(j)=vec(j)^i;
    end
end
if m>1
for i=1:na+nb
    for j=1:na+nb
        for grad=1:m-1
        if i<j 
            v2(j)=vec(i)*(vec(j)^grad);        
        end
        end
    end
end

for i=1:na+nb
    for j=1:na+nb
        for grad=1:m-1
        if i>j 
            v3(j)=(vec(i)^grad)*vec(j);            
        end
    end
    end
end
v=[v1 v2 v3];
pv=[pv;v];
else 
    v=v1;
    pv=[pv;v];
end
end
c(1:1000,1)=1;
pv=[c,pv];
Y1=val.y;
U1=val.u;
N1=length(Y1);
ysimval=1:N1;
size(theta)
for i=1:N1
    ysimval(i)=pv(i,:)*theta;
end        
ysimval=ysimval';

