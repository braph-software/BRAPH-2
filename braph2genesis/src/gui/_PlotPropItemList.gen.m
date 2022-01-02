%% ¡header!
PlotPropItemList < PlotProp (pr, plot property item list) is a plot of an item-list property.

%%% ¡description!
PlotPropItemList plots a ITEMLIST property of an element using a series of pushbuttons to open the elements.
It works for all categories.

%%% ¡seealso!
GUI, PlotElement, PlotProp

%% ¡properties!
p
pushbutton_value_list

%% ¡methods!
function h_panel = draw(pr, varargin)
    %DRAW draws the panel of the item-list property.
    %
    % DRAW(PR) draws the panel of the item-list property.
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
    
    pr.p = draw@PlotProp(pr, varargin{:});

    % output
    if nargout > 0
        h_panel = pr.p;
    end
end
function update(pr)
    %UPDATE updates the content and permissions of the pushbutton series.
    %
    % UPDATE(PR) updates the content and permissions of the pushbutton series.
    %
    % See also draw, redraw, refresh, PlotElement.

    update@PlotProp(pr)

    el = pr.get('EL');
    prop = pr.get('PROP');
        
    value = el.getr(prop);
    if el.getPropCategory(prop) == Category.RESULT && isa(value, 'NoValue')
        %
    else
        item_list = el.get(prop);
        if isempty(pr.pushbutton_value_list)
            pr.pushbutton_value_list = cell(1, length(item_list));
        end
        for i = 1:1:length(item_list)
            if ~check_graphics(pr.pushbutton_value_list{i}, 'pushbutton')
                pr.pushbutton_value_list{i} = uicontrol( ...
                    'Style', 'pushbutton', ...
                    'Tag', ['pushbutton_value ' int2str(i)], ...
                    'Parent', pr.p, ...
                    'FontUnits', BRAPH2.FONTUNITS, ...
                    'FontSize', BRAPH2.FONTSIZE ...
                    );
            end
            set(pr.pushbutton_value_list{i}, ...
                'String', item_list{i}.tostring(), ...
                'Tooltip', regexprep(item_list{i}.tree(), {'<strong>', '</strong>'}, {'' ''}), ...
                'Callback', {@cb_pushbutton_value, item_list{i}} ...
                )
        end
    end
    
    function cb_pushbutton_value(~, ~, item)
        pr.update()
        
        % TODO: check once GUI is finalized
        GUI('EL', item)
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
    % REDRAW(PR, 'X0', X0, 'Y0', Y0, 'Width', WIDTH)
    %  repositions the property panel. It is possible to use a
    %  subset of the Name-Value pairs.
    %  By default:
    %  - X0 does not change
    %  - Y0 does not change
    %  - WIDTH does not change
    %  
    % HEIGHT is automatically set by this function and should not be used (it'll be overwritten).
    %
    % See also draw, update, refresh, PlotElement.
    
    el = pr.get('EL');
    prop = pr.get('PROP');

    value = el.getr(prop);
    if el.getPropCategory(prop) == Category.RESULT && isa(value, 'NoValue')
        pr.redraw@PlotProp('Height', 1.8, varargin{:})
    else
        item_list = el.get(prop);
        
        pr.redraw@PlotProp('Height', 1.8 + 1.5 * length(item_list), varargin{:})
        
        for i = 1:1:length(item_list)
            set(pr.pushbutton_value_list{i}, ...
                'Units', 'character', ...
                'Position', ...
                    [ ...
                        0.01*Plot.w(pr.p) ...
                        1.5*(length(item_list)-i)+.3 ...
                        0.98*Plot.w(pr.p) ...
                        1.2 ...
                    ] ...
                )
        end
    end
end

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡code!
% draws PlotPropItemList and calls update() and redraw()
% note that it doesn't work for category RESULT 
% because it needs to be used with PlotElement() and GUI()
figure()
et = ETA();
props = [et.PROP_ITEMLIST_M et.PROP_ITEMLIST_P et.PROP_ITEMLIST_D et.PROP_ITEMLIST_R et.PROP_ITEMLIST_R_CALC];
for i = 1:1:length(props)
    pr{i} = PlotPropItemList('EL', et, 'PROP', props(i));
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
pr_res = PlotPropItemList('EL', et, 'PROP', et.PROP_ITEMLIST_R_CALC);
pr_res.draw('Parent', p, 'BackgroundColor', [.8 .5 .2])
pr_res.update()
pr_res.redraw()
close(gcf)    