function [Basis, Stamp, Msigns, Signs] = structuredef(sig)
% STRUCTUREDEF Define the algebraic structure for multivectors.
%
%   [Basis, Stamp, Msigns, Signs] = structuredef(sig)
%
%   This function initializes and stores the structure of possible
%   geometric algebra (GA) or conformal geometric algebra (CGA)
%   configurations in persistent variables for efficient reuse.
%   It handles both p,q,r-defined algebras and Cayley table-defined algebras.
%
% INPUT:
%   sig : Either a signature vector [p, q, r] for GA
%         or a Cayley table matrix defining the algebra structure.
%
% OUTPUT:
%   Basis  : Cell array with the basis elements of the algebra (as strings).
%   Stamp  : A matrix representation (absolute values) to help transform MV.
%   Msigns : The sign matrix for multiplication.
%   Signs  : Vector of squared-blade values for each e_i (the signature).
%
% NOTE:
%   - The function uses persistent variables to store precomputed data,
%     ensuring efficiency during repeated calls.
%   - The Cayley part is kept intact.
%
% EXAMPLE:
%   [B, S, Ms, Sig] = structuredef([3,2,1]);
%
%   or
%
%   cTable = ["1" "e1" "e2";
%             "e1" "-1" "e12";
%             "e2" "-e12" "1"];
%   [B, S, Ms, Sig] = structuredef(cTable);

    % ---------------------------------------------------------------------
    % PERSISTENT VARIABLES
    % ---------------------------------------------------------------------
    persistent signatures Csignatures;
    persistent stamps     Cstamps;
    persistent basis      Cbasis;
    persistent msigns    Cmsigns;
    persistent signs     Csigns;
    persistent bnames    Cbnames;

    % ---------------------------------------------------------------------
    % INITIALIZATION 
    % ---------------------------------------------------------------------
    if isempty(signatures)
        stamps{20,20,20}     = 0;
        signatures{20,20,20} = 0;
        basis{20,20,20}      = 0;
        msigns{20,20,20}     = 0;
        signs{20,20,20}      = 0;
        bnames{20,20,20}     = 0;

        % load('@MV/pre_defined_stamps.mat', 'stamps')
        % load('@MV/pre_defined_signatures.mat', 'signatures')
        % load('@MV/pre_defined_basis.mat', 'basis')
        % load('@MV/pre_defined_msigns.mat', 'msigns')
        % load('@MV/pre_defined_signs.mat', 'signs')
        % load('@MV/pre_defined_bnames.mat', 'bnames')

        % Cayley-defined data
        Cstamps      = {};
        Csignatures  = {};
        Cbasis       = {};
        Cmsigns      = {};
        Csigns       = {};
        Cbnames      = {};
    end
        if class(sig)=='string' 
            if sig=="DUMP"
                save('@MV/pre_defined_stamps.mat', 'stamps', '-v7.3');
                save('@MV/pre_defined_signatures.mat', 'signatures', '-v7.3');
                save('@MV/pre_defined_basis.mat', 'basis', '-v7.3');
                save('@MV/pre_defined_msigns.mat', 'msigns', '-v7.3');
                save('@MV/pre_defined_signs.mat', 'signs', '-v7.3');
                save('@MV/pre_defined_bnames.mat', 'bnames', '-v7.3');

            end    
        return
        end

    [sr, sc] = size(sig);

    % ---------------------------------------------------------------------
    % CASE 1: Algebra p,q,r (bitwise implementation)
    % ---------------------------------------------------------------------
    if sr==1  
        if isempty(signatures{sig(1)+1, sig(2)+1, sig(3)+1})
            % Check some constraints
            if any(sig >= 20)
                error('Currently limited to p<10, q<10, r<10.');
            end
            if sum(sig) > 9
                warning('Large algebra: building might take some time at first.');
            end

            % Mark this signature as computed
            signatures{sig(1)+1, sig(2)+1, sig(3)+1} = sig;

            % Build the multiplication table using the bitwise approach
            [stampFull, signMatrix, basisNames, Svec] = buildGA_bitwise(sig);

            % We store abs(...) in "Stamp" and sign(...) in "Msigns"
            StampToStore  = abs(stampFull);
            MsignsToStore = sign(stampFull);
            SignsToStore  = Svec;  % signature vector e1^2, e2^2, ...

            % Save everything in the persistent cells
            stamps{sig(1)+1, sig(2)+1, sig(3)+1}     = StampToStore;
            basis{sig(1)+1, sig(2)+1, sig(3)+1}      = basisNames;
            msigns{sig(1)+1, sig(2)+1, sig(3)+1}     = MsignsToStore;
            signs{sig(1)+1, sig(2)+1, sig(3)+1}      = SignsToStore;
            bnames{sig(1)+1, sig(2)+1, sig(3)+1}     = basisNames;
        end

        % Retrieve from persistent
        Stamp  = stamps{sig(1)+1, sig(2)+1, sig(3)+1};
        Basis  = basis{sig(1)+1, sig(2)+1, sig(3)+1};
        Msigns = msigns{sig(1)+1, sig(2)+1, sig(3)+1};
        Signs  = signs{sig(1)+1, sig(2)+1, sig(3)+1};

    % ---------------------------------------------------------------------
    % CASE 2: Cayley table 
    % ---------------------------------------------------------------------
    elseif sr==sc
        cayley_exists = 0;
        for j=1:size(Csignatures,1)
            existing = size(Csignatures{j},1);
            if existing==sr
                if Csignatures{j}==sig
                    cayley_exists=j;
                    break;
                end
            end
        end

        if cayley_exists==0
            n = sc;
            Signs = ones(1,sc);
            matrixC = cell(sc, sc);
            for i=1:sc
                matrixC{i,1} = i;
            end
            for col=2:sc
                for row=1:sc
                    element = regexprep(sig(row,col),'^-','');
                    if element==sig(row,col)
                        sgn = 1;
                    else
                        sgn = -1;
                    end
                    index = find(sig(:,1)==element);
                    if ~isempty(index)
                        matrixC{index,col} = sgn*row;
                    end
                end
            end
            try
                matrixC = cell2mat(matrixC);
            catch
            end

            Cstamps{end+1}     = abs(double(matrixC));
            Csignatures{end+1} = sig;
            Cbasis{end+1}      = cellstr(sig(:,1)');
            Cmsigns{end+1}     = sign(matrixC);
            Csigns{end+1}      = Signs;
            Cbnames{end+1}     = cellstr(sig(:,1)');
            cayley_exists      = length(Csignatures);
        end

        Stamp  = Cstamps{cayley_exists};
        Basis  = Cbasis{cayley_exists};
        Msigns = Cmsigns{cayley_exists};
        Signs  = Csigns{cayley_exists};

    else
        error("Input is neither [p,q,r] nor a valid Cayley table.");
    end
end

% =========================================================================
% Local function to build GA via bitwise XOR, with custom naming format
% =========================================================================
function [StampFull, SignMatrix, BasisNames, S] = buildGA_bitwise(signature)
% BUILDGA_BITWISE builds the multiplication table for Cl(p,q,r) using bitmasks.
% The basis is named "e0" for scalar, and "e12_10_11" for bits [1,2,10,11].

    % 1) Construct the metric signs for each basis vector e1..en
    n = sum(signature);
    S = zeros(1,n);
    % p vectors with e_i^2=+1
    S(1:signature(1)) = +1;
    % q vectors with e_i^2=-1
    S(signature(1)+1 : signature(1)+signature(2)) = -1;
    % r vectors with e_i^2=0 (if any)
    % S(...) = 0 for those if signature(3)>0

    baseCount = 2^n;

    % 2) Allocate the tables
    StampFull  = zeros(baseCount, baseCount);
    SignMatrix = zeros(baseCount, baseCount);

    % 3) Fill them with bitwise operations
    for A=0:baseCount-1
        for B=0:baseCount-1
            [sgn, C] = productBitwise(A, B, S);

            % Imitate the logic of "matrix(destination,col) = sign * val(row)"
            % Here, val(row) ~ (A+1), so:
            StampFull(C+1, B+1)  = sgn * (A+1);
            SignMatrix(C+1, B+1) = sign(sgn * (A+1));
        end
    end

    % 4) Build textual basis names for each bitmask in the custom format
    BasisNames = cell(1, baseCount);
    for idx=0:baseCount-1
        BasisNames{idx+1} = bitmaskToBasisName(idx);
    end
