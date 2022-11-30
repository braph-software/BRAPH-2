%% ¡header!
PPNNSubjectInputMeasure < PanelPropCell (pr, panel property cell) plots the panel of a cell property in a table with sliders.

%%% ¡description!
PanelPropCell plots the panel of a CELL property with a table with sliders.
It works for all categories.

% % % It can be personalized with the following props:
% % %  ROWNAME - Code to generate the row names as per uitable format.
% % %  COLUMNAME - Code to generate the column names as per uitable format.

%%% ¡seealso!
GUI, PanelElement, PanelProp, uitable, uislider

%% ¡properties!
p
table
xslider
yslider

contextmenu
%
menu_export_to_xls

%% ¡props!
%%% ¡prop!
BA (data, item) is a brain atlas.
%%%% ¡settings!
'BrainAtlas'
%%%% ¡default!
BrainAtlas()

%%% ¡prop!
INPUT_LABEL (data, classlist) represents the the label of input, which can be either graph or measure.

%% ¡methods!
function p_out = draw(pr, varargin)
    %DRAW draws the panel of the cell property.
    %
    % DRAW(PR) draws the panel of the cell property.
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
    
    el = pr.get('EL');
    prop = pr.get('PROP');

    if size(el.getr(prop), 1) == 1
        pr.set('YSLIDERLABELS', 'pr.oneLayerLabel()');
    elseif size(el.getr(prop), 1) == 2
        pr.set('YSLIDERLABELS', 'pr.LayerLabel()');
    end

    pr.p = draw@PanelPropCell(pr, varargin{:});
    
    childs = get(pr.p, 'Children');

    % we have now the t, sliders
    for i = 1:length(childs)
        c = childs(i);
        if check_graphics(c, 'uitable');
            pr.table = c;
        elseif check_graphics(c, 'uislider');
             if c.Tag == 'xslider'
                 pr.xslider = c;
             else
                 pr.yslider = c;
             end
        end
    end

    set(pr.xslider, 'ValueChangedFcn', {@cb_xslider_nn});
    set(pr.yslider, 'ValueChangedFcn', {@cb_yslider_nn});

    function cb_xslider_nn(~, ~)
        pr.cb_xslider();
        pr.cb_xslider_nn();
    end

    function cb_yslider_nn(~, ~)
        pr.cb_yslider();
        pr.cb_xslider_nn();
    end
    pr.cb_xslider_nn();

    % output
    if nargout > 0
        p_out = pr.p;
    end
end
function update(pr)
    %UPDATE updates the content and permissions of the table and sliders.
    %
    % UPDATE(PR) updates the content and permissions of the table and sliders.
    %
    % See also draw, redraw, PanelElement.

    update@PanelPropCell(pr);
    el = pr.get('EL');
    prop = pr.get('PROP');
    if ~isa(el.getr(prop), 'NoValue')
        if size(el.get(prop), 2) == 1
            pr.set('YSLIDERLABELS', 'pr.oneLayerLabel()');
        else
            pr.set('YSLIDERLABELS', 'pr.LayerLabel()');
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
    % 2. REDRAW() is typically called internally by PanelElement and does not need 
    %  to be explicitly called in children of PanelProp.
    %
    % REDRAW(PR, 'X0', X0, 'Y0', Y0, 'Width', WIDTH, 'Height', HEIGHT, 'DHeight', DHEIGHT)
    %  repositions the property panel. It is possible to use a
    %  subset of the Name-Value pairs.
    %  By default:
    %  - X0 does not change
    %  - Y0 does not change
    %  - WIDTH does not change
    %  - HEIGHT = s(2) (header height)
    % The table height is set by the property TAB_H.
    % The slider space is set by the properties XSLIDERHEIGHT and YSLIDERWIDTH.
    %
    % See also draw, update, PanelElement, s.

    pr.cb_xslider_nn();
    redraw@PanelPropCell(pr, varargin{:});
end
function cb_xslider_nn(pr)
    set(pr.xslider, 'Value', round(get(pr.xslider, 'Value')))
    pr.update();
    el = pr.get('el');
    measure_labels = pr.get('Input_Label');
    if pr.xslider.Value > 0 && string(pr.xslider.MajorTickLabels(pr.xslider.Value)) == 'Nodal'
        idx_nodal_measures = cellfun(@(x) Measure.is_nodal(x), measure_labels, 'UniformOutput',false);
        set(pr.table, 'columnname', measure_labels(cell2mat(idx_nodal_measures)));
        set(pr.table, 'rowname', pr.get('BA').get('BR_DICT').getKeys());
    elseif pr.xslider.Value > 0 && string(pr.xslider.MajorTickLabels(pr.xslider.Value)) == 'Global'
        idx_global_measures = cellfun(@(x) Measure.is_global(x), measure_labels, 'UniformOutput',false);
        set(pr.table, 'columnname', measure_labels(cell2mat(idx_global_measures)));
        set(pr.table, 'rowname', eval(pr.getPropDefault('ROWNAME')));
    elseif pr.xslider.Value > 0 && string(pr.xslider.MajorTickLabels(pr.xslider.Value)) == 'Binodal'
        idx_binodal_measures = cellfun(@(x) Measure.is_binodal(x), measure_labels, 'UniformOutput',false);
        measures_binodal = measure_labels(cell2mat(idx_binodal_measures));
        measures_binodal_all = {};
        for i = 1:length(measures_binodal)
            measures_binodal_all = [measures_binodal_all, strcat(measures_binodal(i), pr.get('BA').get('BR_DICT').getKeys())];
        end
        set(pr.table, 'columnname', measures_binodal_all);
        set(pr.table, 'rowname', pr.get('BA').get('BR_DICT').getKeys());
    else
        set(pr.table, 'columnname', eval(pr.getPropDefault('COLUMNNAME')));
        set(pr.table, 'rowname', eval(pr.getPropDefault('ROWNAME')));
    end
end

function p = return_p(pr)
    p = pr.p;
end
function x_slider = return_x_slider(pr)
    x_slider = pr.xslider;   
end
function y_slider = return_y_slider(pr)
    y_slider = pr.yslider;
end
function lbls = oneLayerLabel(pr)
    lbls = {'L1'};
end
function lbls = LayerLabel(pr)
    el = pr.get('EL');
    prop = pr.get('PROP');
    L = size(el.get(prop), 2);
    lbls = cellfun(@(x) ['L' num2str(x)], num2cell(1:L), 'UniformOutput', false);
end