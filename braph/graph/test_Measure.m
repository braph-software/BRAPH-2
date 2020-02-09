% test Measure
measure_code_list = subclasses('Measure');

%% Test 1: Either nodal or global
for i = 1:1:length(measure_code_list)
    measure_code = measure_code_list{i};
    assert(eval([measure_code '.is_nodal() ~= ' measure_code '.is_global()']), ...
        'BRAPH:Measure:NodalOrGlobal', ...
        [measure_code '.is_nodal() == ' measure_code '.is_global()'])
end