end

% -------------------------------------------------------------------------
% PRODUCTBITWISE: multiply two bitmasks A and B in Cl(p,q,r)
% -------------------------------------------------------------------------
function [signo, C] = productBitwise(A, B, S)
% - The reorder sign from Grassmann is (-1)^(popcount(A & B)).
% - The metric sign multiplies by S(i) for each repeated bit i.
% - The resulting bitmask is A XOR B.

    overlap = bitand(A,B);
    gfactor = (-1)^popcount(overlap);

    mfactor = 1;
    x = overlap;
    bitPos = 0;
    while x > 0
        if bitand(x,1)
            if S(bitPos+1)==0
                % If any repeated bit has S=0, product is zero
                signo = 0;
                C     = 0;  % interpret "0" as a "zero" element
                return;
            end
            mfactor = mfactor * S(bitPos+1);
        end
        x = bitshift(x, -1);
        bitPos = bitPos + 1;
    end

    signo = gfactor * mfactor;
    C     = bitxor(A,B);
end

% -------------------------------------------------------------------------
% POPCOUNT: returns the number of 1-bits in x
% -------------------------------------------------------------------------
function c = popcount(x)
    c = 0;
    while x > 0
        x = bitand(x, x-1);
        c = c + 1;
    end
end

% -------------------------------------------------------------------------
% bitmaskToBasisName: convert integer idx to a string like "e12_10_11"
% -------------------------------------------------------------------------
function nm = bitmaskToBasisName(idx)
% If idx=0 => "e0"
% Otherwise => "e" plus a concatenation of bit indices (1-based).
% Digits <10 are appended directly; digits >=10 are appended with an underscore.
% Example bits=[1,2,10,11] => "e12_10_11"

    if idx == 0
        nm = 'e0';
        return;
    end

    bits = [];
    pos  = 0;
    val  = idx;
    while val > 0
        if bitand(val,1)
            bits(end+1) = pos+1; %#ok<AGROW>
        end
        val = bitshift(val, -1);
        pos = pos + 1;
    end
    % bits now holds the indices (1-based) of each active bit.

    % Build the final name
    nm = 'e';  % start with 'e'
    for i = 1:length(bits)
        if bits(i) < 10
            % just append the digit
            nm = [nm, num2str(bits(i))];
        else
            % append with underscore
            nm = [nm, '_', num2str(bits(i))];
        end
    end
end