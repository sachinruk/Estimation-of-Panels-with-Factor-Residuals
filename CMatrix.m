function [Delta Delta_inv]=CMatrix(ZT,X,phi,S,GFT)
	
Beta=[1; -phi(:)];
Delta=zeros(size(ZT,1),size(ZT,1));
for i=1:size(ZT,3)
	e_i=ZT(:,:,i)*X(:,:,i)*Beta-S*GFT(:);
	Delta=Delta+e_i*e_i';
end
Delta=0.5*(Delta+Delta');
% Delta=C;
Delta_inv=inv(Delta);