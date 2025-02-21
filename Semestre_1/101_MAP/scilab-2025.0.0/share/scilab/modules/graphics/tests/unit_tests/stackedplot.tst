// =============================================================================
// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2022 - 3DS - Adeline CARNIS adeline.carnis@3ds.com
// Copyright (C) 2022 - 3DS - Antoine ELIAS antoine.elias@3ds.com
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================

// <-- TEST WITH GRAPHIC -->
// <-- NO CHECK REF -->

n = 100;
t = datetime(2022, 1, 1) + caldays(1:n);
v = floor(10 * rand(n, 4)) + 50;
w = floor(10 * rand(n, 4)) + 50;

ts1 = timeseries(t, v(:, 1), v(:, 2), v(:, 3), v(:, 4), "VariableNames", ["Time", "res1", "res2", "res3", "res4"]);
ts2 = timeseries(t, w(:, 1), w(:, 2), w(:, 3), w(:, 4), "VariableNames", ["Time", "res1", "res2", "res3", "res4"]);

stackedplot(ts1);
f = gcf();
a = f.children;
c = a.children.children;
assert_checkequal(size(a, "*"), 4);
assert_checkequal(a.y_label.text, ["res4"; "res3"; "res2"; "res1"]);
assert_checkequal(a.x_label.text, ["Time"; ""; ""; ""]);
assert_checkequal(a.axes_visible(:, 1), ["on"; "off"; "off"; "off"]);
assert_checkequal(c.thickness, 2 * ones(4, 1));
assert_checkequal(c.line_style, ones(4, 1));
assert_checkequal(c.foreground, 33 * ones(4, 1));


stackedplot(ts2);
f = gcf();
a = f.children;
c = a.children.children;
assert_checkequal(size(a, "*"), 4);
assert_checkequal(a.y_label.text, ["res4"; "res3"; "res2"; "res1"]);
assert_checkequal(a.x_label.text, ["Time"; ""; ""; ""]);
assert_checkequal(a.axes_visible(:, 1), ["on"; "off"; "off"; "off"]);
assert_checkequal(c.thickness, 2 * ones(4, 1));
assert_checkequal(c.line_style, ones(4, 1));
assert_checkequal(c.foreground, 33 * ones(4, 1));


stackedplot(ts1, ts2);
f = gcf();
a = f.children;
c = a.children.children;
l = a.children(a.children.type == "Legend");
assert_checkequal(size(a, "*"), 4);
assert_checkequal(a.y_label.text, ["res4"; "res3"; "res2"; "res1"]);
assert_checkequal(a.x_label.text, ["Time"; ""; ""; ""]);
assert_checkequal(a.axes_visible(:, 1), ["on"; "off"; "off"; "off"]);
assert_checkequal(c.thickness, 2 * ones(8, 1));
assert_checkequal(c.line_style, ones(8, 1));
assert_checkequal(c.foreground, [34; 33; 34; 33; 34; 33; 34; 33]);
assert_checkequal(l(1).text, ["res4"; "res4"]);


stackedplot(ts2, ts1);
f = gcf();
a = f.children;
c = a.children.children;
l = a.children(a.children.type == "Legend");
assert_checkequal(size(a, "*"), 4);
assert_checkequal(a.y_label.text, ["res4"; "res3"; "res2"; "res1"]);
assert_checkequal(a.x_label.text, ["Time"; ""; ""; ""]);
assert_checkequal(a.axes_visible(:, 1), ["on"; "off"; "off"; "off"]);
assert_checkequal(c.thickness, 2 * ones(8, 1));
assert_checkequal(c.line_style, ones(8, 1));
assert_checkequal(c.foreground, [34; 33; 34; 33; 34; 33; 34; 33]);
assert_checkequal(l(1).text, ["res4"; "res4"]);


