%% ¡header!
PPSubjectCON_CON < PlotPropMatrix (pl, plot subject connnectivity data) represents the connnectivity data of a subject.

%%% ¡description!
PPSubjectCON_CON represents the connnectivity data of a subject.

%%% ¡seealso!
GUI, PlotElement, PlotPropMatrix, Subject, SubjectCON.

%% ¡properties!
pp
table_value

%% ¡methods!
function h_panel = draw(pl, varargin)
    %DRAW draws a table with the connnectivity data of a subject.
    %
    % DRAW(PL) draws the graphical panel.
    %
    % H = DRAW(PL) returns a handle to the graphical panel.
    %
    % DRAW(PL, 'Property', VALUE, ...) sets the properties of the graphical
    %  panel with custom property-value couples.
    %  All standard plot properties of uipanel can be used.
    %
    % It is possible to access the properties of the various graphical
    %  objects from the handle H.
    %
    % See also update, redraw, refresh, settings, uipanel, isgraphics.
    
    pl.pp = draw@PlotPropMatrix(pl, varargin{:});

    % retrieves the handle of the table
    children = get(pl.pp, 'Children');
    for i = 1:1:length(children)
        if isa(children(i), 'matlab.ui.control.Table')
            pl.table_value = children(i);
        end
    end

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

    update@PlotPropMatrix(pl)
    
    pp_el = pp.get('EL');
    ba = pp_el.get('BA');

    br_ids = cell(ba.length(), 1);
    for i = 1:1:ba.length()
        br = ba.getItem(i);
        br_id = br.get(BrainRegion.ID);
        if length(br_id) > 10
            br_id = [br_id(1:8) '..'];
        end
        br_ids{i} = br_id;
    end

    set(pl.table_value, ...
        'ColumnName', {}, ...
        'RowName', br_ids ...
        )
end
function redraw(pl, varargin)
    %REDRAW redraws the element graphical panel.
    %
    % REDRAW(PL) redraws the plot PL.
    %
    % REDRAW(PL, 'Height', HEIGHT) sets the height of PL (by default HEIGHT=3.3).
    %
    % See also draw, update, refresh.
    
    pl.redraw@PlotPropMatrix(varargin{:});
end