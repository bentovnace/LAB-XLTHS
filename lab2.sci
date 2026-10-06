clear; clc;

fig_dir = "/work/LAB-XLTHS/Report/Lab/LabsReport/Labs/Lab_2/figures/";

// ========================
// Bai 2.2: Unit Step Signal
// ========================
n2 = -5:5;
u_n = bool2s(n2 >= 0);
f2 = figure('visible', 'off');
f2.background = color('white');
f2.figure_size = [700, 400];
plot2d3(n2, u_n, style=5);
plot(n2, u_n, 'ro');
xgrid;
a2 = gca(); a2.background = color('white');
a2.data_bounds = [-6, -0.5; 6, 1.5];
title("Unit Step Signal u(n)");
xlabel("n"); ylabel("u(n)");
xs2png(f2, fig_dir + "ex2.png");
close(f2);

// ========================
// Bai 2.3: Unit Impulse Signal
// ========================
n3 = -5:5;
delta_n = bool2s(n3 == 0);
f3 = figure('visible', 'off');
f3.background = color('white');
f3.figure_size = [700, 400];
plot2d3(n3, delta_n, style=2);
plot(n3, delta_n, 'bs');
xgrid;
a3 = gca(); a3.background = color('white');
a3.data_bounds = [-6, -0.5; 6, 1.5];
title("Unit Impulse Signal \delta(n)");
xlabel("n"); ylabel("\delta(n)");
xs2png(f3, fig_dir + "ex3.png");
close(f3);

// ========================
// Bai 2.4: Unit Ramp Signal
// ========================
n4 = -5:5;
ur_n = n4 .* bool2s(n4 >= 0);
f4 = figure('visible', 'off');
f4.background = color('white');
f4.figure_size = [700, 400];
plot2d3(n4, ur_n, style=3);
plot(n4, ur_n, 'g^');
xgrid;
a4 = gca(); a4.background = color('white');
a4.data_bounds = [-6, -1; 6, 6];
title("Unit Ramp Signal u_r(n)");
xlabel("n"); ylabel("u_r(n)");
xs2png(f4, fig_dir + "ex4.png");
close(f4);

// ========================
// Bai 2.5: Even/Odd Signal Decomposition
// ========================
n5 = -1:1;
x5 = [1, 3, -2];
x5_neg = [-2, 3, 1];
xe = 0.5 * (x5 + x5_neg);
xo = 0.5 * (x5 - x5_neg);
f5 = figure('visible', 'off');
f5.background = color('white');
f5.figure_size = [800, 650];

subplot(3, 1, 1);
plot2d3(n5, x5, style=2);
plot(n5, x5, 'bo');
xgrid;
a5_1 = gca(); a5_1.background = color('white');
a5_1.data_bounds = [-2, -3; 2, 4];
title("Original Signal x(n)");
ylabel("x(n)");

subplot(3, 1, 2);
plot2d3(n5, xe, style=3);
plot(n5, xe, 'gs');
xgrid;
a5_2 = gca(); a5_2.background = color('white');
a5_2.data_bounds = [-2, -3; 2, 4];
title("Even Component x_e(n)");
ylabel("x_e(n)");

subplot(3, 1, 3);
plot2d3(n5, xo, style=5);
plot(n5, xo, 'rd');
xgrid;
a5_3 = gca(); a5_3.background = color('white');
a5_3.data_bounds = [-2, -3; 2, 4];
title("Odd Component x_o(n)");
xlabel("n"); ylabel("x_o(n)");

xs2png(f5, fig_dir + "ex5.png");
close(f5);

// ========================
// Bai 2.6: Addition of Discrete Signals
// ========================
n6 = -1:3;
x1_padded = [0, 0, 1, 3, -2];
x2_padded = [0, 1, 2, 3, 0];
y6 = x1_padded + x2_padded;
f6 = figure('visible', 'off');
f6.background = color('white');
f6.figure_size = [800, 650];

subplot(3, 1, 1);
plot2d3(n6, x1_padded, style=2);
plot(n6, x1_padded, 'bo');
xgrid;
a6_1 = gca(); a6_1.background = color('white');
a6_1.data_bounds = [-2, -3; 4, 7];
title("Signal x_1(n)");
ylabel("x_1(n)");

subplot(3, 1, 2);
plot2d3(n6, x2_padded, style=3);
plot(n6, x2_padded, 'gs');
xgrid;
a6_2 = gca(); a6_2.background = color('white');
a6_2.data_bounds = [-2, -3; 4, 7];
title("Signal x_2(n)");
ylabel("x_2(n)");

subplot(3, 1, 3);
plot2d3(n6, y6, style=5);
plot(n6, y6, 'rd');
xgrid;
a6_3 = gca(); a6_3.background = color('white');
a6_3.data_bounds = [-2, -3; 4, 7];
title("Sum Signal y(n) = x_1(n) + x_2(n)");
xlabel("n"); ylabel("y(n)");

