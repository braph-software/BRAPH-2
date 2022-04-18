%TEST_FORMAT

test_probability = 0.05;

format_list = Format.getFormats();

error_identifier = [BRAPH2.STR ':Format:' BRAPH2.WRONG_INPUT];

%% Test 1: Static methods
assert(numel(format_list) == Format.getFormatNumber(), ...
    [BRAPH2.STR ':Format:' BRAPH2.WRONG_OUTPUT], ...
    'Format.getFormatNumber() does not return correct number of formats.')

for i = 1:1:numel(format_list)
    if rand() >= (1 - test_probability) * BRAPH2.TEST_RANDOM
        format = format_list{i};

        assert(Format.existsFormat(format), ...
            [BRAPH2.STR ':Format:' BRAPH2.WRONG_OUTPUT], ...
            ['Format.existsFormat(' tostring(format) ') must return true.'])

        assert(strcmp(eval(['Format.' upper(Format.getFormatName(format)) '_NAME']), Format.getFormatName(format)), ...
            [BRAPH2.STR ':Format:' BRAPH2.WRONG_OUTPUT], ...
            ['Format.getFormatName(' tostring(format) ') does not return correct output.'])

        assert(strcmp(eval(['Format.' upper(Format.getFormatName(format)) '_DESCRIPTION']), Format.getFormatDescription(format)), ...
            [BRAPH2.STR ':Format:' BRAPH2.WRONG_OUTPUT], ...
            ['Format.getFormatDescription(' tostring(format) ') does not return correct output.'])

        assert(ischar(Format.getFormatDescription(format, Format.getFormatSettings(format))), ...
            [BRAPH2.STR ':Format:' BRAPH2.WRONG_OUTPUT], ...
            ['Format.getDescription(' tostring(format) ', settings) should return a char array.'])

        assert(Format.checkFormat(format, Format.getFormatDefault(format)), ...
            [BRAPH2.STR ':Format:' BRAPH2.WRONG_OUTPUT], ...
            [BRAPH2.STR ':Format:' BRAPH2.WRONG_OUTPUT '' ...
            'Format.checkFormat(' tostring(format) ') does not work.'])
    end
end

%% Test 2.EM: Check EMPTY
% EMPTY formats that should be accepted
clear value
value{1} = [];
value{2} = '';

% EMPTY formats that should NOT be accepted
clear wrong_value
wrong_value{1} = 'String';
wrong_value{2} = true;
wrong_value{3} = 3.14;

% tests
for i = 1:1:length(value)
    if rand() >= (1 - test_probability) * BRAPH2.TEST_RANDOM
        Format.checkFormat(Format.EMPTY, value{i})
    end
end
for i = 1:1:length(wrong_value)
    if rand() >= (1 - test_probability) * BRAPH2.TEST_RANDOM
        assert_with_error('Format.checkFormat(Format.EMPTY, varargin{1})', error_identifier, wrong_value{i})
    end
end

%% Test 2.ST: Check STRING
% STRING formats that should be accepted
clear value
value{1} = 'String';

% STRING formats that should NOT be accepted
clear wrong_value
wrong_value{1} = true;
wrong_value{2} = 3.14;

% tests
for i = 1:1:length(value)
    if rand() >= (1 - test_probability) * BRAPH2.TEST_RANDOM
        Format.checkFormat(Format.STRING, value{i})
    end
end
for i = 1:1:length(wrong_value)
    if rand() >= (1 - test_probability) * BRAPH2.TEST_RANDOM
        assert_with_error('Format.checkFormat(Format.STRING, varargin{1})', error_identifier, wrong_value{i})
    end
end

%% Test 2.LO: Check LOGICAL
% LOGICAL formats that should be accepted
clear value
value{1} = true;

% LOGICAL formats that should NOT be accepted
clear wrong_value
wrong_value{1} = 'String';
wrong_value{2} = 3.14;

% tests
for i = 1:1:length(value)
    if rand() >= (1 - test_probability) * BRAPH2.TEST_RANDOM
        Format.checkFormat(Format.LOGICAL, value{i})
    end
end
for i = 1:1:length(wrong_value)
    if rand() >= (1 - test_probability) * BRAPH2.TEST_RANDOM
        assert_with_error('Format.checkFormat(Format.LOGICAL, varargin{1})', error_identifier, wrong_value{i})
    end
