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

l_setprop_list % listeners to SetProp
l_resultmemorized_list % listeners to ResultMemorized

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
            pr.f_item_list = cell(1, length(item_list));
        end
        for i = 1:1:length(item_list)
            if ~check_graphics(pr.button_list{i}, 'uibutton')
                pr.button_list{i} = uibutton( ...
                    'Parent', pr.p, ...
                    'Tag', ['button_list ' int2str(i)], ...
                    'FontSize', BRAPH2.FONTSIZE ...
                    );
            end
            set(pr.button_list{i}, ...
                'Text', item_list{i}.tostring(), ...
                'Tooltip', regexprep(item_list{i}.tree(), {'<strong>', '</strong>'}, {'' ''}), ...
                'ButtonPushedFcn', {@cb_button, i} ...
                )
        end
    end
    
    function cb_button(~, ~, i)
        pr.cb_button(i)
    end

    % add listeners
    if ~isa(el.getr(prop), 'NoValue')
        % add listener to prop set in items
        pr.l_setprop_list = cellfun(@(it) listener(it, 'PropSet', @cb_prop_set), el.get(prop), 'UniformOutput', false);

        % add listener to result memorized in items
        pr.l_resultmemorized_list = cellfun(@(it) listener(it, 'ResultMemorized', @cb_result_memorized), el.get(prop), 'UniformOutput', false);
    end
    function cb_prop_set(~, ~)
        notify(el, 'PropSet', EventPropSet(el, prop))
    end
    function cb_result_memorized(~, ~)
        notify(el, 'PropSet', EventPropSet(el, prop))
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
    % See also draw, update, PanelElement.
    
    el = pr.get('EL');
    prop = pr.get('PROP');

    value = el.getr(prop);
    if el.getPropCategory(prop) == Category.RESULT && isa(value, 'NoValue')
        pr.redraw@PanelProp('Height', s(3.5), varargin{:})
    else
        item_list = el.get(prop);
        
        pr.redraw@PanelProp('Height', s(2+2*length(item_list)), varargin{:})
        
        for i = 1:1:length(item_list)
            set(pr.button_list{i}, 'Position', [s(.3) s(.3+2*(length(item_list)-i)) w(pr.p, 'pixels')-s(5) s(1.7)])
        end
    end
end
function cb_button(pr, i)
    %CB_BUTTON executes callback for the button.
    %
    % CB_BUTTON(PR, I) executes callback for the button on item I.

    persistent time
    if isempty(time)
        time = 0;
    end
    if now - time > 1.0 / (24 * 60 * 60)
        time = now;
        set(pr.button_list{i}, 'Enable', 'off')
        %%% start callback %%%
        
        el = pr.get('EL');
        prop = pr.get('PROP');
        item_list = el.memorize(prop); % ensure that the property is stored

        if ~check_graphics(pr.f_item_list{i}, 'figure')
            f = ancestor(pr.p, 'figure');
            gui = GUIElement( ...
                'PE', item_list{i}, ...
                'WAITBAR', Callback('EL', pr, 'TAG', 'WAITBAR'), ...
                'POSITION', [x0(f, 'normalized')+w(f, 'normalized') y0(f, 'normalized') w(f, 'normalized') h(f, 'normalized')], ...
                'CLOSEREQ', false ...
                );
            pr.f_item_list{i} = gui.draw();
        else
            gui = get(pr.f_item_list{i}, 'UserData');
            gui.cb_bring_to_front();
        end
        
        %%% end callback %%%
        set(pr.button_list{i}, 'Enable', 'on')
    end
    
% % %     % updates and redraws the parent PanelElement as well as all siblings PanelProp's
% % %     pe = get(get(pr.p, 'Parent'), 'UserData');
% % %     pe.update()
% % %     pe.redraw()
end
function cb_bring_to_front(pr)
    %CB_BRING_TO_FRONT brings to the front the item figures.
    %
    % CB_BRING_TO_FRONT(PR) brings to the front the item figures.
    %
    % See also cb_hide, cb_close.

    cb_bring_to_front@Panel(pr);
    
    % bring to front item figures
    for i = 1:1:length(pr.f_item_list)
        if check_graphics(pr.f_item_list{i}, 'figure')
            figure(pr.f_item_list{i})
            set(pr.f_item_list{i}, ...
                'Visible', 'on', ...
                'WindowState', 'normal' ...
                )
        end
    end
end
function cb_hide(pr)
    %CB_HIDE hides the item figures.
    %
    % CB_HIDE(PR) hides the item figures.
    %
    % See also cb_bring_to_front, cb_close.
    
    cb_hide@Panel(pr);
    
    % hide callback element figures
    for i = 1:1:length(pr.f_item_list)
        if check_graphics(pr.f_item_list{i}, 'figure')
            set(pr.f_item_list{i}, 'Visible', 'off')
        end
    end
end
function cb_close(pr)
    %CB_CLOSE closes the item figures.
    % 
    % CB_CLOSE(PR) closes the item figures.
    %
    % See also cb_bring_to_front, cb_hide.
    
    cb_close@Panel(pr);

    % close callback element figures
    for i = 1:1:length(pr.f_item_list)
        if check_graphics(pr.f_item_list{i}, 'figure')
            close(pr.f_item_list{i})
        end
    end
    
    % delete listeners
    if ~isempty(pr.l_setprop_list)
        cellfun(@(l_setprop) delete(l_setprop), pr.l_setprop_list, 'UniformOutput', false)
    end
    if ~isempty(pr.l_resultmemorized_list)
        cellfun(@(l_resultmemorized) delete(l_resultmemorized), pr.l_resultmemorized_list, 'UniformOutput', false)
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