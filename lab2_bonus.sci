clear; clc;

fig_dir = "/work/LAB-XLTHS/Report/Lab/LabsReport/Labs/Lab_2/figures/";

// ==========================================
// Bai 1.3: Khao sat tinh tuan hoan
// ==========================================
n_test = 0:48;
x_13b = 3 * cos(5 * n_test + %pi / 6);
x_13e = cos(%pi * n_test / 2) - sin(%pi * n_test / 8) + 3 * cos(%pi * n_test / 4 + %pi / 3);

f13 = figure('visible', 'off');
f13.background = color('white');
f13.figure_size = [800, 550];
subplot(2, 1, 1);
plot2d3(n_test, x_13b, style=2);
plot(n_test, x_13b, 'bo');
xgrid;
a13_1 = gca(); a13_1.background = color('white');
title("Signal x(n) = 3cos(5n + pi/6) [Non-periodic]");
ylabel("x(n)");

subplot(2, 1, 2);
plot2d3(n_test, x_13e, style=5);
plot(n_test, x_13e, 'rd');
xgrid;
a13_2 = gca(); a13_2.background = color('white');
title("Composite Signal x(n) [Periodic, N0 = 16 samples]");
xlabel("n"); ylabel("x(n)");
xs2png(f13, fig_dir + "bonus_ex1_3.png");
close(f13);

// ==========================================
// Bai 1.9: Mo phong hien tuong Aliasing
// ==========================================
Fs_19 = 600;
t_19 = linspace(0, 0.025, 1000);
xa_19 = sin(480 * %pi * t_19) + 3 * sin(720 * %pi * t_19);
n_19 = 0:15;
xn_19 = sin(480 * %pi * n_19 / Fs_19) + 3 * sin(720 * %pi * n_19 / Fs_19);
ya_19 = -2 * sin(480 * %pi * t_19);

f19 = figure('visible', 'off');
f19.background = color('white');
f19.figure_size = [800, 550];
subplot(2, 1, 1);
plot2d(t_19, xa_19, style=2);
plot2d3(n_19 / Fs_19, xn_19, style=5);
plot(n_19 / Fs_19, xn_19, 'ro');
xgrid;
a19_1 = gca(); a19_1.background = color('white');
title("Original Analog Signal x_a(t) and Samples at Fs = 600 Hz");
ylabel("x_a(t)");

subplot(2, 1, 2);
plot2d(t_19, ya_19, style=3);
plot2d3(n_19 / Fs_19, xn_19, style=5);
plot(n_19 / Fs_19, xn_19, 'ro');
xgrid;
a19_2 = gca(); a19_2.background = color('white');
title("Reconstructed Signal y_a(t) = -2sin(480*pi*t) [Aliased]");
xlabel("t (s)"); ylabel("y_a(t)");
xs2png(f19, fig_dir + "bonus_ex1_9_aliasing.png");
close(f19);

// ==========================================
// Bai 1.10: Lay mau va luong tu hoa 1024 muc
// ==========================================
Fs_110 = 1000;
t_110 = linspace(0, 0.02, 1000);
xa_110 = 3 * cos(600 * %pi * t_110) + 2 * cos(1800 * %pi * t_110);
n_110 = 0:20;
xn_110 = 3 * cos(600 * %pi * n_110 / Fs_110) + 2 * cos(1800 * %pi * n_110 / Fs_110);
Delta_110 = 10 / 1024;
xq_110 = Delta_110 * round(xn_110 / Delta_110);

f110 = figure('visible', 'off');
f110.background = color('white');
f110.figure_size = [800, 550];
subplot(2, 1, 1);
plot2d(t_110, xa_110, style=2);
plot2d3(n_110 / Fs_110, xn_110, style=5);
plot(n_110 / Fs_110, xn_110, 'ro');
xgrid;
a110_1 = gca(); a110_1.background = color('white');
title("Analog Signal x_a(t) and Samples at Fs = 1000 Hz");
ylabel("x_a(t)");

subplot(2, 1, 2);
plot2d3(n_110, xq_110, style=3);
plot(n_110, xq_110, 'gs');
xgrid;
a110_2 = gca(); a110_2.background = color('white');
title("Quantized Signal x_q(n) [1024 Levels, Delta = 9.77 mV]");
xlabel("n"); ylabel("x_q(n)");
xs2png(f110, fig_dir + "bonus_ex1_10.png");
close(f110);
