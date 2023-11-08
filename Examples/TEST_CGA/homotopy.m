%% Un robot super simple en CGA
clc
clear all
CGA(2)

%%
%un punto en el origen
P0=push(0);

% una barra de longitud 2, genera un rotor de translación, el ángulo 0 está
% en la vertical
R_barra=make_translation(2,push(e2));

%y una rotación de la base de la barra 
syms teta
R_teta=make_rotation(teta/2,e12);

%El rotor total
RR=R_barra*R_teta;

%Movemos el punto y nos sale la cinemática

P_destino=simplify(RR.reverse*P0*RR)

%% hacemos una homotopia de newton con el parámetro t

syms t
%El punto de destino deseado será 2*e2, 90 grados para teta
Punto_deseado=push(-2*e1);
%usamos la notación normal de homotopias
F_x=P_destino-Punto_deseado;
% Declaramos la homotopia usando Newton
H=simplify(F_x-(1-t)*F_x.subs(teta,0))
% Veamos el valor pata t=0
H.subs(t,0) % Sabemos que la solución es teta=0
H.subs(t,1) % Queremos esta solución

%% Vamos a la solución, RUPESTRE

% Lazo 1, movernos un poco hacia t=1 
% Lazo 2, Newton Rapson para el valor de t

% Derivada respecto de teta
DH_x=MV(diff(H.vector,teta),H.Lsignature,H.REPR);
%Inversa de la derivada
DH_x_inv=simplify(DH_x^-1);


PRODUCT=simplify(DH_x_inv.*H);
NEWTON=matlabFunction(PRODUCT(1));

%lazo 1
x_k=0;
delta=0.01;
for param=0:delta:1
    %Proyección
    %x_k=x_k+delta*(2*e1+2*e2);
    for k=0:2
        %Corrección
        x_k=x_k-NEWTON(param,x_k);
    end
end
x_k
%% Comprobamos
F_x.subs(teta,x_k)

%% Ahora la resolvemos como ecuación diferencial, lo mismo que antes pero muuuuucho mas molon
DF_x=MV(diff(F_x.vector,teta),F_x.Lsignature,F_x.REPR);
DF_x_inv=simplify(DF_x^-1);
VDF_x_inv=DF_x_inv.vector;
VV=matlabFunction(VDF_x_inv)
F_a=F_x.subs(teta,0);

func=@(x)DF_x_inv.subs(teta,x)
RK4( @(x)MV(VV(vpa(x(1) )),[3,1,0],"CGA").*F_x.subs(teta,vpa(x(1) )),F_a,0.02,50)