xs2png(f6, fig_dir + "ex6.png");
close(f6);

// ========================
// Bai 2.7: Multiplication of Discrete Signals
// ========================
y7 = x1_padded .* x2_padded;
f7 = figure('visible', 'off');
f7.background = color('white');
f7.figure_size = [800, 650];

subplot(3, 1, 1);
plot2d3(n6, x1_padded, style=2);
plot(n6, x1_padded, 'bo');
xgrid;
a7_1 = gca(); a7_1.background = color('white');
a7_1.data_bounds = [-2, -3; 4, 10];
title("Signal x_1(n)");
ylabel("x_1(n)");

subplot(3, 1, 2);
plot2d3(n6, x2_padded, style=3);
plot(n6, x2_padded, 'gs');
xgrid;
a7_2 = gca(); a7_2.background = color('white');
a7_2.data_bounds = [-2, -3; 4, 10];
title("Signal x_2(n)");
ylabel("x_2(n)");

subplot(3, 1, 3);
plot2d3(n6, y7, style=5);
plot(n6, y7, 'rd');
xgrid;
a7_3 = gca(); a7_3.background = color('white');
a7_3.data_bounds = [-2, -3; 4, 10];
title("Product Signal y(n) = x_1(n) .* x_2(n)");
xlabel("n"); ylabel("y(n)");

xs2png(f7, fig_dir + "ex7.png");
close(f7);

// ========================
// Bai 2.8: Basic Operations
// ========================
nx = -2:1;
x8 = [1, -2, 3, 6];

// 2.8.a: Time Reversal y1(n) = x(-n)
ny1 = -1:2;
y1 = [6, 3, -2, 1];
f8a = figure('visible', 'off');
f8a.background = color('white');
f8a.figure_size = [800, 550];
subplot(2, 1, 1);
plot2d3(nx, x8, style=2);
plot(nx, x8, 'bo');
xgrid;
a8a_1 = gca(); a8a_1.background = color('white');
a8a_1.data_bounds = [-3, -4; 3, 8];
title("Original Signal x(n)");
ylabel("x(n)");
subplot(2, 1, 2);
plot2d3(ny1, y1, style=5);
plot(ny1, y1, 'rd');
xgrid;
a8a_2 = gca(); a8a_2.background = color('white');
a8a_2.data_bounds = [-3, -4; 3, 8];
title("Time Reversal: y_1(n) = x(-n)");
xlabel("n"); ylabel("y_1(n)");
xs2png(f8a, fig_dir + "ex8a.png");
close(f8a);

// 2.8.b: Time Shift y2(n) = x(n + 3)
ny2 = -5:-2;
y2 = [1, -2, 3, 6];
f8b = figure('visible', 'off');
f8b.background = color('white');
f8b.figure_size = [800, 550];
subplot(2, 1, 1);
plot2d3(nx, x8, style=2);
plot(nx, x8, 'bo');
xgrid;
a8b_1 = gca(); a8b_1.background = color('white');
a8b_1.data_bounds = [-6, -4; 2, 8];
title("Original Signal x(n)");
ylabel("x(n)");
subplot(2, 1, 2);
plot2d3(ny2, y2, style=5);
plot(ny2, y2, 'rd');
xgrid;
a8b_2 = gca(); a8b_2.background = color('white');
a8b_2.data_bounds = [-6, -4; 2, 8];
title("Time Shift: y_2(n) = x(n + 3)");
xlabel("n"); ylabel("y_2(n)");
xs2png(f8b, fig_dir + "ex8b.png");
close(f8b);

// 2.8.c: Scaled and Shifted y3(n) = 2x(-n - 2)
ny3 = -3:0;
y3 = [12, 6, -4, 2];
f8c = figure('visible', 'off');
f8c.background = color('white');
f8c.figure_size = [800, 550];
subplot(2, 1, 1);
plot2d3(nx, x8, style=2);
plot(nx, x8, 'bo');
xgrid;
a8c_1 = gca(); a8c_1.background = color('white');
a8c_1.data_bounds = [-4, -6; 2, 14];
title("Original Signal x(n)");
ylabel("x(n)");
subplot(2, 1, 2);
plot2d3(ny3, y3, style=5);
plot(ny3, y3, 'rd');
xgrid;
a8c_2 = gca(); a8c_2.background = color('white');
a8c_2.data_bounds = [-4, -6; 2, 14];
title("Scaled and Shifted: y_3(n) = 2x(-n - 2)");
xlabel("n"); ylabel("y_3(n)");
xs2png(f8c, fig_dir + "ex8c.png");
close(f8c);
