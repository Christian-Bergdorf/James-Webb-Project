clc
clear
close all

Rs = 696000;
Re = 6378;
Rse = 150*10^6;
z1 = 275.59;
z2 = 10000;
L2 = 151.5*10^6;
ue = 398600;
us = 132.712*10^9;
ge = 9.81/1000;
gs = 275/1000;
mPL = 5000;
m0_1 = 13631243.5+mPL;
m0_2 = 2745862+mPL;
Isp_1 = 335;
Isp_2 = 440;
T_1 = 20015.37;
T_2 = 1078.73;
eL = L2-Rse;
e1_2 = 0;
e1 = 0;

%1st hohmann transfer to altitude 10,000km
Ra = z1+Re;
Rc = Ra;
Rb = z2+ Re;
h1 = sqrt(Ra*ue*(1+e1));
Va1 = h1/Ra;
e2 = (Rb-Ra)/(Rb+Ra);
% h2 = sqrt(Ra*ue*(1+e2));
h2 = sqrt(2*us*e2);
Va2 = h2/Ra;
deltaVa_1 = Va2-Va1;
Vb2 = h2/Rb;
Vb3 = sqrt(ue/Rb);
deltaVb_1 = Vb3-Vb2;

deltaV_1 = deltaVa_1+deltaVb_1

% t1 = pi/ue^2*(h2/(sqrt(1-e2^2)))^3;
t1 = pi/sqrt(ue)*((Ra+Rb)/2)^(3/2);
t1min = t1/60
deltam1 = m0_2 * (1-exp(-deltaV_1/(Isp_2*ge)));

%2nd hohmann transfer to lagrange point
RA2 = z2+Re;
RC2 = RA2;
RB2 = eL+Re;
h1_2 = sqrt(RA2*ue*(1+e1_2));
% h1_2 = sqrt(2*us*e1_2);
VA1_2 = h1_2/RA2;
e2_2 = (RB2-RA2)/(RB2+RA2);
% h2_2 = sqrt(RA2*ue*(1+e2_2));
h2_2 = sqrt(2*us*e2_2);
VA2_2 = h2_2/RA2;
deltaVA2 = VA2_2-VA1_2;
VB2_2 = h2_2/RB2;
VB3_2 = sqrt(ue/RB2);
deltaVB2 = VB3_2-VB2_2;

deltaV_2 = deltaVB2+deltaVA2

% t2 = pi/ue^2*(h2_2/(sqrt(1-e2_2^2)))^3;
t2 = pi/sqrt(ue)*((RA2+RB2)/2)^(3/2);
t2min = t2/60;
t2hrs = t2min/60;
t2days = t2hrs/24
deltam2 = mPL*(1-exp(-deltaV_2/(Isp_2*ge)));

deltam = deltam1+deltam2

%Cost analysis
NG = 2.5*10^9;
%Cost $2.86/DGE
LNG_cost = 2.86;
%Cost $0.20/kg
LOX_cost = 0.20;
%ratio for Oxidizer vs fuel is 6:1 respectively
LNG_mass = (deltam/7)*1;
LOX_mass = (deltam/7)*6;
%conversion of LNG from kg to DGE
LNG_massDGE = LNG_mass/2.748;
Fuel_cost = LNG_massDGE*LNG_cost
Ox_cost = LOX_mass*LOX_cost
Cost_prop = Fuel_cost+Ox_cost

%cost per kg of payload
LNG_mass_payload = (mPL/7)*1;
LOX_mass_payload = (mPL/7)*6;
%conversion of LNG from kg to DGE
LNG_mass_payloadDGE = LNG_mass_payload/2.748;
Fuel_cost_payload = LNG_mass_payloadDGE*LNG_cost;
Ox_cost_payload = LOX_mass_payload*LOX_cost;
cost_per_kg = Fuel_cost_payload+Ox_cost_payload
telescope = 110231100;
Total_cost = NG+Cost_prop+telescope



