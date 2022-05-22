%% ¡header!
PanelPropItemList < PanelProp (pr, panel property item list) plots the panel of a property item-list.

%%% ¡description!
PanelPropItemList plots the panel of an ITEMLIST property with a series of buttons to open the elements.
It works for all categories.

%%% ¡seealso!
GUI, PanelElement, PanelProp, uibutton

%% ¡properties!
p
button_list

f_item_list % item figures

%% ¡methods!
function p_out = draw(pr, varargin)
    %DRAW draws the panel of the item-list property.
    %
    % DRAW(PR) draws the panel of the item-list property.
    %
    % P = DRAW(PR) returns a handle to the property panel.
    %
    % DRAW(PR, 'Property', VALUE, ...) sets the properties of the graphical
    %  panel with custom Name-Value pairs.
    %  All standard panel properties of uipanel can be used.
    %
    % It is possible to access the properties of the various graphical
    %  objects from the handle P of the panel.
    %
    % See also update, redraw, uipanel.
    
    pr.p = draw@PanelProp(pr, varargin{:});

    % output
    if nargout > 0
        p_out = pr.p;
    end
end
function update(pr)
    %UPDATE updates the content and permissions of the button series.
    %
    % UPDATE(PR) updates the content and permissions of the button series.
    %
    % See also draw, redraw, PanelElement.

    update@PanelProp(pr)

    el = pr.get('EL');
    prop = pr.get('PROP');
        
    value = el.getr(prop);
    if el.getPropCategory(prop) == Category.RESULT && isa(value, 'NoValue')
        %
    else
        item_list = el.get(prop);
        if isempty(pr.button_list)
            pr.button_list = cell(1, length(item_list));
        end
        for i = 1:1:length(item_list)
            if ~check_graphics(pr.button_list{i}, 'button')
                pr.button_list{i} = uibutton( ...
                    'Parent', pr.p, ...
                    'Tag', ['button_list ' int2str(i)], ...
                    'FontSize', BRAPH2.FONTSIZE ...
                    );
            end
            set(pr.button_list{i}, ...
                'Text', item_list{i}.tostring(), ...
                'Tooltip', regexprep(item_list{i}.tree(), {'<strong>', '</strong>'}, {'' ''}), ...
                'ButtonPushedFcn', {@cb_button, item_list{i}} ...
                )
        end
    end
    
    function cb_button(~, ~, item)
        pr.update()
        
        % TODO: check once GUI is finalized
        GUI('EL', item)
    end

end
function redraw(pr, varargin)
    %REDRAW resizes the property panel and repositions its graphical objects.
    %
    % REDRAW(PR) resizes the property panel and repositions its graphical objects. 
    % 
    % Important notes:
    % 1. REDRAW() sets the units 'pixels' for panel. 
    % 2. REDRAW() is typically called internally by PanelElement and does not need 
    %  to be explicitly called in children of PanelProp.
    %
    % REDRAW(PR, 'X0', X0, 'Y0', Y0, 'Width', WIDTH)
    %  repositions the property panel. It is possible to use a
    %  subset of the Name-Value pairs.
    %  By default:
    %  - X0 does not change
    %  - Y0 does not change
    %  - WIDTH does not change
    % HEIGHT is automatically set by this function and should not be used (it'll be overwritten).
    %
    % See also draw, update, PanelElement, BRAPH2.
    
    el = pr.get('EL');
    prop = pr.get('PROP');

    value = el.getr(prop);
    if el.getPropCategory(prop) == Category.RESULT && isa(value, 'NoValue')
        pr.redraw@PanelProp('Height', ceil(3.5 * BRAPH2.FONTSIZE * BRAPH2.S), varargin{:})
    else
        item_list = el.get(prop);
        
        pr.redraw@PanelProp('Height', ceil((2 + 2 * length(item_list)) * BRAPH2.FONTSIZE * BRAPH2.S), varargin{:})
        
        for i = 1:1:length(item_list)
            set(pr.button_list{i}, 'Position', [ ...
                ceil(5 * BRAPH2.S) ...
                ceil((.25+2*(length(item_list)-i)) * BRAPH2.FONTSIZE * BRAPH2.S) ...
                ceil(w(pr.p, 'pixels') - 60) ...
                ceil(1.75 * BRAPH2.FONTSIZE * BRAPH2.S) ...
                ])
            
            set(pr.button_list{i}, ...
                'Units', 'character', ...
                'Position', ...
                    [ ...
                        .01*Panel.w(pr.p) ...
                        1.5*(length(item_list)-i)+.3 ...
                        .98*Panel.w(pr.p) ...
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
% draws PanelPropItemList and calls update() and redraw()
% note that it doesn't work for category RESULT 
% because it needs to be used with PanelElement() and GUI()
fig1 = uifigure();
et = ETA();
props = [et.PROP_ITEMLIST_M et.PROP_ITEMLIST_P et.PROP_ITEMLIST_D et.PROP_ITEMLIST_F et.PROP_ITEMLIST_G et.PROP_ITEMLIST_R et.PROP_ITEMLIST_R_CALC];
for i = 1:1:length(props)
    pr{i} = PanelPropItemList('EL', et, 'PROP', props(i));
    pr{i}.draw( ...
        'Parent', fig1, ...
        'BackgroundColor', [i/length(props) .5 (length(props)-i)/length(props)] ...
        )
    pr{i}.update()
    pr{i}.redraw('Y0', (length(props) - i)/length(props) * h(fig1, 'pixels'))
end
close(fig1)