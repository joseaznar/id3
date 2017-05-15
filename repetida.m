function t = repetida(X,A,j,n)
t = 1;
i = 1;

while i<j && t==1
    bool = 1;
    for r=1:n
        if bool==1
           if X(r)~=A(r,i)
               bool = 0;
           end
        end
    end
    if bool == 1
        t = 0;
    end
    i = i+1;
end

end