%% ¡header!
PanelPropRVectorSmart < PanelPropString (pr, plot property smart row vector) is a plot of a smart row vector.

%%% ¡description!
PanelPropRVEctorSmart plots the panel for a STRING property with an edit field.
Smart means that any matlab expression leading to a correct row vector can be introduced in the field.
Also, the valus of the vector can be limited between some MIN and MAX.
It works for all categories, exept for Category.RESULT.

%%% ¡seealso!
GUI, PanelElement, PanelProp, uieditfield

%% ¡properties!
p
editfield

%% ¡props!

%%% ¡prop!
MAX (parameter, scalar) is the max value acceptable as input.
%%%% ¡default!
+Inf

%%% ¡prop!
MIN (parameter, scalar) is the min value acceptable as input.
%%%% ¡default!
-Inf

%%% ¡prop!
UNIQUE_VALUE (parameter, logical) determines if sorting the data with no repetitions.
%%%% ¡default!
true

%%% ¡prop!
DEFAULT (parameter, rvector) is the default value.

%% ¡methods!
function p_out = draw(pr, varargin)
    %DRAW draws the panel of the smart row vector property.
    %
    % DRAW(PR) draws the panel of the smart row vector property.
    %
    % P = DRAW(PR) returns a handle to the property panel.
    % 
    % DRAW(PR, 'Property', VALUE, ...) sets the properties of the graphical
    %  panel with custom Name-Value pairs.
    %  All standard plot properties of uipanel can be used.
    %
    % It is possible to access the properties of the various graphical
    %  objects from the handle P of the panel.
    %
    % See also update, redraw, uipanel.
    
    pr.p = draw@PanelPropString(pr, varargin{:});
    
    pr.editfield = pr.p.Children(1);
    
    % output
    if nargout > 0
        p_out = pr.p;
    end
end
function update(pr)
    %UPDATE updates the content and permissions of the edit field.
    %
    % UPDATE(PR) updates the content and permissions of the edit field.
    %
    % See also draw, redraw, PanelElement.

    update@PanelProp(pr)
    
    el = pr.get('EL');
    prop = pr.get('PROP');
    
    set(pr.editfield, 'Value', mat2str(el.get(prop)))

    if el.isLocked(prop) || isa(el.getr(prop), 'Callback')
        set(pr.editfield, ...
            'Editable', 'off', ...
            'Enable', pr.get('ENABLE') ...
            )
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
    % REDRAW(PR, 'X0', X0, 'Y0', Y0, 'Width', WIDTH, 'Height', HEIGHT)
    %  repositions the property panel. It is possible to use a
    %  subset of the Name-Value pairs.
    %  By default:
    %  - X0 does not change
    %  - Y0 does not change
    %  - WIDTH does not change
    %  - HEIGHT = s(3.5)
    %
    % See also draw, update, PanelElement, s.

    pr.redraw@PanelPropString(varargin{:})
end
function cb_editfield(pr)
    %CB_EDITFIELD executes callback for the edit field.
    %
    % CB_EDITFIELD(PR) executes callback for the edit field.

    el = pr.get('EL');
    prop = pr.get('PROP');

    try 
        value = eval(['[' get(pr.editfield, 'Value') ']']);
        if pr.get('UNIQUE_VALUE')
            value = unique(value(:)'); % sort done by unique
        end
        value(value < pr.get('MIN')) = pr.get('MIN');
        value(value > pr.get('MAX')) = pr.get('MAX');
        
        if isempty(value)
            value = pr.get('DEFAULT');
        end
    catch
        value = el.get(prop);
    end
    
    el.set(prop, value)

% % %     pr.update()
end