end
 
%% Test 2.OP: Check OPTION
% OPTION formats that should be accepted
clear value
value{1} = '';

% OPTION formats that should NOT be accepted
clear wrong_value
wrong_value{1} = 'String';
wrong_value{2} = true;
wrong_value{3} = 3.14;

% tests
for i = 1:1:length(value)
    if rand() >= (1 - test_probability) * BRAPH2.TEST_RANDOM
        Format.checkFormat(Format.OPTION, value{i})
    end
end
for i = 1:1:length(wrong_value)
    if rand() >= (1 - test_probability) * BRAPH2.TEST_RANDOM
        assert_with_error('Format.checkFormat(Format.OPTION, varargin{1})', error_identifier, wrong_value{i})
    end
end

%% Test 2.OP.s: Check OPTION with settings
% OPTION formats that should be accepted
clear value
value{1} = 'true'; settings{1} = {'true', 'false'};
value{2} = 'male'; settings{2} = {'female', 'male'};
value{3} = 'phd'; settings{3} = {'elementary', 'high school', 'college', 'MSc', 'PhD'};

% OPTION formats that should NOT be accepted
clear wrong_value
wrong_value{1} = 'true'; wrong_settings{1} = {'0', '1'};
wrong_value{2} = 'male'; wrong_settings{2} = {'woman', 'man'};
wrong_value{3} = 'phd'; wrong_settings{3} = {'elementary', 'high school', 'college', 'M.Sc.', 'Ph.D.'};

% tests
for i = 1:1:length(value)
    if rand() >= (1 - test_probability) * BRAPH2.TEST_RANDOM
        Format.checkFormat(Format.OPTION, value{i}, settings{i})
    end
end
for i = 1:1:length(wrong_value)
    if rand() >= (1 - test_probability) * BRAPH2.TEST_RANDOM
        assert_with_error('Format.checkFormat(Format.OPTION, varargin{1}, varargin{2})', error_identifier, wrong_value{i}, wrong_settings{i})
    end
end

%% Test 2.CA: Check CLASS
% CLASS formats that should be accepted
clear value
value{1} = 'Element';
element_class_list = subclasses('Element', [], [], true);
for i = 1:1:numel(element_class_list)
    element_class = element_class_list{i};
    value{i + 1} = element_class; %#ok<SAGROW>
end

% CLASS formats that should NOT be accepted
clear wrong_value
wrong_value{1} = 'non existing class';
wrong_value{2} = 3.14;
wrong_value{3} = true;
wrong_value{4} = '1String';

% tests
for i = 1:1:length(value)
    if rand() >= (1 - test_probability) * BRAPH2.TEST_RANDOM
        Format.checkFormat(Format.CLASS, value{i})
    end
end
for i = 1:1:length(wrong_value)
    if rand() >= (1 - test_probability) * BRAPH2.TEST_RANDOM
        assert_with_error('Format.checkFormat(Format.CLASS, varargin{1})', error_identifier, wrong_value{i})
    end
end

%% Test 2.CA.s: Check CLASS with settings
clear value
clear element_class_list
value{1} = 'Element'; settings{1} = Element.getClass();
element_class_list = subclasses('Element', [], [], true);
for i = 1:1:numel(element_class_list)
    element_class = element_class_list{i};
    value{2 * i} = element_class; %#ok<SAGROW>
    settings{2 * i} = eval([element_class '.getClass()']);
    value{2 * i + 1} = element_class; %#ok<SAGROW>
    settings{2 * i + 1} = 'Element';
end

% CLASS formats that should NOT be accepted
clear wrong_value
wrong_value{1} = 'non existing class'; wrong_settings{1} = 'CharClass';
wrong_value{2} = 3.14; wrong_settings{2} = 'DoubleClass';
wrong_value{3} = true; wrong_settings{3} = 'BooleanClass';
wrong_value{4} = 'String'; wrong_settings{4} = 'StringClass';

% tests
for i = 1:1:length(value)
    if rand() >= (1 - test_probability) * BRAPH2.TEST_RANDOM
        Format.checkFormat(Format.CLASS, value{i}, settings{i})
    end
end
for i = 1:1:length(wrong_value)
    if rand() >= (1 - test_probability) * BRAPH2.TEST_RANDOM
        assert_with_error('Format.checkFormat(Format.CLASS, varargin{1}, varargin{2})', error_identifier, wrong_value{i}, wrong_settings{i})
    end
