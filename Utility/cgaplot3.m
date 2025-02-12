function cgaplot3(element)
% CGAPLOT3  Plots a Conformal Geometric Algebra (CGA) element in 3D.
%
%   CGAPLOT3(ELEMENT) visualizes a CGA element in a 3D plot. The function
%   automatically detects and plots different geometric primitives, including:
%
%     - Points (outer and dual representations)
%     - Flat points and their duals
%     - Lines and dual lines
%     - Planes and dual planes
%     - Dipoles (inner and dual representations)
%     - Circles and dual circles
%     - Spheres and dual spheres
%
%   The function classifies the CGA element and renders the corresponding
%   geometric object in a 3D space.
%
%   Input:
%     - ELEMENT: A CGA multivector representing the geometric entity.
%
%   Features:
%     - Detects and classifies CGA elements based on their algebraic structure.
%     - Supports both **round** (circles, spheres, dipoles) and **flat**
%       (points, lines, planes) structures.
%     - Assigns color coding:
%       - **Blue** for standard elements.
%       - **Red** for dual representations.
%     - Holds previous plots if `hold on` is active.
%
%   Example:
%     CGA(3)  % Create a 3D conformal algebra
%     element = point([1,2,3]);  % Create a CGA point
%     cgaplot3(element);         % Plot it
%
%   Notes:
%     - This function is optimized for **3D Conformal Geometric Algebra (CGA)**.
%     - It utilizes **implicit function plots** (`fimplicit3`) for planes.
%     - Spheres are visualized with a shading effect.
%
% See also CGA, GA, MV, CGAPLOT2
persistent cos_p
persistent sin_p
persistent X Y Z
if isempty(cos_p)
    al=0:0.01:2*pi;
    cos_p=real(exp(al*1i));
    sin_p=imag(exp(al*1i));
    [X,Y,Z]=sphere(128);

end
%% ROUND STRUCTURES
M_punto=       [0   1   1   1   1   1   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0];
M_punto_dual = [0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   1   1   1   1   1   0];
M_dipolo=      [0   0   0   0   0   0   1   1   1   1   1   1   1   1   1   1   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0];
M_dipolo_dual= [0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   1   1   1   1   1   1   1   1   1   1   0   0   0   0   0   0];
M_circulo=     [0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   1   1   1   1   1   1   1   1   1   1   0   0   0   0   0   0];
M_circulo_dual=[0   0   0   0   0   0   1   1   1   1   1   1   1   1   1   1   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0];
M_esfera=      [0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   1   1   1   1   1   0];
M_esfera_dual= [0   1   1   1   1   1   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0];
%% FLAT STRUCTURES
M_punto_f =    [0   0   0   0   0   0   0   0   0   1   0   0   1   0   1   1   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0];
M_recta =      [0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   1   0   1   1   0   1   1   1   0   0   0   0   0   0];
M_plano =      [0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   1   1   1   1   0];
M_punto_f_dual=[0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   1   1   1   1   0   0   0   0   0   0];
M_recta_dual = [0   0   0   0   0   0   0   0   0   0   1   1   1   1   1   1   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0];
M_plano_dual = [0   0   1   1   1   1   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0];


tf = ishold;
ev=element.vector;
pCell = num2cell(ev);
[a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20, a21, a22, a23, a24, a25, a26, a27, a28, a29, a30, a31, a32]=pCell{:};

