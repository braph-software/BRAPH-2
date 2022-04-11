function set_braph2icon(f)
%SET_BRAPH2ICON sets the figure title icon to braph2icon.png.
%
% SET_BRAPH2ICON(F) sets the figure F title icon to braph2icon.png.

warning('off', 'MATLAB:ui:javaframe:PropertyToBeRemoved')
javaFrame = get(f, 'JavaFrame'); %#ok<JAVFM>
iconFilePath = [fileparts(which('braph2')) filesep 'src' filesep 'util' filesep 'braph2icon.png'];
javaFrame.setFigureIcon(javax.swing.ImageIcon(iconFilePath));
warning('on', 'MATLAB:ui:javaframe:PropertyToBeRemoved')

end