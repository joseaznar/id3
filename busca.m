function t = busca(col,data,n,indices)
%te da 1 si no hay ningún otra clase con esa 
%combinación y cero de otra manera
t = 1;
i = 1;
while i<=size(data,1) && t==1    
   ind = 1;
   while ind<=n
      if  col(ind)~=0 && ind~=n && data(i,indices(ind)) ~= col(ind)
          ind = n+2;
      end
      if data(i,n)~=col(n) && ind==n
          t = 0;
      end
      ind = ind + 1;
   end
   i = i+1;
end
end
