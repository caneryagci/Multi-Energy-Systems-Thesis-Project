within Wind;

model Windfarm5

  import Modelica.Constants.pi;
  import Modelica.Constants.eps;
  parameter Real _V0=PCC_voltage.k "Terminal Voltage from Power Flow";
  parameter Real _Ang0=0.421202138172605 "Terminal Angle from Power Flow";
  parameter Real _P0=1.62 "Active Power from Power Flow";
  parameter Real _Q0=-0.370492231185345 "Reactive Power from Power Flow";
  parameter Real GEN_base=150 "Base Power from the Electrical Generator";
  parameter Real WT_base=150 "Base Power from the Turbine";
  parameter Real SYS_base=150 "Base Power from the power system";
  parameter Real freq=50 "Steady state Frequency of the power system";
  parameter Real poles=3 "Number of pole pairs";
  parameter Real Tp=0.3 "Time Constant Pitch command";
  parameter Real Kpp=114.0 "Pitch Control gain";
  parameter Real Kip=76.0 "Gain of integrator of Pitch Control";
  parameter Real Kpc=3.0 "Pitch Compensation gain";
  parameter Real Kic=30.0 "Gain of integrator of Pitch Compensation";
  parameter Real pimax=27.0 "Maximum pitch angle";
  parameter Real pimin=0.0 "minimum pitch angle";
  parameter Real pirat=10.0 "maximum variation rate of pitch angle";
  parameter Real pwmax=1.12 "Maximal power taken from the wind";
  parameter Real pwmin=0.1 "Minimal power taken from the wind";
  parameter Real pwrat=0.45 "maximum variation rate of power taken from the wind";
  parameter Real Kptrq=3.5 "Gain Torque Controller";
  parameter Real Kitrq=1.4 "Gain of integrator of Torque Controller";
  parameter Real Tpc=0.05 "Time Constant Torque controller";
  parameter Real KQi=0.1 "Gain constant of first PI in DFIG electrical control model";
  parameter Real KVi=40 "Gain constant of second PI in DFIG electrical control model";
  parameter Real xiqmax=0.4 "Up saturation of second PI in DFIG electrical control model";
  parameter Real xiqmin=-0.5 "Down saturation of second PI in DFIG electrical control model";
  parameter Real Kpllp=30;
  parameter Real Xpp=0.8;
  parameter Real qmax=0.6875;
  parameter Real qmin=-0.48;
  parameter Real nmass=2 "Mono-mass or Two-mass model";
  parameter Real Hg=0.62 "Inertia 2";
  parameter Real H=3.0 "Inertia";
  parameter Real Ktg=1.11 "Gain for 2 mass model";
  parameter Real Dtg=1.5 "Damping";
  parameter Real Kl=56.6;
  Real P "Active Power produced in SYS_base";
  Real Q "Reactive Power produced in SYS_base";
  iPSL.Electrical.Wind.GE.Type_3.Turbine.Turbine_Model turbine_Model1(
    eps=Modelica.Constants.eps,
    GEN_base=GEN_base,
    Kic=Kic,
    Kip=Kip,
    Kitrq=Kitrq,
    Kpc=Kpc,
    Kpp=Kpp,
    Kptrq=Kptrq,
    pimax=pimax,
    pimin=pimin,
    pirat=pirat,
    pwmax=pwmax,
    pwmin=pwmin,
    pwrat=pwrat,
    Tp=Tp,
    Tpc=Tpc,
    wt_x0_0=wt_x0_0,
    wt_x1_0=wt_x1_0,
    wt_x2_0=wt_x2_0,
    wt_x3_0=wt_x3_0,
    wt_x4_0=wt_x4_0,
    wt_x5_0=wt_x5_0,
    wt_x6_0=wt_x6_0,
    wt_x7_0=wt_x7_0,
    wt_x8_0=wt_x8_0,
    wt_x9_0=wt_x9_0,
    WT_base=WT_base,
    Dtg=Dtg,
    H=H,
    Hg=Hg,
    KI=Kl,
    Ktg=Ktg,
    wndtge_kp=wndtge_kp,
    wbase=wbase,
    wndtge_ang0=wndtge_ang0,
    wndtge_spd0=wndtge_spd0) annotation (Placement(visible=true, transformation(
        origin={-46.6105,53.4541},
        extent={{-10, -10}, {10, 10}},
        rotation=0)));
  iPSL.Electrical.Wind.GE.Type_3.Electrical_Control.Electrical_Control electrical_Control1(
    ex_x0_0=ex_x0_0,
    ex_x1_0=ex_x1_0,
    KQi=KQi,
    qmax=qmax,
    qmin=qmin,
    KVi=KVi,
    xiqmax=xiqmax,
    xiqmin=xiqmin) annotation (Placement(visible=true, transformation(
        origin={-10,57.46},
        extent={{-10, -10}, {10, 10}},
        rotation=0)));
  iPSL.Electrical.Wind.GE.Type_3.Generator.Generator generator1(
    freq=freq,
    ge_x0_0=ge_x0_0,
    ge_x1_0=ge_x1_0,
    ge_x2_0=ge_x2_0,
    GEN_base=GEN_base,
    Kpllp=Kpllp,
    Lpp=Lpp,
    SYS_base=SYS_base) annotation (Placement(visible=true, transformation(
        origin={45, 60},
        extent={{-10, -10}, {10, 10}},
        rotation=0)));
  iPSL.Electrical.SystemBase sysData annotation(
    Placement(visible = true, transformation(origin = {110, 80}, extent = {{-10, -10}, {14, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable windspeed(fileName = "C:/Users/Caner/Desktop/Multi-Energy-Systems-Thesis-Project/Co_simulation/Case 1/windspeed.txt", smoothness = Modelica.Blocks.Types.Smoothness.ContinuousDerivative, tableName = "tab1", tableOnFile = true) annotation(
    Placement(visible = true, transformation(origin = {-99, 62}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  iPSL.Electrical.Buses.Bus PVbus annotation(
    Placement(visible = true, transformation(origin = {54, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  iPSL.Electrical.Branches.PSAT.TwoWindingTransformer twoWindingTransformer(Sn = 500, V_b = 12500, Vn = 12500, kT = 12500 / 575) annotation(
    Placement(visible = true, transformation(origin = {26, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  iPSL.Electrical.Buses.Bus PQbus annotation(
    Placement(visible = true, transformation(origin = {-2, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant PCC_voltage(k = 1.01) annotation(
    Placement(visible = true, transformation(origin = {-66, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  iPSL.Electrical.Buses.InfiniteBus2 infiniteBus21(angle = 0) annotation(
    Placement(visible = true, transformation(origin = {-36, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
protected
  function cp_init
    input Real lambda;
    input Real theta;
    output Real cp;
  protected
    Real[5, 1] lambda_vec;
    Real[5, 1] theta_vec;
    Real[5, 1] prod;
    parameter Real[5, 5] coeff=[-0.41909, 0.21808, -0.012406, -0.00013365, 0.000011524; -0.067606, 0.060405, -0.013934, 0.0010683, -0.000023895; 0.015727, -0.010996, 0.0021495, -0.00014855,
        0.0000027937; -0.00086018, 0.00057051, -0.00010479, 0.0000059924, -0.000000089194; 0.000014788, -0.0000094839, 0.0000016167, -0.000000071535, 0.00000000049686];
  algorithm
    lambda_vec := [1; lambda; lambda^2; lambda^3; lambda^4];
    theta_vec := [1; theta; theta^2; theta^3; theta^4];
    prod := coeff*lambda_vec;
    cp := prod[1, 1]*theta_vec[1, 1] + prod[2, 1]*theta_vec[2, 1] + prod[3, 1]*theta_vec[3, 1] + prod[4, 1]*theta_vec[4, 1] + prod[5, 1]*theta_vec[5, 1];
  end cp_init;

  function get_Vw
    input Real pimin;
    input Real wndtge_kl;
    input Real wndtge_kp;
    input Real genbc_k_speed;
    input Real pmech;
    output Real lambdaOUT;
  protected
    Real cp;
    Real Vw;
    Real last_err;
    Real new_err;
    Real pwind;
    Real lambda_sav;
    Real lambda;
    Boolean stop;
  algorithm
    last_err := 99999.0;
    lambda := 15 + 0.001;
    stop := false;
    while lambda >= 2.001 and not stop loop
      lambda := lambda - 0.001;
      cp := cp_init(lambda, pimin);
      Vw := wndtge_kl*genbc_k_speed/lambda;
      pwind := wndtge_kp*cp*Vw^3;
      new_err := pwind - pmech;
      if abs(new_err) <= 0.01 then
        lambdaOUT := lambda;
        stop := true;
      else
        if abs(new_err - last_err) < abs(new_err + last_err) or last_err > 90000.0 then
          last_err := new_err;
          lambda_sav := lambda;
        else
          lambdaOUT := lambda_sav - last_err*(lambda - lambda_sav)/(new_err - last_err);
          cp := cp_init(lambdaOUT, 0.0);
          Vw := wndtge_kl*genbc_k_speed/lambdaOUT;
          stop := true;
        end if;
      end if;
    end while;
  end get_Vw;

  function get_theta
    input Real lambda;
    input Real Vw;
    input Real wndtge_kl;
    input Real wndtge_kp;
    input Real genbc_k_speed;
    input Real pmech;
    input Real pimin;
    input Real pimax;
    output Real thetaOUT;
  protected
    Real Vw1;
    Real cp;
    Real last_err;
    Real new_err;
    Real pwind;
    Real theta_sav;
    Boolean stop;
    Real theta;
  algorithm
    last_err := 99999.0;
    theta := pimin - 0.005;
    stop := false;
    Vw1 := Vw;
    while theta <= pimax - 0.005 and not stop loop
      theta := theta + 0.005;
      cp := cp_init(lambda, theta);
      pwind := wndtge_kp*cp*Vw1^3;
      new_err := pwind - pmech;
      if abs(new_err) <= 0.01 then
        thetaOUT := theta;
        stop := true;
      else
        if abs(new_err - last_err) < abs(new_err + last_err) or last_err > 90000 then
          last_err := new_err;
          theta_sav := theta;
        else
          thetaOUT := theta_sav - last_err*(theta - theta_sav)/(new_err - last_err);
          cp := cp_init(lambda, thetaOUT);
          Vw1 := wndtge_kl*genbc_k_speed/lambda;
          stop := true;
        end if;
      end if;
    end while;
  end get_theta;

  Modelica.Blocks.Sources.Constant const(k=qgen)
    annotation (Placement(visible=true, transformation(
        origin={-44.2929,70.7071},
        extent={{-4.2929,-4.2929},{4.2929,4.2929}},
        rotation=0)));
  parameter Real Lpp=Xpp;
  parameter Real wbase=2*Modelica.Constants.pi*freq/poles;
  parameter Real pelec=_P0/WT_base*SYS_base;
  parameter Real pmech=pelec;
  parameter Real wt_x0_0(fixed=false);
  parameter Real wt_x1_0(fixed=false);
  parameter Real wt_x2_0(fixed=false);
  parameter Real wt_x3_0(fixed=false);
  parameter Real wt_x4_0(fixed=false);
  parameter Real wt_x5_0(fixed=false);
  parameter Real wt_x6_0(fixed=false);
  parameter Real wt_x7_0(fixed=false);
  parameter Real wt_x8_0(fixed=false);
  parameter Real wt_x9_0(fixed=false);
  parameter Real ex_x0_0(fixed=false);
  parameter Real ex_x1_0(fixed=false);
  parameter Real ge_x0_0(fixed=false);
  parameter Real ge_x1_0(fixed=false);
  parameter Real ge_x2_0(fixed=false);
  parameter Real qgen(fixed=false);
  parameter Real wndtge_ang0(fixed=false);
  parameter Real wndtge_spd0(fixed=false);
  parameter Real wndtge_spdwmx(fixed=false);
  parameter Real wndtge_spdwmn(fixed=false);
  parameter Real wndtge_kp(fixed=false) "Power coefficient";
  parameter Real cp(fixed=false);
  parameter Real theta(fixed=false);
  parameter Real Vw(fixed=false);
  parameter Real genbc_k_speed(fixed=false);
  parameter Real wndtge_spdw1(fixed=false);
  parameter Real wndtge_wn=0;
  parameter Real wndtge_m1=0;
  parameter Real wndtge_q11=0;
  parameter Real wndtge_q21=0;
  parameter Real lambda(fixed=false);
  parameter Real masflg=1;
initial algorithm
  wndtge_spdwmx := 25.0 "Max. wind speed";
  wndtge_spdwmn := 3.0 "Min. wind speed";
  wndtge_spdw1 := 14.0;
  genbc_k_speed := 1.2;
  wndtge_kp := 0.00159;
  qgen := _Q0*SYS_base/GEN_base;
  ge_x0_0 := _V0 + _Q0*SYS_base/GEN_base*Lpp/_V0;
  ge_x1_0 := _P0*SYS_base/GEN_base/_V0;
  ge_x2_0 := _Ang0;
  ex_x0_0 := _V0;
  ex_x1_0 := ge_x0_0;
  wndtge_spd0 := if pmech < 0.75 then ((-0.67*pmech) + 1.42)*pmech + 0.51 else genbc_k_speed;
  theta := pimin;
  lambda := get_Vw(
    pimin,
    Kl,
    wndtge_kp,
    genbc_k_speed,
    pmech);
  lambda := lambda + 0.01;
  cp := cp_init(lambda, 0.0);
  Vw := Kl*genbc_k_speed/lambda;
  if wndtge_spdw1 > wndtge_spdwmx then
    wndtge_spdw1 := wndtge_spdwmx;
  end if;
  if wndtge_spdw1 < wndtge_spdwmn then
    wndtge_spdw1 := wndtge_spdwmn;
  end if;
  if pmech >= 1.0 and wndtge_spdw1 > Vw then
    Vw := wndtge_spdw1;
    lambda := Kl*genbc_k_speed/Vw;
    theta := get_theta(
      lambda,
      Vw,
      Kl,
      wndtge_kp,
      genbc_k_speed,
      pmech,
      pimin,
      pimax);
    cp := cp_init(lambda, theta);
    Vw := Kl*genbc_k_speed/lambda;
  end if;
  wndtge_kp := pmech/(cp*Vw^3);
  wt_x0_0 := theta;
  wt_x1_0 := if Kip == 0 then 0.0 else theta - Kpc*(pelec - 1.0);
  wt_x4_0 := pelec;
  wt_x2_0 := if Kitrq == 0 then 0.0 else wt_x4_0/genbc_k_speed;
  wt_x3_0 := 0.0;
  wt_x5_0 := genbc_k_speed;
  wt_x6_0 := 0.0;
  wt_x7_0 := if masflg == 3 then pmech/genbc_k_speed/(wndtge_wn*wndtge_wn*wndtge_m1)*(wndtge_q11 - wndtge_q21) else 0.0;
  wt_x8_0 := 0.0;
  wt_x9_0 := 0.0;
  wndtge_ang0 := -pmech/(Ktg*genbc_k_speed);
equation
  connect(generator1.Pgen, turbine_Model1.Pelec) annotation(
    Line(points = {{53, 58}, {60, 58}, {60, 40.4416}, {-59.6231, 40.4416}, {-59.6231, 47.1382}, {-54.6105, 47.1382}}, color = {0, 0, 127}));
  connect(turbine_Model1.Pord, electrical_Control1.Pord) annotation(
    Line(points = {{-38.6105, 60.0863}, {-23.0125, 60.0863}, {-23.0125, 60.1186}, {-18, 60.1186}}, color = {0, 0, 127}));
  connect(const.y, electrical_Control1.Qord) annotation(
    Line(points = {{-39.5707, 70.7071}, {-18, 70.7071}, {-18, 65.46}}, color = {0, 0, 127}));
  P = generator1.Pgen * GEN_base / SYS_base;
  Q = generator1.Qgen * GEN_base / SYS_base;
  connect(electrical_Control1.Ipcmd, generator1.Ipcmd) annotation(
    Line(points = {{-2, 64.9992}, {31.9874, 64.9992}, {31.9874, 65.1648}, {37, 65.1648}}, color = {0, 0, 127}));
  connect(electrical_Control1.Efd, generator1.Efd) annotation(
    Line(points = {{-2, 58.7152}, {31.9874, 58.7152}, {31.9874, 54.3398}, {37, 54.3398}}, color = {0, 0, 127}));
  connect(generator1.Qgen, electrical_Control1.Qgen) annotation(
    Line(points = {{53, 54}, {58.0125, 54}, {58.0125, 44.4475}, {-18, 44.4475}, {-18, 49.46}}, color = {0, 0, 127}));
  connect(generator1.Vt, electrical_Control1.Vterm) annotation(
    Line(points = {{53, 67.4254}, {58.0125, 67.4254}, {58.0125, 73.0125}, {-23.0125, 73.0125}, {-23.0125, 55.46}, {-18, 55.46}}, color = {0, 0, 127}));
  connect(windspeed.y[1], turbine_Model1.Wind_Speed) annotation(
    Line(points = {{-88, 62}, {-75, 62}, {-75, 60}, {-55, 60}}, color = {0, 0, 127}));
  connect(PVbus.p, generator1.p) annotation(
    Line(points = {{55, -25}, {80, -25}, {80, 30}, {45, 30}, {45, 50}, {45, 50}}, color = {0, 0, 255}));
  connect(PVbus.p, twoWindingTransformer.n) annotation(
    Line(points = {{54, -24}, {37, -24}}, color = {0, 0, 255}));
  connect(twoWindingTransformer.p, PQbus.p) annotation(
    Line(points = {{15, -24}, {-2, -24}}, color = {0, 0, 255}));
  connect(PCC_voltage.y, infiniteBus21.V) annotation(
    Line(points = {{-55, -24}, {-47, -24}}, color = {0, 0, 127}));
  connect(PQbus.p, infiniteBus21.p) annotation(
    Line(points = {{-2, -24}, {-25, -24}}, color = {0, 0, 255}));
  annotation (
    
    Diagram(coordinateSystem(
        extent={{-148.5,-105.0},{148.5,105.0}},
        preserveAspectRatio=true,
        initialScale=0.1,
        grid={5,5})),Icon(coordinateSystem(initialScale = 0.1, grid = {10, 10}), graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}), Text(lineColor = {0, 0, 255},extent = {{-60, 40}, {60, -40}}, textString = "WF")}),
    Documentation(info="<html>
<table cellspacing=\"1\" cellpadding=\"1\" border=\"1\"><tr>
<td align=center  width=50%><p>Development level</p></td>
<td align=center width=25% bgcolor=yellow><p> 2 </p></td>
</tr> 
</table> 
<p></p> 
<table cellspacing=\"1\" cellpadding=\"1\" border=\"1\"><tr>
<td><p>Reference</p></td>
<td><p>GE Wind Turbine Generator<a href=\"http://doi.org/10.1109/PES.2003.1267470\"> http://doi.org/10.1109/PES.2003.1267470</a></p></td>
</tr>
<tr>
<td><p>Last update</p></td>
<td><p>July 2015</p></td>
</tr>
<tr>
<td><p>Author</p></td>
<td><p>Maxime Baudette, SmarTS Lab, KTH Royal Institute of Technology</p></td>
</tr>
<tr>
<td><p>Contact</p></td>
<td><p><a href=\"mailto:luigiv@kth.se\">luigiv@kth.se</a></p></td>
</tr>
</table>
</html>", revisions="<html>
<!--DISCLAIMER-->
<p>Copyright 2015-2016 RTE (France), SmarTS Lab (Sweden), AIA (Spain) and DTU (Denmark)</p>
<ul>
<li>RTE: <a href=\"http://www.rte-france.com\">http://www.rte-france.com</a></li>
<li>SmarTS Lab, research group at KTH: <a href=\"https://www.kth.se/en\">https://www.kth.se/en</a></li>
<li>AIA: <a href=\"http://www.aia.es/en/energy\"> http://www.aia.es/en/energy</a></li>
<li>DTU: <a href=\"http://www.dtu.dk/english\"> http://www.dtu.dk/english</a></li>
</ul>
<p>The authors can be contacted by email: <a href=\"mailto:info@itesla-ipsl.org\">info@itesla-ipsl.org</a></p>

<p>This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. </p>
<p>If a copy of the MPL was not distributed with this file, You can obtain one at <a href=\"http://mozilla.org/MPL/2.0/\"> http://mozilla.org/MPL/2.0</a>.</p>
</html>"));
end Windfarm5;