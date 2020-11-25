classdef PermutationTest < Statistics
    methods
        function s = PermutationTest(varargin)
            s = s@Statistics(varargin{:});
        end
    end
    methods (Access = protected)
        function init_data_dict(s, varargin)
            
            % varargin
            calling_class = get_from_varargin([], 'CallingClass', varargin{:});
            calling_class_cell_hold = split(calling_class, '_');
            calling_class = calling_class_cell_hold{1};
            M = get_from_varargin(1e+3, 'PermutationNumber', varargin{:});
            verbose = get_from_varargin(false, 'Verbose', varargin{:});
            interruptible = get_from_varargin(0.001, 'Interruptible', varargin{:});
            values_1 = get_from_varargin([], 'Val1', varargin{:});
            values_2 = get_from_varargin([], 'Val2', varargin{:});
            res_1 = get_from_varargin([], 'Res1', varargin{:});
            res_2 = get_from_varargin([], 'Res2', varargin{:});
            group_1 = get_from_varargin([], 'Group_1', varargin{:});
            group_2 = get_from_varargin([], 'Group_2', varargin{:});
            
            % settings
            is_longitudinal = s.getSettings('Longitudinal');

            % Operation
            all_permutations_1 = cell(1, M);
            all_permutations_2 = cell(1, M);
            
            start = tic;
            for i = 1:1:M
                if verbose
                    disp(['** PERMUTATION TEST - sampling #' int2str(i) '/' int2str(M) ' - ' int2str(toc(start)) '.' int2str(mod(toc(start),1)*10) 's'])
                end
                
                [permutation_1, permutation_2] = permutation(values_1, values_2, is_longitudinal);
                
                mean_permutated_1 = mean(reshape(cell2mat(permutation_1), [size(permutation_1{1}, 1), size(permutation_1{1}, 2), group_1.subjectnumber()]), 3);
                mean_permutated_2 = mean(reshape(cell2mat(permutation_2), [size(permutation_2{1}, 1), size(permutation_2{1}, 2), group_2.subjectnumber()]), 3);
                
                all_permutations_1(1, i) = {mean_permutated_1};
                all_permutations_2(1, i) = {mean_permutated_2};
                
                difference_all_permutations{1, i} = mean_permutated_1 - mean_permutated_2; %#ok<AGROW>
                if interruptible
                    pause(interruptible)
                end
            end
            
            difference_mean = {res_2{1} - res_1{1}};  % difference of the mean values of the non permutated groups
            difference_all_permutations = cellfun(@(x) [x], difference_all_permutations, 'UniformOutput', false);  %#ok<NBRAK> % permutated group 1 - permutated group 2
            
            % Statistical analysis
            p1 = {pvalue1(difference_mean{1}, difference_all_permutations)};  % singe tail,
            p2 = {pvalue2(difference_mean{1}, difference_all_permutations)};  % double tail
            
            qtl = quantiles(difference_all_permutations, 40);
            ci_lower = {cellfun(@(x) x(2), qtl)};
            ci_upper = {cellfun(@(x) x(40), qtl)};
            
            % init data_dict
            data_dict = containers.Map;
            data_dict('stat_keys') = { ...
                [calling_class '.PermutationNumber'], ...
                [calling_class '.values_1'], ...
                [calling_class '.average_values_1'], ...
                [calling_class '.values_2'], ...
                [calling_class '.average_values_2'], ...
                [calling_class '.difference'], ...
                [calling_class '.all_differences'], ...
                [calling_class '.p1'], ...
                [calling_class '.p2'], ...
                [calling_class '.confidence_min'], ...
                [calling_class '.confidence_max'] ...
                };
            data_dict([calling_class '.PermutationNumber']) = M;
            data_dict([calling_class '.values_1']) = values_1;
            data_dict([calling_class '.average_values_1']) = res_1;
            data_dict([calling_class '.values_2']) = values_2;
            data_dict([calling_class '.average_values_2']) = res_2;
            data_dict([calling_class '.difference']) = difference_mean;
            data_dict([calling_class '.all_differences']) = difference_all_permutations;
            data_dict([calling_class '.p1']) = p1;
            data_dict([calling_class '.p2']) = p2;
            data_dict([calling_class '.confidence_min']) = ci_lower;
            data_dict([calling_class '.confidence_max']) = ci_upper;
            
            s.stat_dict = data_dict;
            
        end
    end
    methods  % plot
        function h = getStatisticPanel(s, ui_parent) %#ok<INUSL>
            
            h_panel = uicontrol('Parent', ui_parent, 'Units', 'normalized', ...
                'Position', [0 .65 .2 .3 ]);
            
            set(h_panel, 'Style', 'popup')
            set(h_panel, 'String', {true, false})
            set(h_panel, 'Value', index)
            set(h_panel, 'Callback', {@cb_perm_test_setting_dropdown})
            
            function cb_perm_test_setting_dropdown(~, ~)                
                setappdata(ui_parent, 'Longitudinal', h_panel.String{h_panel.Value})
            end
            
            if nargout > 0
                h = h_panel;
            end
        end
    end
    methods (Static)
        function measure_class = getClass()  
            measure_class = 'PermutationTest';
        end
        function name = getName()
            name = 'Permutation Test';
        end
        function des = getDescription()
            des = [ ...
                'A permutation test is a type of statistical significance test ' ...
                'in which distribution of the test statistic under the null' ...
                ' hypothesis is obtained by calculating all possible values ' ...
                'of the test statistic under all possible rearrangements ' ...
                'of the observed data points. ' ...
                ];
        end
        function available_settings = getAvailableSettings()
            available_settings = {
                {'Longitudinal', BRAPH2.LOGICAL, false, {false, true}}, ... 
                {'number_groups', BRAPH2.NUMERIC, 2, {}} ...
                };
        end
        function list = getCompatibleAnalysis()
            all_analysis = Analysis.getList();
            list = reshape(all_analysis, [1, numel(all_analysis)]);
        end
    end
end