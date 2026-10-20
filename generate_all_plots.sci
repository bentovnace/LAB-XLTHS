// Scilab Script: generate_all_scilab_plots.sci
// Export authentic Scilab figures using xs2png with pure white background

fig_dir = "/work/LAB-XLTHS/Report/Lab/LabsReport/Labs/Lab_3/figures/";

// ========================================================
// 1. Exercise 1: Delay y(n) = x(n - 1)
// ========================================================
xn = [1, -2, 3, 6];
xorigin = 3;
k = 1;
yn = xn;
yorigin = xorigin - k;
nx = (1:length(xn)) - xorigin;
ny = (1:length(yn)) - yorigin;

f1 = figure('visible', 'off');
f1.background = color('white');
f1.figure_size = [800, 520];

subplot(2, 1, 1);
plot2d3(nx, xn); plot(nx, xn, 'b*');
ax1 = gca();
ax1.data_bounds = [min(nx)-1, min(xn)-1; max(nx)+k+1, max(xn)+1];
title('Signal x(n)'); xlabel('n'); ylabel('x(n)'); xgrid;

subplot(2, 1, 2);
plot2d3(ny, yn); plot(ny, yn, 'b*');
ay1 = gca();
ay1.data_bounds = [min(ny)-k-1, min(yn)-1; max(ny)+1, max(yn)+1];
title('Signal y(n) = Delay x(n)'); xlabel('n'); ylabel('y(n)'); xgrid;

xs2png(f1, fig_dir + "delay.png");
close(f1);

// ========================================================
// 2. Exercise 2: Advance y(n) = x(n + 2)
// ========================================================
k_adv = 2;
yn_adv = xn;
yorigin_adv = xorigin + k_adv;
ny_adv = (1:length(yn_adv)) - yorigin_adv;

f2 = figure('visible', 'off');
f2.background = color('white');
f2.figure_size = [800, 520];

subplot(2, 1, 1);
plot2d3(nx, xn); plot(nx, xn, 'b*');
ax2 = gca();
ax2.data_bounds = [min(nx)-k_adv-1, min(xn)-1; max(nx)+1, max(xn)+1];
title('Signal x(n)'); xlabel('n'); ylabel('x(n)'); xgrid;

subplot(2, 1, 2);
plot2d3(ny_adv, yn_adv); plot(ny_adv, yn_adv, 'b*');
ay2 = gca();
ay2.data_bounds = [min(ny_adv)-1, min(yn_adv)-1; max(ny_adv)+k_adv+1, max(yn_adv)+1];
title('Signal y(n) = Advance x(n)'); xlabel('n'); ylabel('y(n)'); xgrid;

xs2png(f2, fig_dir + "advance.png");
close(f2);

// ========================================================
// 3. Exercise 3: Fold y(n) = x(-n)
// ========================================================
yn_fold = xn($:-1:1);
yorigin_fold = length(xn) - xorigin + 1;
ny_fold = (1:length(yn_fold)) - yorigin_fold;

f3 = figure('visible', 'off');
f3.background = color('white');
f3.figure_size = [800, 520];

subplot(2, 1, 1);
plot2d3(nx, xn); plot(nx, xn, 'b*');
ax3 = gca();
ax3.data_bounds = [min(nx)-1, min(xn)-1; max(nx)+2, max(xn)+1];
title('Signal x(n)'); xlabel('n'); ylabel('x(n)'); xgrid;

subplot(2, 1, 2);
plot2d3(ny_fold, yn_fold); plot(ny_fold, yn_fold, 'b*');
ay3 = gca();
ay3.data_bounds = [min(ny_fold)-2, min(yn_fold)-1; max(ny_fold)+1, max(yn_fold)+1];
title('Signal y(n) = Fold x(n)'); xlabel('n'); ylabel('y(n)'); xgrid;

xs2png(f3, fig_dir + "fold.png");
close(f3);

