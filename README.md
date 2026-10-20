# LAB-XLTHS: Digital Signal Processing (DSP) Laboratory

Mã nguồn thực hành môn Xử Lý Tín Hiệu Số trên phần mềm SciLab 2026.

## Cấu trúc thư mục

- `lab1.sci`: Mã nguồn thực hành Lab 1 (Các phép toán cơ bản trên vector & ma trận, lấy mẫu và lượng tử hóa tín hiệu).
- `lab2.sci`: Mã nguồn thực hành Lab 2 (Các hàm cơ bản, tín hiệu bước nhảy, tín hiệu xung đơn vị, tín hiệu dốc, phân tách chẵn/lẻ, cộng/nhân tín hiệu).
- `lab2_bonus.sci`: Mã nguồn các bài tập bổ sung Lab 2 (Khảo sát tính tuần hoàn, mô phỏng hiện tượng Aliasing).
- `lab3.sci`: Thư viện mã nguồn các hàm cơ bản Lab 3:
  - `delay(xn, xorigin, k)`: Dịch trễ thời gian $y(n) = x(n - k)$.
  - `advance(xn, xorigin, k)`: Dịch sớm thời gian $y(n) = x(n + k)$.
  - `fold(xn, xorigin)`: Đảo trục thời gian $y(n) = x(-n)$.
  - `add(x1n, x1origin, x2n, x2origin)`: Cộng hai tín hiệu rời rạc $y(n) = x_1(n) + x_2(n)$.
  - `multi(x1n, x1origin, x2n, x2origin)`: Nhân hai tín hiệu rời rạc $y(n) = x_1(n) \cdot x_2(n)$.
  - `convolution(xn, xorigin, hn, horigin)`: Tích chập rời rạc $y(n) = x(n) * h(n)$.
  - `bai21()`: Bài tập mở rộng 2.1 ($y(n) = x(4 - n)$).
  - `bai22()`: Bài tập mở rộng 2.2 (8 phép biến đổi tín hiệu mẫu).
  - `bai24()`: Bài tập mở rộng 2.4 (Phân tách và tái thiết chẵn - lẻ).
  - `bai26()`: Bài tập mở rộng 2.6 (Kiểm chứng tính bất biến thời gian $y(n) = x(n^2)$).
- `lab3_bonus.sci`: Script thực thi tự động toàn bộ 4 bài tập mở rộng/bonus của Lab 3 (Bài 2.1, 2.2, 2.4, 2.6).
- `generate_all_plots.sci`: Script tự động xuất toàn bộ đồ thị dạng sóng chuẩn SciLab sang ảnh PNG độ nét cao.

## Hướng dẫn thực thi

Trong cửa sổ Scilab Console:

```scilab
// Nạp toàn bộ thư viện Lab 3
exec('lab3.sci', -1);

// Chạy bài tập bonus / mở rộng Lab 3
exec('lab3_bonus.sci', -1);
```
