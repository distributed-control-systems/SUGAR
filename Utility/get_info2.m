function s=get_info2(element)
% GET_INFO2  Extracts and classifies information from a CGA element in 2D.
%
%   S = GET_INFO2(ELEMENT) analyzes the given Conformal Geometric Algebra (CGA)
%   element and returns a structured output containing relevant information.
%
%   The function automatically classifies the element as **flat** or **round** and
%   determines its representation (outer or dual). It extracts parameters such as:
%
%     - **Points (flat or round, outer or dual representation)**
%     - **Lines (flat or dual representation)**
%     - **Dipoles (real or imaginary)**
%     - **Circles (real or imaginary, outer or dual representation)**
%
%   Input:
%     - ELEMENT: A CGA multivector representing the geometric entity.
%
%   Output:
%     - S: A structure containing:
%         - `Algebra`: `"CGA2"`
%         - `Type`: `"Flat"` or `"Round"`
%         - `Representation`: `"Outer"` or `"Dual"`
%         - `Object`: `"Point"`, `"Line"`, `"Dipole"`, `"Circle"`
%         - Geometric parameters (`x`, `y`, `radius`, etc.)
%         - Corresponding CGA multivector representation (`P` or `C`)
%
%   Features:
%     - Detects and classifies CGA elements based on their algebraic structure.
%     - Supports both **round** (circles, dipoles, points) and **flat** (lines, points) structures.
%     - Differentiates between **real** and **imaginary** geometric objects.
%     - Provides all computed parameters in a structured format.
%
%   Example:
%     info = get_info2(element);  % Get classification and parameters
%
%   Notes:
%     - This function does not plot the element; it only extracts information.
%     - Designed for **2D Conformal Geometric Algebra (CGA2)**.
%
% See also CGA, GA, MV, CGAPLOT2

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
        s.algebra="CGA2";
            s.type="Flat";
            s.Representation="Outer";
            s.Object="Point";
            s.x=a10/a8;
            s.y=a11/a8;
            s.P=MV([0 1 a10/a8 a11/a8 0.5*(a11/a8)^2+0.5*(a11/a8)^2 0 0 0 0 0 0 0 0 0 0 0],[3,1,0],"CGA");
        % END FLAT POINT
        %-----------------------------------------------------------------------------------------
        %-----------------------------------------------------------------------------------------
        % FLAT POINT DUAL, dual flat plint structure
    elseif ((abs(ev)>1e-6).*M_punto_f_dual)==(abs(ev)>1e-6)

        
            s.algebra="CGA2";
            s.type="Flat";
            s.Representation="Dual";
            s.Object="Point";
            s.x=-a11/a9;
            s.y=a10/a9;
            s.P=MV([0 1 -a11/a9 a10/a9 0.5*(-a11/a9)^2+0.5*(a10/a9)^2 0 0 0 0 0 0 0 0 0 0 0],[3,1,0],"CGA");

        % END FLAT POINT DUAL
        %-----------------------------------------------------------------------------------------
        %-----------------------------------------------------------------------------------------
        % FLAT LINE, line structure
    elseif((abs(ev)>1e-6).*M_recta)==(abs(ev)>1e-6)
        s.Algebra="CGA2";
            s.Type="Flat";
            s.Representation="Outer";
            s.Object="Line";
            s.structure="ax+by+c=0";
            s.a=a14;
            s.b=a13;
            s.c=a15;

        

        % END FLAT LINE
        %-----------------------------------------------------------------------------------------
        %-----------------------------------------------------------------------------------------
        % FLAT LINE DUAL, dual line structure
    elseif ((abs(ev)>1e-6).*M_recta_dual)==(abs(ev)>1e-6)

        a13=  a4;
        a14= -a3;
        a15= -a5;

        s.Algebra="CGA2";
            s.Type="Flat";
            s.Representation="Dual";
            s.Object="Line";
            s.structure="ax+by+c=0";
            s.a=a14;
            s.b=a13;
            s.c=a15;

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
            s.Algebra="CGA2";
                s.Type="Round";
                s.Representation="Outer";
                s.Object="Point";
                s.x=x;
                s.y=y;
            

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

            s.Algebra="CGA2";
                s.Type="Round";
                s.Representation="Dual";
                s.Object="Point";
                s.x=x;
                s.y=y;
  
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
            



            s.Algebra="CGA2";
            s.Type="Round";
            s.Representation="Outer/Dual";
            if color=="b"
                s.Object="Real Dipole";
            else
                s.Object="Imaginary Dipole";
            end
            s.x1=x1;
            s.y1=x2;
            
            s.P1=MV([0 1 x1 x2 0.5*x1^2+0.5*x2^2 [6:16]*0],[3,1,0],"CGA");
            s.x2=y1;
            s.y2=y2;
            
            s.P2=MV([0 1 y1 y2 0.5*y1^2+0.5*y2^2 [6:16]*0],[3,1,0],"CGA");

            
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
            s.Algebra="CGA2";
            s.Type="Round";
            s.Representation="Outer";
            if color=="b"
                s.Object="Real Circle";
            else
                s.Object="Imaginary Circle";
            end
            s.radius=r;
            s.xc=cx;
            s.yc=cy;
            s.C=MV([0 1 cx cy  0.5*cx^2+0.5*cy^2 [6:16]*0],[3,1,0],"CGA");
            



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
            s.Algebra="CGA2";
            s.Type="Round";
            s.Representation="Dual";
            if color=="b"
                s.Object="Real Circle";
            else
                s.Object="Imaginary Circle";
            end
            s.radius=r;
            s.xc=cx;
            s.yc=cy;
            s.C=MV([0 1 cx cy  0.5*cx^2+0.5*cy^2 [6:16]*0],[3,1,0],"CGA");
            


            % END CIRCLE DUAL
            %-----------------------------------------------------------------------------------------
        end
    end
end

