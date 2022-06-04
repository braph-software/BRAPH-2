%% ¡header!
Settings < Element (st, graphics settings) contains some graphics settings.

%%% ¡description!
% % % Settings provides the base element for all grpahics settings.
% % %  The graphics objects is identified as a graphics tag (UITAG string) of a Panel element (PANEL item).
% % %  Typically, only its subclasses are employed.
% % % 
% % % The handle to the graphics object can be retrieved as 
% % %     
% % %     h = st.<stron>h</strong>()
% % %     
% % %  which returns the handle is the Panel element is srt and an empty array otherwise.
% % % 
% % % Typically, it is used as a prop of a subclass of Panel (pl) and it is 
% % %  initialized in the constructor with this code:
% % % 
% % %     if isa(pl.getr(''SETTINGS_PROP''), ''NoValue'')
% % %         pl.memorize(''SETTINGS_PROP'').set(''PANEL'', pl, ''UITAG'', ''uitag'')
% % %     end
% % % 
% % %  It might be necessary to add some listeners (e.g., to update toogle buttons).

%%% ¡seealso!
Panel

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
% % %     %HANDLE() returns the graphics object handle.
% % %     %
% % %     % H = HANDLE(ST) sets and returns the handle of the graphics object 
% % %     %  to which the settings are applied.
    
    if nargin > 1
        st.handle = handle;
    end
    
    if isempty(st.handle) || ~check_graphics(st.handle)
% % %         st.handle = st.get('PANEL').panel();
% % % 
% % %         uigen = st.get('UIGEN');
% % %         for g = 1:1:length(uigen)
% % %             st.handle = st.handle.Children(uigen(g));
% % %         end
        if check_graphics(st.get('PANEL').panel())
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