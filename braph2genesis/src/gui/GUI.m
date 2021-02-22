function GUI(el, varargin)

assert( ...
    el.getPropNumber() > 0, ...
    [BRAPH2.STR ':GUI:' BRAPH2.WRONG_INPUT], ...
    [BRAPH2.STR ':GUI:' BRAPH2.WRONG_INPUT ' ' ...
    'The element cannot have zero properties, which is not the case for ' tostring(el, 100, '...')] ...
    )

%% Parameters
if el.existsTag('ID')
    name = get_from_varargin([el.getClass() ' - ' el.get('ID')], 'Name', varargin);
else
    name = get_from_varargin(el.getClass(), 'Name', varargin);
end

f_position = get_from_varargin([.02 .30 .30 .80], 'Position', varargin);

BKGCOLOR = get_from_varargin([.98 .95 .95], 'BackgroundColor', varargin);
FRGCOLOR = get_from_varargin([.90 .90 .90], 'ForegroundColor', varargin);

dw = get_from_varargin(1, 'BorderX', varargin);
dh = get_from_varargin(.5, 'BorderY', varargin);

%% Initialize GUI
[f, p, s, pr] = init();
    function [f, p, s, pr] = init()
        f = figure( ...
            'Visible', 'off', ...
            'NumberTitle', 'off', ...
            'Name', [name ' - ' BRAPH2.STR], ...
            'Units', 'normalized', ...
            'Position', f_position, ...
            'Units', 'character', ...
            'DockControls', 'off', ...
            'Color', BKGCOLOR, ... 
            'SizeChangedFcn', {@resize}, ... 
            'CloseRequestFcn', {@close} ...
            );
        
        p = uipanel( ...
            'Parent', f, ...
            'Units', 'character', ...
            'BackgroundColor', BKGCOLOR, ...
            'BorderType', 'none' ...
            );
        
        s = uicontrol( ...
            'Style', 'slider', ...
            'Parent', f, ...
            'Units', 'character', ...
            'Position', [0 0 5 eps], ... % defines slider width
            'Min', -eps, ...
            'Max', 0, ...
            'Value', 0, ...
            'Callback', {@cb_s});

        function cb_s(~, ~)
            offset = get(s, 'Value');
            set(p, 'Position', [x0(p) h(f)-h(p)-offset w(p) h(p)]);
        end
        
        for prop = 1:1:el.getPropNumber()
            pr{prop}.panel = uipanel( ...
                'Parent', p, ...
                'Units', 'character', ...
                'Position', [0 0 eps 1], ... % defines pr panel height
                'BackgroundColor', FRGCOLOR, ...
                'BorderType', 'none' ...
                ); %#ok<AGROW>
            
            pr{prop}.text_tag =  uicontrol( ...
                'Style', 'text', ...
                'Parent', pr{prop}.panel, ...
                'Units', 'character', ...
                'Position', [0 0 eps 1], ... % defines prop text tag height
                'String', upper(el.getPropTag(prop)), ...
                'HorizontalAlignment', 'left', ...
                'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
                'BackgroundColor', FRGCOLOR ...
                ); %#ok<AGROW>
            
            switch el.getPropFormat(prop)
                case Format.EMPTY
                    init_empty(prop)
                case Format.STRING
                    init_string(prop)
                case Format.LOGICAL
                    init_logical(prop)
                case Format.OPTION
                    init_option(prop)
                case Format.CLASS
                    init_class(prop)
                case Format.CLASSLIST
                    init_classlist(prop)
                case Format.ITEM
                    init_item(prop)
                case Format.ITEMLIST
                    init_itemlist(prop)
                case Format.IDICT
                    init_idict(prop)
                case Format.SCALAR
                    init_scalar(prop)
                case Format.RVECTOR
                    init_rvector(prop)
                case Format.CVECTOR
                    init_cvector(prop)
                case Format.MATRIX
                    init_matrix(prop)
                case Format.SMATRIX
                    init_smatrix(prop)
                case Format.CELL
                    init_cell(prop)
            end
        end
        function init_empty(prop) %#ok<INUSD>
        end
        function init_string(prop)
            set(pr{prop}.panel, 'Position', [0 0 eps 2.5]) % re-defines prop panel height

            pr{prop}.edit_value = uicontrol( ...
                'Style', 'edit', ...
                'Parent', pr{prop}.panel, ...
                'Units', 'normalized', ...
                'Position', [.01 .10 .79 .40], ...
                'HorizontalAlignment', 'left', ...
                'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
                'BackgroundColor', 'w', ...
                'UserData', prop ...
                );
        end
        function init_logical(prop) %#ok<INUSD>
        end
        function init_option(prop) %#ok<INUSD>
        end
        function init_class(prop) %#ok<INUSD>
        end
        function init_classlist(prop) %#ok<INUSD>
        end
        function init_item(prop) %#ok<INUSD>
        end
        function init_itemlist(prop) %#ok<INUSD>
        end
        function init_idict(prop)%#ok<INUSD>
        end
        function init_scalar(prop)
            set(pr{prop}.panel, 'Position', [0 0 eps 2.5]) % re-defines prop panel height

            pr{prop}.edit_value = uicontrol( ...
                'Style', 'edit', ...
                'Parent', pr{prop}.panel, ...
                'Units', 'normalized', ...
                'Position', [.01 .10 .29 .40], ...
                'HorizontalAlignment', 'center', ...
                'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
                'BackgroundColor', 'w', ...
                'UserData', prop ...
                );
        end                
        function init_rvector(prop) %#ok<INUSD>
        end
        function init_cvector(prop) %#ok<INUSD>
        end
        function init_matrix(prop) %#ok<INUSD>
        end
        function init_smatrix(prop) %#ok<INUSD>
        end
        function init_cell(prop) %#ok<INUSD>
        end
    end
    function resize(~, ~)
        pr_panel_w = w(f) - 2 * dw - w(s);
        pr_panel_h = cellfun(@(x) h(x), cellfun(@(y) y.panel, pr, 'UniformOutput', false));
        pr_panel_x0 = dw;
        pr_panel_y0 = sum(pr_panel_h + dh) - cumsum(pr_panel_h + dh) + dh;
        for prop = 1:1:el.getPropNumber()
            set(pr{prop}.panel, 'Position', [pr_panel_x0 pr_panel_y0(prop) pr_panel_w pr_panel_h(prop)])
            set(pr{prop}.text_tag, 'Position', [0 pr_panel_h(prop)-h(pr{prop}.text_tag) pr_panel_w h(pr{prop}.text_tag)])
        end

        h_p = sum(pr_panel_h + dh) + dh;
        if h_p < h(f)
            set(f, 'Position', [x0(f) y0(f)+h(f)-h_p w(f) h_p])
        end
        set(p, 'Position', [0 h(f)-h_p w(f) h_p])
        
        if h(f) >= h(p) - dh
            set(s, 'Visible', 'off')
        else
            set(s, ...
                'Visible', 'on', ...
                'Position', [w(p)-w(s) 0 w(s) h(f)], ...
                'Min', h(f) - h(p) ...
                )            
        end
    end
    function close(~, ~)
        selection = questdlg(['Do you want to close ' name '?'], ...
            ['Close ' name], ...
            'Yes', 'No', 'Yes');
        switch selection
            case 'Yes'
                delete(f)
            case 'No'
                return
        end
    end