stackedplot(ts1, ts2, "res1");
f = gcf();
a = f.children;
c = a.children.children;
l = a.children(a.children.type == "Legend");
assert_checkequal(size(a, "*"), 1);
assert_checkequal(a.y_label.text, ["res1"]);
assert_checkequal(a.x_label.text, ["Time"]);
assert_checkequal(a.axes_visible(:, 1), "on");
assert_checkequal(c.thickness, [2; 2]);
assert_checkequal(c.line_style, [1; 1]);
assert_checkequal(c.foreground, [34; 33]);
assert_checkequal(l(1).text, ["res1"; "res1"]);


stackedplot(ts1, ts2, "res1", "CombineMatchingNames", %f);
f = gcf();
a = f.children;
c = a.children.children;
assert_checkequal(size(a, "*"), 2);
assert_checkequal(a.y_label.text, ["res1"; "res1"]);
assert_checkequal(a.x_label.text, ["Time"; ""]);
assert_checkequal(a.axes_visible(:, 1), ["on"; "off"]);
assert_checkequal(c.thickness, [2; 2]);
assert_checkequal(c.line_style, [1; 1]);
assert_checkequal(c.foreground, [34; 33]);


stackedplot(ts1, ts2, ["res1", "res3"]);
f = gcf();
a = f.children;
c = a.children.children;
l = a.children(a.children.type == "Legend");
assert_checkequal(size(a, "*"), 2);
assert_checkequal(a.y_label.text, ["res3"; "res1"]);
assert_checkequal(a.x_label.text, ["Time"; ""]);
assert_checkequal(a.axes_visible(:, 1), ["on"; "off"]);
assert_checkequal(c.thickness, [2; 2; 2; 2]);
assert_checkequal(c.line_style, [1; 1; 1; 1]);
assert_checkequal(c.foreground, [34; 33; 34; 33]);
assert_checkequal(l(1).text, ["res3"; "res3"]);


stackedplot(ts1, ts2, [1 3]);
f = gcf();
a = f.children;
c = a.children.children;
l = a.children(a.children.type == "Legend");
assert_checkequal(size(a, "*"), 2);
assert_checkequal(a.y_label.text, ["res3"; "res1"]);
assert_checkequal(a.x_label.text, ["Time"; ""]);
assert_checkequal(a.axes_visible(:, 1), ["on"; "off"]);
assert_checkequal(c.thickness, [2; 2; 2; 2]);
assert_checkequal(c.line_style, [1; 1; 1; 1]);
assert_checkequal(c.foreground, [34; 33; 34; 33]);
assert_checkequal(l(1).text, ["res3"; "res3"]);


stackedplot(ts1, ts2, {"res1", "res2", ["res3", "res4"]});
f = gcf();
a = f.children;
c = a.children.children;
l = a.children(a.children.type == "Legend");
assert_checkequal(size(a, "*"), 3);
assert_checkequal(a.y_label.text, ["res3"; "res4"; "res2"; "res1"]);
assert_checkequal(a.x_label.text, ["Time"; ""; ""]);
assert_checkequal(a.axes_visible(:, 1), ["on"; "off"; "off"]);
assert_checkequal(c.thickness, 2 * ones(8,1));
assert_checkequal(c.line_style, [2; 1; 2; 1; 1; 1; 1; 1]);
assert_checkequal(c.foreground, [34; 34; 33; 33; 34; 33; 34; 33]);
assert_checkequal(size(l, "*"), 3);
assert_checkequal(l(1).text, ["res3"; "res4";"res3"; "res4"]);

stackedplot(ts1, ts2, "LegendLabels", ["Results ts1", "Results ts2"]);
f = gcf();
a = f.children;
c = a.children.children;
l = a.children(a.children.type == "Legend");
assert_checkequal(size(a, "*"), 4);
assert_checkequal(a.y_label.text, ["res4"; "res3"; "res2"; "res1"]);
assert_checkequal(a.x_label.text, ["Time"; ""; ""; ""]);
assert_checkequal(a.axes_visible(:, 1), ["on"; "off"; "off"; "off"]);
assert_checkequal(c.thickness, 2 * ones(8, 1));
assert_checkequal(c.line_style, ones(8, 1));
assert_checkequal(c.foreground, [34; 33; 34; 33; 34; 33; 34; 33]);
assert_checkequal(l(1).text, ["Results ts1 - res4"; "Results ts2 - res4"]);