%-----------------------------------------------------------------------------------------
% FLAT ELEMENTS, check if outer product with ni or iner product with ni is zero
if ~any([a1, a2,a3,a4, a5, a7, a8, a9,a11, a12, a14,a17, a18, a20, a23, a27]) || ~any([a2,a7, a8, a9, a1 + a10, a17, a18, a19, a20, a21, a22, a27, a28, a29, a30, a32])
    %-----------------------------------------------------------------------------------------
    % FLAT POINT, flat plint structure
    if((abs(ev)>1e-6).*M_punto_f)==(abs(ev)>1e-6)
        
        scatter3(a13/a10,a15/a10,a16/a10,"o",'filled');
        
        % END FLAT POINT
        %-----------------------------------------------------------------------------------------
        %-----------------------------------------------------------------------------------------
        % FLAT POINT DUAL, dual flat plint structure
    elseif ((abs(ev)>1e-6).*M_punto_f_dual)==(abs(ev)>1e-6)
        
        scatter3(a26/a23,-a25/a23,a24/a23,"o",'filled');
        
        % END FLAT POINT DUAL
        %-----------------------------------------------------------------------------------------
        %-----------------------------------------------------------------------------------------
        % FLAT LINE, line structure
    elseif((abs(ev)>1e-6).*M_recta)==(abs(ev)>1e-6)
        
        if abs(a19)>1e-6
            xp=0;
            yp= -a25/a19;
            zp= -a24/a19;
        elseif abs(a21)>1e-6
            xp=-a26/a21;
            yp= 0;
            zp=a24/a21;
        elseif abs(a4)>1e-6
            xp= -(a24*a25)/(a19*a26 - a21*a25);
            yp= -(a24*a26)/(a19*a26 - a21*a25);
            zp= 0;
        else
            xp=0;yp=0;zp=0;
        end
        t=[-100 100];
        x=xp+t*a19;
        y=yp+t*a21;
        z=zp+t*a22;
        plot3(x,y,z,'LineWidth',4)
        
        % END FLAT LINE
        %-----------------------------------------------------------------------------------------
        %-----------------------------------------------------------------------------------------
        % FLAT LINE DUAL, dual line structure
    elseif ((abs(ev)>1e-6).*M_recta_dual)==(abs(ev)>1e-6)
        
        a19= -a14;
        a21=  a12;
        a22= -a11;
        a24= -a16;
        a25=  a15;
        a26= -a13;

        if abs(a19)>1e-6
            %X cero
            xp=0;
            yp= -a25/a19;
            zp= -a24/a19;

        elseif abs(a21)>1e-6
            %Y cero
            xp=-a26/a21;
            yp= 0;
            zp=a24/a21;
        elseif abs(a4)>1e-6
            %z cero
            xp= -(a24*a25)/(a19*a26 - a21*a25);
            yp= -(a24*a26)/(a19*a26 - a21*a25);
            zp= 0;
        else
            xp=0;yp=0;zp=0;
        end
        t=[-100 100];
        x=xp+t*a19;
        y=yp+t*a21;
        z=zp+t*a22;
        plot3(x,y,z,'LineWidth',4)
        
        % END FLAT LINE DUAL
        %-----------------------------------------------------------------------------------------
        %-----------------------------------------------------------------------------------------
        % FLAT PLANE, flat plane structure
    elseif ((abs(ev)>1e-6).*M_plano)==(abs(ev)>1e-6)
        
        fimplicit3(@(x,y,z) a31 - a30*x + a29*y - a28*z,'EdgeColor','none','FaceAlpha',.5);

        % END FLAT PLANE
        %-----------------------------------------------------------------------------------------
        %-----------------------------------------------------------------------------------------
        % FLAT PLANE DUAL, dual flat plane structure
    elseif ((abs(ev)>1e-6).*M_plano_dual)==(abs(ev)>1e-6)
        
        fimplicit3(@(x,y,z) a3*x - a6 + a4*y + a5*z ,'EdgeColor','none','FaceAlpha',.5);
        
        % END FLAT PLANE DUAL
        %-----------------------------------------------------------------------------------------
    end
    % END FLAT ELEMENTS
    %-----------------------------------------------------------------------------------------


    %-----------------------------------------------------------------------------------------
    % ROUND ELEMENTS
