within Hydrogen;

model first_order
  import Modelica.Blocks.Types.Init;
  parameter Real k=1 "Gain";
  parameter Real T(start=1) "Time Constant";
  parameter Modelica.Blocks.Types.Init initType=Modelica.Blocks.Types.Init.NoInit
    "Type of initialization (1: no init, 2: steady state, 3/4: initial output)" annotation(Evaluate=true,
      Dialog(group="Initialization"));
  parameter Real y_start=0 "Initial or guess value of output (= state)"
    annotation (Dialog(group="Initialization"));

  extends Modelica.Blocks.Interfaces.SISO(y(start=y_start));

initial equation
  if initType == Init.SteadyState then
    der(y) = 0;
  elseif initType == Init.InitialState or initType == Init.InitialOutput then
    y = y_start;
  end if;
equation
  der(y) = (k*u - y)/T;
  annotation (
    Documentation(info="<html>
<p>
This blocks defines the transfer function between the input u
and the output y as <em>first order</em> system:
</p>
<pre>
             k
   y = ------------ * u
          T * s + 1
</pre>
<p>
If you would like to be able to change easily between different
transfer functions (FirstOrder, SecondOrder, ... ) by changing
parameters, use the general block <strong>TransferFunction</strong> instead
and model a first order SISO system with parameters<br>
b = {k}, a = {T, 1}.
</p>
<pre>
Example:
 parameter: k = 0.3, T = 0.4
 results in:
           0.3
    y = ----------- * u
        0.4 s + 1.0
</pre>

</html>"), Icon(
  coordinateSystem(preserveAspectRatio=true,
      extent={{-100.0,-100.0},{100.0,100.0}}),
    graphics={
  Line(points={{-80.0,78.0},{-80.0,-90.0}},
    color={192,192,192}),
  Polygon(lineColor={192,192,192},
    fillColor={192,192,192},
    fillPattern=FillPattern.Solid,
    points={{-80.0,90.0},{-88.0,68.0},{-72.0,68.0},{-80.0,90.0}}),
  Line(points={{-90.0,-80.0},{82.0,-80.0}},
    color={192,192,192}),
  Polygon(lineColor={192,192,192},
    fillColor={192,192,192},
    fillPattern=FillPattern.Solid,
    points={{90.0,-80.0},{68.0,-72.0},{68.0,-88.0},{90.0,-80.0}}),
  Line(origin = {-26.667,6.667},
      points = {{106.667,43.333},{-13.333,29.333},{-53.333,-86.667}},
      color = {0,0,127},
      smooth = Smooth.Bezier),
  Text(lineColor={192,192,192},
    extent={{0.0,-60.0},{60.0,0.0}},
    textString="PT1"),
  Text(extent={{-150.0,-150.0},{150.0,-110.0}},
    textString="T=%T")}),
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-48,52},{50,8}},
          textString="k"),
        Text(
          extent={{-54,-6},{56,-56}},
          textString="T s + 1"),
        Line(points={{-50,0},{50,0}}),
        Rectangle(extent={{-60,60},{60,-60}}, lineColor={0,0,255}),
        Line(points={{-100,0},{-60,0}}, color={0,0,255}),
        Line(points={{60,0},{100,0}}, color={0,0,255})}));


end first_order;
