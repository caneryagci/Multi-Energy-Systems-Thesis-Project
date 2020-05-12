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
  parameter Real s3 = 1.606e-5;
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
  Real Ucell;
  Real i;
  //Cell voltage
  //Modelica.Blocks.Interfaces.RealOutput y;
  //Modelica.Blocks.Interfaces.RealInput u1;
  Modelica.Blocks.Interfaces.RealOutput y annotation(
    Placement(visible = true, transformation(origin = {56, 56}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {102, 68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput PotRef annotation(
    Placement(visible = true, transformation(origin = {-86, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-86, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Electrical.Analog.Interfaces.NegativePin n annotation(
    Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Interfaces.PositivePin p annotation(
    Placement(visible = true, transformation(origin = {-102, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-102, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  Ucell*nc = p.v - n.v;
  0 = p.i + n.i;
  i = p.i;

  //PotRef = u1;
  Ucell = Urev + (r1 + r2 * T) * (PotRef / (Ucell * nc)) / A + (s1 + s2 * T + s3 * T * T) * Modelica.Math.log10((t1 + t2 / T + t3 / T / T) * (PotRef / (Ucell * nc)) / A + 1);
  PotRef = i * Ucell*nc;
  fH2 = nf * PotRef / (Ucell * 2 * F);
  y = fH2;
  
  annotation(
    Icon(graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}), Text(origin = {107, 80}, extent = {{-19, 6}, {11, -2}}, textString = "fH2"), Text(origin = {-88, 82}, extent = {{-14, 6}, {10, -2}}, textString = "Pdcref")}, coordinateSystem(initialScale = 0.1)));
end Electrolyser2;
