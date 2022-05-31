%% ¡header!
SettingsPosition < Settings (st, position settings) contains the figure panel settings.

%%% ¡description!
% % %

%%% ¡seealso!
PanelFig, GUIFig

%% ¡props!

%%% ¡prop!
AUTOPOS (figure, logical) determines whether the position is adjusted automatically.
%%%% ¡default!
true
%%%% ¡postprocessing!
p = st.h();
if st.get('AUTOPOS') && (~strcmpi(get(p, 'Units'), 'normalized') || ~isequal(get(p, 'Position'), [0 0 1 1]))
    set(p, ...
        'Units', 'normalized', ...
        'Position', [0 0 1 1] ...
        )
elseif ~st.get('AUTOPOS') && (~strcmpi(get(p, 'Units'), 'pixels') || ~isequal(get(p, 'Position'), [st.get('X0') st.get('Y0') st.get('WIDTH') st.get('HEIGHT')]))
    set(p, ...
        'Units', 'pixels', ...
        'Position', [st.get('X0') st.get('Y0') st.get('WIDTH') st.get('HEIGHT')] ...
        )
end

%%% ¡prop!
X0 (figure, scalar) is the lower left x-coordinate of the panel in pixels.
%%%% ¡default!
1

%%% ¡prop!
Y0 (figure, scalar) is the lower-left y-coordinate of the panel in pixels.
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