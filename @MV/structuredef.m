function [Basis,Stamp,Msigns,Signs]= structuredef(sig)
    % STRUCTUREDEF Define the algebraic structure for multivectors.
    %
    %  [Basis, Stamp, Msigns, Signs] = structuredef(sig)
    %
    %  ... (comentarios originales) ...
    
    persistent signatures Csignatures;
    persistent stamps     Cstamps;
    persistent basis      Cbasis;
    persistent msigns    Cmsigns;
    persistent signs     Csigns;
    persistent bnames    Cbnames;

    % Inicialización de las persistentes (igual que en tu código original)
    if isempty(signatures)
        stamps{10,10,10}=0;
        signatures{10,10,10}=0;
        basis{10,10,10}=0;
        msigns{10,10,10}=0;
        signs{10,10,10}=0;
        bnames{10,10,10}=0;

        load('@MV/pre_defined_stamps.mat', 'stamps')
        load('@MV/pre_defined_signatures.mat', 'signatures')
        load('@MV/pre_defined_basis.mat', 'basis')
        load('@MV/pre_defined_msigns.mat', 'msigns')
        load('@MV/pre_defined_signs.mat', 'signs')
        load('@MV/pre_defined_bnames.mat', 'bnames')

        % Variables para Cayley
        Cstamps={};
        Csignatures={};
        Cbasis={};
        Cmsigns={};
        Csigns={};
        Cbnames={};
    end
    
