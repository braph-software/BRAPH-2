function [graph_type, correlation_rule, negative_weight_rule] = retrieve_settings_from_varargin(analysis_class, varargin)
    graph_type = get_from_varargin('GraphWU', 'GraphType', varargin{:});
    correlation_rule = [analysis_class '.CorrelationRule'];
    negative_weights_rule = [analysis_class '.NegativeWeightRule'];
    correlation_rule = get_from_varargin('default', correlation_rule, varargin{:});
    negative_weight_rule = get_from_varargin('default', negative_weights_rule, varargin{:});
end