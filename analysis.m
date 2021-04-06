clear all;
close all hidden;
load('data.mat');
data=data(:,2:end);
[m,n]=size(data)
%this is for DTW distance calculate
% for i=1:n
%     for j=i+1:n
%         dist(i,j)=dtw(data(:,i),data(:,j),3);
%     end
% end
% dist(48,48)=0
load("dist.mat")
names=["Agric  Food   Soda   Beer   Smoke  Toys   Fun    Books  Hshld  Clths  Hlth   MedEq  Drugs  Chems  Rubbr  Txtls  BldMt  Cnstr  Steel  FabPr  Mach   ElcEq  Autos  Aero   Ships  Guns   Gold   Mines  Coal   Oil    Util   Telcm  PerSv  BusSv  Comps  Chips  LabEq  Paper  Boxes  Trans  Whlsl  Rtail  Meals  Banks  Insur  RlEst  Fin    Other"];
names=strsplit(names);
%dissimilar matrix
B=(dist+dist')/2;
X=cmdscale(B,3);
% original MDS
figure;
scatter3(X(:,1),X(:,2),X(:,3),'r');
for p=1:length(names)
    text(X(p,1),X(p,2),X(p,3),names(p),'color','b','fontsize',20);
end
set(gca,'linewidth',1,'fontsize',20,'fontname','Times');




%hierarchical tree (MAX C is ward, so we choose ward way to construct the
%hierarchical tree
Z=linkage(B,'ward');
C=cophenet(Z,B);
Z1=linkage(B,'complete');
C1=cophenet(Z1,B);
Z2=linkage(B,'centroid');
C2=cophenet(Z2,B);
Z3=linkage(B,'average');
C3=cophenet(Z3,B);


%visualization of the hierarchical tree
figure;
leafOrder = optimalleaforder(Z,B);
cutoff = median([Z(end-2,3) Z(end-1,3)]);
[H,T] = dendrogram(Z,48,'Orientation','left','Reorder',leafOrder,'colorthreshold',cutoff);
set(H,'LineWidth',1)
yticklabels(names);
set(gca,'linewidth',1,'fontsize',20,'fontname','Times');



%visualization of the weighted hierarchical tree
figure;
leafOrder = optimalleaforder(Z,B);
Z(1:46,3)=Z(1:46,3)/10;
Z(47,3)=Z(47,3)/100;
cutoff = median([Z(end-2,3) Z(end-1,3)]);
[H,T] = dendrogram(Z,48,'Orientation','left','Reorder',leafOrder,'colorthreshold',cutoff);
set(H,'LineWidth',1)
yticklabels(names);
set(gca,'linewidth',1,'fontsize',20,'fontname','Times');



%cluster from hierarchical tree
c = cluster(Z,8);
 [M,R]=gamma_verify(B,c);
 
 %visualization of the cluster
figure;
scatter3(X(:,1),X(:,2),X(:,3),10,c,'filled')
for p=1:length(names)
    text(X(p,1),X(p,2),X(p,3),num2str(c(p)),'color','b','fontsize',20);
end
set(gca,'linewidth',1,'fontsize',20,'fontname','Times');




% show the cluster information
for i=1:8
    disp(["cluster" num2str(i)])
   disp(names(c==i)) 
end