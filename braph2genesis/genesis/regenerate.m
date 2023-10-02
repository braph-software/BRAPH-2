function regenerate(el_path, el_class_list, varargin)
%REGENERATE re-generates some elements.
%
% REGENERATE(EL_PATH, EL_CLASS_LIST) regenerates the elements in
%  EL_CLASS_LIST (cell array of class strings) in directory EL_PATH.
%  It also regenerates the layout and unit test of the element. It then
%  proceeds to unit-test the element.
%
% REGENERATE(EL_PATH, EL_CLASS_LIST, PROPERTY, VALUE, ...) determines how
%  to regenerate the elements, its layout, and its unit test.
%  Admissible properties are:
%       CreateElement     - creates the element (default: true)
%       DoubleCompilation - double compilation of the element for optimization (default: true)
%       CreateLayout      - creates the layout (default: true)
%       CreateTest        - creates the element unit test (default: true)
%       UnitTest          - unit-tests the element (default: true)
%
% Some errors can be thrown, if some elements are still in use and/or
%  memory. In these cases, clear the workspace by executing explicitly
%
%  <a href="matlab:close all; delete(findall(0, 'type', 'figure')); clear all; disp('cleared')">close all; delete(findall(0, 'type', 'figure')); clear all</a>
%
% Importantly, whenever a new element is added or the props of an element
%  are altered (e.g., renamed, moved, added), it is necessary to recompile
%  BRAPH2 with <a href="matlab:braph2genesis">braph2genesis</a>.
%
% See also create_Element, create_layout, create_test_Element, hard_code_constants.

create_element_flag = get_from_varargin(true, 'CreateElement', varargin);
double_compilation_flag = get_from_varargin(true, 'DoubleCompilation', varargin);
create_layout_flag = get_from_varargin(true, 'CreateLayout', varargin);
create_test_flag = get_from_varargin(true, 'CreateTest', varargin);
test_flag = get_from_varargin(true, 'UnitTest', varargin);

% % % Add try-catch to manage cases where the elements are in use. Ask the reader to clear the workspace

for i = 1:1:length(el_class_list)
    el_class = el_class_list{i};
    if create_element_flag
        delete([fileparts(which('braph2')) el_path filesep() el_class '.m'])
        create_Element( ...
            [fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], ...
            [fileparts(which('braph2')) el_path] ...
            )
        if double_compilation_flag
            create_Element( ...
                [fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], ...
                [fileparts(which('braph2')) el_path] ...
                )
        end
    end
    if create_layout_flag
        create_layout( ...
            [fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], ...
            [fileparts(which('braph2')) filesep() 'src' filesep() 'gui' filesep() 'layouts' filesep()] ...
            )
    end
    if create_test_flag
        create_test_Element( ...
            [fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], ...
            [fileparts(which('braph2')) el_path] ...
            )
    end
    if test_flag
        eval(['test_' el_class])
    end
end
