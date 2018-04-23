function [dis c1 c2 ct1 ct2]=ordinal_pattern_similarity(signal1,signal2,m,tau)


%adopted from Gaoxiang Ouyang et al., 2010 "Ordinal pattern based
%similarity analysis for EEG recordings" Clinical Neurophysiology

%INPUT:signal1, signal2
%    m = embedding dimension
%    t = time lag

%OUTPUT:dis = value for dissimalirity measure based on ordinal patterns
%When dis = 0, it indicates that the rank–frequency
%ordinal patterns distribution in the two series is identical. In contrast,
%dis = 1 indicates that one of the two series is totally different
%c1 & c2 = distribution of patterns
%ct1 & ct2 = a time-series of order patterns for signal1 & signal2
%DIMITRIADIS STAVROS 8/2010



tic
%calling embeddelays
[x] = embeddelay(signal1, m, tau);
[y] = embeddelay(signal2, m, tau);

ly1=length(x);
ly2=length(y);

 permlist = perms(1:m);
%normalise permlist
permlist=normr(permlist);

%%%%%%%%%%%%%%%% for signal1 %%%%%%%%%%%%%%
 [a,iv1]=sort(x,2);
% normalise the index list
 iv1=normr(iv1);

%product dot
 X=iv1*permlist';
 X=X';
 X=single(X);
 
%The list of patterns
 [ct1, cols, vals]= find(X==1);
 
 %%%%%%%%%%%%%%%% for signal2 %%%%%%%%%%%%%%
 [a,iv2]=sort(y,2);
% normalise the index list
 iv2=normr(iv2);

%product dot
 Y=iv2*permlist';
 Y=Y';
 Y=single(Y);

% %  The list of patterns
 [ct2, cols, vals]= find(Y==1);

 fact=factorial(m);
 c1(1:length(permlist))=0;
 c2(1:length(permlist))=0;
    

 %calculate c1 & c2
 for i=1:fact
     [r1 d1 v1]= find(ct1==i);
     c1(i)=length(r1);
     [r2 d1 v1]= find(ct2==i);
     c2(i)=length(r2);
 end
   
    
    p1(1:length(permlist))=0;
    p2(1:length(permlist))=0;
    
    for k=1:fact
        p1(k)=c1(k)/(ly1-(m-1)*tau);
        p2(k)=c2(k)/(ly2-(m-1)*tau);
    end
    
    d=0;
    
   
    stable=sqrt(fact/(fact-1));
    
    for k=1:fact
        d=d + (p1(k) - p2(k))^2;
    end
    
    dis=stable * sqrt(d);
    
    
    toc
    
    