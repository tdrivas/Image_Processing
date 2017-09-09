function [Q H]=wiener(A,T,a,K)
  [rows, cols] = size(A);
  H=zeros(rows,cols);
  H(1,:)=T;
  u=1:rows-1;
  for v=1:cols,
    H(2:rows,v) = (T./(pi*u*a)).*sin(pi*u*a).*exp(-j*pi*u*a);
  end
  WF=(1./H).*((abs(H).^2)./(abs(H).^2+K));
  B=fft2(A);
  F=B.*WF;
  G=ifft2(F);
  Q=real(G);