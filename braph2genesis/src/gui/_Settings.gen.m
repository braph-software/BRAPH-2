%% ¡header!
Settings < Element (st, graphics settings) contains some graphics settings.

%%% ¡description!
Settings provides the base element for all graphics settings.
 The graphics objects is identified by its handle h, which can be retrieves as 
 
    h = st.<stron>h</strong>()

 If H is a valid graphic object, it returns the handle; otherwise it retrieves 
  the hnadle as the graphics tag (UITAG string) of a Panel element (PANEL item).

 The handle can be set as
 
    [st = ]st.<stron>h</strong>(h)
    
  or indeirectly setting the graphics tag (UITAG string) ans the Panel element (PANEL item).
  
Typically, it is used as a prop of a subclass of Panel (pn) and it is 
 initialized in the constructor a code smiliar to this:

	pn.memorize(''SETTINGS_PROP'').h(pn.h).set(''PANEL'', pn, ''UITAG'', ''uitag'')

 It might be necessary to add some listeners (e.g., to update toogle buttons).
  
Typically, only its subclasses are employed.

%%% ¡seealso!
Panel, listener

%% ¡props!

%%% ¡prop!
ID (data, string) is a few-letter code for the graphics settings.

%%% ¡prop!
PANEL (gui, item) is the panel to which the graphics object belongs.
%%%% ¡settings!
'Panel'

%%% ¡prop!
UITAG (gui, string) is the UI tag of the graphics object.
%%%% ¡default!
'p'

%% ¡properties!
handle % handle for the graphics object

%% ¡methods!
function out = h(st, handle)
    %H() sets and returns the graphics object handle.
    %
    % HANDLE = H(ST) returns the handle of the graphics object 
    %  to which the settings are applied.
    %
    % H(ST, HANDLE) sets the handle to H.
    %
    % ST = H(ST, HANDLE) sets the handle to H and the turns the Settings.
    
    if nargin > 1
        st.handle = handle;
    end
    
    if isempty(st.handle) || ~check_graphics(st.handle)
        if check_graphics(st.get('PANEL').panel(), 'uipanel')
            st.handle = findall(st.get('PANEL').panel(), 'Tag', st.get('UITAG'));
        end
    end
    
    if nargout > 0
        if nargin == 1
            out = st.handle; % returns the handle
        else
            out = st; % returns the Settings element
        end
    end
end