end

%% Test 2.CL: Check CLASSLIST
% CLASSLIST formats that should be accepted
clear value
value{1} = {'Element'};
element_class_list = subclasses('Element', [], [], true);
value{2} = element_class_list;
for i = 1:1:numel(element_class_list)
    element_class = element_class_list{i};
    value{i + 2} = {element_class};
end

% CLASSLIST formats that should NOT be accepted
clear wrong_value
wrong_value{1} = 'Element';
wrong_value{2} = {'non existing class'};
wrong_value{3} = 3.14;
wrong_value{4} = true;
wrong_value{5} = 'String';

% tests
for i = 1:1:length(value)
    if rand() >= (1 - test_probability) * BRAPH2.TEST_RANDOM
        Format.checkFormat(Format.CLASSLIST, value{i})
    end
end
for i = 1:1:length(wrong_value)
    if rand() >= (1 - test_probability) * BRAPH2.TEST_RANDOM
        assert_with_error('Format.checkFormat(Format.CLASSLIST, varargin{1})', error_identifier, wrong_value{i})
    end
end

%% Test 2.CL.s: Check CLASSLIST with settings
% CLASSLIST formats that should be accepted
clear value
value{1} = {'Element'}; settings{1} = Element.getClass();
element_class_list = subclasses('Element', [], [], true);
value{2} = element_class_list;
for i = 1:1:numel(element_class_list)
    element_class = element_class_list{i};
    value{2 * i + 1} = {element_class};
    settings{2 * i + 1} = eval([element_class '.getClass()']);
    value{2 * i + 2} = {element_class};
    settings{2 * i + 2} = 'Element';
end

% CLASSLIST formats that should NOT be accepted
clear wrong_value
wrong_value{1} = 'Element'; wrong_settings{1} = 'IndexedDictionary';
wrong_value{2} = {'non existing class'}; wrong_settings{2} = 'Very existing class';
wrong_value{3} = 3.14; wrong_settings{3} = 'Numeric';
wrong_value{4} = true; wrong_settings{4} = 'Boolean';
wrong_value{5} = 'String'; wrong_settings{5} = 'StringClass';

% tests
for i = 1:1:length(value)
    if rand() >= (1 - test_probability) * BRAPH2.TEST_RANDOM
        Format.checkFormat(Format.CLASSLIST, value{i}, settings{i})
    end
end
for i = 1:1:length(wrong_value)
    if rand() >= (1 - test_probability) * BRAPH2.TEST_RANDOM
        assert_with_error('Format.checkFormat(Format.CLASSLIST, varargin{1}, varargin{2})', error_identifier, wrong_value{i}, wrong_settings{i})
    end
end

%% Test 2.IT: Check ITEM
% ITEM formats that should be accepted
clear value
element_class_list = subclasses('Element', [], [], true);
for i = 1:1:numel(element_class_list)
    element_class = element_class_list{i};
    value{i} = eval([element_class '()']); %#ok<SAGROW>
end

% ITEM formats that should NOT be accepted
clear wrong_value
wrong_value{1} = 3.14;
wrong_value{2} = true;
wrong_value{3} = 'String';
element_class_list = subclasses('Element', [], [], true);
for i = 1:1:numel(element_class_list)
    element_class = element_class_list{i};
    wrong_value{i + 3} = element_class;
end

% tests
for i = 1:1:length(value)
    if rand() >= (1 - test_probability) * BRAPH2.TEST_RANDOM
        Format.checkFormat(Format.ITEM, value{i})
    end
end
for i = 1:1:length(wrong_value)
    if rand() >= (1 - test_probability) * BRAPH2.TEST_RANDOM
        assert_with_error('Format.checkFormat(Format.ITEM, varargin{1})', error_identifier, wrong_value{i})
    end
end

%% Test 2.IT.s: Check ITEM with settings
% ITEM formats that should be accepted
clear value
clear settings
element_class_list = subclasses('Element', [], [], true);
for i = 1:1:numel(element_class_list)
    element_class = element_class_list{i};
    value{i} = eval([element_class '()']); %#ok<SAGROW>
    settings{i} = eval([element_class '.getClass()']); %#ok<SAGROW>
