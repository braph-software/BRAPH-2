classdef Regression < Statistics
    methods
        function s = Regression(varargin)
            s = s@Statistics(varargin{:});
        end
    end
    methods (Access = protected)
        function init_data_dict(s, varargin)
            % varargin
            calling_class = get_from_varargin([], 'CallingClass', varargin{:});
            calling_class_cell_hold = split(calling_class, '_');
            calling_class = calling_class_cell_hold{1};           
           
            % this has to be an array with the dict cat data ids choosen
            covariates_data = get_from_varargin('', 'RegressionCovariates', varargin{:});
            
            values_1 = get_from_varargin([], 'Val1', varargin{:});
            values_2 = get_from_varargin([], 'Val2', varargin{:});
            res_1 = get_from_varargin([], 'Res1', varargin{:});
            res_2 = get_from_varargin([], 'Res2', varargin{:});
            group_1 = get_from_varargin([], 'Group_1', varargin{:});
            group_2 = get_from_varargin([], 'Group_2', varargin{:});
            
            % get categorical data
            for i = 1:1:length(covariates_data)
                c = covariates_data{i};
                
                % get cov data for subjs in group 1
                subs1 = group_1.getSubjects();
                for j = 1:1:length(subs1)
                    s = subs1{j};
                    cov1{i, j} = s.getData(c).getValue();  %#ok<AGROW>
                end
                
                % get cov data for subjs in group 1
                subs2 = group_2.getSubjects();
                for j = 1:1:length(subs2)
                    s = subs2{j};
                    cov2{i, j} = s.getData(c).getValue();  %#ok<AGROW>
                end
            end
            
            cov1_f = '';
            cov2_f = '';
            % arrange info
            for i = 1:1:length(covariates_data)
                cov1_f = [cov1_f cov1{i, :}]; %#ok<AGROW>
                cov2_f = [cov2_f cov2{i, :}]; %#ok<AGROW>
            end
      
            % algorithm
            Y = [values_1; values_2];
            % create the full covariates matrix (merge CTR and PDcomb values + add ones)
            no1 = length(cov1_f) + length(cov2_f);
            X_temp = [cov1_f; cov2_f];
            X = [ones(no1,1) X_temp];
            % write the model Y = XB + E and find the LS estimate of B by using  b=(X'X)^{-1}X'y
            B = inv(X'*X) *X' *Y; %#ok<MINV>
            % find the residual values
            Y_res = Y - X*B;
            % create the 2 new groups consisting of residuals values
            value_gr1_res = Y_res(1:1:length(value_gr1));
            value_gr2_res = Y_res(length(value_gr1)+1:1:no1);
            
            % run permutation test on the residuals
            
            statistic = Statistics.getStatistic('PermutationTest', varargin{:});
            pt_dict = statistic.getStatistics('CallingClass', analysis.getComparisonClass(), ...                
                varargin{:});

             % init data_dict
             
            data_dict = containers.Map;
            data_dict('stat_keys') = { ...
                [calling_class '.values_1'], ...
                [calling_class '.average_values_1'], ...
                [calling_class '.values_2'], ...
                [calling_class '.average_values_2'], ...
                [calling_class '.difference'], ...
                [calling_class '.p1'], ...
                [calling_class '.p2'], ...
                [calling_class '.confidence_min'], ...
                [calling_class '.confidence_max'] ...
                };
            
            % what should i return?
            
        end
    end
    methods (Static)
        function measure_class = getClass()
            measure_class = 'Regression';
        end
        function name = getName()
            name = 'Regression Test';
        end
        function des = getDescription()
            des = [ ...
                'It is statistical processes for estimating the ', ...
                'relationships between a dependent variable ', ...
                'and one or more independent variables.'
                ];
        end
        function available_settings = getAvailableSettings()
            available_settings = {};
        end
        function list = getCompatibleAnalysis()
            list = {'AnalysisCON_BUD', 'AnalysisFNC_BUD'};
        end
    end
    methods (Static) % plot
        function handle = getStatisticPanel(ui_parent, varargin)
                                   
            covariates = get_from_varargin('', 'Covariates', varargin{:});
            choosen_covariates = {};
            end_height = 0;
            
            init_child_panel()            
            function init_child_panel()
                fields = zeros(length(covariates), 1);
                hold = .01;
                for i = 1:1:length(covariates) 
                    height = .9 - hold;                    
                    fields(i, 1) = uicontrol('Parent', ui_parent, 'Style', 'checkbox', ...
                        'Units', 'normalized', 'FontSize', 8, 'Position', [.3 height .4 .08], ...
                        'String', covariates{i}, 'Callback', {@checkbox_cov});
                    hold = hold + .1;
                    end_height = height;
                end                
            end
            
            function checkbox_cov(~, ~)
                childs = allchild(ui_parent);
                choosen_covariates = [];
                for i = 1:1:length(childs)
                    if ismember(childs(i).String, covariates) & isequal(childs(i).Value , 1)
                        choosen_covariates{end+1} = childs(i).String; %#ok<AGROW>
                    end
                end
                setappdata(ui_parent, 'regression', choosen_covariates)
            end
            handle.variables = [];
            handle.regression = choosen_covariates;
            handle.nextheight = end_height;
        end
        function property = getPlotProperty()
            property = '';
        end
        function properties = getTableProperties()
            properties = {};
        end
    end
end