// ========================================================
// 4. Exercise 4: Add y(n) = x1(n) + x2(n)
// ========================================================
x1n = [0, 1, 3, -2]; x1origin = 1;
x2n = [1, 1, 2, 3];  x2origin = 2;

n1_start = 1 - x1origin; n1_end = length(x1n) - x1origin;
n2_start = 1 - x2origin; n2_end = length(x2n) - x2origin;
n_start = min(n1_start, n2_start);
n_end   = max(n1_end, n2_end);
yorigin_add = 1 - n_start;
ny_add = n_start:n_end;
yn_add = zeros(1, length(ny_add));

for i = 1:length(ny_add)
    if (ny_add(i) >= n1_start) & (ny_add(i) <= n1_end) then
        idx1 = ny_add(i) + x1origin;
        yn_add(i) = yn_add(i) + x1n(idx1);
    end
    if (ny_add(i) >= n2_start) & (ny_add(i) <= n2_end) then
        idx2 = ny_add(i) + x2origin;
        yn_add(i) = yn_add(i) + x2n(idx2);
    end
end

f4 = figure('visible', 'off');
f4.background = color('white');
f4.figure_size = [800, 680];

subplot(3, 1, 1);
plot2d3(n1_start:n1_end, x1n); plot(n1_start:n1_end, x1n, 'b*');
ax41 = gca();
ax41.data_bounds = [n1_start-2, min(x1n)-1; n1_end+1, max(x1n)+1];
title('Signal x1(n)'); xlabel('n'); ylabel('x1(n)'); xgrid;

subplot(3, 1, 2);
plot2d3(n2_start:n2_end, x2n); plot(n2_start:n2_end, x2n, 'b*');
ax42 = gca();
ax42.data_bounds = [n2_start-1, min(x2n)-1; n2_end+2, max(x2n)+1];
title('Signal x2(n)'); xlabel('n'); ylabel('x2(n)'); xgrid;

subplot(3, 1, 3);
plot2d3(ny_add, yn_add); plot(ny_add, yn_add, 'b*');
ax43 = gca();
ax43.data_bounds = [n_start-1, min(yn_add)-1; n_end+1, max(yn_add)+1];
title('Signal y(n) = x1(n) + x2(n)'); xlabel('n'); ylabel('y(n)'); xgrid;

xs2png(f4, fig_dir + "add.png");
close(f4);

// ========================================================
// 5. Exercise 5: Multiply y(n) = x1(n) .* x2(n)
// ========================================================
yn_mul = zeros(1, length(ny_add));
for i = 1:length(ny_add)
    if (ny_add(i) >= max(n1_start, n2_start)) & (ny_add(i) <= min(n1_end, n2_end)) then
        idx1 = ny_add(i) + x1origin;
        idx2 = ny_add(i) + x2origin;
        yn_mul(i) = yn_mul(i) + x1n(idx1) * x2n(idx2);
    end
end

f5 = figure('visible', 'off');
f5.background = color('white');
f5.figure_size = [800, 680];

subplot(3, 1, 1);
plot2d3(n1_start:n1_end, x1n); plot(n1_start:n1_end, x1n, 'b*');
ax51 = gca();
ax51.data_bounds = [n1_start-2, min(x1n)-1; n1_end+1, max(x1n)+1];
title('Signal x1(n)'); xlabel('n'); ylabel('x1(n)'); xgrid;

subplot(3, 1, 2);
plot2d3(n2_start:n2_end, x2n); plot(n2_start:n2_end, x2n, 'b*');
ax52 = gca();
ax52.data_bounds = [n2_start-1, min(x2n)-1; n2_end+2, max(x2n)+1];
title('Signal x2(n)'); xlabel('n'); ylabel('x2(n)'); xgrid;

subplot(3, 1, 3);
plot2d3(ny_add, yn_mul); plot(ny_add, yn_mul, 'b*');
ax53 = gca();
ax53.data_bounds = [n_start-1, min(yn_mul)-1; n_end+1, max(yn_mul)+1];
title('Signal y(n) = x1(n) . x2(n)'); xlabel('n'); ylabel('y(n)'); xgrid;

