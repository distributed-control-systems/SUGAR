function cgaplot2(element)
persistent cos_p
persistent sin_p
if isempty(cos_p)
    al=0:0.01:2*pi;
    cos_p=real(exp(al*1i));
    sin_p=imag(exp(al*1i));
end
%% ROUND STRUCTURES
M_punto=       [0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
M_punto_dual = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0];
M_dipolo=      [0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0];
M_circulo=     [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0];
M_circulo_dual=[0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
%% FLAT STRUCTURES
M_punto_f =    [0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 0, 0, 0, 0];
M_recta =      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0];
M_punto_f_dual=[0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0];
M_recta_dual = [0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];


tf = ishold;
ev=element.vector;
pCell = num2cell(ev);
[a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16]=pCell{:};

%-----------------------------------------------------------------------------------------
% FLAT ELEMENTS, check if outer product with ni or inner product with ni is zero
if ~any([a1, a2, a3, a4, a6, a7, a9, a12]) || ~any([-a2, a6, a7, a1 + a8, -a12, -a13, -a14, a16])
    %-----------------------------------------------------------------------------------------
    % FLAT POINT, flat point structure
    if((abs(ev)>1e-6).*M_punto_f)==(abs(ev)>1e-6)

        scatter(a10/a8,a11/a8,"o",'filled');

        % END FLAT POINT
        %-----------------------------------------------------------------------------------------
        %-----------------------------------------------------------------------------------------
        % FLAT POINT DUAL, dual flat plint structure
    elseif ((abs(ev)>1e-6).*M_punto_f_dual)==(abs(ev)>1e-6)

        scatter(-a11/a9,a10/a9,"o",'filled');

        % END FLAT POINT DUAL
        %-----------------------------------------------------------------------------------------
        %-----------------------------------------------------------------------------------------
        % FLAT LINE, line structure
    elseif((abs(ev)>1e-6).*M_recta)==(abs(ev)>1e-6)

        fimplicit(@(X,Y)X*a14 - a15 - Y*a13);

        % END FLAT LINE
        %-----------------------------------------------------------------------------------------
        %-----------------------------------------------------------------------------------------
        % FLAT LINE DUAL, dual line structure
    elseif ((abs(ev)>1e-6).*M_recta_dual)==(abs(ev)>1e-6)

        a13=  a4;
        a14= -a3;
        a15= -a5;

        fimplicit(@(X,Y)X*a14 - a15 - Y*a13);

        % END FLAT LINE DUAL
        %-----------------------------------------------------------------------------------------
    end
    % END FLAT ELEMENTS
    %-----------------------------------------------------------------------------------------
    %-----------------------------------------------------------------------------------------
    % ROUND ELEMENTS
else

    %-----------------------------------------------------------------------------------------
    % POINTS, if the inner product is zero

    if abs(2*a12*a15 - 2*a6*a10 - 2*a7*a11 - 2*a2*a5 + a1^2 + a3^2 + a4^2 + a8^2 - a9^2 + a13^2 + a14^2 - a16^2)<1e-6
        %-----------------------------------------------------------------------------------------
        % POINT OUTER, and has outer srtucture
        if ((abs(ev)>1e-6).*M_punto)==(abs(ev)>1e-6)

            x=( a3/a2 );
            y=( a4/a2 );

            scatter(x,y,"o",'filled')

            % END POINT OUTER
            %-----------------------------------------------------------------------------------------
            %-----------------------------------------------------------------------------------------
            % POINT DUAL, otherwise is a dual representation
        elseif ((abs(ev)>1e-6).*M_punto_dual)==(abs(ev)>1e-6)

            a2= -a12;
            a3=  a14;
            a4= -a13;
            a5=  a15;

            x=( a3/a2 );
            y=( a4/a2 );

            scatter(x,y,"o",'filled')
        end
        % END POINT DUAL
        %-----------------------------------------------------------------------------------------
        %-----------------------------------------------------------------------------------------
        % END POINTS
    else
        %-----------------------------------------------------------------------------------------
        % DIPOLE , if the structure is the one of a dipole in

        if ((abs(ev)>1e-6).*M_dipolo)==(abs(ev)>1e-6)



            %Get the squared radius
            RR=(  a8^2 - 2*a7*a11 - 2*a6*a10 - a9^2);
            if RR>=0
                color="b";
            else
                color="r";
            end
            r=sqrt(abs(RR));
            %Recover coordinates

            x1=( (a6*a8 + a7*a9 + a6*r)/(a6^2 + a7^2) );
            x2=(  (a7*a8 - a6*a9 + a7*r)/(a6^2 + a7^2) );


            y1=( (a6*a8 + a7*a9 - a6*r)/(a6^2 + a7^2) );
            y2=( -(a6*a9 - a7*a8 + a7*r)/(a6^2 + a7^2)  );
            
            
            

            %And plot
            scatter(x1,x2,"o"+color);
            hold on
            scatter(y1,y2,"o"+color);
            plot([x1 y1],[x2 y2],".-"+color);
            hold off

            % END DIPOLE
            %-----------------------------------------------------------------------------------------
            %-----------------------------------------------------------------------------------------
            % CIRCLE OUTER, if the structure correspons to a circle in

        elseif ((abs(ev)>1e-6).*M_circulo)==(abs(ev)>1e-6)

            %Compute its center point
            cx=-(a12*a14 + a14*(a12/2 + a15) + a14*(a12/2 - a15))/(2*a12^2) ;
            cy=(a12*a13 + a13*(a12/2 + a15) + a13*(a12/2 - a15))/(2*a12^2);

            %Compute its radius squared
            r=(2*a12*a15 + a13^2 + a14^2)/a12^2 ;

            if r>0
                color="b";
            else
                color="r";
            end
            r=sqrt(abs(r));



            %And plot
            plot(cx+r*cos_p, ...
                cy+r*sin_p);


            % END CIRCLE OUTER
            %-----------------------------------------------------------------------------------------
            %-----------------------------------------------------------------------------------------
            % CIRCLE DUAL, if the structure corresponds to a dual cicle
        elseif ((abs(ev)>1e-6).*M_circulo_dual)==(abs(ev)>1e-6)

            %Undualize
            a12=  a2;
            a13=  a4;
            a14= -a3;
            a15= -a5;

            %Compute its center point
            cx=-(a12*a14 + a14*(a12/2 + a15) + a14*(a12/2 - a15))/(2*a12^2) ;
            cy=(a12*a13 + a13*(a12/2 + a15) + a13*(a12/2 - a15))/(2*a12^2);

            %Compute its radius squared
            r=(2*a12*a15 + a13^2 + a14^2)/a12^2 ;

            if r>0
                color="b";
            else
                color="r";
            end
            r=sqrt(abs(r));

            %And plot
            plot(cx+r*cos_p, ...
                cy+r*sin_p);


            % END CIRCLE DUAL
            %-----------------------------------------------------------------------------------------
        end
    end
end
if tf
    hold on
end
