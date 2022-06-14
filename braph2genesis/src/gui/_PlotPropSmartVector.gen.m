%% ¡header!
PlotPropSmartVector < PlotProp (pr, plot property string) is a plot of a string property.

%%% ¡description!
PlotPropString plots a STRING property of an element in an edit field.
It works for all categories.
It has the following additional properties:
- ''Lines'', ''single'' (single-line edit field, default) or ''multi'' (multi-line edit field).
- ''EditHeight'' with the height of the edit field in characters.

%%% ¡seealso!
GUI, PlotElement, PlotProp, PlotPropText

%% ¡properties!
p
edit_value

%% ¡props!

%%% ¡prop!
LINES (metadata, option) switches between single- and multi-line edit field.
%%%% ¡settings!
{'single', 'multi'}

%%% ¡prop!
EDITHEIGHT (metadata, scalar) is the height of the edit field in characters.
%%%% ¡check_prop!
check = value > 0;
%%%% ¡default!
1.5

%%% ¡prop!
MAX (metadata, scalar) is the max value acceptable as input

%%% ¡prop!
MIN (metadata, scalar) is the min value acceptable as input

%%% ¡prop!
STEP (metadata, scalar) is the step value

%% ¡methods!
function h_panel = draw(pr, varargin)
    %DRAW draws the panel of the string property.
    %
    % DRAW(PR) draws the panel of the string property.
    %
    % H = DRAW(PR) returns a handle to the property panel.
    % 
    % DRAW(PR, 'Property', VALUE, ...) sets the properties of the graphical
    %  panel with custom Name-Value pairs.
    %  All standard plot properties of uipanel can be used.
    %
    % It is possible to access the properties of the various graphical
    %  objects from the handle H of the panel.
    %
    % See also update, redraw, refresh, uipanel.
    
    el = pr.get('EL');
    prop = pr.get('PROP');
    
    pr.p = draw@PlotProp(pr, varargin{:});
    
    if ~check_graphics(pr.edit_value, 'edit')
        pr.edit_value = uicontrol( ...
            'Style', 'edit', ...
            'Tag', 'edit_value', ...
            'Parent', pr.p, ...
            'Units', 'normalized', ...
            'HorizontalAlignment', 'left', ...
            'BackgroundColor', 'w', ...
            'Min', 0, ...
            'Max', find(strcmpi(pr.getPropSettings('LINES'), pr.get('LINES'))), ...
            'FontUnits', BRAPH2.FONTUNITS, ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
            'Callback', {@cb_edit_value} ...
            );
    end

    function cb_edit_value(~, ~) % (src, event)
        pr.cb_edit_value()
    end

    % output
    if nargout > 0
        h_panel = pr.p;
    end
end
function update(pr)
    %UPDATE updates the content and permissions of the edit field.
    %
    % UPDATE(PR) updates the content and permissions of the edit field.
    %
    % See also draw, resize, refresh, PlotElement.

    update@PlotProp(pr)
    
    el = pr.get('EL');
    prop = pr.get('PROP');   
    
    switch el.getPropCategory(prop)        
        case Category.METADATA
            raw_tmp = el.get(prop);
            if iscell(raw_tmp)
                raw_tmp = cell2mat(raw_tmp);
            end
            tmp_value = num2str(raw_tmp);
            tmp_value = regexprep(tmp_value, '\\s+', ' ');
            set(pr.edit_value, 'String', tmp_value)

        case {Category.PARAMETER, Category.DATA}
            raw_tmp = el.get(prop);
            if iscell(raw_tmp)
                raw_tmp = cell2mat(raw_tmp);
            end
            tmp_value = num2str(raw_tmp);
            tmp_value = regexprep(tmp_value, '\\s+', ' ');
            set(pr.edit_value, 'String', tmp_value)

            value = el.getr(prop);
            if isa(value, 'Callback')
                set(pr.edit_value, 'Enable', pr.get('ENABLE'))
            end
    end