vars = {"res1", "res2", ["res3", "res4"]};
stackedplot(ts1, ts2, "--or", "LegendLabels", ["Results ts1", "Results ts2"], vars);
f = gcf();
a = f.children;
c = a.children.children;
l = a.children(a.children.type == "Legend");
assert_checkequal(size(a, "*"), 3);
assert_checkequal(a.y_label.text, ["res3"; "res4"; "res2"; "res1"]);
assert_checkequal(a.x_label.text, ["Time"; ""; ""]);
assert_checkequal(a.axes_visible(:, 1), ["on"; "off"; "off"]);
assert_checkequal(c.thickness, 2 * ones(8,1));
assert_checkequal(c.line_style, 2 * ones(8,1));
assert_checkequal(c.foreground, 5 * ones(8,1));
assert_checkequal(size(l, "*"), 3);
assert_checkequal(l(1).text, ["Results ts1 - res3"; "Results ts1 - res4";"Results ts2 - res3"; "Results ts2 - res4"]);

stackedplot(ts1, ts2, ["--or", "*b"], "LegendLabels", ["Results ts1", "Results ts2"], vars);
f = gcf();
a = f.children;
c = a.children.children;
l = a.children(a.children.type == "Legend");
assert_checkequal(size(a, "*"), 3);
assert_checkequal(a.y_label.text, ["res3"; "res4"; "res2"; "res1"]);
assert_checkequal(a.x_label.text, ["Time"; ""; ""]);
assert_checkequal(c.thickness, 2 * ones(8,1));
assert_checkequal(c.line_style, [1; 1; 2; 2; 1; 2; 1; 2]);
assert_checkequal(c.foreground, [1; 1; 5; 5; 1; 5; 1; 5]);
assert_checkequal(size(l, "*"), 3);
assert_checkequal(l(1).text, ["Results ts1 - res3"; "Results ts1 - res4";"Results ts2 - res3"; "Results ts2 - res4"]);

stackedplot(ts1, "marker", "o", "markersize", 3, vars);
f = gcf();
a = f.children;
c = a.children.children;
l = a.children(a.children.type == "Legend");
assert_checkequal(size(a, "*"), 3);
assert_checkequal(a.y_label.text, ["res3"; "res4"; "res2"; "res1"]);
assert_checkequal(a.x_label.text, ["Time"; ""; ""]);
assert_checkequal(c.thickness, 2 * ones(4,1));
assert_checkequal(c.line_style, [1; 1; 1; 1]);
assert_checkequal(c.foreground, [34; 33; 33; 33]);
assert_checkequal(c.mark_size, [3; 3; 3; 3]);
assert_checkequal(c.mark_style, [9; 9; 9; 9]);
assert_checkequal(size(l, "*"), 1);
assert_checkequal(l(1).text, ["res3"; "res4"]);

stackedplot(ts1, "Title", "Stackedplot graph test");
f = gcf();
a = f.children;
assert_checkequal(a($).title.text, "Stackedplot graph test");

stackedplot(ts1, ts2, ["res2", "res4"], "DisplayLabels", ["graph - res2", "graph - res4"]);
f = gcf();
a = f.children;
assert_checkequal(size(a, "*"), 2);
assert_checkequal(a.y_label.text, ["graph - res4"; "graph - res2"]);

stackedplot(ts1, ts2, "DisplayLabels", ["r1", "r2", "r3", "r4"]);
f = gcf();
a = f.children;
assert_checkequal(size(a, "*"), 4);
assert_checkequal(a.y_label.text, ["r4"; "r3"; "r2"; "r1"]);

stackedplot(ts1, ts2, "DisplayLabels", ["r1", "r2", "r3", "r4"], "CombineMatchingNames", %f);
f = gcf();
a = f.children;
assert_checkequal(size(a, "*"), 8);
assert_checkequal(a.y_label.text, ["r4"; "r3"; "r2"; "r1"; "r4"; "r3"; "r2"; "r1"]);

