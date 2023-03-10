function UOut = LGBeam(p, l, w_0, z, lambda, r, phi)
%LGBEAM   Calculate the distribution of the LG beam field amplitude.
%
%   LGBEAM(p, l, w, z, lambda, r, phi) is the complex scalar function
%   describing the distribution of the Laguerre-Gaussian beam field
%   amplitude which satisfies the wave equation in the paraxial
%   approximation and constrained by the following parameters:
%   * p         Radial quantum number
%   * l         Angular quantum number
%   * w_0       Beam waist size
%   * z         Propagation distance
%   * lambda    beam wavelength
%   * r         radius in cylindrical coordinates
%   * phi       angle in cylindrical coordinates
%
%   reference:
%   * <https://doi.org/10.1016/0030-4018(93)90535-D>
%   * <https://en.wikipedia.org/wiki/Gaussian_beam#Laguerre-Gaussian_modes>
%
%   * version:    v1.0.0
%   * created:    2023.03.10
%   * modified:   2023.03.10
%   * author:     yi_Xu
%   * email:      yi_Xu@yixuju.cn
%
%LGBEAM   计算LG光束场振幅的分布
%
%   LGBEAM(p, l, w, z, lambda, r, phi) 是一个复数标量函数，
%   描述了满足准轴近似下的波动方程并受以下参数限制的拉盖尔-高斯光束场振幅分布：
%   * p         径向量子数
%   * l         角向量子数
%   * w_0       光束束腰尺寸
%   * z         传播距离
%   * lambda    光束波长
%   * r         柱坐标系中的半径
%   * phi       柱坐标系中的角度
%
%   参考链接:
%   * <https://doi.org/10.1016/0030-4018(93)90535-D>
%   * <https://en.wikipedia.org/wiki/Gaussian_beam#Laguerre-Gaussian_modes>
%
%   * 版本:         v1.0.0
%   * 创建时间:     2023.03.10
%   * 修改时间:     2023.03.10
%   * 作者:         yi_Xu
%   * 邮箱:         yi_Xu@yixuju.cn

% 波数
k = 2 * pi / lambda;
% 共焦参数 瑞利长度
n = 1; % 考虑真空折射率为n=1
z_R = pi * w_0^2 * n / lambda;
% 归一化常数
C_lp = sqrt(2 * factorial(p) / (pi * factorial(p + abs(l))));
% 光束在传播到距离为z处的束腰
w_z = w_0 * sqrt(1 + (z / z_R)^2);
% 组合模数
N = abs(l) + 2 * p;
% Gouy 相位
phi_z = (N + 1) * atan(z / z_R);
% 波前曲率半径
if z == 0
    R_z = inf;
else
    R_z = z * (1 + (z_R / z)^2);
end

%自定义代换变量
rw_z = r ./ w_z;
rw_z2 = rw_z.^2;
L = laguerre(p, abs(l), 2 .* rw_z2);
% 光束输出振幅分布
UOut = C_lp .* (1 ./ w_z) .* (sqrt(2) .* rw_z).^abs(l) ...
.* exp(-rw_z2) .* L ...
    .* 1 ./ (exp(-1i .* (k .* (r.^2) ./ (2 * R_z))) ...
    .* exp(1i * phi_z) .* exp(-1i .* l .* phi));

end
