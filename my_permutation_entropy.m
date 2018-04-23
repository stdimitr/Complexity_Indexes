
function [pe npe]=my_permutation_entropy(signal,m,t)


%adopted from Christoph Bandt and Bernd Pompe, 2002 "Permutation Entropy: A Natural Complexity Measure for Time Series" 
%Physical Review Letters

%INPUT:signal1
%    m = embedding dimension
%    t = time lag

%OUTPUT:pe = value of permutation entropy & npe = normalized version



%Giannis Kostavelis http://robotics.pme.duth.gr/kostavelis
%& Kostas Charalampous kcharala@csd.auth.gr
%9/2013 - Correction from Dimitriadis Stavros

tic

%embedding the signal
[x] = embeddelay(signal, m, t);


 permlist = perms(1:m);
%normalise permlist
permlist=normr(permlist);

 c(1:length(permlist))=0;
 ly=length(x);
    
 [a,iv1]=sort(x,2);
% normalise the index lise
 iv1=normr(iv1);

%product dot
 X=iv1*permlist';
 X=X';
 X=single(X);
 
%The list of patterns
 [row column]=find(X==1);
 
 for k=1:factorial(m)
     r=find(row==k);
     col(k)=size(r,1);
 end
 
    pe=0;
    p=0;
   
    
    for k=1:factorial(m)
        if(col(k)~=0)
            p=col(k)/((ly-(m-1))*t);
            pe= pe + p*log2(p);
        end
    end
   
    pe=-pe;
    
    %normalized pe
    fact=factorial(m);
    npe=pe/log2(fact);
    
toc


