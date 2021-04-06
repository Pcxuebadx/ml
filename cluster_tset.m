load('data.mat');
addpath("./");
test=A(:,2:end);
[m,n]=size(test);
for i=1:n
    s(i)=approx_entropy(4,0.5,test(:,i));
end


