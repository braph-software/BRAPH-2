function value = get_from_varargin(value, handle, varargin)

if nargin > 2
    for n = 1:1:length(varargin)-1
        if strcmpi(varargin{n}, handle)
            value = varargin{n+1};
        end
    end
end

end