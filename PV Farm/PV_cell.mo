model PV_cell
  extends Modelica.Electrical.Analog.Interfaces.OnePort;
  parameter Real q=1.6e-19; //[C]
  parameter Real Ac=1.6;
  parameter Real K=1.3805e-23;//[Nm/K]
  parameter Real K1=5.532e-3;//[A/oC]
  parameter Real Ior=1.0647e-6;//[A]
  parameter Real Tref=303;//[K]
  parameter Real Eg=1.1;//[V]
  parameter Real Isc=8.51;//[A]
  parameter Real Rspv=0.01;
  parameter Real Tpv=273+25;
  parameter Real Irs=Ior*(Tpv/Tref)^3*exp(q*Eg*(1/Tref-1/Tpv)/K/Ac);
  parameter Integer Np=1; //# paralel connected panel
  parameter Integer Ns=60;//# series connected panel
  Real Iph; //insolation current
  Real exponent;
  Real Ipv;
  Real Vpv;
  Real lambdaph;
  Modelica.Blocks.Interfaces.RealInput u annotation(
    Placement(visible = true, transformation(origin = {0, -104}, extent = {{-20, -20}, {20, 20}}, rotation = 90), iconTransformation(origin = {0, -104}, extent = {{-20, -20}, {20, 20}}, rotation = 90)));

  
equation
  lambdaph=u; //insolation
  Iph=(Isc+K1*(Tpv-Tref))-lambdaph/100;
  Ipv+i=0;
  Vpv=v;
  Ipv-Np*Iph+Np*Irs*(exp(exponent)-1)=0;
  exponent=q*(Vpv/Ns+Ipv*Rspv/Np)/(K*Ac*Tpv);
  
annotation(
    uses(Modelica(version = "3.2.3")));end PV_cell;
