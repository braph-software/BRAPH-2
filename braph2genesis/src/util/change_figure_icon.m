function change_figure_icon(f)
    warning('off')
    javaFrame = get(f, 'JavaFrame'); %#ok<JAVFM>
    iconFilePath = [fileparts(which('braph2')) filesep 'src' filesep 'util' filesep 'braphicon_notext.png'];
    javaFrame.setFigureIcon(javax.swing.ImageIcon(iconFilePath));
    warning('on')
end