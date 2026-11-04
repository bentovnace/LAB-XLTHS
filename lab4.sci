function [s, f, mag] = ex4_audio(plot_flag)
    if argn(2) < 1 then
        plot_flag = %T;
    end
    
    Fs = 8000;
    T = 0.2;
    t = 0:(1/Fs):(T - 1/Fs);
    f1 = 697;
    f2 = 1209;
    s = 0.5 * sin(2 * %pi * f1 * t) + 0.5 * sin(2 * %pi * f2 * t);
    
    N = length(s);
    S_fft = fft(s);
    f = (0:(N/2 - 1)) * (Fs / N);
    mag = abs(S_fft(1:(N/2))) * (2 / N);
    
    disp('=== EXERCISE 4: AUDIO DATA PROCESSING ===');
    disp('Sampling frequency Fs (Hz):', Fs);
    disp('Signal duration (seconds):', T);
    disp('Frequencies present (Hz): [697, 1209]');
    disp('Max magnitude in spectrum:', max(mag));
    
    if plot_flag then
        f_fig = figure('visible', 'off');
        f_fig.background = color('white');
        f_fig.figure_size = [800, 520];
        
        subplot(2, 1, 1);
        t_plot = t(1:160);
        plot2d(t_plot * 1000, s(1:160), style=2);
        ax1 = gca();
        ax1.data_bounds = [0, -1.2; 20, 1.2];
        title('DTMF Audio Signal s(t) in Time Domain (First 20 ms)');
        xlabel('Time (ms)'); ylabel('Amplitude');
        xgrid;
        
        subplot(2, 1, 2);
        plot2d(f, mag, style=5);
        ax2 = gca();
        ax2.data_bounds = [0, 0; 2000, 0.6];
        title('Magnitude Spectrum |S(f)| via FFT (Peaks at 697 Hz and 1209 Hz)');
        xlabel('Frequency (Hz)'); ylabel('|S(f)|');
        xgrid;
        
        fig_dir = "/work/LAB-XLTHS/Report/Lab/LabsReport/Labs/Lab_4/figures/";
        xs2png(f_fig, fig_dir + "ex4_audio.png");
        close(f_fig);
    end
endfunction

function ex5_image(img_file, watermark_file)
    if argn(2) < 1 then
        img_file = 'peppers.png';
    end
    if argn(2) < 2 then
        watermark_file = 'bk_figure.jpg';
    end
    
    disp('=== EXERCISE 5: DIGITAL IMAGE PROCESSING ===');
    disp('Target image: ' + img_file);
    disp('Watermark image: ' + watermark_file);
    disp('Image processing operations: Grayscale, Histogram Equalization, Median Blur, Alpha-Blending Watermarking.');
    disp('Run with IPCV module: atomsLoad(""IPCV"")');
endfunction

