%MATLAB ver R2018b used
%All work is clearly named
%Only x1, x2 & x3 are the values of x matrix
%Bus 1 is slack bus (Vteta)
%Bus 2 is Load bus (PQ) --> Unknown: V2 & teta2
%Bus 3 is Generator bus (PV) ---> Unknown: teta3
%%
syms V2 teta2 teta3
Y12 = 1/(0.02+0.04j)
Y13 = 1/(0.01+0.03j)
Y23 = 1/(0.0125+0.025j)
Ybus = [Y12+Y13, -Y12, -Y13; -Y12, Y12+Y23, -Y23; -Y12, -Y23, Y13+Y23]
V1 = 1.05
V3 = 1.04
P2= abs(V2)*( abs(V1)*(real(Ybus(2,1))*cos(teta2)+imag(Ybus(2,1))*sin(teta2))+abs(V2)*(real(Ybus(2,2)))+ abs(V3)*((real(Ybus(2,3))*cos(teta2-teta3)+imag(Ybus(2,3)*sin(teta2-teta3)))))+4.0
P3= abs(V3)*( abs(V1)*(real(Ybus(3,1))*cos(teta3)+imag(Ybus(3,1))*sin(teta3))+abs(V3)*(real(Ybus(3,3)))+ abs(V2)*((real(Ybus(3,2))*cos(teta3-teta2)+imag(Ybus(3,2)*sin(teta3-teta2)))))-2.0
Q2= abs(V2)*( abs(V1)*(real(Ybus(2,1))*sin(teta2)-imag(Ybus(2,1))*cos(teta2))-abs(V2)*(imag(Ybus(2,2)))+ abs(V3)*((real(Ybus(2,3))*sin(teta2-teta3)-imag(Ybus(2,3)*cos(teta2-teta3)))))+2.5
Q3= abs(V3)*( abs(V1)*(real(Ybus(3,1))*sin(teta3)-imag(Ybus(3,1))*cos(teta3))-abs(V3)*(imag(Ybus(3,3)))+ abs(V2)*((real(Ybus(3,2))*sin(teta3-teta2)-imag(Ybus(3,2)*cos(teta3-teta2)))))+0
%%
%Sigma notation additions did not work because of the varialble use.
%Here, matrix based additions were used, but MATLab is not responding.
%P(i,1) = symsum(P(i,1) + abs(V(i,1))*abs(V(k,1))*(real(Ybus(i,k))*cos(teta(i,1)-teta(k,1))+imag(Ybus(i,k))*sin(teta(i,1)-teta(k,1))),k,1,3)
%(or)
%for i=2:3
% for k=1:3
% sym( P(i,1) ) = P(i,1) + abs(V(i,1))*abs(V(k,1))*(real(Ybus(i,k))*cos(teta(i,1)-teta(k,1))+imag(Ybus(i,k))*sin(teta(i,1)-teta(k,1)))
% end
%end
%Therefore, the manual typing is used.
%%
fx = [P2;P3;Q2]
Jx = jacobian([P2, P3, Q2], [teta2, teta3, V2])
val_epsilon = [0.001;0.001; 0.001];
epsilon = [1;1;1];
itter = 0;
x1 =0;
x2 =0;
