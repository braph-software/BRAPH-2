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
            no_delays = get_from_varargin(10, 'Delays', varargin{:});
            values_1 = get_from_varargin([], 'Val1', varargin{:});
            values_2 = get_from_varargin([], 'Val2', varargin{:});
            res_1 = get_from_varargin([], 'Res1', varargin{:});
            res_2 = get_from_varargin([], 'Res2', varargin{:});
            group_1 = get_from_varargin([], 'Group_1', varargin{:});
            group_2 = get_from_varargin([], 'Group_2', varargin{:});
            
            % get categorical data
            age_group_1 = cell(1, group_1.subjectnumber());
            gender_group_1 = cell(1, group_1.subjectnumber());
            
            age_group_2 = cell(1, group_2.subjectnumber());
            gender_group_2 = cell(1, group_2.subjectnumber());
            
            CTR_reg = [age_group_1 gender_group_1];
                        
            % algorithm
            Y = [values_1; values_2];
            % create the full covariates matrix (merge CTR and PDcomb values + add ones)
            no1 = length(CTR_reg) + length(PD_reg);
            X_temp = [CTR_reg; PD_reg];
            X = [ones(no1,1) X_temp];
            % write the model Y = XB + E and find the LS estimate of B by using  b=(X'X)^{-1}X'y
            B = inv(X'*X) *X' *Y; %#ok<MINV>
            % find the residual values
            Y_res = Y - X*B;
            % create the 2 new groups consisting of residuals values
            value_gr1_res = Y_res(1:1:length(value_gr1));
            value_gr2_res = Y_res(length(value_gr1)+1:1:no1);
            
            % run permutation test on the residuals
            p_t = PermutationTest('CallingClass', analysis.getComparisonClass(), ...
                'Group_1', group_1, 'Group_2', group_2, ...
                'Val1', value_gr1_res, 'Val2', value_gr2_res , ...
                'Res1', res_1, 'Res2', res_2,  ...
                'PermutationNumber', 10000);


             % init data_dict
            data_dict = containers.Map;
            
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
            
            ui_permutation_text = uicontrol('Parent', ui_parent, 'Units', 'normalized', 'Style', 'text');
            ui_permutation_edit = uicontrol('Parent', ui_parent, 'Units', 'normalized', 'Style', 'edit');
            ui_longitudinal_text = uicontrol('Parent', ui_parent, 'Units', 'normalized', 'Style', 'text');
            ui_longitudinal_popup = uicontrol('Parent', ui_parent, 'Units', 'normalized', 'Style', 'popup') ;
            
            init_child_panel()
            
            function init_child_panel()
                
                set(ui_permutation_text, 'String', 'Permutation Number')
                set(ui_permutation_text, 'Position', [.01 .8 .47 .14])
                set(ui_permutation_text, 'Fontweight', 'bold')
                
                set(ui_permutation_edit, 'String', 1000)
                set(ui_permutation_edit, 'Position', [.5 .87 .45 .08])
                set(ui_permutation_edit, 'Callback', {@cb_comparison_permutation})
                
                set(ui_longitudinal_text, 'String', 'Longitudinal')
                set(ui_longitudinal_text, 'Position', [.01 .65 .4 .14])
                set(ui_longitudinal_text, 'Fontweight', 'bold')
                
                set(ui_longitudinal_popup, 'Position', [.5 .65 .4 .15]);
                set(ui_longitudinal_popup, 'String', {'true', 'false'})
                set(ui_longitudinal_popup, 'Callback', {@cb_perm_test_setting_dropdown})
            end
            
            function cb_comparison_permutation(~, ~)
                setappdata(ui_parent, 'permutation', str2double(get(ui_permutation_edit, 'String')))
            end
            handle.variables = [];
            handle.permutation = ui_permutation_edit;
            setappdata(ui_parent, 'permutation', str2double(get(ui_permutation_edit, 'String')))
            
            function cb_perm_test_setting_dropdown(~, ~)
                setappdata(ui_parent, 'Longitudinal', ui_longitudinal_popup.String{ui_longitudinal_popup.Value})
            end
            
        end
        function property = getPlotProperty()
            property = '';
        end
        function properties = getTableProperties()
            properties = {};
        end
    end
end