function [Basis,Stamp,Msigns,Signs]= structuredef(sig)
    % STRUCTUREDEF Define the algebraic structure for multivectors.
    %
    %  [Basis, Stamp, Msigns, Signs] = structuredef(sig)
    %
    %  This function defines the algebraic structure associated with a given
    %  signature `sig`, either in terms of a geometric algebra (p, q, r) or
    %  in the form of a Cayley table.

    persistent signatures Csignatures;
    persistent stamps     Cstamps;
    persistent basis      Cbasis;
    persistent msigns    Cmsigns;
    persistent signs     Csigns;
    persistent bnames    Cbnames;

    % Persistent variable initialization (same as in the original code)
    if isempty(signatures)
        stamps{16,16,16}=0;
        signatures{16,16,16}=0;
        basis{16,16,16}=0;
        msigns{16,16,16}=0;
        signs{16,16,16}=0;
        bnames{16,16,16}=0;

        % Variables for Cayley tables
        Cstamps={};
        Csignatures={};
        Cbasis={};
        Cmsigns={};
        Csigns={};
        Cbnames={};
    end
    
    [sr,sc] = size(sig);

    if (sr==1)
        % --------------------------------------------------------
        % ---------- GEOMETRIC ALGEBRA CASE (p, q, r) ------------
        % --------------------------------------------------------
        if isempty(signatures{sig(1)+1, sig(2)+1, sig(3)+1})

            % Dimension checks
            if any(sig>=15)
                error('Limit: p<16, q<16, r<16. (adjust if needed)');
            end
            if sum(sig)>9
                warning('off', 'backtrace')  % Disable line number display
                warning('Large algebra; first instance computation may take some time.');
                warning('on', 'backtrace')   % Re-enable line number display
            end

            % Mark as computed
            signatures{sig(1)+1, sig(2)+1, sig(3)+1} = 1;

            % Define the signature
            signature = sig;
            n = sum(signature);
            val = 1 : 2^n;  % vector for "val(row)"

            if 2^n == length(val)
                % Assigning signs
                s1 = 1; s2 = -1; s3 = 0; 
                S = zeros(1,n) + s3; 
                for k=1:n
                    if k <= signature(1)
                        S(k) = s1;
                    elseif k <= (signature(1)+signature(2))
                        S(k) = s2;
                    end
                end
                Signs = S;  % Store in temporary variable

                % --------------------------------------------
                % Construct the basis by combining indices
                v = 1:n;
                Basis = cell(1, 2^n);
                Basis{1} = '0';
                counter = 2;
                for k=1:n
                    C = nchoosek(v,k);
                    [f,~] = size(C);
                    for item=1:f
                        % e.g., "1  2" -> "1,2"
                        b = regexprep(num2str(C(item,:)), "[ ]{2,}", ",");
                        Basis{counter} = b;
                        counter = counter+1;
                    end
                end

                Basis_count = length(Basis);

                % --------------------------------------------
                % Prepare a Map container to index the basis
                mapBasis = containers.Map(Basis, num2cell(1:Basis_count));

                % --------------------------------------------
                % Create the matrix (now directly in double format)
                matrix = zeros(Basis_count, Basis_count);

                % Fill the multiplication table
                for col = 1:Basis_count
                    for row = 1:Basis_count
                        % Retrieve names of row and col, merge and compute result
                        if Basis{row}=="0"
                            namesRow = [];
                        else
                            namesRow = str2double(strsplit(Basis{row}, ","));
                        end
                        if Basis{col}=="0"
                            namesCol = [];
                        else
                            namesCol = str2double(strsplit(Basis{col}, ","));
                        end

                        names = [namesRow, namesCol];
                        % Compute permutation sign due to "reordering" 
                        signo = 1;
                        for kk = 1:length(names)
                            signo = signo * (-1)^( sum(names(1:kk-1) > names(kk)) );
                        end

                        % Compute repetitions + signature
                        values = unique(names,'sorted');
                        final_nums = [];
                        for kk = 1:length(values)
                            number_in_vector = sum(names==values(kk));
                            disapearing      = fix(number_in_vector/2);
                            remaining        = mod(number_in_vector,2);

                            % Affect sign according to S(values(kk))^(disapearing)
                            signo = signo * ( S(values(kk)) )^(disapearing);

                            % If one repetition remains, pass to result
                            if remaining==1
                                final_nums(end+1) = values(kk); %#ok<AGROW>
                            end
                        end

                        % Retrieve target basis as string
                        if isempty(final_nums)
                            final_element = "0";
                        else
                            final_element = join(string(final_nums), ",");
                        end

                        % Index of target basis (fast using mapBasis)
                        destination = mapBasis(final_element);

                        % Store: in the original = signo*val(row)
                        matrix(destination, col) = signo * val(row);
                    end
                end

                % --------------------------------------------
                % Store values in 'matrix'
                % Abs and sign are stored in stamps, msigns...
                % Construct names like "e1", "e1_10", etc.
                for j=1:Basis_count
                    % Final replacement, same as in the original code
                    % (careful with regex)
                    Bas_j = regexprep(Basis{j},",\d{2,}",",_$0");
                    Bas_j = strrep(Bas_j, ",", "");
                    BasisN{j} = "e" + Bas_j;
                end

                % Store in persistent cells
                stamps{sig(1)+1, sig(2)+1, sig(3)+1}     = abs(matrix);
                signatures{sig(1)+1, sig(2)+1, sig(3)+1} = sig;
                basis{sig(1)+1, sig(2)+1, sig(3)+1}      = BasisN;
                msigns{sig(1)+1, sig(2)+1, sig(3)+1}     = sign(matrix);
                signs{sig(1)+1, sig(2)+1, sig(3)+1}      = Signs;
                bnames{sig(1)+1, sig(2)+1, sig(3)+1}     = BasisN;
            end
        end

        % Retrieve results for output
        Stamp  = stamps{sig(1)+1, sig(2)+1, sig(3)+1};
        Basis  = basis{sig(1)+1, sig(2)+1, sig(3)+1};
        Msigns = msigns{sig(1)+1, sig(2)+1, sig(3)+1};
        Signs  = signs{sig(1)+1, sig(2)+1, sig(3)+1};

    elseif (sr==sc)
        % --------------------------------------------------------
        % ------- CAYLEY TABLE CASE (untouched) -----------------
        % --------------------------------------------------------
        cayley_exists=0;
        for j=1:size(Csignatures,1)
            existing=size(Csignatures{j},1);
            if (existing==sr)
                if Csignatures{j}==sig
                    cayley_exists=j;
                    break;
                end
            end
        end

        if cayley_exists==0
            n=sc;
            Signs=ones(1,sc); 
            matrix(1:sc,1:sc)={0};
            for i=1:sc
                matrix{i,1}=i;
            end
            for j=2:sc
                for i=1:sc
                    element = regexprep(sig(i,j),'^-','');
                    signo = (element == sig(i,j)) * 2 - 1;
                    index = find(sig(:,1)==element);
                    if ~isempty(index)
                        matrix{index,j} = signo*i;
                    end
                end
            end
            Cstamps{end+1} = abs(double(matrix));
            Csignatures{end+1} = sig;
            Cbasis{end+1} = cellstr(sig(:,1)');
            Cmsigns{end+1} = sign(matrix);
            Csigns{end+1} = Signs;
            cayley_exists = length(Csignatures);
        end

        Stamp  = Cstamps{cayley_exists};
        Basis  = Cbasis{cayley_exists};
        Msigns = Cmsigns{cayley_exists};
        Signs  = Csigns{cayley_exists};
    else
        error("Input is neither [p,q,r] nor a valid Cayley table.");
    end
end