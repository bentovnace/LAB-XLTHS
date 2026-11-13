clear;
clc;
close;

out_fig_dir = "/work/LAB-XLTHS/Report/Lab/LabsReport/Labs/Lab_5/figures/";

printf("\n=================================================================\n");
printf("BAI TAP 1: KHAO SAT HE THONG y(n) - y(n-2) = x(n)\n");
printf("=================================================================\n");

N1 = 15;
n1 = 0:(N1-1);
x1 = zeros(1, N1);
x1(1) = 1;

h1_sim = zeros(1, N1);
for k = 1:N1
    prev2 = 0;
    if k - 2 >= 1 then
        prev2 = h1_sim(k - 2);
    end
    h1_sim(k) = prev2 + x1(k);
end

h1_theory = 0.5 * (1 + (-1).^n1);

printf("Dap ung xung mo phong (10 mau dau): \n");
disp(h1_sim(1:10));
printf("Dap ung xung ly thuyet (10 mau dau): \n");
disp(h1_theory(1:10));

f1 = figure("Figure_name", "Lab 5 - Bai tap 1: Dap ung xung h(n)", "Position", [100, 100, 800, 450]);
f1.background = color("white");

plot2d3(n1, h1_sim, 2);
poly1 = gca();
poly1.children.children.thickness = 2;

plot(n1, h1_sim, "bo");
h_axes = gca();
h_axes.data_bounds = [-1, -0.2; N1, 1.4];
h_axes.x_location = "origin";
h_axes.grid = [color("gray"), color("gray")];
title("Impulse Response h(n) of System y(n) - y(n-2) = x(n)", "fontsize", 3);
xlabel("n", "fontsize", 3);
ylabel("h(n)", "fontsize", 3);

xs2png(f1, out_fig_dir + "ex1_h_stem.png");
close(f1);


printf("\n=================================================================\n");
printf("BAI TAP 2: TINH TICH CHAP BANG BIEN DOI Z\n");
printf("=================================================================\n");

x2a_1 = [1, 2, 3, 4, 5];
x2a_2 = [1, 1, 1];
y2a = convol(x2a_1, x2a_2);

printf("Cau 2a: Tich chap x1 * x2 = \n");
disp(y2a);

nb = 0:5;
yb_theory = -(1/9) * (0.2).^nb + (10/9) * (2).^nb;
printf("Cau 2b (6 mau dau ly thuyet): \n");
disp(yb_theory);

nc = 0:5;
yc_theory = 2 * (2.^nc - nc - 1);
printf("Cau 2c (6 mau dau ly thuyet): \n");
disp(yc_theory);

f2 = figure("Figure_name", "Lab 5 - Bai tap 2a: Tich chap", "Position", [100, 100, 800, 500]);
f2.background = color("white");

subplot(3, 1, 1);
plot2d3(0:4, x2a_1, 2);
plot(0:4, x2a_1, "bo");
ax2_1 = gca();
ax2_1.data_bounds = [-1, 0; 7, 6];
ax2_1.grid = [color("gray"), color("gray")];
title("Input Signal x1(n) = [1, 2, 3, 4, 5]", "fontsize", 2);
ylabel("x1(n)");

subplot(3, 1, 2);
plot2d3(0:2, x2a_2, 5);
plot(0:2, x2a_2, "rd");
ax2_2 = gca();
ax2_2.data_bounds = [-1, 0; 7, 2];
ax2_2.grid = [color("gray"), color("gray")];
title("Input Signal x2(n) = [1, 1, 1]", "fontsize", 2);
ylabel("x2(n)");

subplot(3, 1, 3);
plot2d3(0:6, y2a, 3);
plot(0:6, y2a, "g^");
ax2_3 = gca();
ax2_3.data_bounds = [-1, 0; 7, 14];
ax2_3.grid = [color("gray"), color("gray")];
title("Convolution Output y(n) = x1(n) * x2(n)", "fontsize", 2);
xlabel("n");
ylabel("y(n)");

xs2png(f2, out_fig_dir + "ex2a_conv_stem.png");
close(f2);


printf("\n=================================================================\n");
printf("BAI TAP 4: HE THONG BAC 1 y(n) = 0.7y(n-1) + x(n)\n");
printf("=================================================================\n");

N4 = 20;
n4 = 0:(N4-1);
x4 = ones(1, N4);

y4_sim = zeros(1, N4);
for k = 1:N4
    prev = 0;
    if k - 1 >= 1 then
        prev = y4_sim(k - 1);
    end
    y4_sim(k) = 0.7 * prev + x4(k);
end

y4_theory = (10 - 7 * (0.7).^n4) / 3;

printf("Dap ung buoc nhay mo phong (10 mau dau): \n");
disp(y4_sim(1:10));
printf("Dap ung buoc nhay ly thuyet (10 mau dau): \n");
disp(y4_theory(1:10));

