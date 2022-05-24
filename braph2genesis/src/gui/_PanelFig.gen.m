%% ¡header!
PanelFig < Panel (pf, panel figure) plots the panel of a figure.

%%% ¡description!
% % % PanelElement plots all properties of an element in a panel P, 
% % %  which contains a series of stacked property panels,
% % %  one for each property of the element EL being plotted.
% % % 
% % % Importnat notes:
% % % 1. The key methods that need to be called are draw() and reinit().
% % % 2. The methods update() and redraw() are used internally by PanelElement 
% % %   and typically do not need to be called explicitly.
% % % 
% % % CONSTRUCTOR - To construct a PanelElement use the constructor:
% % % 
% % %     pe = PanelElement(''EL'', <element>)
% % %     
% % % DRAW - To create the element panel, call pe.draw():
% % % 
% % %     p = pe.<strong>draw</strong>();
% % %     p = pe.<strong>draw</strong>(''Parent'', f);
% % %  
% % %  Typically, f is a figure where the panel is plotted.
% % %  It is also possible to use pe.draw() to get the parent panel handle
% % %   and to set its properties (as in the case of Panel and PanelProp).
% % % 
% % % REINIT - To reinitialize the element plot with a new element, call:
% % % 
% % %     pe.reinit(<new element>)
% % % 
% % %  This function resets both the element and the panel using the new element.
% % %  Importantly, the new element must be of exactly the same class as the old element.
% % % 
% % % CALLBACK - These are the callback functions:
% % % 
% % %     pe.<strong>cb_bring_to_front</strong>() - brings to the front the figure with the element panel and its dependent figures
% % %     pe.<strong>cb_hide</strong>() - hides the figure with the element panel and its dependent figures
% % %     pe.<strong>cb_close</strong>() - closes the figure with the element panel and its dependent figures

%%% ¡seealso!
GUI, GUIFig, uipanel

%% ¡props!

%%% ¡prop!
AUTOPOS (figure, logical) determines whether the position is adjusted automatically.
%%%% ¡default!
true
%%%% ¡postprocessing!
if pf.get('AUTOPOS') && (~strcmpi(get(pf.p, 'Units'), 'normalized') || ~isequal(get(pf.p, 'Position'), [0 0 1 1]))
    set(pf.p, ...
        'Units', 'normalized', ...
        'Position', [0 0 1 1] ...
        )
elseif ~pf.get('AUTOPOS') && (~strcmpi(get(pf.p, 'Units'), 'pixels') || ~isequal(get(pf.p, 'Position'), [pf.get('X0') pf.get('Y0') pf.get('WIDTH') pf.get('HEIGHT')]))
    set(pf.p, ...
        'Units', 'pixels', ...
        'Position', [pf.get('X0') pf.get('Y0') pf.get('WIDTH') pf.get('HEIGHT')] ...
        )
end

%%% ¡prop!
X0 (figure, size) is the lower left x-coordinate of the panel in pixels.
%%%% ¡default!
1

%%% ¡prop!
Y0 (figure, size) is the lower-left y-coordinate of the panel in pixels.
%%%% ¡default!
1

%%% ¡prop!
WIDTH (figure, size) is the width of the panel in pixels.
%%%% ¡default!
800

%%% ¡prop!
HEIGHT (figure, size) is the height of the panel in pixels.
%%%% ¡default!
600

%% ¡props_update!

%%% ¡prop!
BKGCOLOR (figure, color) is the panel background color.
%%%% ¡default!
[1 1 1]
%%%% ¡postprocessing!
if check_graphics(pf.p, 'uipanel') && ~isequal(get(pf.p, 'BackgroundColor'), pf.get('BKGCOLOR'))
    set(pf.p, 'BackgroundColor', pf.get('BKGCOLOR'))
end

%% ¡properties!
p % handle for panel figure

