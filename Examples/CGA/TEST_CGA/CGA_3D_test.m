close all
clear all
CGA(3,"verbose")
%%
% Generate four points witha random component
off=1*rand*e1+1*rand*e2+1*rand*e3;
p1=push(e1+off);
p2=push(e2+off);
p3=push(e3+off);
p4=push(-e1+off);

% The basic round structures
point=p1;
dipole=point.^p2;
circle=dipole.^p3;
sphere=circle.^p4;
point_f=p1.^ni;
line=p1.^p2.^ni;
plane=p1.^p2.^p3.^ni;
%%
clc
point
point.plot()
point.info()
%%
point.dual
point.dual.plot()
point.dual.info()
%%
dipole
dipole.plot()
dipole.info()
%%
dipole.dual
dipole.dual.plot()
dipole.dual.info()
%%
circle
circle.plot()
circle.info()
%%
circle.dual
circle.dual.plot()
circle.dual.info()
%%
sphere
sphere.plot()
sphere.info()
%%
sphere.dual
sphere.dual.plot()
sphere.dual.info()




%% FLATS
flat_point=point.^ni
flat_point.plot()
flat_point.info()
%%
flat_point_dual=flat_point.dual
flat_point_dual.plot()
flat_point_dual.info()
%%

line=dipole.^ni
line.plot()
line.info()
%%
dual_line=line.dual
dual_line.plot()
dual_line.info()
%%
plane=circle.^ni
plane.plot()
plane.info()
%%
% FALLA
dual_plane=plane.dual
dual_plane.plot()
dual_plane.info()