%% Update GUI
update()
    function update()
        for prop = 1:1:el.getPropNumber()
            switch el.getPropFormat(prop)
                case Format.EMPTY
                    update_empty(prop)
                case Format.STRING
                    update_string(prop)
                case Format.LOGICAL
                    update_logical(prop)
                case Format.OPTION
                    update_option(prop)
                case Format.CLASS
                    update_class(prop)
                case Format.CLASSLIST
                    update_classlist(prop)
                case Format.ITEM
                    update_item(prop)
                case Format.ITEMLIST
                    update_itemlist(prop)
                case Format.IDICT
                    update_idict(prop)
                case Format.SCALAR
                    update_scalar(prop)
                case Format.RVECTOR
                    update_rvector(prop)
                case Format.CVECTOR
                    update_cvector(prop)
                case Format.MATRIX
                    update_matrix(prop)
                case Format.SMATRIX
                    update_smatrix(prop)
                case Format.CELL
                    update_cell(prop)
            end
        end
        function update_empty(prop) %#ok<INUSD>
        end
        function update_string(prop)
            set(pr{prop}.edit_value, 'String', el.get(prop))
        end
        function update_logical(prop) %#ok<INUSD>
        end
        function update_option(prop) %#ok<INUSD>
        end
        function update_class(prop) %#ok<INUSD>
        end
        function update_classlist(prop) %#ok<INUSD>
        end
        function update_item(prop) %#ok<INUSD>
        end
        function update_itemlist(prop) %#ok<INUSD>
        end
        function update_idict(prop)%#ok<INUSD>
        end
        function update_scalar(prop)
            set(pr{prop}.edit_value, 'String', num2str(el.get(prop)))
        end                
        function update_rvector(prop) %#ok<INUSD>
        end
        function update_cvector(prop) %#ok<INUSD>
        end
        function update_matrix(prop) %#ok<INUSD>
        end
        function update_smatrix(prop) %#ok<INUSD>
        end
        function update_cell(prop) %#ok<INUSD>
        end
    end

%% Setup GUI

%% Show GUI
set(f, 'Visible', 'on')

%% Auxiliary functions
function r = x0(h)
    r = get(h, 'Position');
    r = r(1);
end
function r = y0(h)
    r = get(h, 'Position');
    r = r(2);
end
function r = w(h)
    r = get(h, 'Position');
    r = r(3);
end
function r = h(h)
    r = get(h, 'Position');
    r = r(4);
end

end