%% ¡methods!
function p_out = draw(pf, varargin)
% % %     %DRAW draws the element panel.
% % %     %
% % %     % DRAW(PE) draws the element panel.
% % %     %
% % %     % P = DRAW(PE) returns a handle to the element parent panel.
% % %     %
% % %     % DRAW(PE, 'Property', VALUE, ...) sets the properties of the parent
% % %     %  panel with custom Name-Value pairs.
% % %     %  All standard plot properties of uipanel can be used.
% % %     %
% % %     % It is possible to access the properties of the various graphical
% % %     %  objects from the handle H of the parent panel.
% % %     %
% % %     % See also update, redraw, reinit, uipanel.

    pf.p = draw@Panel(pf, ...
        varargin{:}, ...
        'AutoResizeChildren', 'off' ...
        );

% % %     if isempty(pe.pr_list) || any(cellfun(@(x) ~check_graphics(x, 'uipanel'), pe.pr_list))
% % %         pe.pr_list = cellfun(@(x) x.draw('Parent', pe.p), pe.memorize('PR_DICT').getItems(), 'UniformOutput', false);
% % %     end
% % % 
% % %     pe.update()
% % %     pe.redraw()    
    
    % output
    if nargout > 0
        p_out = pf.p;
    end
end
% % % function update(pe)
% % %     %UPDATE updates the content of the prop panels and their graphical objects.
% % %     %
% % %     % UPDATE(PE) updates the content of the prop panels and their graphical objects.
% % %     %
% % %     % Important note:
% % %     %  UPDATE() does not need to be explicitly called from outside code,
% % %     %  as it is called internally by PanelElement when needed.
% % %     %
% % %     % See also draw, redraw.
% % % 
% % %     for prop = 1:1:pe.get('PR_DICT').length()
% % %         pe.get('PR_DICT').getItem(prop).update()
% % %     end
% % % end
% % % function redraw(pe, varargin)
% % %     %REDRAW resizes and repositions the prop panels.
% % %     %
% % %     % REDRAW(PE) resizes the property panels and repositions their graphical objects.
% % %     %
% % %     % REDRAW(PL, 'X0', X0, 'Y0', Y0, 'Width', WIDTH, 'Height', HEIGHT)
% % %     %  repositions the property panel. It is possible to use a
% % %     %  subset of the Name-Value pairs.
% % %     %  By default:
% % %     %  - X0 does not change
% % %     %  - Y0 does not change
% % %     %  - WIDTH does not change
% % %     %  - HEIGHT is set automatically
% % %     % 
% % %     % Important note:
% % %     %  REDRAW() does not need to be explicitly called from outside code,
% % %     %  as it is called internally by PanelElement when needed.
% % %     %
% % %     % See also draw, update.
% % % 
% % %     p = pe.p;
% % %     pr_list = pe.pr_list;
% % % 
% % %     % get panel (p) position
% % %     % repositions the panel
% % %     x0_p = ceil(get_from_varargin(x0(p, 'pixels'), 'X0', varargin));
% % %     y0_p = ceil(get_from_varargin(y0(p, 'pixels'), 'Y0', varargin));
% % %     w_p = ceil(max(get_from_varargin(w(p, 'pixels'), 'Width', varargin), pe.get('MIN_WIDTH')));
% % %     h_p = ceil(get_from_varargin(w(p, 'pixels'), 'Height', varargin));
% % %     
% % %     % graphics constants
% % %     dh = ceil(pe.get('DH') * BRAPH2.S);
% % %     dw = ceil(pe.get('DW') * BRAPH2.S);
% % %     w_s = ceil(pe.get('WSLIDER') * BRAPH2.S);
% % % 
% % %     % redraw prop panels (following update)
% % %     w_pp = w_p - 2 * dw - w_s;
% % %     for prop = 1:1:length(pr_list)
% % %         pe.get('PR_DICT').getItem(prop).redraw('Width', w_pp)
% % %     end
% % %     
% % %     % calculate position prop panels (pp)
% % %     x0_pp = dw;
% % %     h_pp = cellfun(@(x) h(x, 'pixels'), pr_list);
% % %     y0_pp = sum(h_pp + dh) - cumsum(h_pp + dh) + dh;
% % %     
% % %     % calculate and set height panel (p)
% % %     if sum(h_pp + dh) + dh > h_p
% % %         h_p = sum(h_pp + dh) + dh;
% % %     else
% % %         y0_pp = y0_pp + (h_p - sum(h_pp + dh) - dh);
% % %     end
% % % 
% % %     set(p, ...
% % %         'Units', 'pixels', ...
% % %         'Position', [x0_p y0_p w_p h_p] ...
% % %         )
% % %     
% % %     % reposition prop panels
% % %     for prop = 1:1:length(pr_list)
% % %         pr = pr_list{prop};
% % %         set(pr, 'Position', [x0_pp y0_pp(prop) w(pr) h(pr)])
% % %     end    
% % % end
% function reinit(pf, new_pf)
% % %     %REINIT resets the element, and updates and redraws the element plot.
% % %     %
% % %     % REINIT(PE, EL) reinitializes the plot element.Specifically:
% % %     %  1. sets EL as the new element of the PanelElement
% % %     %  2. reinizalizes PR_DICT
% % %     %  3. deletes all prop panels
% % %     %  4. draws anew, updates and redraws
% % %     % 
% % %     % Important note:
% % %     %  EL must be of the same class as the previous element in the
% % %     %  PanelElement, otherwise an error is thrown.
% % %     %  Error id: [BRAPH2:PanelElement:WrongInput].
% % %     %
% % %     % See also update, draw, redraw.

