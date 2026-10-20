function [yn, yorigin] = delay(xn, xorigin, k)
    yn = xn;
    yorigin = xorigin - k;
    disp('yn = ', yn);
    disp('yorigin = ', yorigin);
    nx = (1:length(xn)) - xorigin;
    ny = (1:length(yn)) - yorigin;
    
    subplot(2, 1, 1);
    plot2d3(nx, xn);
    plot(nx, xn, 'b*');
    ax = gca();
    ax.data_bounds = [min(nx)-1, min(xn)-1; max(nx)+k+1, max(xn)+1];
    title('Signal x(n)');
    xlabel('n');
    ylabel('x(n)');
    xgrid;
    
    subplot(2, 1, 2);
    plot2d3(ny, yn);
    plot(ny, yn, 'b*');
    ay = gca();
    ay.data_bounds = [min(ny)-k-1, min(yn)-1; max(ny)+1, max(yn)+1];
    title('Signal y(n) = Delay x(n)');
    xlabel('n');
    ylabel('y(n)');
    xgrid;
endfunction

function [yn, yorigin] = advance(xn, xorigin, k)
    yn = xn;
    yorigin = xorigin + k;
    disp('yn = ', yn);
    disp('yorigin = ', yorigin);
    nx = (1:length(xn)) - xorigin;
    ny = (1:length(yn)) - yorigin;
    
    subplot(2, 1, 1);
    plot2d3(nx, xn);
    plot(nx, xn, 'b*');
    ax = gca();
    ax.data_bounds = [min(nx)-k-1, min(xn)-1; max(nx)+1, max(xn)+1];
    title('Signal x(n)');
    xlabel('n');
    ylabel('x(n)');
    xgrid;
    
    subplot(2, 1, 2);
    plot2d3(ny, yn);
    plot(ny, yn, 'b*');
    ay = gca();
    ay.data_bounds = [min(ny)-1, min(yn)-1; max(ny)+k+1, max(yn)+1];
    title('Signal y(n) = Advance x(n)');
    xlabel('n');
    ylabel('y(n)');
    xgrid;
endfunction

function [yn, yorigin] = fold(xn, xorigin)
    yn = xn($:-1:1);
    yorigin = length(xn) - xorigin + 1;
    disp('yn = ', yn);
    disp('yorigin = ', yorigin);
    nx = (1:length(xn)) - xorigin;
    ny = (1:length(yn)) - yorigin;
    
    subplot(2, 1, 1);
    plot2d3(nx, xn);
    plot(nx, xn, 'b*');
    ax = gca();
    ax.data_bounds = [min(nx)-1, min(xn)-1; max(nx)+2, max(xn)+1];
    title('Signal x(n)');
    xlabel('n');
    ylabel('x(n)');
    xgrid;
    
    subplot(2, 1, 2);
    plot2d3(ny, yn);
    plot(ny, yn, 'b*');
    ay = gca();
    ay.data_bounds = [min(ny)-2, min(yn)-1; max(ny)+1, max(yn)+1];
    title('Signal y(n) = Fold x(n)');
    xlabel('n');
    ylabel('y(n)');
    xgrid;
endfunction

function [yn, yorigin] = add(x1n, x1origin, x2n, x2origin)
    n1_start = 1 - x1origin;
    n1_end   = length(x1n) - x1origin;
    n2_start = 1 - x2origin;
    n2_end   = length(x2n) - x2origin;
    n_start  = min(n1_start, n2_start);
    n_end    = max(n1_end  , n2_end);
    yorigin  = 1 - n_start;
    ny = n_start:n_end;
    yn = zeros(1, length(ny));
    for i = 1:length(ny)
        if (ny(i) >= n1_start) & (ny(i) <= n1_end) then
            index1 = ny(i) + x1origin;
            yn(i)  = yn(i) + x1n(index1);
        end
        if (ny(i) >= n2_start) & (ny(i) <= n2_end) then
            index2 = ny(i) + x2origin;
            yn(i)  = yn(i) + x2n(index2);
        end
    end

    subplot(3, 1, 1);
    plot2d3(n1_start:n1_end, x1n);
    plot(n1_start:n1_end, x1n, 'b*');
    ax1 = gca();
    ax1.data_bounds = [n1_start-2, min(x1n)-1; n1_end+1, max(x1n)+1];
    title('Signal x1(n)');
    xlabel('n');
    ylabel('x1(n)');
    xgrid;

    subplot(3, 1, 2);
    plot2d3(n2_start:n2_end, x2n);
    plot(n2_start:n2_end, x2n, 'b*');
    ax2 = gca();
    ax2.data_bounds = [n2_start-1, min(x2n)-1; n2_end+2, max(x2n)+1];
    title('Signal x2(n)');
    xlabel('n');
    ylabel('x2(n)');
    xgrid;

    subplot(3, 1, 3);
    plot2d3(ny, yn);
    plot(ny, yn, 'b*');
    ay = gca();
    ay.data_bounds = [n_start-1, min(yn)-1; n_end+1, max(yn)+1];
    title('Signal y(n) = x1(n) + x2(n)');
    xlabel('n');
    ylabel('y(n)');
    xgrid;
endfunction

