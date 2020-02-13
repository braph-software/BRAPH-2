function varargin_clean = clean_varargin(handles, varargin)

varargin_clean = varargin;

for n = 1:2:length(varargin)-1
    if ~any(strcmpi(varargin{n}, handles))
        varargin_clean{n} = [];
        varargin_clean{n+1} = [];
    end
end
varargin_clean(cellfun('isempty', varargin_clean)) = [];

end