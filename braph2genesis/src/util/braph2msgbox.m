function f_out = braph2msgbox(title, message)
%BRAPH2MSGBOX opens a modal message box.
%
% BRAPH2MSGBOX(TITLE, MESSAGE) opens a modal message box with TITLE and
%  MESSAGE. 
%
% F = BRAPH2MSGBOX(TITLE, MESSAGE) retunrs a handle to the figure of the
%  message box. 

icon = rgb2gray(imresize(imread('braph2icon.png'), [50 50]));
cmap = [BRAPH2.COL_FIG; repmat(BRAPH2.COL, 254, 1); 1 1 1];

CreateStruct.WindowStyle = 'modal';
CreateStruct.Interpreter = 'tex';

DefaultUicontrolBackgroundColor_BAK = get(0, 'DefaultUicontrolBackgroundColor');
set(0, 'DefaultUicontrolBackgroundColor', BRAPH2.COL_FIG)
f = msgbox(message, title, ...
    'custom', icon, cmap, ...
    CreateStruct);
set(0, 'DefaultUicontrolBackgroundColor', DefaultUicontrolBackgroundColor_BAK)

if nargout > 0
    f_out = f;
end

end
