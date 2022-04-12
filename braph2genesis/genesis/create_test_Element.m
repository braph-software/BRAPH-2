function create_test_Element(generator_file, target_dir)
%CREATE_TEST_ELEMENT creates the test of an element.
%
% CREATE_TEST_ELEMENT(FILE, DIR) creates the m-file with the script to test
%  an Element from its generator file FILE (with ending '.gen.m') and saves
%  it in the target directory DIR.
%
% The structure of the generator file can be found in <a href="matlab:help create_Element">create_Element</a>.
%
% See also genesis, create_Element.

disp(['¡ source file: ' generator_file])
disp(['¡ target dir: ' target_dir])

txt = fileread(generator_file);

disp('¡! generator file read')

%% Analysis
[class_name, superclass_name, moniker] = analyze_header(); %#ok<ASGLU>
    function [class_name, superclass_name, moniker, descriptive_name, header_description, class_attributes, description, seealso] = analyze_header()
        header = getToken(txt, 'header');
        res = regexp(header, '^\s*(?<class_name>\w*)\s*<\s*(?<superclass_name>\w*)\s*\(\s*(?<moniker>\w*)\s*,\s*(?<descriptive_name>[^)]*)\)\s*(?<header_description>[^.]*)\.', 'names');
        class_name = res.class_name;
        superclass_name = res.superclass_name;
        moniker = res.moniker;
        descriptive_name = res.descriptive_name;
        header_description = res.header_description;
        
        class_attributes = getToken(txt, 'header', 'class_attributes');

        description = splitlines(getToken(txt, 'header', 'description'));
        
        seealso = getToken(txt, 'header', 'seealso');        
    end

prop_number = Element.getPropNumber(class_name);

[tests, test_functions] = analyze_tests();
    function tests = analyze_tests()
        tests = getTokens(txt, 'tests', 'test');
        for i = 1:1:numel(tests)
            tests{i}.name = getToken(tests{i}.token, 'name');
            
            tests{i}.probability = getToken(tests{i}.token, 'probability');
            if isempty(tests{i}.probability)
                tests{i}.probability = '1';
            end
            
            tests{i}.parallel = getToken(tests{i}.token, 'parallel');
            if isempty(tests{i}.parallel)
                tests{i}.parallel = 'true';
            end
            
            tests{i}.code = splitlines(getToken(tests{i}.token, 'code'));
        end
        test_functions = getToken(txt, 'tests', 'test_functions');
    end

%% Basic tests
basic_tests{1} = test_1_instantation_empty();
    function basic_test = test_1_instantation_empty()
        basic_test.name = 'Instantiation - empty';
        basic_test.probability = '.01';
        basic_test.parallel = 'true';
        basic_test.code = {
            [moniker ' = ' class_name '();']
            ''
            ['prop_number = ' class_name '.getPropNumber();']
            'for prop = 1:1:prop_number'
                ['\t' 'TAG = upper(' class_name '.getPropTag(prop));']
                ['\t' 'assert( ...']
                    ['\t\t' 'isa(' moniker '.getr(prop), ''NoValue''), ...']
                    ['\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.BUG_FUNC], ...']
                    ['\t\t' '[''' class_name '.getr('' int2str(prop) '') must be inizialized to NoValue(). '' ...']
                    ['\t\t' '''Or there could be an error in ' class_name '.getr('' int2str(prop) '').''] ...']
                    ['\t\t' ')']
                ['\t' 'assert( ...']
                    ['\t\t' 'isa(' moniker '.getr(TAG), ''NoValue''), ...']
                    ['\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.BUG_FUNC], ...']
                    ['\t\t' '[''' class_name '.getr('''''' TAG '''''') must be inizialized to NoValue(). '' ...']
                    ['\t\t' '''Or there could be an error in ' class_name '.getr('''''' TAG '''''').''] ...']
                    ['\t\t' ')']
            'end'
            };
    end

