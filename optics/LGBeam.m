function UOut = LGBeam(p, l, w_0, z, lambda, rho, theta)
%LGBEAM   Calculate the distribution of the LG beam field amplitude.
%
%   LGBEAM(p, l, w_0, z, lambda, rho, phi) is the complex scalar function
%   describing the distribution of the Laguerre-Gaussian beam field
%   amplitude which satisfies the wave equation in the paraxial
%   approximation and constrained by the following parameters:
%   * p         Radial quantum number
%   * l         Angular quantum number
%   * w_0       Beam waist size
%   * z         Propagation distance
%   * lambda    beam wavelength
%   * rho       radius in cylindrical coordinates
%   * theta     angle in cylindrical coordinates
%
%   reference:
%   * <https://doi.org/10.1016/0030-4018(93)90535-D>
%   * <https://en.wikipedia.org/wiki/Gaussian_beam#Laguerre-Gaussian_modes>
%
%   * version:    v1.0.1
%   * created:    2023.03.10
%   * modified:   2023.03.12
%   * author:     yi_Xu
%   * email:      yi_Xu@yixuju.cn

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
rw_z = rho ./ w_z;
rw_z2 = rw_z.^2;
L = laguerre(p, abs(l), 2 .* rw_z2);
% 光束输出振幅分布
UOut = C_lp .* (1 ./ w_z) .* (sqrt(2) .* rw_z).^abs(l) ...
    .* exp(-rw_z2) .* L ...
    .* 1 ./ (exp(-1i .* (k .* (rho.^2) ./ (2 * R_z))) ...
    .* exp(1i * phi_z) .* exp(-1i .* l .* theta));

end
