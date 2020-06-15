within Hydrogen;

model Electrolyser2
  parameter Real F = 96485;
  //[C mol^-1]
  parameter Real Urev = 1.229;
  //[V]
  parameter Real r1 = 7.331e-5;
  //[ohm m^2]
  parameter Real r2 = -1.107e-7;
  //[ohm m^2 C-1]
  parameter Real r3 = 0;
  parameter Real s1 = 1.586e-1;
  //[V]
  parameter Real s2 = 1.378e-3;
  //[V C-1]
  parameter Real s3 = -1.606e-5;
  //[V C-2]
  parameter Real t1 = 1.599e-2;
  //[m^2 A^-1]
  parameter Real t2 = -1.302;
  //[m^2 A^-1 C^-1]
  parameter Real t3 = 4.213e2;
  //[m^2 A^-1 C^-2]
  parameter Real A = 0.25;
  //[m^2]
  parameter Real nf = 1;
  //Faraday Efficient
  parameter Real nc = 1;
  //number of series cells
  parameter Real T = 40;
  //Real PotRef;
  //Pdc_cell reference
  Real fH2;
  Real Ucell(start = V_0);
  Real i;
  
 
    
  //Cell voltage
  //Modelica.Blocks.Interfaces.RealOutput y;
  //Modelica.Blocks.Interfaces.RealInput u1;
  Modelica.Blocks.Interfaces.RealOutput nH2 annotation(
    Placement(visible = true, transformation(origin = {92, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {107, 59}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput Porder annotation(
    Placement(visible = true, transformation(origin = {-100, 32}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-86, 44}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  protected
    parameter Real V_0 = 1.3 "Voltage magnitude" annotation(Dialog(group = "Power flow data"));

equation
  //PotRef = u1;
  Ucell = Urev + (r1 + r2 * T) * (Porder / (Ucell * nc)) / A + (s1 + s2 * T + s3 * T * T) * Modelica.Math.log10((t1 + t2 / T + t3 / T / T) * (Porder / (Ucell * nc)) / A + 1);
  Porder = i * Ucell*nc;
  fH2 = nf * Porder / (Ucell * 2 * F);
  nH2 = fH2;
  
  annotation(
    Icon(graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}), Text(origin = {71, 72}, extent = {{-19, 6}, {15, -26}}, textString = "nH2"), Text(origin = {-74, 80}, extent = {{-14, 6}, {14, -24}}, textString = "Porder")}, coordinateSystem(initialScale = 0.1)));
end Electrolyser2;