basic_tests{end+1} = test_2_instantation_defaults();
    function basic_test = test_2_instantation_defaults()
        basic_test.name = 'Instantiation - defaults';
        basic_test.probability = '.01';
        basic_test.parallel = 'true';
        basic_test.code = {
            ['warning(''off'', ''' BRAPH2.STR ':' class_name ''')']
            [moniker ' = ' class_name '( ...']
            };
            for prop = 1:1:prop_number
                TAG = upper(eval([class_name '.getPropTag(' int2str(prop) ')']));
                if prop < prop_number
                    basic_test.code{end+1} = ['\t' class_name '.' TAG ', ' class_name '.getPropDefault(' class_name '.' TAG '), ...'];
                else
                    basic_test.code{end+1} = ['\t' class_name '.' TAG ', ' class_name '.getPropDefault(' class_name '.' TAG ') ...'];
                end
            end
        basic_test.code = [basic_test.code 
            {
            ['\t' ');']
            ['warning(''on'', ''' BRAPH2.STR ':' class_name ''')']
            ''
            ['for prop = 1:1:' class_name '.getPropNumber()']
                ['\t' 'TAG = upper(' class_name '.getPropTag(prop));']
                ['\t' 'switch ' class_name '.getPropCategory(prop)']
                    ['\t\t' 'case {Category.METADATA, Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}']
                        ['\t\t\t' 'assert( ...']
                            ['\t\t\t\t' 'isequal(' moniker '.getr(prop), ' class_name '.getPropDefaultConditioned(prop)), ...']
                            ['\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.BUG_FUNC], ...']
                            ['\t\t\t\t' '[''' class_name '.getr('' int2str(prop) '') must be inizialized to its default value '' ...']
                            ['\t\t\t\t' '''given by ' class_name '.getPropDefaultConditioned('' int2str(prop) ''). '' ...']
                            ['\t\t\t\t' '''Or there could be an error in ' class_name '.getr('' int2str(prop) '').''] ...']
                            ['\t\t\t\t' ')']
                        ['\t\t\t' 'assert( ...']
                            ['\t\t\t\t' 'isequal(' moniker '.getr(TAG), ' class_name '.getPropDefaultConditioned(prop)), ...']
                            ['\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.BUG_FUNC], ...']
                            ['\t\t\t\t' '[''' class_name '.getr('''''' TAG '''''') must be inizialized to its default value '' ...']
                            ['\t\t\t\t' '''given by ' class_name '.getPropDefaultConditioned('' int2str(prop) ''). '' ...']
                            ['\t\t\t\t' '''Or there could be an error in ' class_name '.getr('''''' TAG '''''').''] ...']
                            ['\t\t\t\t'  ')']
                    ['\t\t' 'case Category.RESULT']
                        ['\t\t\t' 'assert( ...']
                            ['\t\t\t\t' 'isa(' moniker '.getr(prop), ''NoValue''), ...']
                            ['\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.BUG_FUNC], ...']
                            ['\t\t\t\t' '[''Being a result, ' class_name '.getr('' int2str(prop) '') must be inizialized to NoValue(). '' ...']
                            ['\t\t\t\t' '''Or there could be an error in ' class_name '.getr('' int2str(prop) '').''] ...']
                            ['\t\t\t\t' ')']
                        ['\t\t\t' 'assert( ...']
                            ['\t\t\t\t' 'isa(' moniker '.getr(TAG), ''NoValue''), ...']
                            ['\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.BUG_FUNC], ...']
                            ['\t\t\t\t' '[''Being a result, ' class_name '.getr('''''' TAG '''''') must be inizialized to NoValue(). '' ...']
                            ['\t\t\t\t' '''Or there could be an error in ' class_name '.getr('''''' TAG '''''').''] ...']
                            ['\t\t\t\t' ')']
                ['\t' 'end']
            'end'
            }];
    end