end

% ITEM formats that should NOT be accepted
clear wrong_value
clear wrong_settings
wrong_value{1} = 3.14;
wrong_value{2} = true;
wrong_value{3} = 'String';
element_class_list = subclasses('Element', [], [], true);
for i = 1:1:numel(element_class_list)
    element_class = element_class_list{i};
    wrong_value{2 * i + 2} = element_class;
    wrong_settings{2 * i + 2} = eval([element_class '.getClass()']); %#ok<SAGROW>
    wrong_value{2 * i + 3} = element_class;
    wrong_settings{2 * i + 3} = 'Element'; %#ok<SAGROW>    
end

% tests
for i = 1:1:length(value)
    if rand() >= (1 - test_probability) * BRAPH2.TEST_RANDOM
        Format.checkFormat(Format.ITEM, value{i}, settings{i})
    end
end
for i = 1:1:length(wrong_value)
    if rand() >= (1 - test_probability) * BRAPH2.TEST_RANDOM
        assert_with_error('Format.checkFormat(Format.ITEM, varargin{1}, varargin{2})', error_identifier, wrong_value{i}, wrong_settings{i})
    end
end

%% Test 2.IL: Check ITEMLIST
% ITEMLIST formats that should be accepted
clear value
element_class_list = subclasses('Element', [], [], true);
value{1} = cellfun(@(x) eval([x '()']), element_class_list, 'UniformOutput', false);
for i = 1:1:length(element_class_list)
    value{i + 1} = {eval([element_class_list{i} '()'])}; %#ok<SAGROW>
end

% ITEMLIST formats that should NOT be accepted
clear wrong_value
wrong_value{1} = 3.14;
wrong_value{2} = true;
wrong_value{3} = 'String';
wrong_value{4} = {'1', '2', '3'};

% tests
for i = 1:1:length(value)
    if rand() >= (1 - test_probability) * BRAPH2.TEST_RANDOM
        Format.checkFormat(Format.ITEMLIST, value{i})
    end
end
for i = 1:1:length(wrong_value)
    if rand() >= (1 - test_probability) * BRAPH2.TEST_RANDOM
        assert_with_error('Format.checkFormat(Format.ITEMLIST, varargin{1})', error_identifier, wrong_value{i})
    end
end

%% Test 2.IL.s: Check ITEMLIST with settings
% ITEMLIST formats that should be accepted
clear value
clear settings
element_class_list = subclasses('Element', [], [], true);
value{1} = cellfun(@(x) eval([x '()']), element_class_list, 'UniformOutput', false);
settings{1} = 'Element';
for i = 1:1:length(element_class_list)
    value{2 * i} = {eval([element_class_list{i} '()'])}; %#ok<SAGROW>
    settings{2 * i} = element_class_list{i}; %#ok<SAGROW>
    value{2 * i + 1} = {eval([element_class_list{i} '()'])}; %#ok<SAGROW>
    settings{2 * i + 1} = 'Element'; %#ok<SAGROW>
end

% ITEMLIST formats that should NOT be accepted
clear wrong_value
clear wrong_settings
wrong_value{1} = 3.14; wrong_settings{1} = 'String';
wrong_value{2} = true; wrong_settings{2} = 'Boolean';
wrong_value{3} = 'String'; wrong_settings{3} = 'Char';
wrong_value{4} = {'1', '2', '3'}; wrong_settings{4} = 'String';

% tests
for i = 1:1:length(value)
    if rand() >= (1 - test_probability) * BRAPH2.TEST_RANDOM
        Format.checkFormat(Format.ITEMLIST, value{i}, settings{i})
    end
end
for i = 1:1:length(wrong_value)
    if rand() >= (1 - test_probability) * BRAPH2.TEST_RANDOM
        assert_with_error('Format.checkFormat(Format.ITEM, varargin{1}, varargin{2})', error_identifier, wrong_value{i}, wrong_settings{i})
    end
end

%% Test 2.DI: Check IDICT
% IDICT formats that should be accepted
clear value
element_class_list = subclasses('Element', [], [], true);
for i = 1:1:numel(element_class_list)
    element_class = element_class_list{i};
    if Element.existsTag(element_class, 'ID')
        value{i} = IndexedDictionary( ...
            'IT_CLASS', element_class, ...
            'IT_KEY', Element.getPropProp(element_class, 'ID'), ...
            'IT_LIST', {eval([element_class '()']), eval([element_class '()']), eval([element_class '()'])} ...
            ); %#ok<SAGROW>
    end
