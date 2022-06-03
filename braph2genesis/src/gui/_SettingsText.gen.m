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
        ~isequal(get(h, 'Interpreter'), st.get('INTERPRETER')) ...
        )
    if st.get('VISIBLE')
        set(h, ...
            'Position', [st.get('X') st.get('Y') st.get('Z')], ...
            'String', st.get('TXT'), ...
            'FontSize', st.get('FONTSIZE'), ...
            'FontName', st.get('FONTNAME'), ...
            'Color', st.get('FONTCOLOR'), ...
            'Interpreter', st.get('INTERPRETER'), ...
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
'LaTeX'