end
function redraw(pr, varargin)
    %REDRAW resizes the property panel and repositions its graphical objects.
    %
    % REDRAW(PR) resizes the property panel and repositions its
    %   graphical objects. 
    % 
    % Important notes:
    % 1. REDRAW() sets the units 'characters' for panel and all its graphical objects. 
    % 2. REDRAW() is typically called internally by PlotElement and does not need 
    %  to be explicitly called in children of PlotProp.
    %
    % REDRAW(PR, 'X0', X0, 'Y0', Y0, 'Width', WIDTH, 'Height', HEIGHT)
    %  repositions the property panel. It is possible to use a
    %  subset of the Name-Value pairs.
    %  By default:
    %  - X0 does not change
    %  - Y0 does not change
    %  - WIDTH does not change
    %  - HEIGHT=3.33 characters.
    %
    % See also draw, update, refresh, PlotElement.
    
    h = pr.get('EDITHEIGHT');
    
    set(pr.edit_value, 'Position', [.01 .33/(1.83+h) .98 h/(1.83+h)])
    
    pr.redraw@PlotProp('Height', 1.83 + h, varargin{:})
end
function cb_edit_value(pr)
    %CB_EDIT_VALUE executes callback for the edit value.
    %
    % CB_EDIT_VALUE(PR) executes callback for the edit value.

    el = pr.get('EL');
    prop = pr.get('PROP');

    % get string value
    tmp_value = get(pr.edit_value, 'String');
    max = pr.get('max');
    min = pr.get('min');

    allowedChars = "0123456789,:. ";
    pat = characterListPattern(allowedChars); % pattern
    result = extract(tmp_value, pat); % cell array
    if ~isempty(result)
        try
            if any(contains(result, ':'))
                proccessed_value = eval([result{:}]);
            else
                tmp_r = convertCharsToStrings([result{:}]);
                tmp_r = strsplit(tmp_r, {' ', ','});
                holder = [];
                for i = 1:length(tmp_r)
                    holder = [holder str2double(tmp_r{i})]; %#ok<AGROW>
                end
                proccessed_value = holder;
            end

            proccessed_value = proccessed_value(proccessed_value <= max);
            proccessed_value = proccessed_value(proccessed_value >= min);
        catch e
            pr.warning_creator(e.message);
        end
    end
    % set rvector
    if exist('proccessed_value', 'var') && isnumeric(proccessed_value)
        try
            el.set(prop, proccessed_value);
            % set other analysis if needed

        catch e
            pr.warning_creator(e.message);
        end
    else
        pr.warning_creator('The entered value is not valid.');
    end

    pr.update()
end
function warning_creator(pr, text)
    warning_figure = warndlg(text);
    set_braph2icon(warning_figure);
end
  
%% ¡tests!

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡code!
% draws PlotPropString and calls update() and redraw()
% note that it doesn't work for category RESULT 
% because it needs to be used with PlotElement() and GUI()
figure()
et = ETA();
pr = {};
props = [et.PROP_STRING_M et.PROP_STRING_P et.PROP_STRING_D et.PROP_STRING_R et.PROP_STRING_R_CALC];
for i = 1:1:length(props)
    pr{i} = PlotPropString('EL', et, 'PROP', props(i));
    pr{i}.draw('BackgroundColor', [i/length(props) .5 (length(props)-i)/length(props)])
    pr{i}.update()
    pr{i}.redraw('Y0', (length(props) - i)/length(props) * Plot.h(gcf, 'characters'))
end
close(gcf)

% minimal working version for category RESULT
figure()
p = uipanel('Parent', gcf); % needed for the function refresh that is called when the result is calculated
set(gcf, 'SizeChangedFcn', 'pr_res.update()') % callback to update panel when figure is resized (in refresh)
et = ETA();
pr_res = PlotPropString('EL', et, 'PROP', et.PROP_STRING_R_CALC, 'LINES', 'multi', 'EDITHEIGHT', 10);
pr_res.draw('Parent', p, 'BackgroundColor', [.8 .5 .2])
pr_res.update()
pr_res.redraw()
close(gcf)