end
value = value(~cellfun('isempty', value));

% IDICT formats that should NOT be accepted
clear wrong_value
wrong_value{1} = '';
wrong_value{2} = 3.14;
wrong_value{3} = true;
wrong_value{4} = 'String';

% tests
for i = 1:1:length(value)
    if rand() >= (1 - test_probability) * BRAPH2.TEST_RANDOM
        Format.checkFormat(Format.IDICT, value{i})
    end
end
for i = 1:1:length(wrong_value)
    if rand() >= (1 - test_probability) * BRAPH2.TEST_RANDOM
        assert_with_error('Format.checkFormat(Format.IDICT, varargin{1})', error_identifier, wrong_value{i})
    end
end

%% Test 2.DI.s: Check IDICT
% IDICT formats that should be accepted
clear value
element_class_list = subclasses('Element', [], [], true);
for i = 1:1:numel(element_class_list)
    element_class = element_class_list{i};
    if Element.existsTag(element_class, 'ID')
        value{i} = IndexedDictionary( ...
            'IT_CLASS', element_class, ...
            'IT_KEY', Element.getPropProp(element_class, 'ID'), ...
            'IT_LIST', {eval([element_class '()']), eval([element_class '()']), eval([element_class '()'])} ...
            ); %#ok<SAGROW>
        settings{i} = element_class; %#ok<SAGROW>
    end
end
settings = settings(~cellfun('isempty', value));
value = value(~cellfun('isempty', value));

% IDICT formats that should NOT be accepted
clear wrong_value
wrong_value{1} = ''; wrong_settings{1} = 'String';
wrong_value{2} = 3.14; wrong_settings{2} = 'String';
wrong_value{3} = true; wrong_settings{3} = 'String';
wrong_value{4} = 'String'; wrong_settings{4} = 'String';

% tests
for i = 1:1:length(value)
    if rand() >= (1 - test_probability) * BRAPH2.TEST_RANDOM
        Format.checkFormat(Format.IDICT, value{i}, settings{i})
    end
end
for i = 1:1:length(wrong_value)
    if rand() >= (1 - test_probability) * BRAPH2.TEST_RANDOM
        assert_with_error('Format.checkFormat(Format.IDICT, varargin{1}, varargin{2})', error_identifier, wrong_value{i}, wrong_settings{i})
    end
end

%% Test 2.NN: Check SCALAR
% SCALAR formats that should be accepted
clear value
value{1} = 3.14;

% SCALAR formats that should NOT be accepted
clear wrong_value
wrong_value{1} = [1 2 3];
wrong_value{2} = 'String';

% tests
for i = 1:1:length(value)
    if rand() >= (1 - test_probability) * BRAPH2.TEST_RANDOM
        Format.checkFormat(Format.SCALAR, value{i})
    end
end
for i = 1:1:length(wrong_value)
    if rand() >= (1 - test_probability) * BRAPH2.TEST_RANDOM
        assert_with_error('Format.checkFormat(Format.SCALAR, varargin{1})', error_identifier, wrong_value{i})
    end
end

%% Test 2.NR: Check RVECTOR
% RVECTOR formats that should be accepted
clear value
value{1} = [1 2 3];
value{2} = 3.14;

% RVECTOR formats that should NOT be accepted
clear wrong_value
wrong_value{1} = [1 2 3]';
wrong_value{2} = 'String';

% tests
for i = 1:1:length(value)
    if rand() >= (1 - test_probability) * BRAPH2.TEST_RANDOM
        Format.checkFormat(Format.RVECTOR, value{i})
    end
end
for i = 1:1:length(wrong_value)
    if rand() >= (1 - test_probability) * BRAPH2.TEST_RANDOM
        assert_with_error('Format.checkFormat(Format.RVECTOR, varargin{1})', error_identifier, wrong_value{i})
    end
end

%% Test 2.NC: Check CVECTOR
% CVECTOR formats that should be accepted
clear value
value{1} = [1 2 3]';
value{2} = 3.14;

% CVECTOR formats that should NOT be accepted
clear wrong_value
wrong_value{1} = [1 2 3];
wrong_value{2} = 'String';