function [yn, yorigin] = multi(x1n, x1origin, x2n, x2origin)
    n1_start = 1 - x1origin;
    n1_end   = length(x1n) - x1origin;
    n2_start = 1 - x2origin;
    n2_end   = length(x2n) - x2origin;
    n_start  = min(n1_start, n2_start);
    n_end    = max(n1_end  , n2_end);
    yorigin  = 1 - n_start;
    ny  = n_start:n_end;
    yn = zeros(1, length(ny));
    for i = 1:length(ny)
        if (ny(i) >= max(n1_start, n2_start)) & (ny(i) <= min(n1_end, n2_end)) then
            index1 = ny(i) + x1origin;
            index2 = ny(i) + x2origin;
            yn(i)  = yn(i) + x1n(index1) * x2n(index2);
        end
    end
    
    subplot(3, 1, 1);
    plot2d3(n1_start:n1_end, x1n);
    plot(n1_start:n1_end, x1n, 'b*');
    ax1 = gca();
    ax1.data_bounds = [n1_start-2, min(x1n)-1; n1_end+1, max(x1n)+1];
    title('Signal x1(n)');
    xlabel('n');
    ylabel('x1(n)');
    xgrid;
    
    subplot(3, 1, 2);
    plot2d3(n2_start:n2_end, x2n);
    plot(n2_start:n2_end, x2n, 'b*');
    ax2 = gca();
    ax2.data_bounds = [n2_start-1, min(x2n)-1; n2_end+2, max(x2n)+1];
    title('Signal x2(n)');
    xlabel('n');
    ylabel('x2(n)');
    xgrid;
    
    subplot(3, 1, 3);
    plot2d3(ny, yn);
    plot(ny, yn, 'b*');
    ay = gca();
    ay.data_bounds = [n_start-1, min(yn)-1; n_end+1, max(yn)+1];
    title('Signal y(n) = x1(n) . x2(n)');
    xlabel('n');
    ylabel('y(n)');
    xgrid;
endfunction

function [yn, yorigin] = convolution(xn, xorigin, hn, horigin)
    nx = (1:length(xn)) - xorigin;
    nh = (1:length(hn)) - horigin;
    n_start = min(nx) + min(nh);
    n_end   = max(nx) + max(nh);
    ny      = n_start:n_end;
    yorigin = 1 - n_start;
    yn      = zeros(1, length(ny));
    for ix = 1:length(xn)
        for ih = 1:length(hn)
            n_val = nx(ix) + nh(ih);
            iy = n_val - n_start + 1;
            yn(iy) = yn(iy) + xn(ix) * hn(ih);
        end
    end
    disp('Implemented convolution yn = ', yn);
    disp('yorigin = ', yorigin);
    disp('Built-in convolution = ', conv(xn, hn));
endfunction

function bai21()
    xn = [0, 1/3, 2/3, 1, 1, 1, 1];
    xn_range = -3:3;
    xn_origin = 4;
    plot2d3(xn_range, xn);
    plot(xn_range, xn, 'b*');
    ax = gca();
    ax.data_bounds = [-4, -1; 4, 2];
    title('Signal x(n) - Exercise 2.1');
    xlabel('n');
    ylabel('x(n)');
    xgrid;
    [xn_f, xn_f_origin] = fold(xn, xn_origin);
    [yn, yorigin] = delay(xn_f, xn_f_origin, 4);
endfunction

function bai22()
    xn = [0, 1, 1, 1, 1, 0.5, 0.5];
    xorigin = 3;
    [ya, ya_origin] = delay(xn, xorigin, 2);
    [x_f, org_f] = fold(xn, xorigin);
    [yb, yb_origin] = delay(x_f, org_f, 4);
    [yc, yc_origin] = advance(xn, xorigin, 2);
    un = [1, 1, 1, 1, 1, 0, 0];
    uorigin = 3;
    [yd, yd_origin] = multi(xn, xorigin, un, uorigin);
    [x_d1, org_d1] = delay(xn, xorigin, 1);
    deltan = [0, 0, 0, 1];
    delta_origin = 1;
    [ye, ye_origin] = multi(x_d1, org_d1, deltan, delta_origin);
    nf = -2:2;
    yf = zeros(1, length(nf));
    for i = 1:length(nf)
        n_sq = nf(i)^2;
        if (n_sq >= -2) & (n_sq <= 4) then
            yf(i) = xn(n_sq + xorigin);
        end
    end
    [x_fold, org_fold] = fold(xn, xorigin);
    [x_add, org_add] = add(xn, xorigin, x_fold, org_fold);
    xe = 0.5 * x_add;
    x_fold_neg = -1 * x_fold;
    [x_sub, org_sub] = add(xn, xorigin, x_fold_neg, org_fold);
    xo = 0.5 * x_sub;
endfunction

function bai24()
    xn = [2, 3, 4, 5, 6];
    xorigin = 3;
    [xn_f, org_f] = fold(xn, xorigin);
    xe = 0.5 * (xn + xn_f);
    xo = 0.5 * (xn - xn_f);
    disp('Even component xe = ', xe);
    disp('Odd component xo = ', xo);
    disp('Reconstructed x_rec = ', xe + xo);
endfunction

function bai26()
    xn = [1, 1, 1, 1];
    xorigin = 1;
    n_in = 0:3;
    n_out = -2:2;
    yn = zeros(1, length(n_out));
    for i = 1:length(n_out)
        sq = n_out(i)^2;
        if (sq >= 0) & (sq <= 3) then
            yn(i) = 1;
        end
    end
    disp('Input x(n): ', xn);
    disp('System output y(n) = x(n^2): ', yn);
endfunction
