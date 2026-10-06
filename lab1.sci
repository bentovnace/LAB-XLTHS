clear; clc;

fig_dir = "/work/LAB-XLTHS/Report/Lab/LabsReport/Labs/Lab_1/figures/";

// ========================
// Bai 1.1: Thao tac Vector
// ========================
function ex1()
    clear; clc;
    //-------1.1.a--------//
    x = 1:4;
    disp(x + 1);
    //-------1.1.b--------//
    x = 1:4;
    y = 5:8;
    disp(x .* y);
    //-------1.1.c--------//
    x = linspace(0, %pi, 10);
    disp(sin(x));
endfunction

// ========================
// Bai 1.2: Lay mau & Luong tu hoa
// ========================
function ex2()
    clear; clc;
    F0 = 50; 
    A = 3; 
    Fs = 300; 
    T0 = 1 / F0;
    Ts = 1 / Fs;

    t = linspace(0, 5 * T0, 2000);
    xa = A * sin(2 * %pi * F0 * t);

    n = 0:(5 * Fs / F0); 
    xn = A * sin(2 * %pi * F0 * (n * Ts));
    threshold = 1e-5;
    xn(abs(xn) < threshold) = 0;

    Delta = 0.1;
    xq = Delta * floor(xn / Delta);
    eq = xq - xn;

    f_all = figure('visible', 'off');
    f_all.background = color('white');
    f_all.figure_size = [1200, 450];

    subplot(1, 3, 1);
    plot(t, xa);
    a1 = gca(); a1.background = color('white');
    a1.data_bounds = [0, -3; 0.1, 3];
    title('Analog Signal x_a(t)');
    xlabel('t (s)'); ylabel('x_a(t)');
    xgrid;

    subplot(1, 3, 2);
    plot2d3(n, xn);
    plot(n, xn, 'b*');
    a2 = gca(); a2.background = color('white');
    a2.data_bounds = [0, -3; 30, 3];
    title('Discrete-Time Signal x(n)');
    xlabel('n'); ylabel('x(n)');
    xgrid;

    subplot(1, 3, 3);
    plot2d3(n, xq);
    plot(n, xq, 'b*');
    a3 = gca(); a3.background = color('white');
    a3.data_bounds = [0, -3; 30, 3];
    title('Quantized Signal x_q(n)');
    xlabel('n'); ylabel('x_q(n)');
    xgrid;

    xs2png(f_all, "/work/LAB-XLTHS/Report/Lab/LabsReport/Labs/Lab_1/figures/ex1_2_combined.png");
    close(f_all);

    f_err = figure('visible', 'off');
    f_err.background = color('white');
    f_err.figure_size = [800, 420];
    plot2d3(n, eq, style=5);
    plot(n, eq, 'kd');
    a_err = gca(); a_err.background = color('white');
    a_err.data_bounds = [0, -0.11; 30, 0.01];
    title('Quantization Error e_q(n)');
    xlabel('n'); ylabel('e_q(n)');
    xgrid;
    xs2png(f_err, "/work/LAB-XLTHS/Report/Lab/LabsReport/Labs/Lab_1/figures/ex1_2_error.png");
    close(f_err);
endfunction
