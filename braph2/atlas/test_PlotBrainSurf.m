% File to test the use of PlotBrainSurf.
%
% See also PlotBrainSurf, ListElement.

% Author: Mite Mijalkov, Ehsan Kakaei & Giovanni Volpe
% Date: 2016/01/01

close all
clear all
clc

bs = PlotBrainSurf()

bs.brain()
bs.axis_equal()
bs.view(PlotBrainSurf.VIEW_3D)
bs.update_light()

h = bs.get_axes()

% bs.brain_settings( ...
%     'FigPosition',[.1 .1 .2 .2], ...
%     'FigColor', [.95 .95 .95], ...
%     'FigTitle', 'PlotBrainSurf' ...
%     )