basic_tests{end+1} = test_3_callbacks();
    function basic_test = test_3_callbacks()
        basic_test.name = 'Callbacks';
        basic_test.probability = '.01';
        basic_test.parallel = 'true';

        if strcmp(class_name, 'Callback')
            basic_test.code = {'% this test is not implemented for Callback'};
            return
        end
        
        % element
        basic_test.code = {
            ['warning(''off'', ''' BRAPH2.STR ':' class_name ''')']
            [moniker '_0 = ' class_name '( ...']
            };
        for prop = 1:1:prop_number
            TAG = upper(eval([class_name '.getPropTag(' int2str(prop) ')']));
            if prop < prop_number
                basic_test.code{end+1} = ['\t' class_name '.' TAG ', ' class_name '.getPropDefault(' class_name '.' TAG '), ...'];
            else
                basic_test.code{end+1} = ['\t' class_name '.' TAG ', ' class_name '.getPropDefault(' class_name '.' TAG ') ...'];
            end
        end
        basic_test.code = [basic_test.code 
            {
                ['\t' ');']
            ['warning(''on'', ''' BRAPH2.STR ':' class_name ''')']
            ''
            }];

        % element with 1st callbacks
        basic_test.code{end+1} = [moniker '_1 = ' class_name '( ...'];
        for prop = 1:1:prop_number
            TAG = upper(eval([class_name '.getPropTag(' int2str(prop) ')']));
            switch eval([class_name '.getPropCategory(' int2str(prop) ')'])
                case Category.METADATA
                    if prop < prop_number
                        basic_test.code{end+1} = ['\t' class_name '.' TAG ', ' class_name '.getPropDefault(' class_name '.' TAG '), ...'];
                    else
                        basic_test.code{end+1} = ['\t' class_name '.' TAG ', ' class_name '.getPropDefault(' class_name '.' TAG ') ...'];
                    end                    
                case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
                    if prop < prop_number
                        basic_test.code{end+1} = ['\t' class_name '.' TAG ', Callback(''EL'', ' moniker '_0, ''PROP'', ' int2str(prop) '), ...'];
                    else
                        basic_test.code{end+1} = ['\t' class_name '.' TAG ', Callback(''EL'', ' moniker '_0, ''PROP'', ' int2str(prop) ') ...'];
                    end
                case Category.RESULT
                    if prop < prop_number
                        basic_test.code{end+1} = ['\t' class_name '.' TAG ', NoValue(), ...'];
                    else
                        basic_test.code{end+1} = ['\t' class_name '.' TAG ', NoValue() ...'];
                    end                    
            end
        end
        basic_test.code = [basic_test.code 
            {
                ['\t' ');']
            ''
            }];
        
        basic_test.code = [basic_test.code 
            {
            ['prop_number = ' class_name '.getPropNumber();']
            'for prop = 1:1:prop_number'
                ['\t' 'TAG = upper(' class_name '.getPropTag(prop));']
                ['\t' 'switch ' class_name '.getPropCategory(prop)']
                    ['\t\t' 'case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}']
                        ['\t\t\t' 'assert( ...']
                            ['\t\t\t\t' 'isa(' moniker '_1.getr(prop),  ''Callback''), ...']
                            ['\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.BUG_FUNC], ...']
                            ['\t\t\t\t' '[''' class_name '.getr('' int2str(prop) '') must be a callback.''] ...']
                            ['\t\t\t\t' ')']
                        ['\t\t\t' 'assert( ...']
                            ['\t\t\t\t' 'isequal(' moniker '_1.get(prop), ' moniker '_0.get(prop)) && ~isa(' moniker '_1.get(prop), ''Callback''), ...']
                            ['\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.BUG_FUNC], ...']
                            ['\t\t\t\t' '[''' class_name '.get('' int2str(prop) '') must be the actual property and NOT a callback.''] ...']
                            ['\t\t\t\t' ')']
                    ['\t\t' 'case {Category.METADATA, Category.RESULT}']
                        ['\t\t\t' 'assert( ...']
                            ['\t\t\t\t' '~isa(' moniker '_1.getr(prop), ''Callback''), ...']
                            ['\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.BUG_FUNC], ...']
                            ['\t\t\t\t' '[''' class_name '.getr('' int2str(prop) '') must NOT be a callback.''] ...']
                            ['\t\t\t\t' ')']
                ['\t' 'end']
            'end'
            ''
            }];
        
        % element with 2nd callbacks
        basic_test.code{end+1} = [moniker '_2 = ' class_name '( ...'];
        for prop = 1:1:prop_number
            TAG = upper(eval([class_name '.getPropTag(' int2str(prop) ')']));
            switch eval([class_name '.getPropCategory(' int2str(prop) ')'])
                case Category.METADATA
                    if prop < prop_number
                        basic_test.code{end+1} = ['\t' class_name '.' TAG ', ' class_name '.getPropDefault(' class_name '.' TAG '), ...'];
                    else
                        basic_test.code{end+1} = ['\t' class_name '.' TAG ', ' class_name '.getPropDefault(' class_name '.' TAG ') ...'];
                    end                    
                case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
                    if prop < prop_number
                        basic_test.code{end+1} = ['\t' class_name '.' TAG ', Callback(''EL'', ' moniker '_1, ''PROP'', ' int2str(prop) '), ...'];
                    else
                        basic_test.code{end+1} = ['\t' class_name '.' TAG ', Callback(''EL'', ' moniker '_1, ''PROP'', ' int2str(prop) ') ...'];
                    end
                case Category.RESULT
                    if prop < prop_number
                        basic_test.code{end+1} = ['\t' class_name '.' TAG ', NoValue(), ...'];
                    else
                        basic_test.code{end+1} = ['\t' class_name '.' TAG ', NoValue() ...'];
                    end                    
            end
        end
        basic_test.code = [basic_test.code 
            {
                ['\t' ');']
            ''
            }];
        
        basic_test.code = [basic_test.code 
            {
            ['prop_number = ' class_name '.getPropNumber();']
            'for prop = 1:1:prop_number'
                ['\t' 'TAG = upper(' class_name '.getPropTag(prop));']
                ['\t' 'switch ' class_name '.getPropCategory(prop)']
                	['\t\t' 'case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}']
                        ['\t\t\t' 'assert( ...']
                            ['\t\t\t' 'isa(' moniker '_2.getr(prop),  ''Callback''), ...']
                            ['\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.BUG_FUNC], ...']
                            ['\t\t\t' '[''' class_name '.getr('' int2str(prop) '') must be a callback.''] ...']
                            ['\t\t\t' ')']
                        ['\t\t\t' 'assert( ...']
                            ['\t\t\t' 'isequal(' moniker '_2.get(prop), ' moniker '_0.get(prop)) && ~isa(' moniker '_1.get(prop), ''Callback''), ...']
                            ['\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.BUG_FUNC], ...']
                            ['\t\t\t' '[''' class_name '.get('' int2str(prop) '') must be the actual property and NOT a callback.''] ...']
                            ['\t\t\t' ')']
                    ['\t\t' 'case {Category.METADATA, Category.RESULT}']
                        ['\t\t\t' 'assert( ...']
                            ['\t\t\t' '~isa(' moniker '_2.getr(prop), ''Callback''), ...']
                            ['\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.BUG_FUNC], ...']
                            ['\t\t\t' '[''' class_name '.getr('' int2str(prop) '') must NOT be a callback.''] ...']
                            ['\t\t\t' ')']
                ['\t' 'end']
            'end'
            }];
        
        % element with 3rd callbacks
        basic_test.code{end+1} = [moniker '_3 = ' class_name '( ...'];
        for prop = 1:1:prop_number
            TAG = upper(eval([class_name '.getPropTag(' int2str(prop) ')']));
            switch eval([class_name '.getPropCategory(' int2str(prop) ')'])
                case Category.METADATA
                    if prop < prop_number
                        basic_test.code{end+1} = ['\t' class_name '.' TAG ', ' class_name '.getPropDefault(' class_name '.' TAG '), ...'];
                    else
                        basic_test.code{end+1} = ['\t' class_name '.' TAG ', ' class_name '.getPropDefault(' class_name '.' TAG ') ...'];
                    end                    
                case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
                    if prop < prop_number
                        basic_test.code{end+1} = ['\t' class_name '.' TAG ', Callback(''EL'', ' moniker '_2, ''PROP'', ' int2str(prop) '), ...'];
                    else
                        basic_test.code{end+1} = ['\t' class_name '.' TAG ', Callback(''EL'', ' moniker '_2, ''PROP'', ' int2str(prop) ') ...'];
                    end
                case Category.RESULT
                    if prop < prop_number
                        basic_test.code{end+1} = ['\t' class_name '.' TAG ', NoValue(), ...'];
                    else
                        basic_test.code{end+1} = ['\t' class_name '.' TAG ', NoValue() ...'];
                    end                    
            end
        end
        basic_test.code = [basic_test.code 
            {
                ['\t' ');']
            ''
            }];
        
        basic_test.code = [basic_test.code 
            {
            ['prop_number = ' class_name '.getPropNumber();']
            'for prop = 1:1:prop_number'
                ['\t' 'TAG = upper(' class_name '.getPropTag(prop));']
                ['\t' 'switch ' class_name '.getPropCategory(prop)']
                    ['\t\t' 'case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}']
                        ['\t\t\t' 'assert( ...']
                            ['\t\t\t' 'isa(' moniker '_3.getr(prop),  ''Callback''), ...']
                            ['\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.BUG_FUNC], ...']
                            ['\t\t\t\t' '[''' class_name '.getr('' int2str(prop) '') must be a callback.''] ...']
                            ['\t\t\t\t'  ')']
                    ['\t\t\t' 'assert( ...']
                            ['\t\t\t\t' 'isequal(' moniker '_3.get(prop), ' moniker '_0.get(prop)) && ~isa(' moniker '_1.get(prop), ''Callback''), ...']
                            ['\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.BUG_FUNC], ...']
                            ['\t\t\t\t' '[''' class_name '.get('' int2str(prop) '') must be the actual property and NOT a callback.''] ...']
                            ['\t\t\t\t' ')']
                ['\t\t' 'case {Category.METADATA, Category.RESULT}']
                    ['\t\t\t' 'assert( ...']
                            ['\t\t\t\t' '~isa(' moniker '_3.getr(prop), ''Callback''), ...']
                            ['\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.BUG_FUNC], ...']
                            ['\t\t\t\t' '[''' class_name '.getr('' int2str(prop) '') must NOT be a callback.''] ...']
                            ['\t\t\t\t' ')']
                ['\t' 'end']
            'end'
            }];
    end

