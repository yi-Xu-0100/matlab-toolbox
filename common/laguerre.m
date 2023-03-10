function result = laguerre(n, alpha, x)
%LAGUERRE   Calculate the value of Laguerre polynomial The function.
%
%   LAGUERRE(n, alpha, x) returns the Laguerre polynomial of variable x,
%   with respect to the constant parameters n and alpha. Typically, the
%   variable x is an array, while the constant parameters n and alpha are
%   integers.
%
%   $result = L_n^{\alpha}(x)$
%
%   According to the definition of Laguerre polynomial, this function
%   employs the Qin Jiushao algorithm to calculate the Laguerre polynomial.
%
%   * version:    v1.0.1
%   * created:    2023.03.03
%   * modified:   2023.03.10
%   * author:     yi_Xu
%   * email:      yi_Xu@yixuju.cn
%
%   See also LGBEAM.
%
%   Reference:
%   * <https://zh.wikipedia.org/wiki/拉盖尔多项式>
%
%LAGUERRE 计算拉盖尔多项式的值
%
%   LAGUERRE(n, alpha, x) 返回变量x的拉盖尔多项式，与常数参数n和alpha有关。
%   通常，变量x是一个数组，而常数参数n和alpha是整数。
%
%   $result = L_n^{\alpha}(x)$
%
%   根据拉盖尔多项式的定义，该函数采用了秦九韶算法来计算拉盖尔多项式。
%
%   同时可查看 LGBEAM。
%
%   参考链接:
%   * <https://zh.wikipedia.org/wiki/拉盖尔多项式>
%
%   * 版本:         v1.0.1
%   * 创建时间:     2023.03.03
%   * 修改时间:     2023.03.10
%   * 作者:         yi_Xu
%   * 邮箱:         yi_Xu@yixuju.cn

result = 1;
bin = 1;

for i = n:-1:1
    bin = bin * (alpha + i) / (n + 1 - i);
    result = bin - x .* result ./ i;
end

end
