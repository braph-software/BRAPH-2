% test BrainAtlas
br1 = BrainRegion('BR1', 'brain region 1', 1, 11, 111);
br2 = BrainRegion('BR2', 'brain region 2', 2, 22, 222);
br3 = BrainRegion('BR3', 'brain region 3', 3, 33, 333);
br4 = BrainRegion('BR4', 'brain region 4', 4, 44, 444);
br5 = BrainRegion('BR5', 'brain region 5', 5, 55, 555);

%% Test 1: Instantiation
ba = BrainAtlas('brain atlas', {br1, br2, br3, br4, br5});

%% Test 2: Basic functionalities
ba = BrainAtlas('brain atlas', {br1, br2, br3, br4, br5});

assert(ba.brainregionnumber()==5, ...
    'BRAPH:BrainAtlas:Bug', ...
    'BrainAtlas.brainregionnumber does not work')
assert(ba.contains_brain_region('BR1'), ...
    'BRAPH:BrainAtlas:Bug', ...
    'BrainAtlas.contains_brain_region does not work')
assert(~ba.contains_brain_region('BR6'), ...
    'BRAPH:BrainAtlas:Bug', ...
    'BrainAtlas.contains_brain_region does not work')
assert(isequal(ba.getBrainRegion('BR1').getLabel(), 'BR1'), ...
    'BRAPH:BrainAtlas:Bug', ...
    'BrainAtlas.getBrainRegion does not work')

%% Test 3: Deep copy