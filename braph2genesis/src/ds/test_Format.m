%TEST_FORMAT

format_list = Format.getFormats();

error_identifier = [BRAPH2.STR ':Format:' BRAPH2.WRONG_INPUT];

%% Test 1: Static methods
assert(numel(format_list) == Format.getFormatNumber(), ...
    [BRAPH2.STR ':Format:' BRAPH2.WRONG_OUTPUT], ...
    [BRAPH2.STR ':Format:' BRAPH2.WRONG_OUTPUT ' ' ...
    'Format.getFormatNumber() does not return correct number of formats.'])

for i = 1:1:numel(format_list)
    format = format_list{i};

    assert(Format.existsFormat(format), ...
        [BRAPH2.STR ':Format:' BRAPH2.WRONG_OUTPUT], ...
        [BRAPH2.STR ':Format:' BRAPH2.WRONG_OUTPUT ' ' ...
        'Format.existsFormat(' tostring(format) ') must return true.'])

    assert(strcmp(eval(['Format.' upper(Format.getFormatName(format)) '_NAME']), Format.getFormatName(format)), ...
        [BRAPH2.STR ':Format:' BRAPH2.WRONG_OUTPUT], ...
        [BRAPH2.STR ':Format:' BRAPH2.WRONG_OUTPUT ' ' ...
        'Format.getFormatName(' tostring(format) ') does not return correct output.'])

    assert(strcmp(eval(['Format.' upper(Format.getFormatName(format)) '_DESCRIPTION']), Format.getFormatDescription(format)), ...
        [BRAPH2.STR ':Format:' BRAPH2.WRONG_OUTPUT], ...
        [BRAPH2.STR ':Format:' BRAPH2.WRONG_OUTPUT ' ' ...
        'Format.getFormatDescription(' tostring(format) ') does not return correct output.'])
    
    assert(ischar(Format.getFormatDescription(format, Format.getFormatSettings(format))), ...
        [BRAPH2.STR ':Format:' BRAPH2.WRONG_OUTPUT], ...
        [BRAPH2.STR ':Format:' BRAPH2.WRONG_OUTPUT '' ...
        'Format.getDescription(' tostring(format) ', settings) should return a char array.'])

% TODO: uncomment once IndexedDictionary works
%     assert(Format.checkFormat(format, Format.getFormatDefault(format)), ...
%         [BRAPH2.STR ':Format:' BRAPH2.WRONG_OUTPUT], ...
%         [BRAPH2.STR ':Format:' BRAPH2.WRONG_OUTPUT '' ...
%         'Format.checkFormat(' tostring(format) ') should return a char array, when called with the default format.'])
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
    Format.checkFormat(Format.EMPTY, value{i})
end
for i = 1:1:length(wrong_value)
    assert_with_error('Format.checkFormat(Format.EMPTY, varargin{1})', error_identifier, wrong_value{i})
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
    Format.checkFormat(Format.STRING, value{i})
end
for i = 1:1:length(wrong_value)
    assert_with_error('Format.checkFormat(Format.STRING, varargin{1})', error_identifier, wrong_value{i})
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
    Format.checkFormat(Format.LOGICAL, value{i})
end
for i = 1:1:length(wrong_value)
    assert_with_error('Format.checkFormat(Format.LOGICAL, varargin{1})', error_identifier, wrong_value{i})
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
    Format.checkFormat(Format.OPTION, value{i})
end
for i = 1:1:length(wrong_value)
    assert_with_error('Format.checkFormat(Format.OPTION, varargin{1})', error_identifier, wrong_value{i})
end

%% Test 2.OP.s: Check OPTION with settings
% OPTION formats that should be accepted
clear value
value{1} = 'true'; settings{1} = {'true', 'false'};
value{2} = 'male'; settings{2} = {'male', 'female'};
value{3} = 'phd'; settings{3} = {'elementary', 'high school', 'college', 'MSc', 'PhD'};

% OPTION formats that should NOT be accepted
clear wrong_value
wrong_value{1} = 'true'; wrong_settings{1} = {'0', '1'};
wrong_value{2} = 'male'; wrong_settings{2} = {'man', 'woman'};
wrong_value{3} = 'phd'; wrong_settings{3} = {'elementary', 'high school', 'college', 'M.Sc.', 'Ph.D.'};

% tests
for i = 1:1:length(value)
    Format.checkFormat(Format.OPTION, value{i}, settings{i})
end
for i = 1:1:length(wrong_value)
    assert_with_error('Format.checkFormat(Format.OPTION, varargin{1})', error_identifier, wrong_value{i}, wrong_settings{i})
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
wrong_value{4} = 'String';

% tests
for i = 1:1:length(value)
    Format.checkFormat(Format.CLASS, value{i})
end
for i = 1:1:length(wrong_value)
    assert_with_error('Format.checkFormat(Format.CLASS, varargin{1})', error_identifier, wrong_value{i})
end

%% Test 2.CA.s: Check CLASS
% TODO

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
    Format.checkFormat(Format.CLASSLIST, value{i})
end
for i = 1:1:length(wrong_value)
    assert_with_error('Format.checkFormat(Format.CLASSLIST, varargin{1})', error_identifier, wrong_value{i})
