%% ¡header!
SettingsText < Settings (st, text settings) contains the text settings.

%%% ¡description!
SettingsSymbol provides the settings for a text, 
including visibility, x, y, z, font color, font size, and interpreter.

%%% ¡seealso!
PanelFig, GUIFig, text

%% ¡props!

%%% ¡prop!
VISIBLE (figure, logical) determines whether the text is visible.
%%%% ¡defaul!
false
%%%% ¡postprocessing!
h = st.h(); % text
if check_graphics(h, 'text') && ( ...
        get(h, 'Visible') ~= st.get('VISIBLE') || ...
        ~isequal(get(h, 'Position'), [st.get('X') st.get('Y') st.get('Z')]) || ...
        ~isequal(get(h, 'String'), st.get('TXT')) || ...
        get(h, 'FontSize') ~= st.get('FONTSIZE') || ...
        ~isequal(get(h, 'FontName'), st.get('FONTNAME')) || ...
        ~isequal(get(h, 'Color'), st.get('FONTCOLOR')) || ...
        ~isequal(get(h, 'Interpreter'), st.get('INTERPRETER')) || ...
        ~isequal(get(h, 'HorizontalAlignment'), st.get('HORIZONTALALIGNMENT')) || ...
        ~isequal(get(h, 'VerticalAlignment'), st.get('VERTICALALIGNMENT')) || ...
        get(h, 'Rotation') ~= st.get('ROTATION') ...
        )
    if st.get('VISIBLE')
        set(h, ...
            'Position', [st.get('X') st.get('Y') st.get('Z')], ...
            'String', st.get('TXT'), ...
            'FontSize', st.get('FONTSIZE'), ...
            'FontName', st.get('FONTNAME'), ...
            'Color', st.get('FONTCOLOR'), ...
            'Interpreter', st.get('INTERPRETER'), ...
            'HorizontalAlignment', st.get('HORIZONTALALIGNMENT'), ...
            'VerticalAlignment', st.get('VERTICALALIGNMENT'), ...
            'Rotation', st.get('ROTATION'), ...
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
TXT (figure, string) is the text.

%%% ¡prop!
FONTSIZE (figure, size) is the font size.
%%%% ¡default!
BRAPH2.FONTSIZE

%%% ¡prop!
FONTNAME (figure, string) is the font name.
%%%% ¡default!
'Helvetica'

%%% ¡prop!
FONTCOLOR (figure, color) is the text color.
%%%% ¡default!
[0 0 0]

%%% ¡prop!
INTERPRETER (figure, option) is the text interpreter.
%%%% ¡settings!
{'none', 'TeX', 'LaTeX'}
%%%% ¡default!
'none'

%%% ¡prop!
HORIZONTALALIGNMENT (figure, option) is the text horizonthal alignment.
%%%% ¡settings!
{'left', 'center', 'right'}

%%% ¡prop!
VERTICALALIGNMENT (figure, option) is the text vertical alignment.
%%%% ¡settings!
{'middle', 'top', 'bottom', 'baseline', 'cap'}

%%% ¡prop!
ROTATION (figure, scalar) is the text rotation.
