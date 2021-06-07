%% ¡header!
PPComparisonEnsembleDiff < PlotProp (pl, plot property of comparison ensemble difference) is a plot of comparison ensemble difference.

%%% ¡description!
PPComparisonEnsembleDiff plots a Compairson Ensemble difference.

%%% ¡seealso!
GUI, PlotElement, PlotProp, CompareEnsemble, ComparisonEnsemble.

%% ¡properties!
pp
comparison_tbl

%% ¡methods!
function h_panel = draw(pl, varargin)
    %DRAW draws the idict for group ensemble property graphical panel.
    %
    % DRAW(PL) draws the idict property graphical panel.
    %
    % H = DRAW(PL) returns a handle to the idict property graphical panel.
    %
    % DRAW(PL, 'Property', VALUE, ...) sets the properties of the graphical
    %  panel with custom property-value couples.
    %  All standard plot properties of uipanel can be used.
    %
    % It is possible to access the properties of the various graphical
    %  objects from the handle to the brain surface graphical panel H.
    %
    % see also update, redraw, refresh, settings, uipanel, isgraphics.

    pl.pp = draw@PlotProp(pl, varargin{:});

    % output
    if nargout > 0
        h_panel = pl.pp;
    end
end
function update(pl)
    %UPDATE updates the content of the property graphical panel.
    %
    % UPDATE(PL) updates the content of the property graphical panel.
    %
    % See also draw, redraw, refresh.

    update@PlotProp(pl)

    el = pl.get('EL');
    prop = pl.get('PROP');    
    a1 = el.get('A1');
    graph = a1.get('G_DICT').getItem(1);

    function [pixels, normalized] = get_figure_position()
        fig_h = getGUIFigureObj();
        set(fig_h, 'Units', 'normalized'); % set it to get position on normal units
        pixels = getpixelposition(fig_h);
        normalized = get(fig_h, 'Position');
        set(fig_h, 'Units', 'characters'); % go back
    end
    function obj = getGUIFigureObj()
        obj = get_handle_objs('figure', 'CompareEnsemble');
    end

    if el.getPropCategory(prop) == Category.RESULT && isa(graph, 'NoValue')
        %
    else
        % construct a data holder
        if isa(graph, 'Graph')  
            [parent_position_pixels, ~] = get_figure_position();
            mlist = Graph.getCompatibleMeasureList(graph);
            data = cell(length(mlist), 5);
            for mi = 1:1:length(mlist)
                if any(pl.selected == mi)
                    data{mi, 1} = true;
                else
                    data{mi, 1} = false;
                end
                data{mi, 2} = mlist{mi};
                if Measure.is_nodal(mlist{mi})
                    data{mi, 3} = 'NODAL';
                elseif Measure.is_global(mlist{mi})
                    data{mi, 3} = 'GLOBAL';
                else
                    data{mi, 3} = 'BINODAL';
                end
                
                if Measure.is_superglobal(mlist{mi})
                    data{mi, 4} = 'SUPERGLOBAL';
                elseif Measure.is_unilayer(mlist{mi})
                    data{mi, 4} = 'UNILAYER';
                else
                    data{mi, 4} = 'BILAYER';
                end
                
                data{mi, 5} = eval([mlist{mi} '.getDescription()']);
            end            

            set(pl.comparison_tbl, ...
                'Data', data, ...
                'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)] ...
                )
            set(pl.comparison_tbl, 'ColumnWidth', {'auto', 'auto', 'auto', 'auto', parent_position_pixels(3)})
        end

    end
end
function redraw(pl, varargin)
    %REDRAW redraws the element graphical panel.
    %
    % REDRAW(PL) redraws the plot PL.
    %
    % REDRAW(PL, 'Height', HEIGHT) sets the height of PL (by default HEIGHT=3.3).
    %
    % See also draw, update, refresh.

    el = pl.get('EL');
    prop = pl.get('PROP');
    
    value = el.getr(prop);
    if el.getPropCategory(prop) == Category.RESULT && isa(value, 'NoValue')
        pl.redraw@PlotProp('Height', 1.8, varargin{:})
    else
        value_cell = el.get(prop);
        
        if isempty(value_cell)
            pl.redraw@PlotProp('Height', 1.8, varargin{:})
        else
            pl.redraw@PlotProp('Height', 30, varargin{:})
        end
        
        for i = 1:1:size(value_cell, 1)
            for j = 1:1:size(value_cell, 2)
                set(pl.comparison_tbl{i, j}, ...
                    'Units', 'character', ...
                    'Position', ...
                    [ ...
                    (0.01 + (i - 1) * 0.98 / size(pl.comparison_tbl, 1)) * Plot.w(pl.pp) ...
                    (0.2 + (j - 1) * 0.8 / size(pl.comparison_tbl, 2)) * (Plot.h(pl.pp) - 1.8) ...
                    0.98 / size(pl.comparison_tbl, 1) * Plot.w(pl.pp) ...
                    0.8 / size(pl.comparison_tbl, 2) * (Plot.h(pl.pp) - 1.8) ...
                    ] ...
                    )
            end
        end
    end
end
