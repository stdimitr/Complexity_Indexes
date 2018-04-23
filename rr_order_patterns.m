function cstr=rr_order_patterns(signal1,signal2,m,tau)


%adopted from "Visualization of coupling in time series by order recurrence
%plots" Andreas Groth, Physcial Review E, 2005

%INPUT:signal1 % signal2 
%      m = embedding dimension
%     tau = time delay
%OUTPUT:cstr = cstr = strength of coupling

tic
%calling embeddelays
[x] = embeddelay(signal1, m, tau);
[y] = embeddelay(signal2, m, tau);


 permlist = perms(1:m);
%normalise permlist

permlist=normr(permlist);

%%%%%%%%%%%%%%%% for signal1 %%%%%%%%%%%%%%
 [a,iv1]=sort(x,2);
% normalise the index lise
 iv1=normr(iv1);

%product dot
 X=iv1*permlist';
 X=X';
 X=single(X);
 
%The list of patterns
 [rows1, cols, vals]= find(X==1);
 
 %%%%%%%%%%%%%%%% for signal2 %%%%%%%%%%%%%%
 [a,iv2]=sort(y,2);
% normalise the index lise
 iv2=normr(iv2);

%product dot
 Y=iv2*permlist';
 Y=Y';
 Y=single(Y);

% %  The list of patterns
 [rows2, cols, vals]= find(Y==1);


 len=length(x);
 
 sum1=0;
 for k=1:len
     if(rows1(k)==rows2(k))
        sum1=sum1+1; 
     end
 end

 %strength of coupling
 cstr=sum1/len;


 toc
 
 
 
 