// res2 is drawned in two graphs
vars = {["res1", "res2"], ["res2", "res3"], "res4"};
f = stackedplot(ts1, vars);
a = f.children;
assert_checkequal(size(a, "*"), 3);
assert_checkequal(a.y_label.text, ["res4"; "res2"; "res3"; "res1"; "res2"]);
assert_checkequal(a.x_label.text, ["Time"; ""; ""]);

towns = ["Agen" "Bastia" "Chamonix" "Cognac" "Hyères" "Le Mans" "Le Puy" ..
"Lille" "Lorient" "Mende" ];
months = datetime(2023, 1:12, 1, "OutputFormat", "MMMM");

T = [5.7 5.9 9.8 12.1 16.0 19.4 21.8 21.5 18.4 14.7 9.3 5.2 13.5
9.4 9.4 11.2 13.3 17.3 21.0 24.1 24.5 21.2 17.6 13.3 10.4 16.1
-2.3 -0.8 3.0 6.6 11.2 14.4 15.5 15.9 12.5 8.6 2.7 -1.6 7.2
6.1 5.9 9.7 11.9 15.8 19.0 21.1 20.9 17.9 14.4 9.3 5.6 13.3
8.7 8.9 11.0 13.1 16.7 20.3 23.2 23.3 20.2 16.8 12.6 9.8 15.4
5.0 5.5 8.3 10.7 14.5 17.8 19.9 19.7 18.5 12.8 8.1 5.4 12.8
1.0 1.3 4.8 7.2 11.3 14.3 17.6 17.1 13.5 9.9 4.6 1.8 8.8
3.7 4.1 7.1 9.8 13.5 16.2 18.6 18.5 15.5 11.7 7.2 4.2 10.8
6.6 6.7 8.6 10.3 13.6 16.2 18.1 18.0 16.0 13.0 9.4 7.0 12.0
0.6 1.3 3.7 5.5 9.6 13.1 16.2 16.0 12.8 8.8 3.8 1.8 7.8
];
T = T(:, 1:12);

ts = timeseries(months', T', "VariableNames", ["Time", towns]);

stackedplot(ts, {towns});

// error
msg = msprintf(_("%s: Wrong type for input argument #%d: boolean expected.\n"), "stackedplot", 4);
assert_checkerror("stackedplot(ts1, ts2, ""CombineMatchingNames"", 1)", msg);
msg = msprintf(_("%s: Wrong type for input argument #%d: string expected.\n"), "stackedplot", 4);
assert_checkerror("stackedplot(ts1, ts2, ""LegendLabels"", 1)", msg);
msg = msprintf(_("%s: Wrong size for input argument #%d: Must be the same size as the number of timeseries.\n"), "stackedplot", 4);
assert_checkerror("stackedplot(ts1, ts2, ""LegendLabels"", ""toto"")", msg);
msg = msprintf(_("%s: The number of Linespec must be equal to the number of timeseries in input.\n"), "stackedplot");
assert_checkerror("stackedplot(ts1, ts2, [""--or"", ""*b"", "".g""])", msg);
msg = msprintf(_("%s: Wrong type for input argument #%d: string expected.\n"), "stackedplot", 4);
assert_checkerror("stackedplot(ts1, ts2, ""Title"", 1)", msg);
msg = msprintf(_("%s: Wrong type for input argument #%d: string expected.\n"), "stackedplot", 4);
assert_checkerror("stackedplot(ts1, ts2, ""DisplayLabels"", 1)", msg);
msg = msprintf(_("%s: DisplayLabels must be the same size as the number of variables.\n"), "stackedplot");
assert_checkerror("stackedplot(ts1, ts2, ""DisplayLabels"", [""r1"", ""r2"", ""r3""])", msg);
msg = msprintf(_("%s: Wrong value for input argument #%d: a valid LineSpec or VariableName expected.\n"), "stackedplot", 2);
assert_checkerror("stackedplot(ts1, ""o+-"")", msg);