basic_tests{end+1} = test_4_result();
    function basic_test = test_4_result()
        basic_test.name = 'Result';
        basic_test.probability = '.01';
        basic_test.parallel = 'true';

        basic_test.code = {
            ['warning(''off'', ''' BRAPH2.STR ':' class_name ''')']
            [moniker ' = ' class_name '( ...']
            };
        for prop = 1:1:prop_number
            TAG = upper(eval([class_name '.getPropTag(' int2str(prop) ')']));
            if prop < prop_number
                basic_test.code{end+1} = ['\t' class_name '.' TAG ', ' class_name '.getPropDefault(' class_name '.' TAG '), ...'];
            else
                basic_test.code{end+1} = ['\t' class_name '.' TAG ', ' class_name '.getPropDefault(' class_name '.' TAG ') ...'];
            end
        end
        basic_test.code = [basic_test.code 
            {
                ['\t' ');']
            ['warning(''on'', ''' BRAPH2.STR ':' class_name ''')']
            ''
            }];
        
        basic_test.code = [basic_test.code 
            {
        	['prop_number = ' class_name '.getPropNumber();']
        	'for prop = 1:1:prop_number'
                ['\t' 'TAG = upper(' class_name '.getPropTag(prop));']
            	['\t' 'switch ' class_name '.getPropCategory(prop)']
                    ['\t\t' 'case {Category.METADATA, Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}']
                    ['\t\t' 'case Category.RESULT']
                        ['\t\t\t' 'assert( ...']
                            ['\t\t\t\t' '~isa(' moniker '.get(prop),  ''NoValue''), ...']
                            ['\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.BUG_FUNC], ...']
                            ['\t\t\t\t' '[''' class_name '.get('' int2str(prop) '') must NOT be a NoValue, because it should have been calculated.''] ...']
                            ['\t\t\t\t' ')']
                        ['\t\t\t' 'assert( ...']
                            ['\t\t\t\t' 'isa(' moniker '.getr(prop),  ''NoValue''), ...']
                            ['\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.BUG_FUNC], ...']
                            ['\t\t\t\t' '[''' class_name '.getr('' int2str(prop) '') must be a NoValue, because it has not been memorized.''] ...']
                            ['\t\t\t\t' ')']
                        ['\t\t\t' 'if isempty(' moniker '.getPropSettings(prop))']
                            ['\t\t\t\t' 'assert( ...']
                                ['\t\t\t\t\t' moniker '.checkFormat(' moniker '.getPropFormat(prop), ' moniker '.get(prop)), ...']
                                ['\t\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.BUG_FUNC], ...']
                                ['\t\t\t\t\t' '[''' class_name '.get('' int2str(prop) '') returns a value with the wrong format.''] ...']
                                ['\t\t\t\t\t' ')']
                        ['\t\t\t' 'else']
                            ['\t\t\t\t' 'assert( ...']
                                ['\t\t\t\t\t' moniker '.checkFormat(' moniker '.getPropFormat(prop), ' moniker '.get(prop), ' moniker '.getPropSettings(prop)), ...']
                                ['\t\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.BUG_FUNC], ...']
                                ['\t\t\t\t\t' '[''' class_name '.get('' int2str(prop) '') returns a value with the wrong format.''] ...']
                                ['\t\t\t\t\t' ')']
                        ['\t\t\t' 'end']
                ['\t' 'end']
            'end'
            }];
    end

