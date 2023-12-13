function s=get_info3(element)

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



ev=element.vector;
pCell = num2cell(ev);
[a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20, a21, a22, a23, a24, a25, a26, a27, a28, a29, a30, a31, a32]=pCell{:};

%-----------------------------------------------------------------------------------------
% FLAT ELEMENTS, check if outer product with ni or iner product with ni is zero
if ~any([a1, a2,a3,a4, a5, a7, a8, a9,a11, a12, a14,a17, a18, a20, a23, a27]) || ~any([a2,a7, a8, a9, a1 + a10, a17, a18, a19, a20, a21, a22, a27, a28, a29, a30, a32])
    %-----------------------------------------------------------------------------------------
    % FLAT POINT, flat plint structure
    if((abs(ev)>1e-6).*M_punto_f)==(abs(ev)>1e-6)
        
        s.Algebra="CGA3";
            s.Type="Flat";
            s.Representation="Outer";
            s.Object="Point";
            s.x=-a13/a10;
            s.y=a15/a10;
            s.z=a16/a10;
            s.P=MV([0 1 a13/a10 a15/a10 a16/a10 0.5*(a13/a10)^2+0.5*(a15/a10)^2+0.5*(a16/a10)^2 [7:32]*0 ],[4,1,0],"CGA");


        
        % END FLAT POINT
        %-----------------------------------------------------------------------------------------
        %-----------------------------------------------------------------------------------------
        % FLAT POINT DUAL, dual flat plint structure
    elseif ((abs(ev)>1e-6).*M_punto_f_dual)==(abs(ev)>1e-6)
        
        s.Algebra="CGA3";
            s.Type="Flat";
            s.Representation="Dual";;
            s.Object="Point";
            s.x=-a13/a10;
            s.y=a15/a10;
            s.z=a16/a10;
            s.P=MV([0 1 a26/a23 -a25/a23 a24/a23 0.5*(a26/a23)^2+0.5*(-a25/a23)^2+0.5*(a24/a23)^2 [7:32]*0 ],[4,1,0],"CGA");
       
        
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


        s.Algebra="CGA3";
            s.Type="Flat";
            s.Representation="Outer";
            s.Object="Line";
            s.structure="p+t*v";
            s.p=MV([0 1 xp yp zp 0.5*xp^2+0.5*yp^2+0.5*zp^2 [7:32]*0],[4,1,0],"CGA");
            s.p_x=xp;
            s.p_y=yp;
            s.p_z=zp;
            s.v=MV([0 0 a3 a4 a5 1 [7:32]*0],[4,1,0],"CGA");
            s.v_x=a19;
            s.v_y=a21;
            s.v_z=a22;

        
        
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
        s.Algebra="CGA3";
            s.Type="Flat";
            s.Representation="Dual";
            s.Object="Line";
            s.structure="p+t*v";
            s.p=MV([0 1 xp yp zp 0.5*xp^2+0.5*yp^2+0.5*zp^2 [7:32]*0],[4,1,0],"CGA");
            s.p_x=xp;
            s.p_y=yp;
            s.p_z=zp;
            s.v=MV([0 0 a3 a4 a5 1 [7:32]*0],[4,1,0],"CGA");
            s.v_x=a19;
            s.v_y=a21;
            s.v_z=a22;
        
        % END FLAT LINE DUAL
        %-----------------------------------------------------------------------------------------
        %-----------------------------------------------------------------------------------------
        % FLAT PLANE, flat plane structure
    elseif ((abs(ev)>1e-6).*M_plano)==(abs(ev)>1e-6)

        s.Algebra="CGA3";
            s.Type="Flat";
            s.Representation="Outer";
            s.Object="Plane";
            s.structure="n_1*x+n_2*y+n3*z+d=0";
            s.d=a31;
            s.n=MV([0 0 -a30 a29 a28 1 [7:32]*0],[4,1,0],"CGA");
        
        

        % END FLAT PLANE
        %-----------------------------------------------------------------------------------------
        %-----------------------------------------------------------------------------------------
        % FLAT PLANE DUAL, dual flat plane structure
    elseif ((abs(ev)>1e-6).*M_plano_dual)==(abs(ev)>1e-6)
        
        s.Algebra="CGA3";
            s.Type="Flat";
            s.Representation="Dual";
            s.Object="Plane";
            s.structure="n_1*x+n_2*y+n3*z+d=0";
            s.d=a6;
            s.n=MV([0 0 a3 a4 a5 1 [7:32]*0],[4,1,0],"CGA");

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
            s.Algebra="CGA3";
                s.Type="Round";
                s.Representation="Outer";
                s.Object="Point";
                s.x=x;
                s.y=y;
                s.z=z;
            
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
            s.Algebra="CGA3";
                s.Type="Round";
                s.Representation="Dual";
                s.Object="Point";
                s.x=x;
                s.y=y;
                s.z=z;
        end
        % END POINT DUAL
        %-----------------------------------------------------------------------------------------
        %-----------------------------------------------------------------------------------------
        % END POINTS
    else
        %-----------------------------------------------------------------------------------------
        % DIPOLE DUAL, if the MV has dual dipole structure
        if((abs(ev)>1e-6).*M_dipolo_dual)==(abs(ev)>1e-6)

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

            

            s.DIPOLE.Algebra="CGA3";
            s.DIPOLE.Type="Round";
            s.DIPOLE.Representation="Dual";
            if color=="b"
                s.DIPOLE.Object="Real Dipole";
            else
                s.DIPOLE.Object="Imaginary Dipole";
            end
            s.DIPOLE.x1=x1;
            s.DIPOLE.y1=x2;
            s.DIPOLE.z1=x3;
            s.DIPOLE.P1=MV([0 1 x1 x2 x3 0.5*x1^2+0.5*x2^2+0.5*x3^2 [7:32]*0],[4,1,0],"CGA");
            s.DIPOLE.x2=y1;
            s.DIPOLE.y2=y2;
            s.DIPOLE.z2=y3;
            s.DIPOLE.P2=MV([0 1 y1 y2 y3 0.5*y1^2+0.5*y2^2+0.5*y3^2 [7:32]*0],[4,1,0],"CGA");
        end
            % END DIPOLE DUAL
            %-----------------------------------------------------------------------------------------
            %-----------------------------------------------------------------------------------------
            % DIPOLE OUTER, if the structure is the one of a dipole in
            % outer product representation
            
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

            

            s.DIPOLE.Algebra="CGA3";
            s.DIPOLE.Type="Round";
            s.DIPOLE.Representation="Outer";
            if color=="b"
                s.DIPOLE.Object="Real Dipole";
            else
                s.DIPOLE.Object="Imaginary Dipole";
            end
            s.DIPOLE.x1=x1;
            s.DIPOLE.y1=x2;
            s.DIPOLE.z1=x3;
            s.DIPOLE.P1=MV([0 1 x1 x2 x3 0.5*x1^2+0.5*x2^2+0.5*x3^2 [7:32]*0],[4,1,0],"CGA");
            s.DIPOLE.x2=y1;
            s.DIPOLE.y2=y2;
            s.DIPOLE.z2=y3;
            s.DIPOLE.P2=MV([0 1 y1 y2 y3 0.5*y1^2+0.5*y2^2+0.5*y3^2 [7:32]*0],[4,1,0],"CGA");
        end
            % END DIPOLE OUTER
            %-----------------------------------------------------------------------------------------
            %-----------------------------------------------------------------------------------------
            % CIRCLE OUTER, if the structure correspons to a circle in
            
        if ((abs(ev)>1e-6).*M_circulo)==(abs(ev)>1e-6)
            
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
            
            s.CIRCLE.Algebra="CGA3";
            s.CIRCLE.Type="Round";
            s.CIRCLE.Representation="Outer";
            if color=="b"
                s.CIRCLE.Object="Real Circle";
            else
                s.CIRCLE.Object="Imaginary Circle";
            end
            s.CIRCLE.radius=r;
            s.CIRCLE.xc=cx;
            s.CIRCLE.yc=cy;
            s.CIRCLE.zc=cz;
            s.CIRCLE.C=MV([0 1 cx cy cz 0.5*cx^2+0.5*cy^2+0.5*cz^2 [7:32]*0],[4,1,0],"CGA");
            s.CIRCLE.nx=n(1);
            s.CIRCLE.ny=n(2);
            s.CIRCLE.nz=n(3);
            s.CIRCLE.n=MV([0 0 n(1) n(2) n(3) 1 [7:32]*0],[4,1,0],"CGA");
        end

            % END CIRCLE OUTER
            %-----------------------------------------------------------------------------------------
            %-----------------------------------------------------------------------------------------
            % CIRCLE DUAL, if the structure corresponds to a dual cicle
        if ((abs(ev)>1e-6).*M_circulo_dual)==(abs(ev)>1e-6)

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

            s.CIRCLE.Algebra="CGA3";
            s.CIRCLE.Type="Round";
            s.CIRCLE.Representation="Dual";
            if color=="b"
                s.CIRCLE.Object="Real Circle";
            else
                s.CIRCLE.Object="Imaginary Circle";
            end
            s.CIRCLE.radius=r;
            s.CIRCLE.xc=cx;
            s.CIRCLE.yc=cy;
            s.CIRCLE.zc=cz;
            s.CIRCLE.C=MV([0 1 cx cy cz 0.5*cx^2+0.5*cy^2+0.5*cz^2 [7:32]*0],[4,1,0],"CGA");
            s.CIRCLE.nx=n(1);
            s.CIRCLE.ny=n(2);
            s.CIRCLE.nz=n(3);
            s.CIRCLE.n=MV([0 0 n(1) n(2) n(3) 1 [7:32]*0],[4,1,0],"CGA");
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
            
            s.Algebra="CGA3";
            s.Type="Round";
            s.Representation="Dual";;
            if color=="b"
                s.Object="Real Sphere";
            else
                s.Object="Imaginary Sphere";
            end
            s.radius=r;
            s.xc=cx;
            s.yc=cy;
            s.zc=cz;
            s.C=MV([0 1 cx cy cz 0.5*cx^2+0.5*cy^2+0.5*cz^2 [7:32]*0],[4,1,0],"CGA");
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
            
            s.Algebra="CGA3";
            s.Type="Round";
            s.Representation="Outer";;
            if color=="b"
                s.Object="Real Sphere";
            else
                s.Object="Imaginary Sphere";
            end
            s.radius=r;
            s.xc=cx;
            s.yc=cy;
            s.zc=cz;
            s.C=MV([0 1 cx cy cz 0.5*cx^2+0.5*cy^2+0.5*cz^2 [7:32]*0],[4,1,0],"CGA");
        end
            % END SPHERE
            %-----------------------------------------------------------------------------------------
        end
    end
end
