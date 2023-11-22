function r= to_SUPER_MATRIX(self)
    % Whenever you wanna compute the exp or the log or any function of a
    % matrix of multivectors you face a problem. This function composes a
    % BIG matrix ehere each element is the matrix representation of each
    % element of the matrix of multivectors
    [f,c]=size(self);
    dimension=2^sum(self(1,1).Lsignature);
    % As I don't know a priori if the elements of the matrix of
    % multivectors will have any symbolic variable I create a symbolic
    % matrix in order to accomodate any symbolic component
    SUPER_MATRIX=sym(zeros(f*dimension,c*dimension));
    f=0;
    for i=1:dimension:f*dimension
        f=f+1;
        c=0;
        for j=1:dimension:c*dimension
            c=c+1;
            SUPER_MATRIX(i:i+dimension-1,j:j+dimension-1)=self(f,c).matrix;
        end
    end
    %try to convert to double, only if ALL the components are numeric....
    try
        r=double(SUPER_MATRIX);
    catch
        r=SUPER_MATRIX;
    end

end