xs2png(f5, fig_dir + "multi.png");
close(f5);

// ========================================================
// 6. Exercise 6: Convolution y(n) = x(n) * h(n)
// ========================================================
hn = [1, 1, 2, 3]; horigin = 2;
nx_c = (1:length(x1n)) - x1origin;
nh_c = (1:length(hn)) - horigin;
nc_start = min(nx_c) + min(nh_c);
nc_end   = max(nx_c) + max(nh_c);
ny_conv  = nc_start:nc_end;
yn_conv  = zeros(1, length(ny_conv));

for ix = 1:length(x1n)
    for ih = 1:length(hn)
        n_val = nx_c(ix) + nh_c(ih);
        iy = n_val - nc_start + 1;
        yn_conv(iy) = yn_conv(iy) + x1n(ix) * hn(ih);
    end
end

f6 = figure('visible', 'off');
f6.background = color('white');
f6.figure_size = [800, 680];

subplot(3, 1, 1);
plot2d3(nx_c, x1n); plot(nx_c, x1n, 'b*');
ax61 = gca();
ax61.data_bounds = [min(nx_c)-1, min(x1n)-1; max(nx_c)+1, max(x1n)+1];
title('Input Signal x(n)'); xlabel('n'); ylabel('x(n)'); xgrid;

subplot(3, 1, 2);
plot2d3(nh_c, hn); plot(nh_c, hn, 'b*');
ax62 = gca();
ax62.data_bounds = [min(nh_c)-1, min(hn)-1; max(nh_c)+1, max(hn)+1];
title('Impulse Response h(n)'); xlabel('n'); ylabel('h(n)'); xgrid;

subplot(3, 1, 3);
plot2d3(ny_conv, yn_conv); plot(ny_conv, yn_conv, 'b*');
ax63 = gca();
ax63.data_bounds = [min(ny_conv)-1, min(yn_conv)-1; max(ny_conv)+1, max(yn_conv)+1];
title('Convolution y(n) = x(n) * h(n)'); xlabel('n'); ylabel('y(n)'); xgrid;

xs2png(f6, fig_dir + "convolution.png");
close(f6);

// ========================================================
// 7. Exercise 2.1: x(n) and y(n) = x(4-n)
// ========================================================
x21 = [0, 1/3, 2/3, 1, 1, 1, 1];
n21 = -3:3;
x21_org = 4;

f21 = figure('visible', 'off');
f21.background = color('white');
f21.figure_size = [800, 420];
plot2d3(n21, x21); plot(n21, x21, 'b*');
ax21 = gca();
ax21.data_bounds = [-4, -0.5; 4, 1.5];
title('Signal x(n) - Exercise 2.1'); xlabel('n'); ylabel('x(n)'); xgrid;
xs2png(f21, fig_dir + "21a.png");
close(f21);

// Intermediate fold x(-n)
x21_fold = x21($:-1:1);
n21_fold = -3:3;
f21_f = figure('visible', 'off');
f21_f.background = color('white');
f21_f.figure_size = [800, 420];
plot2d3(n21_fold, x21_fold); plot(n21_fold, x21_fold, 'b*');
ax21f = gca();
ax21f.data_bounds = [-4, -0.5; 4, 1.5];
title('Folded Signal v(n) = x(-n)'); xlabel('n'); ylabel('v(n)'); xgrid;
xs2png(f21_f, fig_dir + "c_fold.png");
close(f21_f);

// Final delay v(n-4) = x(4-n)
n21_del = (-3:3) + 4; // 1:7
f21_d = figure('visible', 'off');
f21_d.background = color('white');
f21_d.figure_size = [800, 420];
plot2d3(n21_del, x21_fold); plot(n21_del, x21_fold, 'b*');
ax21d = gca();
ax21d.data_bounds = [0, -0.5; 8, 1.5];
title('Output Signal y(n) = x(4-n)'); xlabel('n'); ylabel('y(n)'); xgrid;
xs2png(f21_d, fig_dir + "c_delay.png");
close(f21_d);

