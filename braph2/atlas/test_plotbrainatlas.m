% test PlotBrainAtlas

br1 = BrainRegion('BR1', 'brain region 1', 'brain region notes 1', 1, 11, 111);
br2 = BrainRegion('BR2', 'brain region 2', 'brain region notes 2', 2, 22, 222);
br3 = BrainRegion('BR3', 'brain region 3', 'brain region notes 3', 3, 33, 333);
br4 = BrainRegion('BR4', 'brain region 4', 'brain region notes 4', 4, 44, 444);
br5 = BrainRegion('BR5', 'brain region 5', 'brain region notes 5', 5, 55, 555);

atlas = BrainAtlas('TRIAL', 'Brain Atlas', 'Brain atlas notes', 'BrainMesh_Cerebellum.nv', {br1, br2, br3, br4, br5});

%% Test 1: Basic Functions.
ba = PlotBrainAtlas(atlas);
h = ba.set_axes();
ba.hold_on();
ba.view(PlotBrainAtlas.VIEW_3D);

assert(~isempty(ba), ...
    [BRAPH2.STR ':' class(ba) ':' BRAPH2.WRONG_OUTPUT], ...
    'PlotBrainAtlas does not work.')

close

%% Symbols, Spheres, Labels
ba = PlotBrainAtlas(atlas);
h = ba.set_axes();
ba.hold_on();
ba.view(PlotBrainAtlas.VIEW_3D);
ba.br_syms()
ba.br_syms_on()

ba.br_syms_settings([], ...
    'FigPosition', [.1 .2 .4 .4], ...
    'FigColor', [.95 .95 .95], ...
    'FigTitle','PlotBrainSurf - Symbols' ...
    )

close

ba.br_sphs()
ba.br_sphs_on()

ba.br_sphs_settings([], ...
    'FigPosition',[.2 .3 .4 .4], ...
    'FigColor', [.95 .95 .95], ...
    'FigTitle','PlotBrainSurf - Spheres' ...
    )

close

ba.br_labs()
ba.br_labs_on()

ba.br_labs_settings([], ...
    'FigPosition',[.3 .4 .4 .4], ...
    'FigColor', [.95 .95 .95], ...
    'FigTitle','PlotBrainSurf - Labels' ...
    )

close
close  % close the axis figure.

%% Distance
atlas = BrainAtlas.load_from_txt();
ba = PlotBrainAtlas(atlas);
axes = ba.set_axes();
ba.hold_on();
ba.view(PlotBrainAtlas.VIEW_3D);
bs = ba.brain();
ba.br_sphs()
ba.br_sphs_on()

distance = ba.calculatePointsDistance([1 10 29]);  % select the first
set(bs, 'Facecolor', 'interp')
set(bs, 'CData', distance)
minimu = min(distance(:));
maxi = max(distance(:));
caxis([minimu maxi])
