function check_out = installed(addon, ew)
%INSTALLED returns whether an addon is installed/error.
%
% CHECK = INSTALLED(ADDON) returns whether ADDON is installed.
%  ADDON can be either the addon name or identifier.
%
% INSTALLED(ADDON, 'error') throws an error if ADDON is not installed.
%  Error id: [BRAPH2:installed:AddOn].
%
% INSTALLED(ADDON, 'warning') throws a warning if ADDON is not installed.
%  Warning id: [BRAPH2:installed].
%
% BRAPH2 uses the following addons:
%  - DM: "Parallel Computing Toolbox"
%  - NN: "Deep Learning Toolbox"
%  - ONNXCONVERTER: "Deep Learning Toolbox Converter for ONNX Model Format"
%
% Some BRAPH2 functionalities might not be available if these addons are
%  not installed.
% 
% A list of all installed addon can be obtained using
%  <a href="matlab:matlab.addons.installedAddons">matlab.addons.installedAddons</a>

addons = matlab.addons.installedAddons;
check = ismember(addon, [addons.Name; addons.Identifier]);

if nargin > 1 && strcmpi(ew, 'error')
    assert( ...
        check, ...
        [BRAPH2.STR ':installed:' BRAPH2.ADDON], ...
        [BRAPH2.STR ':installed:' BRAPH2.ADDON ' ' ...
        'The addon ' addon ' is not installed. ' ...
        'Some BRAPH2 functionalities might not be available.'] ...
        )
elseif nargin > 1 && strcmpi(ew, 'warning') && ~check
    warning( ...
        [BRAPH2.STR ':installed'], ...
        [BRAPH2.STR ':installed ' ...
        'The addon ' addon ' is not installed. ' ...
        'Some BRAPH2 functionalities might not be available.'])    
end

if nargout == 1
    check_out = check;
end

end