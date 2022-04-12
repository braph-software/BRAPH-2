function set_icon(f)
% SETICON sets the figure tittle icon to braph2icon.
%
% SETICON(F) sets the figure F tittle icon to braph2icon.
%
% see also BRAPH2, figure.

warning('off')
javaFrame = get(f, 'JavaFrame'); %#ok<JAVFM>
iconFilePath = [fileparts(which('braph2')) filesep 'src' filesep 'util' filesep 'braph2icon.png'];
javaFrame.setFigureIcon(javax.swing.ImageIcon(iconFilePath));
warning('on')
end