end

%% Test 2.CL.s: Check CLASSLIST
% TODO

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
    Format.checkFormat(Format.ITEM, value{i})
end
for i = 1:1:length(wrong_value)
    assert_with_error('Format.checkFormat(Format.ITEM, varargin{1})', error_identifier, wrong_value{i})
end

%% Test 2.IT.s: Check ITEM
% TODO

%% Test 2.IL: Check ITEMLIST
clear value
clear element_class_list
clear wrong_value

element_class_list{1} = Element();
element_class_list{2} = Element();

% ITEMLIST formats that should NOT be accepted
wrong_value{1} = 3.14;
wrong_value{2} = true;
wrong_value{3} = 'String';
wrong_value{4} = {'1', '2', '3'};

% tests
Format.checkFormat(Format.ITEMLIST, element_class_list)

for i = 1:1:length(wrong_value)
    assert_with_error('Format.checkFormat(Format.ITEMLIST, varargin{1})', error_identifier, wrong_value{i})
end

%% Test 2.IL.s: Check ITEMLIST
% TODO

%% Test 2.DI: Check IDICT
% % % IDICT formats that should be accepted
% % clear value
% % value{1} = IndexedDictionary('Element');
% % 
% % % IDICT formats that should NOT be accepted
% % clear wrong_value
% % wrong_value{1} = IndexedDictionary('DummyObject');
% % wrong_value{2} = 3.14;
% % wrong_value{3} = true;
% % wrong_value{4} = 'String';
% % 
% % % tests
% % for i = 1:1:length(value)
% %     Format.checkFormat(Format.IDICT, value{i})
% % end
% % for i = 1:1:length(wrong_value)
% %     assert_with_error('Format.checkFormat(Format.IDICT, varargin{1})', error_identifier, wrong_value{i})
% % end

%% Test 2.DI.s: Check IDICT
% TODO

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
    Format.checkFormat(Format.SCALAR, value{i})
end
for i = 1:1:length(wrong_value)
    assert_with_error('Format.checkFormat(Format.SCALAR, varargin{1})', error_identifier, wrong_value{i})
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
    Format.checkFormat(Format.RVECTOR, value{i})
end
for i = 1:1:length(wrong_value)
    assert_with_error('Format.checkFormat(Format.RVECTOR, varargin{1})', error_identifier, wrong_value{i})
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
    Format.checkFormat(Format.CVECTOR, value{i})
end
for i = 1:1:length(wrong_value)
    assert_with_error('Format.checkFormat(Format.CVECTOR, varargin{1})', error_identifier, wrong_value{i})
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
    Format.checkFormat(Format.MATRIX, value{i})
end
for i = 1:1:length(wrong_value)
    assert_with_error('Format.checkFormat(Format.MATRIX, varargin{1})', error_identifier, wrong_value{i})
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
    Format.checkFormat(Format.SMATRIX, value{i})
end
for i = 1:1:length(wrong_value)
    assert_with_error('Format.checkFormat(Format.SMATRIX, varargin{1})', error_identifier, wrong_value{i})
end

%% Test 2.LL: Check CELL
% % ADJACENCY formats that should be accepted
% clear value
% value{1} = rand(5);
% value{2} = {
%     rand(5) [] []
%     [] rand(2) []
%     [] [] rand(1)
%     };
% value{3} = {
%     rand(4) diag(rand(4, 1)) []
%     diag(rand(4, 1)) rand(4) diag(rand(4, 1))
%     [] diag(rand(4, 1)) rand(4)
%     };
% value{4} = {
%     rand(4) diag(rand(4, 1)) diag(rand(4, 1))
%     diag(rand(4, 1)) rand(4) diag(rand(4, 1))
%     diag(rand(4, 1)) diag(rand(4, 1)) rand(4)
%     };
% value{5} = {
%     rand(3) rand(3, 2) []
%     rand(2, 3) rand(2) rand(2, 4)
%     [] rand(4, 2) rand(4)
%     };
% value{6} = {
%     rand(3) rand(3, 2) rand(3, 4)
%     rand(2, 3) rand(2) rand(2, 4)
%     rand(4, 3) rand(4, 2) rand(4)
%     };
% 
% % ADJACENCY formats that should NOT be accepted
% clear wrong_value
% wrong_value{1} = 'String';
% wrong_value{2} = true;
% wrong_value{3} = rand(5, 3);
% wrong_value{4} = {rand(4, 3)};
% wrong_value{5} = {rand(3, 4)};
% wrong_value{6} = {
%     rand(4, 3) rand(4) rand(4)
%     rand(4) rand(4) rand(4)
%     rand(4) rand(4) rand(4)
%     };
% wrong_value{6} = {
%     rand(3, 4) rand(4) rand(4)
%     rand(4) rand(4) rand(4)
%     rand(4) rand(4) rand(4)
%     };
% wrong_value{7} = {rand(4) rand(4)};
%  
% % tests
% for i = 1:1:length(value)
%     Format.checkFormat(Format.ADJACENCY, value{i})
% end
% for i = 1:1:length(wrong_value)
%     assert_with_error('Format.checkFormat(Format.ADJACENCY, varargin{1})', error_identifier, wrong_value{i})
% end