% tests
for i = 1:1:length(value)
    if rand() >= (1 - test_probability) * BRAPH2.TEST_RANDOM
        Format.checkFormat(Format.CVECTOR, value{i})
    end
end
for i = 1:1:length(wrong_value)
    if rand() >= (1 - test_probability) * BRAPH2.TEST_RANDOM
        assert_with_error('Format.checkFormat(Format.CVECTOR, varargin{1})', error_identifier, wrong_value{i})
    end
end

%% Test 2.NM: Check MATRIX
% MATRIX formats that should be accepted
clear value
value{1} = rand(2, 3);
value{2} = 3.14;
value{3} = [1 2 3]';
value{4} = [1 2 3];

% MATRIX formats that should NOT be accepted
clear wrong_value
wrong_value{1} = 'String';

% tests
for i = 1:1:length(value)
    if rand() >= (1 - test_probability) * BRAPH2.TEST_RANDOM
        Format.checkFormat(Format.MATRIX, value{i})
    end
end
for i = 1:1:length(wrong_value)
    if rand() >= (1 - test_probability) * BRAPH2.TEST_RANDOM
        assert_with_error('Format.checkFormat(Format.MATRIX, varargin{1})', error_identifier, wrong_value{i})
    end
end

%% Test 2.NS: Check SMATRIX
% SMATRIX formats that should be accepted
clear value
value{1} = rand(10);
value{2} = 3.14;

% SMATRIX formats that should NOT be accepted
clear wrong_value
wrong_value{1} = rand(2, 3);
wrong_value{1} = [1 2 3]';
wrong_value{1} = [1 2 3];
wrong_value{1} = 'String';

% tests
for i = 1:1:length(value)
    if rand() >= (1 - test_probability) * BRAPH2.TEST_RANDOM
        Format.checkFormat(Format.SMATRIX, value{i})
    end
end
for i = 1:1:length(wrong_value)
    if rand() >= (1 - test_probability) * BRAPH2.TEST_RANDOM
        assert_with_error('Format.checkFormat(Format.SMATRIX, varargin{1})', error_identifier, wrong_value{i})
    end
end

%% Test 2.LL: Check CELL
% CELL formats that should be accepted
clear value
value{1} = {rand(5)};
value{2} = {
    rand(5) [] []
    [] rand(2) []
    [] [] rand(1)
    };
value{3} = {
    rand(4) diag(rand(4, 1)) []
    diag(rand(4, 1)) rand(4) diag(rand(4, 1))
    [] diag(rand(4, 1)) rand(4)
    };
value{4} = {
    rand(4) diag(rand(4, 1)) diag(rand(4, 1))
    diag(rand(4, 1)) rand(4) diag(rand(4, 1))
    diag(rand(4, 1)) diag(rand(4, 1)) rand(4)
    };
value{5} = {
    rand(3) rand(3, 2) []
    rand(2, 3) rand(2) rand(2, 4)
    [] rand(4, 2) rand(4)
    };
value{6} = {
    rand(3) rand(3, 2) rand(3, 4)
    rand(2, 3) rand(2) rand(2, 4)
    rand(4, 3) rand(4, 2) rand(4)
    };
value{7} = {
    rand(5)
    rand(2)
    rand(1)
    };
value{8} = {rand(5) rand(2) rand(1)};
value{9} = {rand(3, 2, 4) 1 2};

% CELL formats that should NOT be accepted
clear wrong_value
wrong_value{1} = 'String';
wrong_value{2} = true;
wrong_value{3} = rand(5, 3);
wrong_value{4} = rand(4, 3);
wrong_value{5} = rand(3, 4);

% tests
for i = 1:1:length(value)
    if rand() >= (1 - test_probability) * BRAPH2.TEST_RANDOM
        Format.checkFormat(Format.CELL, value{i})
    end
end
for i = 1:1:length(wrong_value)
    if rand() >= (1 - test_probability) * BRAPH2.TEST_RANDOM
        assert_with_error('Format.checkFormat(Format.CELL, varargin{1})', error_identifier, wrong_value{i})
    end
end

%% Test 2.ML: Check NET
% NET formats that should be accepted
clear value

