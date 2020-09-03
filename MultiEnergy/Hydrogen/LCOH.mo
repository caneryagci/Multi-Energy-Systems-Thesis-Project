within Hydrogen;

model LCOH
  Modelica.Blocks.Interfaces.RealInput efficiency annotation(
    Placement(visible = true, transformation(origin = {-94, 36}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-80, -40}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput cost annotation(
    Placement(visible = true, transformation(origin = {50, 26}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {113, 73}, extent = {{-13, -13}, {13, 13}}, rotation = 0)));
parameter Real capex = 200 "EUR/kW";
parameter Real opex = 8 "EUR/kW";
parameter Real lifetime = 20 "years";
parameter Real carbon_price= 1 "EUR/gCO2";
parameter Real carbon_emission_rate = 0.00361"gCO2/kW";
Real cost1;
protected
parameter Real carbon_penalty = carbon_price*carbon_emission_rate;

equation
cost1 = (((capex + opex)/lifetime) + carbon_penalty)/efficiency;
cost = -(1/cost1)*196;
annotation(
    Icon(graphics = {Text(origin = {-42, -58}, extent = {{-38, 20}, {54, -32}}, textString = "Efficiency"), Text(origin = {54, 81}, extent = {{-18, 19}, {36, -39}}, textString = "Cost"), Rectangle(extent = {{-100, 100}, {100, -100}}), Text(origin = {1, 9}, lineColor = {0, 0, 255}, extent = {{-41, 29}, {41, -29}}, textString = "LCOH")}));
end LCOH;
