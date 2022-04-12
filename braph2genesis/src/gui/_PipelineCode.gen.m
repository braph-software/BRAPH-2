%% ¡header!
PipelineCode < Element (pc, pipeline code line) is an executable code line of a pipeline.

%%% ¡description!
PipelineCode represents a line of executable code in a pipeline.

%%% ¡seealso!
PipelineGUI, Pipeline, PipelineSection

%% ¡props!

%%% ¡prop!
ID (data, string) is a numeric code for the pipeline code line.

%%% ¡prop!
LABEL (metadata, string) is an extended label of the pipeline code line.

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the pipeline code line.

%%% ¡prop!
TEXT_BEFORE_EXEC (metadata, string) is the text before the code line execution.

%%% ¡prop!
TEXT_AFTER_EXEC (metadata, string) is the text after the code line execution.

%%% ¡prop!
MONIKER (data, string) is the moniker of the calculated element.
%%%% ¡check_value!
check = ~iskeyword(value) && ~strcmp(value, 'varargin');
if check 
    msg = 'All ok!';
else
    msg = ['The MONIKER (' value ') cannot be a MatLab keyword ' ...
        '(' char(join(cellfun(@(x) ['''' x ''''], iskeyword, 'UniformOutput', false))) ') ' ...
        'or ''varargin''.'];
end

%%% ¡prop!
CODE (data, string) is the code line to calculate the element.

%%% ¡prop!
EL (data, item) is the calculated element.

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Error with keyword moniker
%%%% ¡test!
keywords = iskeyword();
keywords{end + 1} = 'varargin';
for i = 1:1:length(keywords)
    assert_with_error( ...
        'PipelineCode(''MONIKER'', varargin{1})', ...
        [BRAPH2.STR ':PipelineCode:' BRAPH2.WRONG_INPUT], ...
        keywords{i})
end

assert(isa(PipelineCode('MONIKER', 'a'), 'PipelineCode'))