basic_tests{end+1} = test_5_memorize();
    function basic_test = test_5_memorize()
        basic_test.name = 'Memorize';
        basic_test.probability = '.01';
        basic_test.parallel = 'true';
        basic_test.code = {
            ['warning(''off'', ''' BRAPH2.STR ':' class_name ''')']
        	[moniker ' = ' class_name '( ...']
            };
        for prop = 1:1:prop_number
            TAG = upper(eval([class_name '.getPropTag(' int2str(prop) ')']));
            if prop < prop_number
                basic_test.code{end+1} = ['\t' class_name '.' TAG ', ' class_name '.getPropDefault(' class_name '.' TAG '), ...'];
            else
                basic_test.code{end+1} = ['\t' class_name '.' TAG ', ' class_name '.getPropDefault(' class_name '.' TAG ') ...'];
            end
        end
        basic_test.code = [basic_test.code 
            {
                ['\t' ');']
            ['warning(''on'', ''' BRAPH2.STR ':' class_name ''')']
            ''
            }];
        
        basic_test.code = [basic_test.code 
            {
            ['for prop = 1:1:' class_name '.getPropNumber()']
                ['\t' 'TAG = upper(' class_name '.getPropTag(prop));']
                ['\t' 'switch ' class_name '.getPropCategory(prop)']
                    ['\t\t' 'case {Category.METADATA, Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}']
                	['\t\t' 'case Category.RESULT']
                        ['\t\t\t' 'assert( ...']
                            ['\t\t\t' '~isa(' moniker '.get(prop),  ''NoValue''), ...']
                            ['\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.BUG_FUNC], ...']
                            ['\t\t\t' '[''' class_name '.get('' int2str(prop) '') must NOT be a NoValue, because it should have been calculated.''] ...']
                            ['\t\t\t' ')']
                        ['\t\t\t' 'assert( ...']
                            ['\t\t\t' 'isa(' moniker '.getr(prop),  ''NoValue''), ...']
                            ['\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.BUG_FUNC], ...']
                            ['\t\t\t' '[''' class_name '.getr('' int2str(prop) '') must be a NoValue, because it should NOT have been memorized.''] ...']
                            ['\t\t\t' ')']
                        ['\t\t\t' 'assert( ...']
                            ['\t\t\t' '~isa(' moniker '.memorize(prop),  ''NoValue''), ...']
                            ['\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.BUG_FUNC], ...']
                            ['\t\t\t' '[''' class_name '.memorize('' int2str(prop) '') must NOT be a NoValue, because it should have been calculated.''] ...']
                            ['\t\t\t' ')']
                        ['\t\t\t' 'assert( ...']
                            ['\t\t\t' '~isa(' moniker '.getr(prop),  ''NoValue''), ...']
                            ['\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.BUG_FUNC], ...']
                            ['\t\t\t' '[''' class_name '.getr('' int2str(prop) '') must NOT be a NoValue, because it should have been memorized.''] ...']
                            ['\t\t\t' ')']
                        ['\t\t\t' 'assert( ...']
                            ['\t\t\t' moniker '.checkFormat(' moniker '.getPropFormat(prop), ' moniker '.getr(prop),' moniker '.getPropSettings(prop)), ...']
                            ['\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.BUG_FUNC], ...']
                            ['\t\t\t' '[''' class_name '.getr('' int2str(prop) '') returns a value with the wrong format.''] ...']
                            ['\t\t\t' ')']
            ['\t' 'end']
        'end'
        }];
    end

