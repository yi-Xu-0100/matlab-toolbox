function varargout = getMonitorInfo(varargin)
%GETMONITORINFO Monitor information by index of position.
%
%   monitorInfo = GETMONITORINFO(mPosition), for index of monitor position,
%   returns the four-element row vector. monitorInfo = [x, y, length,
%   width] containing the monitor information in the matrix.
%
%   [x, y, length, width, ..., others] = GETMONITORINFO(mPosition), returns
%   monitor information as separate output variables and returns NaN for
%   others.
%
%   Then for index of monitor position (mPosition):
%
%   mPosition = 0, GETMONITORINFO returns current monitor information.
%   mPosition > 1, GETMONITORINFO returns monitor information of the
%                  mPosition.
%   mPosition < 0, GETMONITORINFO returns monitor information of
%                  the ABS(mPosition) beside current monitor.
%
%   See also GET.
%
%   * version:    v1.0.0
%   * created:    2023.03.14
%   * modified:   2023.03.14
%   * author:     yi_Xu
%   * email:      yi_Xu@yixuju.cn

% default set monitor position as 0
if nargin == 0
    mPosition = 0;
else
    mPosition = varargin{1};
end

if mPosition == 0
    % default return current monitor information
    monitorInfo = get(0, 'ScreenSize');
else
    mPositions = get(0, 'MonitorPositions');

    if mPosition > 0
        monitorInfo = mPositions(mPosition, :);
    elseif mPosition < 0
        cMonitorInfo = get(0, 'ScreenSize');
        % find current monitor
        findRow = (mPositions(:, 1) == cMonitorInfo(1)) ...
            & (mPositions(:, 1) == cMonitorInfo(2));
        m_cPositions = mPositions(~findRow, :);
        % return monitor information beside current monitor
        monitorInfo = m_cPositions(abs(mPosition), :);
    end

end

if nargout == 0 || nargout == 1
    varargout{1} = monitorInfo;
elseif nargout > 1
    varargout = num2cell([monitorInfo NaN(1:nargout - 4)]);
end
