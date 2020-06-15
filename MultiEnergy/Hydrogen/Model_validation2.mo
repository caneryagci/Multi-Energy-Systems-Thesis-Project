within Hydrogen;

model Model_validation2
  Modelica.Blocks.Sources.CombiTimeTable Porder_step(fileName = "C:/Users/Caner/Desktop/Multi-Energy-Systems-Thesis-Project/Electrolyser/Text/Porder_test.txt", tableName = "tab1", tableOnFile = true)  annotation(
    Placement(visible = true, transformation(origin = {-65, 23}, extent = {{-17, -17}, {17, 17}}, rotation = 0)));
  Hydrogen.electrolyser_simple electrolyser_simple annotation(
    Placement(visible = true, transformation(origin = {27, 39}, extent = {{-31, -31}, {31, 31}}, rotation = 0)));
  Hydrogen.electrolyser_detailed electrolyser_detailed annotation(
    Placement(visible = true, transformation(origin = {25, -51}, extent = {{-35, -35}, {35, 35}}, rotation = 0)));
equation
  connect(Porder_step.y[1], electrolyser_simple.Porder) annotation(
    Line(points = {{-46, 24}, {-30, 24}, {-30, 52}, {2, 52}, {2, 52}}, color = {0, 0, 127}));
  connect(Porder_step.y[1], electrolyser_detailed.Porder) annotation(
    Line(points = {{-46, 24}, {-30, 24}, {-30, -26}, {0, -26}, {0, -28}}, color = {0, 0, 127}));
protected
end Model_validation2;
