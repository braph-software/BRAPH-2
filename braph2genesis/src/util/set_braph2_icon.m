function set_braph2_icon(f)
%SET_BRAPH2_ICON sets the figure title icon to braph2icon.png.
%
% SET_BRAPH2_ICON(F) sets the figure F tittle icon to braph2icon.png.

warning('off')
javaFrame = get(f, 'JavaFrame'); %#ok<JAVFM>
iconFilePath = [fileparts(which('braph2')) filesep 'src' filesep 'util' filesep 'braph2icon.png'];
javaFrame.setFigureIcon(javax.swing.ImageIcon(iconFilePath));
warning('on')

end