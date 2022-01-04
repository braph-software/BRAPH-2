function check = check_graphics(h, type)
%CHECK_GRAPHICS returns whether a handle is a graphic obejct/error.
%
% CHECK = CHECK_GRAPHICS(H) returns whether the H is a graphic obejct.
%
% CHECK = CHECK_GRAPHICS(H, TYPE) returns whether the H is a graphic obejct 
%  of the kind TYPE = 'figure', 'uipanel', 'axes', 'uitable', 'uimenu',
%  'uitoolbar', 'uipushtool', 'pushbutton', 'togglebutton', 'checkbox',
%  'radiobutton', 'edit', 'text', 'slider', 'listbox', or 'popupmenu'.
%
% CHECK_GRAPHICS(H[, TYPE]) throws an error if H is not a correct graphic object.
%  Error id: [BRAPH2:Format:WrongInput]
%
% See also isgraphics.

if nargin < 2
    type = [];
end

if nargout == 1
    if isempty(type)
        check = isgraphics(h);
    else
        switch type
            case 'figure'
                check = ~isempty(h) && isgraphics(h) && isgraphics(h, 'figure');
            case 'uipanel'
                check = ~isempty(h) && isgraphics(h, 'uipanel');
            case 'axes'
                check = ~isempty(h) && isgraphics(h, 'axes');
            case 'uitable'
                check = ~isempty(h) && isgraphics(h, 'uitable');
            case 'uimenu'
                check = ~isempty(h) && isgraphics(h, 'uimenu');
            case 'uitoolbar'
                check = ~isempty(h) && isgraphics(h, 'uitoolbar');
            case 'uipushtool'
                check = ~isempty(h) && isgraphics(h, 'uipushtool');
            case 'pushbutton'
                check = ~isempty(h) && isgraphics(h, 'uicontrol') && strcmpi(get(h, 'Style'), 'pushbutton');
            case 'togglebutton'
                check = ~isempty(h) && isgraphics(h, 'uicontrol') && strcmpi(get(h, 'Style'), 'togglebutton');
            case 'checkbox'
                check = ~isempty(h) && isgraphics(h, 'uicontrol') && strcmpi(get(h, 'Style'), 'checkbox');
            case 'radiobutton'
                check = ~isempty(h) && isgraphics(h, 'uicontrol') && strcmpi(get(h, 'Style'), 'radiobutton');
            case 'edit'
                check = ~isempty(h) && isgraphics(h, 'uicontrol') && strcmpi(get(h, 'Style'), 'edit');
            case 'text'
                check = ~isempty(h) && isgraphics(h, 'uicontrol') && strcmpi(get(h, 'Style'), 'text');
            case 'slider'
                check = ~isempty(h) && isgraphics(h, 'uicontrol') && strcmpi(get(h, 'Style'), 'slider');
            case 'listbox'
                check = ~isempty(h) && isgraphics(h, 'uicontrol') && strcmpi(get(h, 'Style'), 'listbox');
            case 'popupmenu'
                check = ~isempty(h) && isgraphics(h, 'uicontrol') && strcmpi(get(h, 'Style'), 'popupmenu');
            otherwise
                error( ...
                    [BRAPH2.STR ':check_graphics:' BRAPH2.WRONG_INPUT], ...
                    [BRAPH2.STR ':check_graphics:' BRAPH2.WRONG_INPUT '\n' ...
                    '''' type ''' is not an allowed type.'] ...
                    )
        end
    end
else
    assert( ...
        check_graphics(h, type), ...
        [BRAPH2.STR ':check_graphics:' BRAPH2.WRONG_INPUT], ...
        [BRAPH2.STR ':check_graphics:' BRAPH2.WRONG_INPUT '\n' ...
        'The handle ' tostring(h) ' is not a valid graphic object. '] ...
        )
end

end