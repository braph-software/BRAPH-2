%% ¡header!
Settings < Element (st, graphics settings) contains some graphics settings.

%%% ¡description!
Settings provides the base element for all grpahics settings.
 The graphics objects is identified as a graphics tag (UITAG string) of a Panel element (PANEL item).
 Typically, only its subclasses are employed.

The handle to the graphics object can be retrieved as 
    
    h = st.<stron>h</strong>()
    
 which returns the handle is the Panel element is srt and an empty array otherwise.

Typically, it is used as a prop of a subclass of Panel (pl) and it is 
 initialized in the constructor with this code:

    if isa(pl.getr('SETTINGS_PROP'), 'NoValue')
        pl.memorize('SETTINGS_PROP').set('PANEL', pl, 'UITAG', 'uitag')
    end

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