if BRAPH2.installed('NN', 'warning') && BRAPH2.installed('ONNXCONVERTER', 'warning')
    % switch off the nnet warning
    w = warning('query','MATLAB:mir_warning_unrecognized_pragma');
    warning('off', 'MATLAB:mir_warning_unrecognized_pragma');

    % create network object
    value{1} = network();

    % create SeriesNetwork object
    size_x = 28;
    size_y = 28;
    num_channel = 1;
    num_neuron = 100;
    num_class = 10;
    layers = [
        imageInputLayer([size_x size_y num_channel], 'Name', 'input', 'Mean', rand(size_x, size_y, num_channel))
        fullyConnectedLayer(num_neuron, 'Name', 'fc1', 'Weights', rand(num_neuron, size_x * size_y), 'Bias', rand(num_neuron, 1))
        fullyConnectedLayer(num_class, 'Name', 'fc2', 'Weights', rand(num_class, num_neuron), 'Bias', rand(num_class, 1))
        softmaxLayer('Name', 'softmax')
        classificationLayer('Classes', categorical(1:num_class), 'Name', 'classOutput')
        ];
    value{2} = SeriesNetwork(layers);

    % create DAGNetwrok object
    lgraph = layerGraph(layers);
    value{3} = assembleNetwork(lgraph);

    % create dlnetwork object
    lgraph = removeLayers(lgraph, 'classOutput');
    value{4} = dlnetwork(lgraph); % dlnetework object

    % resume nnet warning status and clear variables
    warning(w.state, 'MATLAB:mir_warning_unrecognized_pragma')
    vars = {'w', 'size_x', 'size_y', 'num_channel', 'num_neuron', 'num_class', 'layers', 'vars'};
    clear(vars{:})

    % NET formats that should NOT be accepted
    clear wrong_value
    wrong_value{1} = 'String';
    wrong_value{2} = 3.14;
    wrong_value{3} = Element();
    wrong_value{4} = {};

    % tests
    for i = 1:1:length(value)
        if rand() >= (1 - test_probability) * BRAPH2.TEST_RANDOM
            Format.checkFormat(Format.NET, value{i})
        end
    end
    for i = 1:1:length(wrong_value)
        if rand() >= (1 - test_probability) * BRAPH2.TEST_RANDOM
            assert_with_error('Format.checkFormat(Format.NET, varargin{1})', error_identifier, wrong_value{i})
        end
    end
end
%% Test 2.CO: Check COLOR
% COLOR formats that should be accepted
clear value
value{1} = [0 0 0];
value{2} = [1 1 1];
value{3} = [1 0 0];
value{4} = [0 1 0];
value{5} = [0 1 1];

% COLOR formats that should NOT be accepted
clear wrong_value
wrong_value{1} = 1;
wrong_value{2} = 'b';
wrong_value{3} = 'Color';
wrong_value{4} = [2 2 2];
wrong_value{5} = [-1 0 0];
wrong_value{6} = {};
wrong_value{7} = Element();

% tests
for i = 1:1:length(value)
    if rand() >= (1 - test_probability) * BRAPH2.TEST_RANDOM
        Format.checkFormat(Format.COLOR, value{i})
    end
end
for i = 1:1:length(wrong_value)
    if rand() >= (1 - test_probability) * BRAPH2.TEST_RANDOM
        assert_with_error('Format.checkFormat(Format.COLOR, varargin{1})', error_identifier, wrong_value{i})
    end
end

%% Test 2.AL: Check ALPHA
% ALPHA formats that should be accepted
clear value
value{1} = 0;
value{2} = .5;
value{3} = 1;

% ALPHA formats that should NOT be accepted
clear wrong_value
wrong_value{1} = -1;
wrong_value{2} = 2;
wrong_value{3} = 'transparent';
wrong_value{4} = [2 2 2];
wrong_value{5} = [-1 0 0];
wrong_value{6} = {};
wrong_value{7} = Element();

% tests
for i = 1:1:length(value)
    if rand() >= (1 - test_probability) * BRAPH2.TEST_RANDOM
        Format.checkFormat(Format.ALPHA, value{i})
    end
end
for i = 1:1:length(wrong_value)
    if rand() >= (1 - test_probability) * BRAPH2.TEST_RANDOM
        assert_with_error('Format.checkFormat(Format.ALPHA, varargin{1})', error_identifier, wrong_value{i})
    end
end