% % %     assert( ...
% % %         strcmp(pf.getClass(), new_pf.getClass()), ...
% % %         [BRAPH2.STR ':PanelFig:' BRAPH2.WRONG_INPUT], ...
% % %         [BRAPH2.STR ':PanelFig:' BRAPH2.WRONG_INPUT ' ' ...
% % %         'The class of the new panel figure (' new_pf.getClass() ') must be exactly the same as that of the old element (' pf.get('EL').getClass() ').'] ...
% % %         )    
% % % 
% % %     pf.set( ...
% % %         'EL', new_pf, ...
% % %         'PR_DICT', NoValue.getNoValue() ...
% % %         )

%     delete(get(pf.p, 'Children'))
%     
%     pf.draw()
%     pf.set()
% % %     pf.update()
% % %     pf.redraw()
% end
% % % function cb_bring_to_front(pe)
% % %     %CB_BRING_TO_FRONT brings to front the figure with the element panel and its dependent figures.
% % %     %
% % %     % CB_BRING_TO_FRONT(PE) brings to front the figure with the element and
% % %     %  its dependent figures by calling the methods cb_bring_to_front() for
% % %     %  all the PanelProp panels of the PanelElement.
% % %     %  
% % %     % Note that it will draw a new the figure if the element panel is currently not plotted. 
% % %     %
% % %     % See also cb_hide, cb_close.
% % % 
% % %     pe.cb_bring_to_front@Panel();
% % %     
% % %     pr_dict = pe.get('PR_DICT');
% % %     for prop = 1:1:pr_dict.length()
% % %         pr = pr_dict.getItem(prop);
% % %         pr.cb_bring_to_front()
% % %     end
% % % end
% % % function cb_hide(pe)
% % %     %CB_HIDE hides the figure with the element panel and its dependent figures.
% % %     %
% % %     % CB_HIDE(PE) hides the figure with the element panel and its dependent figures 
% % %     %  by calling the methods cb_hide() for all the PanelProp panels of the PanelElement.
% % %     %  
% % %     % See also cb_bring_to_front, cb_close.
% % % 
% % %     pe.cb_hide@Panel();
% % %     
% % %     pr_dict = pe.get('PR_DICT');
% % %     for prop = 1:1:pr_dict.length()
% % %         pr = pr_dict.getItem(prop);
% % %         pr.cb_hide()
% % %     end
% % % end
% % % function cb_close(pe)
% % %     %CB_CLOSE closes the figure with the element panel and its dependent figures.
% % %     %
% % %     % CB_CLOSE(PE) closes the figure with the element panel and its dependent figures 
% % %     %  by calling the methods cb_close() for all the PanelProp panels of the PanelElement.
% % %     %  
% % %     % See also cb_bring_to_front, cb_hide.
% % % 
% % %     pe.cb_close@Panel();
% % %     
% % %     pr_dict = pe.get('PR_DICT');
% % %     for prop = 1:1:pr_dict.length()
% % %         pr = pr_dict.getItem(prop);
% % %         pr.cb_close()
% % %     end
% % % end

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡code!