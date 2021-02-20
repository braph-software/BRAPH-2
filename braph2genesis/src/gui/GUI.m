classdef GUI2
    properties (Access=protected)
        el % element to be visualized
        
        name % app name
        
        f % figure
        p % panel
        s % slider
        
        prop_panel % prop panel cell array
        prop_text_tag
    end
    properties (Constant)
        BKGCOLOR = [.80 .80 .80]
        FRGCOLOR = [.98 .98 .98]
    end
    methods % constructor
        function gui = GUI2(el, varargin)
            gui.el = el;

            % name
            if el.existsTag('ID')
                gui.name = get_from_varargin([el.getClass() ' - ' el.get('ID')], 'name', varargin);
            else
                gui.name = get_from_varargin(el.getClass(), 'name', varargin);
            end
            
            position = get_from_varargin([.02 .30 .30 .80], 'position', varargin);

            % initializes GUI
            gui.f = figure( ...
                'Visible', 'off', ...
                'NumberTitle', 'off', ...
                'Name', [gui.name ' - ' BRAPH2.STR], ...
                'Units', 'normalized', ...
                'Position', position, ...
                'Units', 'character', ...
                'DockControls', 'off', ...
                'Color', GUI2.BKGCOLOR, ...
                'SizeChangedFcn', {@resize}, ...
                'CloseRequestFcn', {@close} ...
                );
            
            function close(~, ~)
                selection = questdlg(['Do you want to close ' gui.name '?'], ...
                    ['Close ' gui.name], ...
                    'Yes', 'No', 'Yes');
                switch selection
                    case 'Yes'
                        delete(gui.f)
                    case 'No'
                        return
                end
            end
            function resize(~, ~)
                set(gui.p, 'Position', [0 0 w(gui.f) h(gui.f)])
                                
                dw = 1; % border along x
                dh = .5; % border along y
                
                prop_panel_w = w(gui.p) - 2 * dw - w(gui.s);
                prop_panel_h = cellfun(@(x) h(x), gui.prop_panel);
                prop_panel_x0 = dw;
                prop_panel_y0 = sum(prop_panel_h + dh) - cumsum(prop_panel_h + dh) + dh;
                for prop = 1:1:el.getPropNumber() %#ok<FXUP>
                    set(gui.prop_panel{prop}, 'Position', [prop_panel_x0 prop_panel_y0(prop) prop_panel_w prop_panel_h(prop)])
                    set(gui.prop_text_tag{prop}, 'Position', [0 prop_panel_h(prop)-h(gui.prop_text_tag{prop}) prop_panel_w h(gui.prop_text_tag{prop})])
                end

                h_p = sum(prop_panel_h + dh) + dh;
                set(gui.p, 'Position', [0 max(0, h(gui.f) - h_p) w(gui.f) h_p])
                
                if h(gui.f) >= h(gui.p)
                    set(gui.s, 'Visible', 'off')
                else
                    set(gui.s, ...
                        'Visible', 'on', ...
                        'Position', [w(gui.p)-w(gui.s) 0 w(gui.s) h(gui.f)], ...
                        'Min', h(gui.f) - h(gui.p) ...
                        )
                end
            end
            
            gui.p = uipanel( ...
                'Parent', gui.f, ...
                'Units', 'character', ...
                'BackgroundColor', GUI2.BKGCOLOR, ...
                'BorderType', 'none' ...
                );

            for prop = 1:1:el.getPropNumber() %#ok<FXUP>
                gui.prop_panel{prop} = uipanel( ...
                    'Parent', gui.p, ...
                    'Units', 'character', ...
                    'Position', [0 0 eps 2], ... % defines prop panel height
                    'BackgroundColor', GUI2.FRGCOLOR, ...
                    'BorderType', 'none' ...
                    );
                
                gui.prop_text_tag{prop} =  uicontrol( ...
                    'Style', 'text', ...
                    'Parent', gui.prop_panel{prop}, ...
                    'Units', 'character', ...
                    'Position', [0 0 eps 1], ... % defines prop text tag height
                    'String', upper(el.getPropTag(prop)), ...
                    'HorizontalAlignment', 'left', ...
                    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
                    'BackgroundColor', GUI2.FRGCOLOR ...
                    );
            end
            
            gui.s = uicontrol( ...
                'Style', 'slider', ...
                'Parent', gui.f, ...
                'Units', 'character', ...
                'Position', [0 0 5 eps], ... % defines slider width
                'Min', -eps, ...
                'Max', 0, ...
                'Value', 0, ...
                'Callback', {@cb_s});
                
            function cb_s(~, ~)
                offset = get(gui.s, 'Value');
                set(gui.p, 'Position', [x0(gui.p) h(gui.f)-h(gui.p)-offset w(gui.p) h(gui.p)]);
            end               

            % shows GUI
            set(gui.f, 'Visible', 'on')
            
            % auxiliary functions
            function r = x0(h)
                r = get(h, 'Position');
                r = r(1);
            end
            function r = y0(h) %#ok<DEFNU>
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
    end
end