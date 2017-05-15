function A = generaArbol(indices,data)
    n = size(indices,2);
    n = n+1;
    A = zeros(n,100);
    j = 1;
    
    for i=1:size(data,1)
        bool = 1;
        for r=1:n-1
            if bool == 1
                if r==1
                    A(1,j) = data(i,indices(1));
                    A(n,j) = data(i,n);
                else
                   A(r,j) = data(i,indices(r)); 
                end
                
                %busca te da 1 si no hay ningún otra clase con esa
                %combinación y cero de otra manera
                temp1 = busca(A(:,j),data,n, indices);

                if temp1 == 1
                   bool = 0;
                   %repetida te regresa 1 si la columna no existía y 0 en
                   %otro caso
                   temp2 = repetida(A(:,j),A,j,n);
                   if temp2 == 1
                      j = j+1; 
                   else
                      A(:,j) = zeros(n,1); 
                   end
                end
            end            
        end
        %esto significa que nunca encontró que fuera única o que se
        %repitiera en A la columna
        %if min(A(:,j))~=0
        %    A(:,j) = zeros(n,1);
        %end
    end
 end
    