%         if class(sig)=='string' 
%             if sig=="DUMP"
%                 save @MV/pre_defined_stamps.mat stamps
%                 save @MV/pre_defined_signatures.mat signatures
%                 save @MV/pre_defined_basis.mat basis
%                 save @MV/pre_defined_msigns.mat msigns
%                 save @MV/pre_defined_signs.mat signs
%                 save @MV/pre_defined_bnames.mat bnames
%                 return
%             end    
%       end

    [sr,sc] = size(sig);

    if (sr==1)
        % --------------------------------------------------------
        % ---------- CASO DE ÁLGEBRA p, q, r ----------------------
        % --------------------------------------------------------
        if isempty(signatures{sig(1)+1, sig(2)+1, sig(3)+1})

            % Chequeos de dimensión
            if any(sig>=10)
                error('Límite: p<10, q<10, r<10. (ajústalo si lo requieres)');
            end
            if sum(sig)>9
                warning('Algebra grande; la primera instancia puede tardar.');
            end

            % Marcamos que está computada
            signatures{sig(1)+1, sig(2)+1, sig(3)+1} = 1;

            % Definición de la firma
            signature = sig;
            n = sum(signature);
            val = 1 : 2^n;  % vector para "val(row)"

            if 2^n == length(val)
                % Asignación de signos
                s1 = 1; s2 = -1; s3 = 0; 
                S = zeros(1,n) + s3; 
                for k=1:n
                    if k <= signature(1)
                        S(k) = s1;
                    elseif k <= (signature(1)+signature(2))
                        S(k) = s2;
                    end
                end
                Signs = S;  % Guardamos en variable temporal

                % --------------------------------------------
                % Construcción de la base combinando índices
                v = 1:n;
                Basis = cell(1, 2^n);
                Basis{1} = '0';
                counter = 2;
                for k=1:n
                    C = nchoosek(v,k);
                    [f,~] = size(C);
                    for item=1:f
                        % p.ej: "1  2" -> "1,2"
                        b = regexprep(num2str(C(item,:)), "[ ]{2,}", ",");
                        Basis{counter} = b;
                        counter = counter+1;
                    end
                end

                Basis_count = length(Basis);

                % --------------------------------------------
                % Prepara un contenedor Map para indexar la base
                mapBasis = containers.Map(Basis, num2cell(1:Basis_count));

                % --------------------------------------------
                % Creamos la matriz (ahora en double directamente)
                matrix = zeros(Basis_count, Basis_count);

                % Relleno de la tabla de multiplicación
                for col = 1:Basis_count
                    for row = 1:Basis_count
                        % Tomamos los nombres de row y col, unimos y calculamos el resultado
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
                        % Cálculo de la permutación: sign por "reordenar" 
                        signo = 1;
                        for kk = 1:length(names)
                            signo = signo * (-1)^( sum(names(1:kk-1) > names(kk)) );
                        end

                        % Cálculo de repeticiones + firma
                        values = unique(names,'sorted');
                        final_nums = [];
                        for kk = 1:length(values)
                            number_in_vector = sum(names==values(kk));
                            disapearing      = fix(number_in_vector/2);
                            remaining        = mod(number_in_vector,2);

                            % Afecta signo según S(values(kk))^(disapearing)
                            signo = signo * ( S(values(kk)) )^(disapearing);

                            % Si queda 1 repetición, pasa al resultado
                            if remaining==1
                                final_nums(end+1) = values(kk); %#ok<AGROW>
                            end
                        end

                        % Obtiene la base destino como string
                        if isempty(final_nums)
                            final_element = "0";
                        else
                            final_element = join(string(final_nums), ",");
                        end

                        % Índice de la base destino (rápido con mapBasis)
                        destination = mapBasis(final_element);

                        % Almacena: en el original = signo*val(row)
                        matrix(destination, col) = signo * val(row);
                    end
                end

                % --------------------------------------------
                % Se quedan los valores en 'matrix'
                % Abs y sign se guardan en stamps, msigns...
                % Se construyen los nombres "e1", "e1_10", etc.
                for j=1:Basis_count
                    % Reemplazo final, igual que en tu código
                    % (ojo con la regex)
                    Bas_j = regexprep(Basis{j},",\d{2,}",",_$0");
                    Bas_j = strrep(Bas_j, ",", "");
                    BasisN{j} = "e" + Bas_j;
                end

                % Almacena en las celdas persistentes
                stamps{sig(1)+1, sig(2)+1, sig(3)+1}     = abs(matrix);
                signatures{sig(1)+1, sig(2)+1, sig(3)+1} = sig;
                basis{sig(1)+1, sig(2)+1, sig(3)+1}      = BasisN;
                msigns{sig(1)+1, sig(2)+1, sig(3)+1}     = sign(matrix);
                signs{sig(1)+1, sig(2)+1, sig(3)+1}      = Signs;
                bnames{sig(1)+1, sig(2)+1, sig(3)+1}     = BasisN;
            end
        end

        % Recuperamos los resultados para la salida
        Stamp  = stamps{sig(1)+1, sig(2)+1, sig(3)+1};
        Basis  = basis{sig(1)+1, sig(2)+1, sig(3)+1};
        Msigns = msigns{sig(1)+1, sig(2)+1, sig(3)+1};
        Signs  = signs{sig(1)+1, sig(2)+1, sig(3)+1};

    elseif (sr==sc)
        % --------------------------------------------------------
        % ------- CASO DE TABLA DE CAYLEY (sin tocar) ------------
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
                    if element == sig(i,j)
                        signo=1;
                    else
                        signo=-1;
                    end
                    index = find(sig(:,1)==element);
                    if ~isempty(index)
                        matrix{index,j} = signo*i;
                    end
                end
            end

            try
                matrix=cell2mat(matrix);
            catch
            end

            Cstamps{end+1}     = abs(double(matrix));
            Csignatures{end+1} = sig;
            Cbasis{end+1}      = cellstr(sig(:,1)');
            Cmsigns{end+1}     = sign(matrix);
            Csigns{end+1}      = Signs;
            Cbnames{end+1}     = cellstr(sig(:,1)');
            cayley_exists      = length(Csignatures);
        end

        Stamp  = Cstamps{cayley_exists};
        Basis  = Cbasis{cayley_exists};
        Msigns = Cmsigns{cayley_exists};
        Signs  = Csigns{cayley_exists};

    else
        error("La entrada no es ni un [p,q,r] ni una tabla de Cayley válida.");
    end
end