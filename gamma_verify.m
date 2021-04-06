function [pro,gammaS] = gamma_verify(B,c)
Y=ne(c,c');

gammaX=triu(B);
gammaY=triu(Y);
gammaS=sum(sum(gammaX.*gammaY));


for i=1:1000000
    randindex=randperm(length(c));
    b=c(randindex);
    Y=ne(b,b');

    gammaX=triu(B);
    gammaY=triu(Y);
    gammaS_test(i)=sum(sum(gammaX.*gammaY));
end
gammaS_test(end+1)=gammaS;
result=tabulate(gammaS_test);
pro=result(result(:,1)==gammaS,:);
if pro>0.1
    disp("lower than 90% for 1000000 random sampled. reject the number of clusters")
else
    disp("Higher than 90% for 1000000 random sampled. accecpt the number of clusters")
end

end

