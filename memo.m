

%a random time series
signal1=rand(1,1000);
signal2=rand(1,1000);

%run 2 versions of complexity
m=3;
tau=1;
%implementation based on matrices
[pe1 npe1]=my_permutation_entropy(signal1,m,tau);
[pe2 npe2]=my_permutation_entropy1(signal1,m,tau);


%ordinal pattern similarity
[dis c1 c2 ct1 ct2]=ordinal_pattern_similarity(signal1,signal2,m,tau);

%order recurrence plots
cstr=rr_order_patterns(signal1,signal2,m,tau);