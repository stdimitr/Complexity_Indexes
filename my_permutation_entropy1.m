
function [pe npe]=my_permutation_entropy1(signal,m,t)


%adopted from Christoph Bandt and Bernd Pompe, 2002 "Permutation Entropy: A Natural Complexity Measure for Time Series" 
%Physical Review Letters

%INPUT:signal1
%    m = embedding dimension
%    t = time lag

%OUTPUT:pe = value of permutation entropy & npe = normalized version



%DIMITRIADIS STAVROS 8/2010
%%9/2013 - Correction from Dimitriadis Stavros - line 27 - 34
tic

%embedding the signal
[x] = embeddelay(signal, m, t);
    
  permlist = perms(1:m);
  c(1:length(permlist))=0;
 ly=length(x);
 
    for j=1:length(x)
        [a,iv]=sort(x(j,:));
        for jj=1:length(permlist)
            if (abs(permlist(jj,:)-iv))==0
                c(jj) = c(jj) + 1 ;
            end
        end
    end
    
   pe=0;
    p=0;
  
    
    for k=1:length(permlist)
        if(c(k)~=0)
            p=c(k)/((ly-(m-1))*t);
            pe= pe + p*log2(p);
        end
    end
   
    pe=-pe;
    
    %normalized pe
    fact=factorial(m);
    npe=pe/log2(fact);
    
    

    
    toc