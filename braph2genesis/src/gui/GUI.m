function GUI(el)

f = figure();

pl = PlotElement('EL', el);
pl.draw('Parent', f)

end