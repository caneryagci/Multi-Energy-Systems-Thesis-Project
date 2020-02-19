model FirstOrderExperiment "Defining experimental conditions"
  Real x "State variable";
initial equation
  x = 0 "Used before simulation to compute initial values";
equation
  der(x) = 1 "Drives value of x toward 1.0";
annotation(
    Icon(graphics = {Ellipse(origin = {-1, -3}, extent = {{-63, 51}, {63, -51}}, endAngle = 360), Rectangle(origin = {-4, -4}, extent = {{-40, 30}, {38, -28}})}));end FirstOrderExperiment;
