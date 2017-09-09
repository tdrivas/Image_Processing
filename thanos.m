clear
close all
load Washington_DC_Mall_distorted

DI(:,:,50)=round(DI(:,:,50)./max(max(DI(:,:,50))).*255);
DI(:,:,36)=round(DI(:,:,50)./max(max(DI(:,:,50))).*255);
DI(:,:,15)=round(DI(:,:,50)./max(max(DI(:,:,50))).*255);
R=DI(:,:,50);
G=DI(:,:,36);
B=DI(:,:,15);


T=5;
a=0.1;
K=0.0001;

figure(1, 'Name', 'Distored Washington DC Mall due to motion')
imshow(DI(:,:,191),[]);  
for i=1:191,
  RI(:,:,i)=wiener(DI(:,:,i),T,a,K);
end

figure(2, 'Name', 'Restored Washington DC Mall via wiener filter')
imshow(RI(:,:,191),[]);    

[pixrows pixcols nbands]=size(RI);
RI2=reshape(RI,pixrows*pixcols,nbands)';
[eigenval,eigenvec,explain,Y,mean_vec]=pca_fun(RI2,3);
figure(3), scatter3(Y(1,:),Y(2,:),Y(3,:));


nPCs=3;
Ynew=Y(1:nPCs,:); 
for k=2:9
  theta_ini=rand(nPCs,k);
  for dm=1:nPCs
    theta_ini(dm,:)=(max(Ynew(dm,:))-min(Ynew(dm,:)))*theta_ini(dm,:)+min(Ynew(dm,:));
  end  
  [theta,bel,J]=k_means(Ynew,theta_ini);
  bel2D=reshape(bel', pixrows, pixcols);
  figure(k,'Name', sprintf('%d clusters image',k)),
  imagesc(bel2D)
end  

 



