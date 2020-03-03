function varargin_copy = copy_varargin(varargin)

if length(varargin) == 1
    varargin = varargin{:};
end

varargin_copy = varargin;

for n = 1:1:length(varargin)
    item = varargin{n};
    if isobject(item) && ismethod(item, 'copy')
        varargin_copy{n} = copy(item);
    end
end

end