%% Test 2.MS: Check MARKERSTYLE
% MARKERSTYLE formats that should be accepted
clear value
value{1} = 'o';
value{2} = '+';
value{3} = '*';
value{4} = '.';
value{5} = 'x';
value{6} = '_';
value{7} = '|';
value{8} = 's';
value{9} = 'd';
value{10} = '^';
value{11} = 'v';
value{12} = '>';
value{13} = '<';
value{14} = 'p';
value{15} = 'h';
value{16} = '';

% MARKERSTYLE formats that should NOT be accepted
clear wrong_value
wrong_value{1} = '-';
wrong_value{2} = ':';
wrong_value{3} = '-.';
wrong_value{4} = '--';
wrong_value{5} = 1;
wrong_value{6} = {};
wrong_value{7} = Element();

% tests
for i = 1:1:length(value)
    if rand() >= (1 - test_probability) * BRAPH2.TEST_RANDOM
        Format.checkFormat(Format.MARKERSTYLE, value{i})
    end
end
for i = 1:1:length(wrong_value)
    if rand() >= (1 - test_probability) * BRAPH2.TEST_RANDOM
        assert_with_error('Format.checkFormat(Format.MARKERSTYLE, varargin{1})', error_identifier, wrong_value{i})
    end
end

%% Test 2.MS: Check MARKERSIZE
% MARKERSIZE formats that should be accepted
clear value
value{1} = .5;
value{2} = 1;
value{3} = 10;

% MARKERSIZE formats that should NOT be accepted
clear wrong_value
wrong_value{1} = 0;
wrong_value{2} = -1;
wrong_value{3} = 'large';
wrong_value{4} = Element();

% tests
for i = 1:1:length(value)
    if rand() >= (1 - test_probability) * BRAPH2.TEST_RANDOM
        Format.checkFormat(Format.MARKERSIZE, value{i})
    end
end
for i = 1:1:length(wrong_value)
    if rand() >= (1 - test_probability) * BRAPH2.TEST_RANDOM
        assert_with_error('Format.checkFormat(Format.MARKERSIZE, varargin{1})', error_identifier, wrong_value{i})
    end
end

%% Test 2.LS: Check LINESTYLE
% LINESTYLE formats that should be accepted
clear value
value{1} = '-';
value{2} = ':';
value{3} = '-.';
value{4} = '--';
value{5} = '';

% LINESTYLE formats that should NOT be accepted
clear wrong_value
wrong_value{1} = 'o';
wrong_value{2} = '+';
wrong_value{3} = '*';
wrong_value{4} = '.';
wrong_value{5} = 'x';
wrong_value{6} = '_';
wrong_value{7} = '|';
wrong_value{8} = 's';
wrong_value{9} = 'd';
wrong_value{10} = '^';
wrong_value{11} = 'v';
wrong_value{12} = '>';
wrong_value{13} = '<';
wrong_value{14} = 'p';
wrong_value{15} = 'h';
wrong_value{16} = 1;
wrong_value{17} = {};
wrong_value{18} = Element();

% tests
for i = 1:1:length(value)
    if rand() >= (1 - test_probability) * BRAPH2.TEST_RANDOM
        Format.checkFormat(Format.LINESTYLE, value{i})
    end
end
for i = 1:1:length(wrong_value)
    if rand() >= (1 - test_probability) * BRAPH2.TEST_RANDOM
        assert_with_error('Format.checkFormat(Format.LINESTYLE, varargin{1})', error_identifier, wrong_value{i})
    end
end

%% Test 2.LW: Check LINEWIDTH
% LINEWIDTH formats that should be accepted
clear value
value{1} = .5;
value{2} = 1;
value{3} = 10;

% LINEWIDTH formats that should NOT be accepted
clear wrong_value
wrong_value{1} = 0;
wrong_value{2} = -1;
wrong_value{3} = 'large';
wrong_value{4} = Element();

% tests
for i = 1:1:length(value)
    if rand() >= (1 - test_probability) * BRAPH2.TEST_RANDOM
        Format.checkFormat(Format.LINEWIDTH, value{i})
    end
end
for i = 1:1:length(wrong_value)
    if rand() >= (1 - test_probability) * BRAPH2.TEST_RANDOM
        assert_with_error('Format.checkFormat(Format.LINEWIDTH, varargin{1})', error_identifier, wrong_value{i})
    end
end