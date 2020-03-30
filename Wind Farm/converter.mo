model converter
  import Modelica.ComplexMath;
  import Modelica.Constants.pi;
  constant Complex j = Complex(0, 1) "Imaginary unit";
    OpenIPSL.Interfaces.PwPin pinI annotation (Placement(
      visible=true,
      transformation(
        origin={-158.307,1.6927},
        extent={{-10, -10}, {10, 10}},
        rotation=0),
      iconTransformation(
        origin={90, 0},
        extent={{-10, -10}, {10, 10}},
        rotation=0)));
     OpenIPSL.Interfaces.PwPin pin0 annotation (Placement(
      visible=true,
      transformation(
        origin={-158.307,1.6927},
        extent={{-10, -10}, {10, 10}},
        rotation=0),
      iconTransformation(
        origin={90, 0},
        extent={{-10, -10}, {10, 10}},
        rotation=0)));
 
  //parameter Real L=;
  //parameter Real R=;
  //parameter Real C=;
  
  Real P;
  Real Q;
  
  Complex Vp;
  Complex V;
  Complex I;
  
equation
vq = pin0.vr;
vd = -pin0.vi;
iq = -pin0.ii;
id = -pin0.ir;
vpd = pinI.vr;
vpq = pinI.vi;

Vp = Vpd + j*Vpq;
V = Vd + j*Vq;
I = id + j*iq;

Vpd = -L*der(id) - R*id + w*L*iq+Vd;
Vpq = -L*der(iq) -R*iq - w-L-id + vq;

idc = 3/2*(1/vdc)*(vd*id+vq*iq);
C*der(vdc)= idc-(P/vdc);
3/2*(vd*id+vq*iq) = vdc*idc;

Vd = vdc*Dd;
Vq = vdc*Dd;
 
P_comp =Vp*Complex(I.re, -I.im);
Q_comp =Vp*Complex(I.re, -I.im);
P = 3/2*P_comp.re;
Q = 3/2*Qcomp.im;
end converter;
