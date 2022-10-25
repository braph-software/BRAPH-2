%% ¡header!
SettingsSymbol < Settings (st, symbol settings) contains the symbol settings.

%%% ¡description!
SettingsSymbol provides the settings for a symbol, 
including visibility, x, y, z, symbol marker, symbol size, face color, and edge color.

%%% ¡seealso!
PanelFig, GUIFig, line

%% ¡props!

%%% ¡prop!
VISIBLE (figure, logical) determines whether the symbol is visible.
%%%% ¡defaul!
false
%%%% ¡postprocessing!
h = st.h(); % line
if check_graphics(h, 'line') && ( ...
        get(h, 'Visible') ~= st.get('VISIBLE') || ...
        get(h, 'XData') ~= st.get('X') || ...
        get(h, 'YData') ~= st.get('Y') || ...
        get(h, 'ZData') ~= st.get('Z') || ...
        ~isequal(get(h, 'Marker'), regexprep(st.get('SYMBOL'), 'none', '')) || ...
        get(h, 'MarkerSize') ~= st.get('SYMBOLSIZE') || ...
        ~isequal(get(h, 'MarkerEdgeColor'), st.get('EDGECOLOR')) || ...
        ~isequal(get(h, 'MarkerFaceColor'), st.get('FACECOLOR')) ...
        )
    if st.get('VISIBLE')
        set(h, ...
            'XData', st.get('X'), ...
            'YData', st.get('Y'), ...
            'ZData', st.get('Z'), ...
            'Marker', st.get('SYMBOL'), ...
            'MarkerSize', st.get('SYMBOLSIZE'), ...
            'MarkerEdgeColor', st.get('EDGECOLOR'), ...
            'MarkerFaceColor', st.get('FACECOLOR'), ...
            'Visible', true ...
            )
    else
        set(h, 'VISIBLE', false)
    end
end

%%% ¡prop!
X (figure, scalar) is the x-coordinate.

%%% ¡prop!
Y (figure, scalar) is the y-coordinate.

%%% ¡prop!
Z (figure, scalar) is the z-coordinate.

%%% ¡prop!
SYMBOL (figure, marker) is the symbol.

%%% ¡prop!
SYMBOLSIZE (figure, size) is the symbol size.
%%%% ¡default!
10

%%% ¡prop!
EDGECOLOR (figure, color) is the symbol RGB edge color.
%%%% ¡default!
[0 0 0]

%%% ¡prop!
FACECOLOR (figure, color) is the symbol RGB face color.
%%%% ¡default!
BRAPH2.COL