// ========================================================
// 8. Exercise 2.2: Systematic Operations
// ========================================================
x22 = [0, 1, 1, 1, 1, 0.5, 0.5];
n22 = -2:4;
x22_org = 3;

// (a) x(n-2)
f22a = figure('visible', 'off');
f22a.background = color('white');
f22a.figure_size = [800, 420];
plot2d3(n22 + 2, x22); plot(n22 + 2, x22, 'b*');
ax = gca(); ax.data_bounds = [-1, -0.2; 7, 1.5];
title('Signal y(n) = x(n-2)'); xlabel('n'); ylabel('y(n)'); xgrid;
xs2png(f22a, fig_dir + "22a.png");
close(f22a);

// (b1) fold x(-n)
x22_fold = x22($:-1:1);
n22_fold = -4:2;
f22b1 = figure('visible', 'off');
f22b1.background = color('white');
f22b1.figure_size = [800, 420];
plot2d3(n22_fold, x22_fold); plot(n22_fold, x22_fold, 'b*');
ax = gca(); ax.data_bounds = [-5, -0.2; 3, 1.5];
title('Folded Signal v(n) = x(-n)'); xlabel('n'); ylabel('v(n)'); xgrid;
xs2png(f22b1, fig_dir + "22b1.png");
close(f22b1);

// (b2) x(4-n) = v(n-4)
f22b2 = figure('visible', 'off');
f22b2.background = color('white');
f22b2.figure_size = [800, 420];
plot2d3(n22_fold + 4, x22_fold); plot(n22_fold + 4, x22_fold, 'b*');
ax = gca(); ax.data_bounds = [-1, -0.2; 7, 1.5];
title('Signal y(n) = x(4-n)'); xlabel('n'); ylabel('y(n)'); xgrid;
xs2png(f22b2, fig_dir + "22b2.png");
close(f22b2);

// (c) x(n+2)
f22c = figure('visible', 'off');
f22c.background = color('white');
f22c.figure_size = [800, 420];
plot2d3(n22 - 2, x22); plot(n22 - 2, x22, 'b*');
ax = gca(); ax.data_bounds = [-5, -0.2; 3, 1.5];
title('Signal y(n) = x(n+2)'); xlabel('n'); ylabel('y(n)'); xgrid;
xs2png(f22c, fig_dir + "22c.png");
close(f22c);

// (d) x(n) * u(2-n)
// u(2-n) = 1 for n <= 2, 0 for n > 2
y22d = x22;
y22d(n22 > 2) = 0;
f22d = figure('visible', 'off');
f22d.background = color('white');
f22d.figure_size = [800, 420];
plot2d3(n22, y22d); plot(n22, y22d, 'b*');
ax = gca(); ax.data_bounds = [-3, -0.2; 5, 1.5];
title('Signal y(n) = x(n) . u(2-n)'); xlabel('n'); ylabel('y(n)'); xgrid;
xs2png(f22d, fig_dir + "22d.png");
close(f22d);

// (e1) x(n-1)
f22e1 = figure('visible', 'off');
f22e1.background = color('white');
f22e1.figure_size = [800, 420];
plot2d3(n22 + 1, x22); plot(n22 + 1, x22, 'b*');
ax = gca(); ax.data_bounds = [-2, -0.2; 6, 1.5];
title('Delayed Signal x(n-1)'); xlabel('n'); ylabel('x(n-1)'); xgrid;
xs2png(f22e1, fig_dir + "22e1.png");
close(f22e1);

// (e2) x(n-1) * delta(n-3) = x(2) * delta(n-3) = 1 at n=3
n22e = -1:5;
y22e = zeros(1, length(n22e));
y22e(n22e == 3) = 1;
f22e2 = figure('visible', 'off');
f22e2.background = color('white');
f22e2.figure_size = [800, 420];
plot2d3(n22e, y22e); plot(n22e, y22e, 'b*');
ax = gca(); ax.data_bounds = [-2, -0.2; 6, 1.5];
title('Signal y(n) = x(n-1) . delta(n-3)'); xlabel('n'); ylabel('y(n)'); xgrid;
xs2png(f22e2, fig_dir + "22e2.png");
close(f22e2);

