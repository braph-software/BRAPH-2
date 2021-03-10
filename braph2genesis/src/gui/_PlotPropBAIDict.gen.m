%% ¡header!
PlotPropBAIDict < PlotProp (pl, plot property of brain atlas idict) is a plot of brain atlas idict.

%%% ¡description!
PlotPropBAIDict plots an IndexedDictionary for Brain Atlas brain regions.

%%% ¡seealso!
GUI, PlotElement, PlotProp, BrainAtlas

%% ¡properties!
pp
table_value_idict
selected

%% ¡methods!
function h_panel = draw(pl, varargin)
%DRAW draws the idict for brain atlas property graphical panel.
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

el = pl.get('EL');
prop = pl.get('PROP');
pl.selected = [];

pl.pp = draw@PlotProp(pl, varargin{:});

if isempty(pl.table_value_idict) || ~isgraphics(pl.table_value_idict, 'uitable')
    % construct a data holder
    value_idict_ba = el.get(prop);
    data = cell(value_idict_ba.length(), 7);
    for sub = 1:1:value_idict_ba.length() %#ok<FXUP>
        if any(pl.selected == sub)
            data{sub, 1} = true;
        else
            data{sub, 1} = false;
        end
        data{sub, 2} = value_idict_ba.getItem(sub).get('ID');
        data{sub, 3} = value_idict_ba.getItem(sub).get('Label');
        data{sub, 4} = value_idict_ba.getItem(sub).get('X');
        data{sub, 5} = value_idict_ba.getItem(sub).get('Y');
        data{sub, 6} = value_idict_ba.getItem(sub).get('Z');
        data{sub, 7} = value_idict_ba.getItem(sub).get('Notes');
    end
    pl.table_value_idict = uitable( ...
        'Parent', pl.pp, ...
        'Units', 'normalized', ...
        'Position', [.01 .05 .98 .80], ...
        'Data', data, ...
        'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
        'ColumnEditable', true, ...
        'CellEditCallback', {@cb_table_idict_value} ...
        );
end

% callback
    function cb_table_idict_value(~, event)
        i = event.Indices(1);
        col = event.Indices(2);
        newdata = event.NewData;
        ba_idict = el.getr(prop);
        switch col
            case 1
                if newdata == 1
                    pl.selected = sort(unique([pl.selected(:); i]));
                else
                    pl.selected = pl.selected(pl.selected~=i);
                end
            case 2
                if ~ba_idict.containsKey(newdata)
                    % change brain region id
                    ba_idict.getItem(i).set('ID', newdata)
                    % change brain region key in idict
                    oldkey = ba_idict.getKey(i);
                    ba_idict.replaceKey(oldkey, newdata);
                end
            case 3
                ba_idict.getItem(i).set('Label', newdata)
            case 4
                ba_idict.getItem(i).set('X', newdata)
            case 5
                ba_idict.getItem(i).set('Y', newdata)
            case 6
                ba_idict.getItem(i).set('Z', newdata)
            case 7
                ba_idict.getItem(i).set('Notes', newdata)
        end
        pl.update()
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

update@PlotProp(pl)

el = pl.get('EL');
prop = pl.get('PROP');

value = el.getr(prop);


if el.getPropCategory(prop) == Category.RESULT && isa(value, 'NoValue')
    %
else
    value_idict_ba = el.get(prop);
    % construct a data holder
    data = cell(value_idict_ba.length(), 7);
    for i = 1:1:value_idict_ba.length()
        if any(pl.selected == i)
            data{i, 1} = true;
        else
            data{i, 1} = false;
        end
        data{i, 2} = value_idict_ba.getItem(i).get('ID');
        data{i, 3} = value_idict_ba.getItem(i).get('Label');
        data{i, 4} = value_idict_ba.getItem(i).get('X');
        data{i, 5} = value_idict_ba.getItem(i).get('Y');
        data{i, 6} = value_idict_ba.getItem(i).get('Z');
        data{i, 7} = value_idict_ba.getItem(i).get('Notes');
    end
    
    
    if isempty(pl.table_value_idict)
        pl.table_value_idict = cell(value_idict_ba.length(), 7); % {'logical', 'char', 'char', 'numeric', 'numeric', 'numeric', 'char'})
    end
    
    set(pl.table_value_idict, ...
        'Data', data, ...
        'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)] ...
        )
    
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
    
    pl.redraw@PlotProp('Height', 20, varargin{:});    
end