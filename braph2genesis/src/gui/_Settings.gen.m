%% ¡header!
Settings < Element (st, graphics settings) contains some graphics settings.

%%% ¡description!
% % %

%%% ¡seealso!
Panel

%% ¡props!

%%% ¡prop!
ID (data, string) is a few-letter code for the graphics settings.

%%% ¡prop!
PANEL (gui, item) is the panel to which the graphics object belongs.
%%%% ¡settings!
'Panel'
%%%% ¡postprocessing!
if st.prop_set('PANEL', varargin) && ~braph2_testing()
    st.p = st.get('PANEL').draw();
end

%%% ¡prop!
UITAG (gui, string) is the UI tag of the graphics object.
%%%% ¡default!
'p'

%% ¡properties!
p % handle for the panel
handle % handle for the graphics object

%% ¡methods!
function handle = h(st)
    %HANDLE() returns the graphics object handle.
    %
    % H = HANDLE(ST) sets and returns the handle of the graphics object 
    %  to which the settings are applied.
    
    if check_graphics(st.p)
        st.handle = findall(st.p, 'Tag', st.get('UITAG'));
    end
    
    handle = st.handle;
end