f4 = figure("Figure_name", "Lab 5 - Bai tap 4: Dap ung buoc nhay", "Position", [100, 100, 800, 450]);
f4.background = color("white");

plot2d3(n4, y4_sim, 2);
plot(n4, y4_sim, "bo");
plot(n4, y4_theory, "r--");
ax4 = gca();
ax4.data_bounds = [-1, 0; N4, 4];
ax4.grid = [color("gray"), color("gray")];
title("Step Response y(n) of System y(n) = 0.7y(n-1) + x(n)", "fontsize", 3);
xlabel("n", "fontsize", 3);
ylabel("y(n)", "fontsize", 3);
legend(["Scilab Simulation (stems)"; "Analytical Solution: (10 - 7*0.7^n)/3"], opt=4);

xs2png(f4, out_fig_dir + "ex4_step_response.png");
close(f4);


printf("\n=================================================================\n");
printf("BAI TAP 5: HE THONG BAC 2 y(n) = 2y(n-1) - 3y(n-2) + x(n) + x(n-1)\n");
printf("=================================================================\n");

N5 = 8;
n5 = 0:(N5-1);

y_zi_sim = zeros(1, N5);
for k = 1:N5
    p1 = (k == 1) * 1 + (k > 1) * y_zi_sim(max(1, k - 1));
    p2 = (k == 1) * 1 + (k == 2) * 1 + (k > 2) * y_zi_sim(max(1, k - 2));
    y_zi_sim(k) = 2 * p1 - 3 * p2;
end

r5 = sqrt(3);
theta5 = atan(sqrt(2));
y_zi_theory = zeros(1, N5);
for k = 1:N5
    curr_n = k - 1;
    z_pole = 1 + %i * sqrt(2);
    term = (-0.5 + %i * sqrt(2)) * (z_pole^curr_n) + (-0.5 - %i * sqrt(2)) * (conj(z_pole)^curr_n);
    y_zi_theory(k) = real(term);
end

printf("y_zi(n) mo phong: \n");
disp(y_zi_sim);
printf("y_zi(n) ly thuyet: \n");
disp(y_zi_theory);

x5 = 2.^n5;
y_zs_sim = zeros(1, N5);
for k = 1:N5
    p1 = 0;
    if k - 1 >= 1 then p1 = y_zs_sim(k - 1); end
    p2 = 0;
    if k - 2 >= 1 then p2 = y_zs_sim(k - 2); end
    
    x_curr = x5(k);
    x_prev = 0;
    if k - 1 >= 1 then x_prev = x5(k - 1); end
    
    y_zs_sim(k) = 2 * p1 - 3 * p2 + x_curr + x_prev;
end

y_zs_theory = zeros(1, N5);
for k = 1:N5
    curr_n = k - 1;
    z_pole = 1 + %i * sqrt(2);
    c_pole = -0.5 - %i * (sqrt(2)/2);
    term = 2 * (2^curr_n) + c_pole * (z_pole^curr_n) + conj(c_pole) * (conj(z_pole)^curr_n);
    y_zs_theory(k) = real(term);
end

printf("y_zs(n) mo phong: \n");
disp(y_zs_sim);
printf("y_zs(n) ly thuyet: \n");
disp(y_zs_theory);

y_total_sim = y_zi_sim + y_zs_sim;
y_total_theory = y_zi_theory + y_zs_theory;

printf("Total y(n) mo phong: \n");
disp(y_total_sim);
printf("Total y(n) ly thuyet: \n");
disp(y_total_theory);

f5 = figure("Figure_name", "Lab 5 - Bai tap 5: Cac dap ung", "Position", [100, 100, 800, 600]);
f5.background = color("white");

subplot(3, 1, 1);
plot2d3(n5, y_zi_sim, 5);
plot(n5, y_zi_sim, "rd");
ax5_1 = gca();
ax5_1.grid = [color("gray"), color("gray")];
title("Zero-Input Response y_zi(n) with Initial Conditions y(-1)=y(-2)=1", "fontsize", 2);
ylabel("y_zi(n)");

subplot(3, 1, 2);
plot2d3(n5, y_zs_sim, 2);
plot(n5, y_zs_sim, "bo");
ax5_2 = gca();
ax5_2.grid = [color("gray"), color("gray")];
title("Zero-State Response y_zs(n) with Input x(n) = 2^n u(n)", "fontsize", 2);
ylabel("y_zs(n)");

subplot(3, 1, 3);
plot2d3(n5, y_total_sim, 3);
plot(n5, y_total_sim, "g^");
ax5_3 = gca();
ax5_3.grid = [color("gray"), color("gray")];
title("Total System Response y(n) = y_zi(n) + y_zs(n)", "fontsize", 2);
xlabel("n");
ylabel("y(n)");

xs2png(f5, out_fig_dir + "ex5_responses.png");
close(f5);

printf("\nHoan thanh toan bo mo phong Lab 5 thanh cong!\n");