tests = [basic_tests tests];

%% Generate file
file_str = [];

generate_header()
    function generate_header()
        gs(0, {
            ['%TEST_' upper(class_name)]
            ''
            })
    end

generate_tests()
    function generate_tests()    
        for i = 1:1:numel(tests)
            gs(0, {
                ['%% Test ' int2str(i) ': ' tests{i}.name]
                ''
                })
            
            if tests{i}.parallel
                % tested ALSO if parallel on
                g(0, ['if rand() >= (1 - ' tests{i}.probability ') * BRAPH2.TEST_RANDOM'])
            else
                % NOT tested if parallel on
                g(0, ['if ~BRAPH2.TEST_PARALLEL && rand() >= (1 - ' tests{i}.probability ') * BRAPH2.TEST_RANDOM'])
            end
            
                gs(1, {
                    'try'
                    ''
                    })

                    gs(2, tests{i}.code)

                gs(1, {
                    ''
                    'catch e'
                    })
                    g(2, 'if BRAPH2.TEST_PARALLEL && strcmp(e.identifier, ''MATLAB:Java:InvalidInput'')')
                        g(3, ['disp(''' class_name ' Test ' int2str(i) ' - MATLAB:Java:InvalidInput probably due to parallel testing.'')'])
                    g(2, 'else')
                        g(3, 'rethrow(e)')
                    g(2, 'end')
                g(1, 'end')

            gs(0, {
                'end'
                ''
                })
        end
        
        g(0, '%% Test functions')
        gs(0, test_functions)
    end

%% Save file
target_file = [target_dir filesep() 'test_' class_name '.m'];
object_file = fopen(target_file, 'w');
fprintf(object_file, file_str);
fclose(object_file);    

disp(['¡! saved file: ' target_file])
disp(' ')

%% Help functions
    function g(tabs, str)
        str = regexprep(str, '%', '%%');
        file_str = [file_str repmat('\t', 1, tabs) str '\n'];
    end
    function gs(tabs, lines)
        for i = 1:1:length(lines)
            g(tabs, lines{i})
        end
    end
end