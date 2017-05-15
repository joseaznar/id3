    % ID3
% EntropiaTime
% Probabilidad del atributo Ak de tener un valor J
%data = importdata('data.txt');
data = load('data.mat');
data = data.data;
atributos = data(:,1:(size(data,2)-1));
clases = data(:,size(data,2));
% Regla de Sturges
%numIntervalos = ceil(1+log2(size(atributos,1)));
numIntervalos = size(data,2);

% Numero de atributos de valor j en el rango del intervalo i;
for i=1:size(atributos,2)
    [counts,centers] = hist(atributos(:,i),numIntervalos);
    
    ocurrencias(i,:) = counts;
    marcasClase(:,i) = centers';
end

% Transponer matrices y normalizar
probabilidad = (1/size(atributos,1)) * ocurrencias';

% Numero de clases a clasificar
numClases = unique(clases);

% Datos por clase (en submatrices)
for i = 1:size(data,1)
    for j = 1:size(numClases,2)
        if data(i,size(data,2)) == numClases(j)
            subMat(i,:,j) = data(i,:);
        end
    end
end

subM = subMat(:,1:size(subMat,2)-1,:);
%Probabilidad de la clase Cj cuando Ak tiene un valor de j
for j = 1:size(numClases,2)
    for i=1:size(subM,2)
        ocurrenciasPerClass(:,i,j) = hist(nonzeros(subM(:,i,j)),marcasClase(:,i))';
    end
    probabilidadPorClase(:,:,j) = ocurrenciasPerClass(:,:,j)/sum(ocurrenciasPerClass(:,1,j));
end

% Entropia de atributo Ak
for j = 1:size(atributos,2)
    dEntropia = 0;
    for i = 1:numIntervalos
        alfa = 0;
        for k = 1:size(numClases,2)
            if probabilidadPorClase(i,j,k) == 0
                aux = 1;
            else
                aux = probabilidadPorClase(i,j,k);
            end
            alfa = probabilidadPorClase(i,j,k) * log2(aux) + alfa;
        end
        dEntropia = dEntropia + probabilidad(i,j) * (-1) * alfa;
    end
    Entropia(j) = dEntropia;
end

%saca el ínidice de cada uno de los atributos en el arreglo de las
%entropías ordenadas
minEntropia = sort(Entropia,'ascend');
for i=1:size(atributos,2)
   indices(i) = indice(minEntropia(i), Entropia,size(atributos,2));  
end

A = generaArbol(indices,data);

% j = 1;
% size(A)
% while j<size(A,2) && A(1,j)~=0  
%    temp = 'Si (';
%    for i=1:size(A,1)-1
%        if i<size(A,1)-1
%            temp = strcat(temp, num2str(A(i,j)), ' &  ');
%        else
%            temp = strcat(temp, num2str(A(i,j)), ') ');
%        end
%    end
%    temp = strcat(temp, ' entonces  ', num2str(A(size(A,1),j)));
%    
%    C{j} = temp;
%    j = j + 1;
% end
%celldisp(C);
formatSpec = 'If (%d & %d & %d & %d & %d & %d & %d & %d & %d & %d) then %d \n';
fileID = fopen('reglas.txt','w');
fprintf(fileID, '%s\n', 'The first five are card values and the second five are the color of each card');
fprintf(fileID,formatSpec,A);
Z = A';
fclose(fileID);
