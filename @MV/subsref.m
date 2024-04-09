function varargout= subsref(objs,subs)
% Access vector elements as it where a simple vector.
% ()->array value, of the coefficients or the elements of the matrix
% {}-> MV returns a multivector

% THIS FILE MUST BE REFORMATED!!!!
if size(subs,2)>1
  switch subs(1).type  
    case '()' | '{}'
            [varargout{1:nargout}]=builtin('subsref',objs,subs(1));
            varargout{1:nargout}=builtin('subsref',varargout{end},subs(2:end));
      otherwise
          try
        [varargout{1:nargout}]=builtin('subsref',objs,subs);  
          catch
              builtin('subsref',objs,subs)
          end
  end
    
%             o=varargout{end};
%             varargout={o.subsref(subs(2:end))};
else
switch subs(1).type
    case '()'
        [m,n]=size(objs);
        if m*n==1
            % care, numeric or basis-based
            elements=subs(1).subs{1};
            c=class(elements);
            if c=="double"
                varargout={builtin('subsref',objs.vector,subs(1))};
            elseif c=="MV"
                if class(elements.vector)=="double"
                    M=abs(elements.vector)>1e-6;
                    I=find(M);
                    s.type='()';
                    s.subs={I};
                    varargout={builtin('subsref',objs.vector,s)};
                else
                    error("Unable to perform indexing with symbolic coeficients")
                end


            else
                error("Not known indexing")
            end
        else
            [varargout{1:nargout}]=builtin('subsref',objs,subs);
        end
%         if size(subs,2)>1
%             %[varargout{1:nargout}]=builtin('subsref',varargout{end},subs(2:end));
%             o=varargout{end};
%             varargout={o.subsref(subs(2:end))};

%         end
    case '{}'
        [m,n]=size(objs);
        if m*n==1
            elements=subs(1).subs{1};

            c=class(elements);
            if c=="double"
                M=zeros(1,2^sum(objs.Lsignature));
                M(elements)=1;
                subs(1).subs={1};
                varargout={MV(objs.vector.*M,objs.Lsignature,objs.REPR)};
            elseif c=="MV"
                if class(elements.vector)=="double"
                    M=abs(elements.vector)>1e-6;
                    varargout={MV(objs.vector.*M,objs.Lsignature,objs.REPR)};
                else
                    error("Unable to perform indexing with symbolic coeficients")
                end


            else
                error("Not known indexing")
            end

        else
            % So, we want some components of the MV that
            % conform the matrix
            %lets retrive the MV components for each element of
            %the matrix
            s.type='()';
            M=sym(zeros(m,n));
            for i=1:m
                for j=1:n

                    s.subs={[i] [j]};
                    e=builtin('subsref',objs,s);%objs(i,j);

                    s.subs={[subs(1).subs{1}]};
                    % care, numeric or basis-based
                    elements=subs(1).subs{1};
            c=class(elements);
            if c=="double"
                M(i,j)=builtin('subsref',e.vector,subs(1));
            elseif c=="MV"
                if class(elements.vector)=="double"
                    MM=abs(elements.vector)>1e-6;
                    I=find(MM);
                    s.type='()';
                    s.subs={I};
                    M(i,j)=builtin('subsref',e.vector,s);
                else
                    error("Unable to perform indexing with symbolic coeficients")
                end


            else
                error("Not known indexing")
            end


     %%%               M(i,j)=builtin('subsref',e.vector,s);

                end
            end
            [varargout{1:nargout}]=M;

        end
        if size(subs,2)>1
            %[varargout{1:nargout}]=builtin('subsref',varargout{end},subs(2:end));
            o=varargout{end};
            varargout={o.subsref(subs(2:end))};

        end
    otherwise
        try
        [varargout{1:nargout}]=builtin('subsref',objs,subs);
        catch
            builtin('subsref',objs,subs);
            varargout{1:nargout}="";
        end
end
end
end


