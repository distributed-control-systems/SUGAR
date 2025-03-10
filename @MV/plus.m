function r= plus(obj1,obj2)


% PLUS - Overload of addition for multivectors (MV) or MV matrices.
%
% Syntax:
%   r = obj1 + obj2
%
% Description:
%   This function overloads the addition operator for multivectors (MV)
%   or matrices of MVs. It supports addition of scalars to MVs, MVs to MVs,
%   and handles the case where the MVs belong to different algebras.
%
% Input:
%   obj1 - (MV) The first multivector to add.
%   obj2 - (MV) The second multivector to add.
%
% Output:
%   r - (MV) The resulting multivector after addition.
%
% Example:
%   mv1 = MV([1, 2, 3, 4], [2, 0]);
%   mv2 = MV([4, 5, 6, 7], [2, 0]);
%   mv3 = mv1 + mv2;  % Adds two multivectors.
%
% Notes:
%   - This function also supports the addition of scalars to MVs.
%   - If the multivectors belong to different algebras, an error will be raised.


    % Overload of addition of MV or MV matrizes
    % Get the size
    [f,c]=size(obj1);
    % An scalar scalar
    if f*c==1 
        % Check if both objects are MVs,
        if class(obj1)=="double" 
            % Addition of double to MV
            v=obj2.vec*0;
            v(1)=obj1;
            obj1=MV();
            obj1.Basis=obj2.Basis;
            obj1.Lsignature=obj2.Lsignature;
            obj1.vec=v;
            obj1.Signs=obj2.Signs;
            obj1.REPR=obj2.REPR;
            obj1.matrix=obj1.get_matrix_repr();
        elseif class(obj1)=="sym"
            % Addition of sym to MV
            v=sym(obj2.vec*0);
            v(1)=obj1;
            obj1=MV();
            obj1.Basis=obj2.Basis;
            obj1.Lsignature=obj2.Lsignature;
            obj1.vec=v;
            obj1.Signs=obj2.Signs;
            obj1.REPR=obj2.REPR;
            obj1.matrix=obj1.get_matrix_repr();
        end
        if class(obj2)=="double" || class(obj2)=="sym"
            % Addition of  MV to sym/double 
            v=obj1.vec*0;
            v(1)=obj2;
            obj2=MV();
            obj2.Basis=obj1.Basis;
            obj2.Lsignature=obj1.Lsignature;
            obj2.vec=v;
            obj2.Signs=obj1.Signs;
            obj2.REPR=obj1.REPR;
            obj2.matrix=obj2.get_matrix_repr();
        end
        if obj1.Lsignature==obj2.Lsignature
            % Real addition
            r=MV();
            r.Basis=obj1.Basis;
            r.Lsignature=obj1.Lsignature;
            r.vec=obj1.vec+obj2.vec;
            r.Signs=obj1.Signs;
            r.REPR=obj1.REPR;
            r.matrix=r.get_matrix_repr();
        else
            error("Objects comming from different algebras cannot be added")
        end
    else
        % In case of array of MV, go one by one
        for i=1:f
            for j=1:c
                r(i,j)=obj1(i,j)+obj2(i,j);
            end
        end
    end
end