else

    %-----------------------------------------------------------------------------------------
    % POINTS, if the inner product is zero
    if abs(a1^2 + a3^2 + a4^2 + a5^2 + a10^2 - a11^2 - a12^2 - a14^2 + a19^2 + a21^2 + a22^2 - a23^2 - a28^2 - a29^2 - a30^2 - a32^2 - 2*a2*a6 - 2*a7*a13 - 2*a8*a15 - 2*a9*a16 + 2*a17*a24 + 2*a18*a25 + 2*a20*a26 + 2*a27*a31)<1e-6

        %-----------------------------------------------------------------------------------------
        % POINT OUTER, and has outer srtucture
        if ((abs(ev)>1e-6).*M_punto)==(abs(ev)>1e-6)
            
            x=( a3/a2 );
            y=( a4/a2 );
            z=( a5/a2 );
            scatter3(x,y,z,"o",'filled')
            
            % END POINT OUTER
            %-----------------------------------------------------------------------------------------
            %-----------------------------------------------------------------------------------------
            % POINT DUAL, otherwise is a dual representation
        elseif ((abs(ev)>1e-6).*M_punto_dual)==(abs(ev)>1e-6)
            
            a2=  a27;
            a3=  a30;
            a4= -a29;
            a5=  a28;
            a6=  a31;

            x=( a3/a2 );
            y=( a4/a2 );
            z=( a5/a2 );
            scatter3(x,y,z,"o",'filled')
        end
        % END POINT DUAL
        %-----------------------------------------------------------------------------------------
        %-----------------------------------------------------------------------------------------
        % END POINTS
    else
        %-----------------------------------------------------------------------------------------
        % DIPOLE DUAL, if the MV has dual dipole structure 
        if(((abs(ev)>1e-6).*M_dipolo_dual)==(abs(ev)>1e-6)) 
          
            %undualize the coeficients
            a7=  a20;
            a8= -a18;
            a10=  a23;
            a11=  a22;
            a12= -a21;
            a13=  a26;
            a14=  a19;
            a15= -a25;
            a16=  a24;

             a7=  a20/abs(a19^2 - (a18/2 - a25)^2 - (a20/2 - a26)^2 - (a17/2 - a24)^2 + a21^2 + a22^2 - a23^2 + (a17/2 + a24)^2 + (a18/2 + a25)^2 + (a20/2 + a26)^2)^(1/2);
             a8= -a18/abs(a19^2 - (a18/2 - a25)^2 - (a20/2 - a26)^2 - (a17/2 - a24)^2 + a21^2 + a22^2 - a23^2 + (a17/2 + a24)^2 + (a18/2 + a25)^2 + (a20/2 + a26)^2)^(1/2);
             a9=  a17/abs(a19^2 - (a18/2 - a25)^2 - (a20/2 - a26)^2 - (a17/2 - a24)^2 + a21^2 + a22^2 - a23^2 + (a17/2 + a24)^2 + (a18/2 + a25)^2 + (a20/2 + a26)^2)^(1/2);
            a10=  a23/abs(a19^2 - (a18/2 - a25)^2 - (a20/2 - a26)^2 - (a17/2 - a24)^2 + a21^2 + a22^2 - a23^2 + (a17/2 + a24)^2 + (a18/2 + a25)^2 + (a20/2 + a26)^2)^(1/2);
            a11=  a22/abs(a19^2 - (a18/2 - a25)^2 - (a20/2 - a26)^2 - (a17/2 - a24)^2 + a21^2 + a22^2 - a23^2 + (a17/2 + a24)^2 + (a18/2 + a25)^2 + (a20/2 + a26)^2)^(1/2);
            a12= -a21/abs(a19^2 - (a18/2 - a25)^2 - (a20/2 - a26)^2 - (a17/2 - a24)^2 + a21^2 + a22^2 - a23^2 + (a17/2 + a24)^2 + (a18/2 + a25)^2 + (a20/2 + a26)^2)^(1/2);
            a13=  a26/abs(a19^2 - (a18/2 - a25)^2 - (a20/2 - a26)^2 - (a17/2 - a24)^2 + a21^2 + a22^2 - a23^2 + (a17/2 + a24)^2 + (a18/2 + a25)^2 + (a20/2 + a26)^2)^(1/2);
            a14= a19/abs(a19^2 - (a18/2 - a25)^2 - (a20/2 - a26)^2 - (a17/2 - a24)^2 + a21^2 + a22^2 - a23^2 + (a17/2 + a24)^2 + (a18/2 + a25)^2 + (a20/2 + a26)^2)^(1/2);
            a15= -a25/abs(a19^2 - (a18/2 - a25)^2 - (a20/2 - a26)^2 - (a17/2 - a24)^2 + a21^2 + a22^2 - a23^2 + (a17/2 + a24)^2 + (a18/2 + a25)^2 + (a20/2 + a26)^2)^(1/2);
            a16=  a24/abs(a19^2 - (a18/2 - a25)^2 - (a20/2 - a26)^2 - (a17/2 - a24)^2 + a21^2 + a22^2 - a23^2 + (a17/2 + a24)^2 + (a18/2 + a25)^2 + (a20/2 + a26)^2)^(1/2);




            %squred radius
            RR=( a10^2 - 2*a8*a15 - 2*a7*a13 - a11^2 - a12^2 - a14^2 );
            if RR>=0
                color="b";
            else
                color="r";
            end
            r=sqrt(abs(RR));
            %recover coordinates
            x1=(a7*abs(- a10^2 + a11^2 + a12^2 + a14^2 + 2*a7*a13 + 2*a8*a15 + 2*a9*a16) + a7*a10^2 - a7*a11^2 - a7*a12^2 - 2*a7^2*a13 + a7*a14^2 - 2*a8^2*a13 - 2*a9^2*a13 + 2*a7*a10*abs(- a10^2 + a11^2 + a12^2 + a14^2 + 2*a7*a13 + 2*a8*a15 + 2*a9*a16)^(1/2) + 2*a8*a11*abs(- a10^2 + a11^2 + a12^2 + a14^2 + 2*a7*a13 + 2*a8*a15 + 2*a9*a16)^(1/2) + 2*a9*a12*abs(- a10^2 + a11^2 + a12^2 + a14^2 + 2*a7*a13 + 2*a8*a15 + 2*a9*a16)^(1/2) + 2*a8*a10*a11 + 2*a9*a10*a12 - 2*a8*a12*a14 + 2*a9*a11*a14)/(2*abs(- a10^2 + a11^2 + a12^2 + a14^2 + 2*a7*a13 + 2*a8*a15 + 2*a9*a16)^(1/2)*(a7^2 + a8^2 + a9^2));
            x2=-(a8*a11^2 - a8*a10^2 - a8*abs(- a10^2 + a11^2 + a12^2 + a14^2 + 2*a7*a13 + 2*a8*a15 + 2*a9*a16) - a8*a12^2 + a8*a14^2 + 2*a7^2*a15 + 2*a8^2*a15 + 2*a9^2*a15 + 2*a7*a11*abs(- a10^2 + a11^2 + a12^2 + a14^2 + 2*a7*a13 + 2*a8*a15 + 2*a9*a16)^(1/2) - 2*a8*a10*abs(- a10^2 + a11^2 + a12^2 + a14^2 + 2*a7*a13 + 2*a8*a15 + 2*a9*a16)^(1/2) - 2*a9*a14*abs(- a10^2 + a11^2 + a12^2 + a14^2 + 2*a7*a13 + 2*a8*a15 + 2*a9*a16)^(1/2) + 2*a7*a10*a11 + 2*a9*a11*a12 + 2*a7*a12*a14 - 2*a9*a10*a14)/(2*abs(- a10^2 + a11^2 + a12^2 + a14^2 + 2*a7*a13 + 2*a8*a15 + 2*a9*a16)^(1/2)*(a7^2 + a8^2 + a9^2));
            x3=-(a9*a12^2 - a9*a10^2 - a9*a11^2 - a9*abs(- a10^2 + a11^2 + a12^2 + a14^2 + 2*a7*a13 + 2*a8*a15 + 2*a9*a16) + a9*a14^2 + 2*a7^2*a16 + 2*a8^2*a16 + 2*a9^2*a16 + 2*a7*a12*abs(- a10^2 + a11^2 + a12^2 + a14^2 + 2*a7*a13 + 2*a8*a15 + 2*a9*a16)^(1/2) - 2*a9*a10*abs(- a10^2 + a11^2 + a12^2 + a14^2 + 2*a7*a13 + 2*a8*a15 + 2*a9*a16)^(1/2) + 2*a8*a14*abs(- a10^2 + a11^2 + a12^2 + a14^2 + 2*a7*a13 + 2*a8*a15 + 2*a9*a16)^(1/2) + 2*a7*a10*a12 + 2*a8*a11*a12 - 2*a7*a11*a14 + 2*a8*a10*a14)/(2*abs(- a10^2 + a11^2 + a12^2 + a14^2 + 2*a7*a13 + 2*a8*a15 + 2*a9*a16)^(1/2)*(a7^2 + a8^2 + a9^2));

            y1=(a7*a11^2 - a7*a10^2 - a7*abs(- a10^2 + a11^2 + a12^2 + a14^2 + 2*a7*a13 + 2*a8*a15 + 2*a9*a16) + a7*a12^2 + 2*a7^2*a13 - a7*a14^2 + 2*a8^2*a13 + 2*a9^2*a13 + 2*a7*a10*abs(- a10^2 + a11^2 + a12^2 + a14^2 + 2*a7*a13 + 2*a8*a15 + 2*a9*a16)^(1/2) + 2*a8*a11*abs(- a10^2 + a11^2 + a12^2 + a14^2 + 2*a7*a13 + 2*a8*a15 + 2*a9*a16)^(1/2) + 2*a9*a12*abs(- a10^2 + a11^2 + a12^2 + a14^2 + 2*a7*a13 + 2*a8*a15 + 2*a9*a16)^(1/2) - 2*a8*a10*a11 - 2*a9*a10*a12 + 2*a8*a12*a14 - 2*a9*a11*a14)/(2*abs(- a10^2 + a11^2 + a12^2 + a14^2 + 2*a7*a13 + 2*a8*a15 + 2*a9*a16)^(1/2)*(a7^2 + a8^2 + a9^2));
            y2=(a8*a11^2 - a8*a10^2 - a8*abs(- a10^2 + a11^2 + a12^2 + a14^2 + 2*a7*a13 + 2*a8*a15 + 2*a9*a16) - a8*a12^2 + a8*a14^2 + 2*a7^2*a15 + 2*a8^2*a15 + 2*a9^2*a15 - 2*a7*a11*abs(- a10^2 + a11^2 + a12^2 + a14^2 + 2*a7*a13 + 2*a8*a15 + 2*a9*a16)^(1/2) + 2*a8*a10*abs(- a10^2 + a11^2 + a12^2 + a14^2 + 2*a7*a13 + 2*a8*a15 + 2*a9*a16)^(1/2) + 2*a9*a14*abs(- a10^2 + a11^2 + a12^2 + a14^2 + 2*a7*a13 + 2*a8*a15 + 2*a9*a16)^(1/2) + 2*a7*a10*a11 + 2*a9*a11*a12 + 2*a7*a12*a14 - 2*a9*a10*a14)/(2*abs(- a10^2 + a11^2 + a12^2 + a14^2 + 2*a7*a13 + 2*a8*a15 + 2*a9*a16)^(1/2)*(a7^2 + a8^2 + a9^2));
            y3=(a9*a12^2 - a9*a10^2 - a9*a11^2 - a9*abs(- a10^2 + a11^2 + a12^2 + a14^2 + 2*a7*a13 + 2*a8*a15 + 2*a9*a16) + a9*a14^2 + 2*a7^2*a16 + 2*a8^2*a16 + 2*a9^2*a16 - 2*a7*a12*abs(- a10^2 + a11^2 + a12^2 + a14^2 + 2*a7*a13 + 2*a8*a15 + 2*a9*a16)^(1/2) + 2*a9*a10*abs(- a10^2 + a11^2 + a12^2 + a14^2 + 2*a7*a13 + 2*a8*a15 + 2*a9*a16)^(1/2) - 2*a8*a14*abs(- a10^2 + a11^2 + a12^2 + a14^2 + 2*a7*a13 + 2*a8*a15 + 2*a9*a16)^(1/2) + 2*a7*a10*a12 + 2*a8*a11*a12 - 2*a7*a11*a14 + 2*a8*a10*a14)/(2*abs(- a10^2 + a11^2 + a12^2 + a14^2 + 2*a7*a13 + 2*a8*a15 + 2*a9*a16)^(1/2)*(a7^2 + a8^2 + a9^2));
            
            if abs(x1-y1)>1e-4 && abs(x2-y2)>1e-4 && abs(x3-y3)>1e-4 
                %And plot if it is a dipole
                dipole=true;
                plot3(x1,x2,x3,"o"+color);
                hold on
                plot3(y1,y2,y3,"o"+color);
                plot3([x1 y1],[x2 y2],[x3 y3],".-"+color);
            else
                dipole=false;
            end
            %hold off
        end
            % END DIPOLE DUAL
            %-----------------------------------------------------------------------------------------
            %-----------------------------------------------------------------------------------------
            % DIPOLE OUTER, if the structure is the one of a dipole inner and its outer
            % product with itself is zero
            
        if ((abs(ev)>1e-6).*M_dipolo)==(abs(ev)>1e-6)
            
            %Get the squared radius
            RR=( a10^2 - 2*a8*a15 - 2*a7*a13 - a11^2 - a12^2 - a14^2 );
            if RR>=0
                color="b";
            else
                color="r";
            end
            r=sqrt(abs(RR));
            %Recover coordinates
            
            x1=(a7*abs(- a10^2 + a11^2 + a12^2 + a14^2 + 2*a7*a13 + 2*a8*a15 + 2*a9*a16) + a7*a10^2 - a7*a11^2 - a7*a12^2 - 2*a7^2*a13 + a7*a14^2 - 2*a8^2*a13 - 2*a9^2*a13 + 2*a7*a10*abs(- a10^2 + a11^2 + a12^2 + a14^2 + 2*a7*a13 + 2*a8*a15 + 2*a9*a16)^(1/2) + 2*a8*a11*abs(- a10^2 + a11^2 + a12^2 + a14^2 + 2*a7*a13 + 2*a8*a15 + 2*a9*a16)^(1/2) + 2*a9*a12*abs(- a10^2 + a11^2 + a12^2 + a14^2 + 2*a7*a13 + 2*a8*a15 + 2*a9*a16)^(1/2) + 2*a8*a10*a11 + 2*a9*a10*a12 - 2*a8*a12*a14 + 2*a9*a11*a14)/(2*abs(- a10^2 + a11^2 + a12^2 + a14^2 + 2*a7*a13 + 2*a8*a15 + 2*a9*a16)^(1/2)*(a7^2 + a8^2 + a9^2));
            x2=-(a8*a11^2 - a8*a10^2 - a8*abs(- a10^2 + a11^2 + a12^2 + a14^2 + 2*a7*a13 + 2*a8*a15 + 2*a9*a16) - a8*a12^2 + a8*a14^2 + 2*a7^2*a15 + 2*a8^2*a15 + 2*a9^2*a15 + 2*a7*a11*abs(- a10^2 + a11^2 + a12^2 + a14^2 + 2*a7*a13 + 2*a8*a15 + 2*a9*a16)^(1/2) - 2*a8*a10*abs(- a10^2 + a11^2 + a12^2 + a14^2 + 2*a7*a13 + 2*a8*a15 + 2*a9*a16)^(1/2) - 2*a9*a14*abs(- a10^2 + a11^2 + a12^2 + a14^2 + 2*a7*a13 + 2*a8*a15 + 2*a9*a16)^(1/2) + 2*a7*a10*a11 + 2*a9*a11*a12 + 2*a7*a12*a14 - 2*a9*a10*a14)/(2*abs(- a10^2 + a11^2 + a12^2 + a14^2 + 2*a7*a13 + 2*a8*a15 + 2*a9*a16)^(1/2)*(a7^2 + a8^2 + a9^2));
            x3=-(a9*a12^2 - a9*a10^2 - a9*a11^2 - a9*abs(- a10^2 + a11^2 + a12^2 + a14^2 + 2*a7*a13 + 2*a8*a15 + 2*a9*a16) + a9*a14^2 + 2*a7^2*a16 + 2*a8^2*a16 + 2*a9^2*a16 + 2*a7*a12*abs(- a10^2 + a11^2 + a12^2 + a14^2 + 2*a7*a13 + 2*a8*a15 + 2*a9*a16)^(1/2) - 2*a9*a10*abs(- a10^2 + a11^2 + a12^2 + a14^2 + 2*a7*a13 + 2*a8*a15 + 2*a9*a16)^(1/2) + 2*a8*a14*abs(- a10^2 + a11^2 + a12^2 + a14^2 + 2*a7*a13 + 2*a8*a15 + 2*a9*a16)^(1/2) + 2*a7*a10*a12 + 2*a8*a11*a12 - 2*a7*a11*a14 + 2*a8*a10*a14)/(2*abs(- a10^2 + a11^2 + a12^2 + a14^2 + 2*a7*a13 + 2*a8*a15 + 2*a9*a16)^(1/2)*(a7^2 + a8^2 + a9^2));


            y1=(a7*a11^2 - a7*a10^2 - a7*abs(- a10^2 + a11^2 + a12^2 + a14^2 + 2*a7*a13 + 2*a8*a15 + 2*a9*a16) + a7*a12^2 + 2*a7^2*a13 - a7*a14^2 + 2*a8^2*a13 + 2*a9^2*a13 + 2*a7*a10*abs(- a10^2 + a11^2 + a12^2 + a14^2 + 2*a7*a13 + 2*a8*a15 + 2*a9*a16)^(1/2) + 2*a8*a11*abs(- a10^2 + a11^2 + a12^2 + a14^2 + 2*a7*a13 + 2*a8*a15 + 2*a9*a16)^(1/2) + 2*a9*a12*abs(- a10^2 + a11^2 + a12^2 + a14^2 + 2*a7*a13 + 2*a8*a15 + 2*a9*a16)^(1/2) - 2*a8*a10*a11 - 2*a9*a10*a12 + 2*a8*a12*a14 - 2*a9*a11*a14)/(2*abs(- a10^2 + a11^2 + a12^2 + a14^2 + 2*a7*a13 + 2*a8*a15 + 2*a9*a16)^(1/2)*(a7^2 + a8^2 + a9^2));
            y2=(a8*a11^2 - a8*a10^2 - a8*abs(- a10^2 + a11^2 + a12^2 + a14^2 + 2*a7*a13 + 2*a8*a15 + 2*a9*a16) - a8*a12^2 + a8*a14^2 + 2*a7^2*a15 + 2*a8^2*a15 + 2*a9^2*a15 - 2*a7*a11*abs(- a10^2 + a11^2 + a12^2 + a14^2 + 2*a7*a13 + 2*a8*a15 + 2*a9*a16)^(1/2) + 2*a8*a10*abs(- a10^2 + a11^2 + a12^2 + a14^2 + 2*a7*a13 + 2*a8*a15 + 2*a9*a16)^(1/2) + 2*a9*a14*abs(- a10^2 + a11^2 + a12^2 + a14^2 + 2*a7*a13 + 2*a8*a15 + 2*a9*a16)^(1/2) + 2*a7*a10*a11 + 2*a9*a11*a12 + 2*a7*a12*a14 - 2*a9*a10*a14)/(2*abs(- a10^2 + a11^2 + a12^2 + a14^2 + 2*a7*a13 + 2*a8*a15 + 2*a9*a16)^(1/2)*(a7^2 + a8^2 + a9^2));
            y3=(a9*a12^2 - a9*a10^2 - a9*a11^2 - a9*abs(- a10^2 + a11^2 + a12^2 + a14^2 + 2*a7*a13 + 2*a8*a15 + 2*a9*a16) + a9*a14^2 + 2*a7^2*a16 + 2*a8^2*a16 + 2*a9^2*a16 - 2*a7*a12*abs(- a10^2 + a11^2 + a12^2 + a14^2 + 2*a7*a13 + 2*a8*a15 + 2*a9*a16)^(1/2) + 2*a9*a10*abs(- a10^2 + a11^2 + a12^2 + a14^2 + 2*a7*a13 + 2*a8*a15 + 2*a9*a16)^(1/2) - 2*a8*a14*abs(- a10^2 + a11^2 + a12^2 + a14^2 + 2*a7*a13 + 2*a8*a15 + 2*a9*a16)^(1/2) + 2*a7*a10*a12 + 2*a8*a11*a12 - 2*a7*a11*a14 + 2*a8*a10*a14)/(2*abs(- a10^2 + a11^2 + a12^2 + a14^2 + 2*a7*a13 + 2*a8*a15 + 2*a9*a16)^(1/2)*(a7^2 + a8^2 + a9^2));
            if abs(x1-y1)>1e-4 && abs(x2-y2)>1e-4 && abs(x3-y3)>1e-4 
                %And plot if it is a dipole
                dipole=true;
                plot3(x1,x2,x3,"o"+color);
                hold on
                plot3(y1,y2,y3,"o"+color);
                plot3([x1 y1],[x2 y2],[x3 y3],".-"+color);
            else
                dipole=false;
            end
            %hold off
        end
            % END DIPOLE OUTER
            %-----------------------------------------------------------------------------------------
            %-----------------------------------------------------------------------------------------
            % CIRCLE OUTER, if the structure correspons to a circle in
            
        if ((abs(ev)>1e-6).*M_circulo)==(abs(ev)>1e-6) & ~dipole
            
            %Get the normal vector
            n=[a20,-a18,a17];

            %Compute its center point
            cx=( -(a17*a21 + a18*a22 - a20*a23)/(a17^2 + a18^2 + a20^2) );
            cy=( -(a18*a23 - a17*a19 + a20*a22)/(a17^2 + a18^2 + a20^2) );
            cz=( (a18*a19 + a17*a23 + a20*a21)/(a17^2 + a18^2 + a20^2) );

            %Compute its radius squared
            r=( (2*a17*a24 + 2*a18*a25 + 2*a20*a26 + a19^2 + a21^2 + a22^2 - a23^2)/(a17^2 + a18^2 + a20^2) );

            if r>0
                color="b";
            else
                color="r";
            end
            r=sqrt(abs(r));


            %Perpendicular to n
            a1=n(2)/sqrt(n(1)^2+n(2)^2);
            a2=-n(1)/sqrt(n(1)^2+n(2)^2);
            a3=0;
            if isnan(a1)
                a1=0;
                a2=-n(3)/sqrt(n(3)^2+n(2)^2);
                a3=n(2)/sqrt(n(3)^2+n(2)^2);
            end
            %Perpendicular to a and n
            B=cross([a1,a2,a3],n);
            B=B/norm(B);

            b1=B(1);
            b2=B(2);
            b3=B(3);

            %And plot
            plot3(cx+r*cos_p*a1+r*sin_p*b1, ...
                cy+r*cos_p*a2+r*sin_p*b2,...
                cz+r*cos_p*a3+r*sin_p*b3,color,'LineWidth',4)

        end
            % END CIRCLE OUTER
            %-----------------------------------------------------------------------------------------
            %-----------------------------------------------------------------------------------------
            % CIRCLE DUAL, if the structure corresponds to a dual cicle
        if ((abs(ev)>1e-6).*M_circulo_dual)==(abs(ev)>1e-6) & ~dipole

            %Undualize
            a17=  -a9;
            a18=   a8;
            a19= -a14;
            a20=  -a7;
            a21=  a12;
            a22= -a11;
            a23= -a10;
            a24= -a16;
            a25=  a15;
            a26= -a13;
            %Get the normal vector
            n=[a20,-a18,a17];

            %Compute its center point
            cx=( -(a17*a21 + a18*a22 - a20*a23)/(a17^2 + a18^2 + a20^2) );
            cy=( -(a18*a23 - a17*a19 + a20*a22)/(a17^2 + a18^2 + a20^2) );
            cz=( (a18*a19 + a17*a23 + a20*a21)/(a17^2 + a18^2 + a20^2) );

            %Compute its radius squared
            r=( (2*a17*a24 + 2*a18*a25 + 2*a20*a26 + a19^2 + a21^2 + a22^2 - a23^2)/(a17^2 + a18^2 + a20^2) );

            if r>0
                color="b";
            else
                color="r";
            end
            r=sqrt(abs(r));

            %Perpendicular to n
            a1=n(2)/sqrt(n(1)^2+n(2)^2);
            a2=-n(1)/sqrt(n(1)^2+n(2)^2);
            a3=0;

            %Perpendicular to a and n
            B=cross([a1,a2,a3],n);
            B=B/norm(B);

            b1=B(1);
            b2=B(2);
            b3=B(3);

            %And plot
            plot3(cx+r*cos_p*a1+r*sin_p*b1, ...
                cy+r*cos_p*a2+r*sin_p*b2,...
                cz+r*cos_p*a3+r*sin_p*b3,color,'LineWidth',4)
        end
            % END CIRCLE DUAL
            %-----------------------------------------------------------------------------------------
            %-----------------------------------------------------------------------------------------
            % SPHERE DUAL, the MV matches the structure of dual sphere
        if((abs(ev)>1e-6).*M_esfera_dual)==(abs(ev)>1e-6)

            %Undualize
            a27= -a2;
            a28= -a5;
            a29=  a4;
            a30= -a3;
            a31= -a6;

            %squared radius
            rsq=( (a28^2 - 2*a27*a31 + a29^2 + a30^2)/a27^2 );
            if rsq>0
                color="b";
            else
                color="r";
            end
            r=sqrt(abs(rsq));
            
            %Get the center S*ni*S
            cx=( a30/a27 );
            cy=( -a29/a27 );
            cz=( a28/a27 );
            %and plot
            h=surfl(cx+r*X,cy+r*Y,cz+r*Z);
            set(h, 'FaceAlpha', 0.5)
            shading interp
        end    
            % END SPHERE DUAL
            %-----------------------------------------------------------------------------------------
            %-----------------------------------------------------------------------------------------
            % SPHERE , the MV matches the structure of sphere
        if((abs(ev)>1e-6).*M_esfera)==(abs(ev)>1e-6)

            rsq=( (a28^2 - 2*a27*a31 + a29^2 + a30^2)/a27^2 );
            if rsq>0
                color="b";
            else
                color="r";
            end
            r=sqrt(abs(rsq));
 
            %Get the center S*ni*S
            cx=( a30/a27 );
            cy=( -a29/a27 );
            cz=( a28/a27 );
            %and plot
            h=surfl(cx+r*X,cy+r*Y,cz+r*Z);
            set(h, 'FaceAlpha', 0.5)
            shading interp
        
            % END SPHERE
            %-----------------------------------------------------------------------------------------
        end
    end
end
if tf
    hold on
end

end