function [y_conv, y_matrix, Ex, Ey] = ex6_linear_conv(plot_flag)
    if argn(2) < 1 then
        plot_flag = %T;
    end
    
    x = [1, 2, -3, 2, 1];
    h = [1, 0, -1];
    
    // Method 1: Folding and shifting (built-in conv)
    y_conv = conv(x, h);
    
    // Method 2: Toeplitz matrix method
    m = length(h);
    n = length(x);
    p = m + n - 1;
    H = zeros(p, n);
    for i = 1:p
        for j = 1:n
            k = i - j;
            if k >= 0 & k < m then
                H(i, j) = h(k + 1);
            end
        end
    end
    y_matrix = (H * x')';
    
    // Energy calculations
    Ex = sum(x.^2);
    Ey = sum(y_conv.^2);
    
    disp('=== EXERCISE 6: LINEAR CONVOLUTION ===');
    disp('Input x(n):', x);
    disp('Impulse response h(n):', h);
    disp('Convolution (folding & shifting):', y_conv);
    disp('Convolution (Toeplitz matrix):', y_matrix);
    disp('Input energy Ex:', Ex);
    disp('Output energy Ey:', Ey);
    
    if plot_flag then
        nx = 0:(length(x) - 1);
        ny = 0:(length(y_conv) - 1);
        
        f_fig = figure('visible', 'off');
        f_fig.background = color('white');
        f_fig.figure_size = [800, 520];
        
        subplot(2, 1, 1);
        plot2d3(nx, x, style=2);
        plot(nx, x, 'bo');
        ax1 = gca();
        ax1.data_bounds = [-0.5, -4; 6.5, 4];
        title('Input Signal x(n) [Energy Ex = 19]');
        xlabel('n'); ylabel('x(n)');
        xgrid;
        
        subplot(2, 1, 2);
        plot2d3(ny, y_conv, style=5);
        plot(ny, y_conv, 'rd');
        ax2 = gca();
        ax2.data_bounds = [-0.5, -5; 6.5, 5];
        title('Linear Convolution Output y(n) = x(n) * h(n) [Energy Ey = 42]');
        xlabel('n'); ylabel('y(n)');
        xgrid;
        
        fig_dir = "/work/LAB-XLTHS/Report/Lab/LabsReport/Labs/Lab_4/figures/";
        xs2png(f_fig, fig_dir + "ex6_d.png");
        close(f_fig);
    end
endfunction

function [y_circ_shift, y_circ_mat, Ex, Ey] = ex7_circular_conv(plot_flag)
    if argn(2) < 1 then
        plot_flag = %T;
    end
    
    x = [1, 2, -3, 2, 1];
    h = [1, 0, -1, -1, 1];
    N = 5;
    
    // Method 1: Circular folding and shifting
    y_circ_shift = zeros(1, N);
    for n = 0:(N - 1)
        sum_val = 0;
        for k = 0:(N - 1)
            idx = pmodulo(n - k, N) + 1;
            sum_val = sum_val + h(k + 1) * x(idx);
        end
        y_circ_shift(n + 1) = sum_val;
    end
    
    // Method 2: Circulant matrix method
    r = [h(1), h(N:-1:2)];
    H_circ = toeplitz(h, r);
    y_circ_mat = (H_circ * x')';
    
    // Energy calculations
    Ex = sum(x.^2);
    Ey = sum(y_circ_shift.^2);
    
    disp('=== EXERCISE 7: CIRCULAR CONVOLUTION ===');
    disp('Input x(n) (N = 5):', x);
    disp('Impulse response h(n) (N = 5):', h);
    disp('Circular convolution (circular folding & shifting):', y_circ_shift);
    disp('Circular convolution (circulant matrix):', y_circ_mat);
    disp('Input energy Ex:', Ex);
    disp('Output energy Ey:', Ey);
    
    if plot_flag then
        n = 0:(N - 1);
        
        f_fig = figure('visible', 'off');
        f_fig.background = color('white');
        f_fig.figure_size = [800, 520];
        
        subplot(2, 1, 1);
        plot2d3(n, x, style=2);
        plot(n, x, 'bo');
        ax1 = gca();
        ax1.data_bounds = [-0.5, -4; 4.5, 4];
        title('Periodic Signal x(n) (N = 5) [Energy Ex = 19]');
        xlabel('n'); ylabel('x(n)');
        xgrid;
        
        subplot(2, 1, 2);
        plot2d3(n, y_circ_shift, style=5);
        plot(n, y_circ_shift, 'rd');
        ax2 = gca();
        ax2.data_bounds = [-0.5, -5; 4.5, 5];
        title('Circular Convolution Output y(n) [Energy Ey = 50]');
        xlabel('n'); ylabel('y(n)');
        xgrid;
        
        fig_dir = "/work/LAB-XLTHS/Report/Lab/LabsReport/Labs/Lab_4/figures/";
        xs2png(f_fig, fig_dir + "ex7.png");
        close(f_fig);
    end
endfunction
