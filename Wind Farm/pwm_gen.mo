model pwm_gen
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
 
/* 
 parameter Real Vtri = "peak-to-peak carrier wave voltage";
 parameter Real Kpwm =
 */
 Complex d "duty cycle";
 Complex vm "modulation signal";
equation
d = dd +j*dq;
d = Kpwm*vm;
vm = vmd +j*vmq;

dd = Kpwm*vmd;
dq = Kpwm*vmq;

end pwm_gen;
