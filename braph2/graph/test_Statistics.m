% test Statistics

statistics_list = Statistics.getList();

%% All Statistics not abstract
for i = 1:1:length(statistics_list)
    statistics_class = statistics_list{i};
    s = Statistics.getStatistic(statistics_class);
    assert(~isempty(s), ...
                [BRAPH2.STR ':' statistics_class ':' BRAPH2.WRONG_OUTPUT], ...
                [statistics_class ' not initializating'])
end

%% Implementation static methods

for i = 1:1:length(statistics_list)
    statistics_class = statistics_list{i};
    s = Statistics.getStatistic(statistics_class);
    
    assert(ischar(s.getClass()), ...
                [BRAPH2.STR ':' statistics_class ':' BRAPH2.WRONG_OUTPUT], ...
                [statistics_class ' .getClass() should return a sting.'])
            
    assert(ischar(s.getName()), ...
                [BRAPH2.STR ':' statistics_class ':' BRAPH2.WRONG_OUTPUT], ...
                [statistics_class ' .getName() should return a sting.'])
            
    assert(ischar(s.getDescription()), ...
                [BRAPH2.STR ':' statistics_class ':' BRAPH2.WRONG_OUTPUT], ...
                [statistics_class ' .getDescription() should return a sting.'])
            
    assert(iscell(s.getAvailableSettings()), ...
                [BRAPH2.STR ':' statistics_class ':' BRAPH2.WRONG_OUTPUT], ...
                [statistics_class ' .getAvailableSettingss() should return a cell.'])
            
    assert(iscell(s.getCompatibleAnalysis()), ...
                [BRAPH2.STR ':' statistics_class ':' BRAPH2.WRONG_OUTPUT], ...
                [statistics_class ' .getCompatibleAnalysis() should return a cell.'])
            
end