// (f) x(n^2)
n22f = -2:2;
y22f = zeros(1, length(n22f));
for i = 1:length(n22f)
    sq = n22f(i)^2;
    if (sq >= -2) & (sq <= 4) then
        y22f(i) = x22(sq + x22_org);
    end
end
f22f = figure('visible', 'off');
f22f.background = color('white');
f22f.figure_size = [800, 420];
plot2d3(n22f, y22f); plot(n22f, y22f, 'b*');
ax = gca(); ax.data_bounds = [-3, -0.2; 3, 1.5];
title('Signal y(n) = x(n^2)'); xlabel('n'); ylabel('y(n)'); xgrid;
xs2png(f22f, fig_dir + "22f.png");
close(f22f);

// (g) Even part xe(n) = 0.5*(x(n) + x(-n))
n_sym = -4:4;
x_sym = zeros(1, length(n_sym));
x_sym(n_sym >= -2 & n_sym <= 4) = x22;
x_fold_sym = x_sym($:-1:1);
xe = 0.5 * (x_sym + x_fold_sym);

f22g = figure('visible', 'off');
f22g.background = color('white');
f22g.figure_size = [800, 420];
plot2d3(n_sym, xe); plot(n_sym, xe, 'b*');
ax = gca(); ax.data_bounds = [-5, -0.2; 5, 1.5];
title('Even Part xe(n) = 0.5 * (x(n) + x(-n))'); xlabel('n'); ylabel('xe(n)'); xgrid;
xs2png(f22g, fig_dir + "22g.png");
close(f22g);

// (h) Odd part xo(n) = 0.5*(x(n) - x(-n))
xo = 0.5 * (x_sym - x_fold_sym);

f22h = figure('visible', 'off');
f22h.background = color('white');
f22h.figure_size = [800, 420];
plot2d3(n_sym, xo); plot(n_sym, xo, 'b*');
ax = gca(); ax.data_bounds = [-5, -1; 5, 1];
title('Odd Part xo(n) = 0.5 * (x(n) - x(-n))'); xlabel('n'); ylabel('xo(n)'); xgrid;
xs2png(f22h, fig_dir + "22h.png");
close(f22h);

// ========================================================
// 9. Exercise 2.4: Even/Odd Analysis of [2, 3, 4, 5, 6]
// ========================================================
x24 = [2, 3, 4, 5, 6];
n24 = -2:2;
x24_f = x24($:-1:1);
xe24 = 0.5 * (x24 + x24_f);
xo24 = 0.5 * (x24 - x24_f);

f24 = figure('visible', 'off');
f24.background = color('white');
f24.figure_size = [800, 750];

subplot(3, 1, 1);
plot2d3(n24, x24); plot(n24, x24, 'b*');
ax = gca(); ax.data_bounds = [-3, 0; 3, 7];
title('Original Signal x(n)'); xlabel('n'); ylabel('x(n)'); xgrid;

subplot(3, 1, 2);
plot2d3(n24, xe24); plot(n24, xe24, 'b*');
ax = gca(); ax.data_bounds = [-3, 0; 3, 7];
title('Even Part xe(n)'); xlabel('n'); ylabel('xe(n)'); xgrid;

subplot(3, 1, 3);
plot2d3(n24, xo24); plot(n24, xo24, 'b*');
ax = gca(); ax.data_bounds = [-3, -3; 3, 3];
title('Odd Part xo(n)'); xlabel('n'); ylabel('xo(n)'); xgrid;

xs2png(f24, fig_dir + "24_plot.png");
close(f24);

disp("=== ALL SCILAB PLOTS GENERATED SUCCESSFULLY ===");
exit;
