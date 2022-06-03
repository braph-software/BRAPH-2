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
if check_graphics(h, 'line') && get(h, 'Visible') ~= st.get('VISIBLE')
    if st.get('VISIBLE')
        set(h, 'Visible', true)
    else
        set(h, 'VISIBLE', false)
    end
end

%%% ¡prop!
X (figure, scalar) is the x-coordinate.
%%%% ¡postprocessing!
h = st.h(); % line
if check_graphics(h, 'line') && get(h, 'XData') ~= st.get('X')
    set(h, 'XData', st.get('X'))
end

%%% ¡prop!
Y (figure, scalar) is the y-coordinate.
%%%% ¡postprocessing!
h = st.h(); % line
if check_graphics(h, 'line') && get(h, 'YData') ~= st.get('Y')
    set(h, 'YData', st.get('Y'))
end

%%% ¡prop!
Z (figure, scalar) is the z-coordinate.
%%%% ¡postprocessing!
h = st.h(); % line
if check_graphics(h, 'line') && get(h, 'ZData') ~= st.get('Z')
    set(h, 'ZData', st.get('Z'))
end

%%% ¡prop!
SYMBOL (figure, marker) is the symbol.
%%%% ¡postprocessing!
h = st.h(); % line
if check_graphics(h, 'line') && ~isequal(get(h, 'Marker'), regexprep(st.get('SYMBOL'), 'none', ''))
    set(h, 'Marker', st.get('SYMBOL'))
end

%%% ¡prop!
SYMBOLSIZE (figure, size) is the symbol size.
%%%% ¡default!
10
%%%% ¡postprocessing!
h = st.h(); % line
if check_graphics(h, 'line') && get(h, 'MarkerSize') ~= st.get('SYMBOLSIZE')
    set(h, 'MarkerSize', st.get('SYMBOLSIZE'))
end

%%% ¡prop!
EDGECOLOR (figure, color) is the symbol RGB edge color.
%%%% ¡default!
[0 0 0]
%%%% ¡postprocessing!
h = st.h(); % line
if check_graphics(h, 'line') && ~isequal(get(h, 'MarkerEdgeColor'), st.get('EDGECOLOR'))
    set(h, 'MarkerEdgeColor', st.get('EDGECOLOR'))
end

%%% ¡prop!
FACECOLOR (figure, color) is the symbol RGB face color.
%%%% ¡default!
BRAPH2.COL
%%%% ¡postprocessing!
h = st.h(); % line
if check_graphics(h, 'line') && ~isequal(get(h, 'MarkerFaceColor'), st.get('FACECOLOR'))
    set(h, 'MarkerFaceColor', st.get('FACECOLOR'))
end