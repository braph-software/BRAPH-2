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

% Analysis
[class_name, superclass_name, moniker] = analyze_header();
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

tests = analyze_tests();
    function tests = analyze_tests()
        tests = getTokens(txt, 'tests', 'test');
        for i = 1:1:numel(tests)
            tests{i}.name = getToken(tests{i}.token, 'name');
            tests{i}.code = splitlines(getToken(tests{i}.token, 'code'));
        end
    end

%% Generate and save file
target_file = [target_dir filesep() 'test_' class_name '.m'];
object_file = fopen(target_file, 'w');

generate_header()
    function generate_header()
        gs(0, {['%TEST_' upper(class_name)]; ''})
    end

generate_test1_1_instantation_empty()
    function generate_test1_1_instantation_empty()
        gs(0, {'%% Test 1.1: Instantiation - empty'; ''})
        
        gs(0, {[moniker ' = ' class_name '();']; ''})
        
        g(0, ['prop_number = ' class_name '.getPropNumber();'])
        g(0, 'for prop = 1:1:prop_number')
            g(1, ['TAG = upper(' class_name '.getPropTag(prop));'])
            g(1, 'assert( ...')
                gs(2, {
                    ['isa(' moniker '.getr(prop), ''NoValue''), ...']
                    ['[BRAPH2.STR '':' class_name ':'' BRAPH2.BUG_FUNC], ...']
                    ['[BRAPH2.STR '':' class_name ':'' BRAPH2.BUG_FUNC '' '' ...']
                    ['''' class_name '.getr('' int2str(prop) '') must be inizialized to NoValue(). '' ...']
                    ['''Or there could be an error in ' class_name '.getr('' int2str(prop) '').''] ...']
                    ')'
                    })
            g(1, 'assert( ...')
                gs(2, {
                    ['isa(' moniker '.getr(TAG), ''NoValue''), ...']
                    ['[BRAPH2.STR '':' class_name ':'' BRAPH2.BUG_FUNC], ...']
                    ['[BRAPH2.STR '':' class_name ':'' BRAPH2.BUG_FUNC '' '' ...']
                    ['''' class_name '.getr('''''' TAG '''''') must be inizialized to NoValue(). '' ...']
                    ['''Or there could be an error in ' class_name '.getr('''''' TAG '''''').''] ...']
                    ')'
                    })
        g(0, 'end')
        g(0, '')
    end

generate_test1_2_instantation_defaults()
    function generate_test1_2_instantation_defaults()
        gs(0, {'%% Test 1.2: Instantiation - defaults'; ''})

        gs(0, {['warning(''off'', ''' BRAPH2.STR ':' class_name ''')'], ''})
        g(0, [moniker ' = ' class_name '( ...'])
            for prop = 1:1:prop_number
                TAG = upper(eval([class_name '.getPropTag(' int2str(prop) ')']));
                if prop < prop_number
                    g(1, [class_name '.' TAG ', ' class_name '.getPropDefault(' class_name '.' TAG '), ...'])
                else
                    g(1, [class_name '.' TAG ', ' class_name '.getPropDefault(' class_name '.' TAG ') ...'])
                end
            end
            g(1, ');')
        gs(0, {['warning(''on'', ''' BRAPH2.STR ':' class_name ''')'], ''})

        g(0, ['for prop = 1:1:' class_name '.getPropNumber()'])
            g(1, ['TAG = upper(' class_name '.getPropTag(prop));'])
            g(1, ['switch ' class_name '.getPropCategory(prop)'])
                g(2, 'case {Category.METADATA, Category.PARAMETER, Category.DATA}')
                    g(3, 'assert( ...')
                        gs(4, {
                            ['isequal(' moniker '.getr(prop), ' class_name '.getPropDefault(prop)), ...']
                            ['[BRAPH2.STR '':' class_name ':'' BRAPH2.BUG_FUNC], ...']
                            ['[BRAPH2.STR '':' class_name ':'' BRAPH2.BUG_FUNC '' '' ...']
                            ['''' class_name '.getr('' int2str(prop) '') must be inizialized to its default value '' ...']
                            ['''given by ' class_name '.getPropDefault('' int2str(prop) ''). '' ...']
                            ['''Or there could be an error in ' class_name '.getr('' int2str(prop) '').''] ...']
                            ')'
                            })
                    g(3, 'assert( ...')
                        gs(4, {
                            ['isequal(' moniker '.getr(TAG), ' class_name '.getPropDefault(prop)), ...']
                            ['[BRAPH2.STR '':' class_name ':'' BRAPH2.BUG_FUNC], ...']
                            ['[BRAPH2.STR '':' class_name ':'' BRAPH2.BUG_FUNC '' '' ...']
                            ['''' class_name '.getr('''''' TAG '''''') must be inizialized to its default value '' ...']
                            ['''given by ' class_name '.getPropDefault('' int2str(prop) ''). '' ...']
                            ['''Or there could be an error in ' class_name '.getr('''''' TAG '''''').''] ...']
                            ')'
                            })
                g(2, 'case Category.RESULT')
                    g(3, 'assert( ...')
                        gs(4, {
                            ['isa(' moniker '.getr(prop), ''NoValue''), ...']
                            ['[BRAPH2.STR '':' class_name ':'' BRAPH2.BUG_FUNC], ...']
                            ['[BRAPH2.STR '':' class_name ':'' BRAPH2.BUG_FUNC '' '' ...']
                            ['''Being a result, ' class_name '.getr('' int2str(prop) '') must be inizialized to NoValue(). '' ...']
                            ['''Or there could be an error in ' class_name '.getr('' int2str(prop) '').''] ...']
                            ')'
                            })
                    g(3, 'assert( ...')
                        gs(4, {
                            ['isa(' moniker '.getr(TAG), ''NoValue''), ...']
                            ['[BRAPH2.STR '':' class_name ':'' BRAPH2.BUG_FUNC], ...']
                            ['[BRAPH2.STR '':' class_name ':'' BRAPH2.BUG_FUNC '' '' ...']
                            ['''Being a result, ' class_name '.getr('''''' TAG '''''') must be inizialized to NoValue(). '' ...']
                            ['''Or there could be an error in ' class_name '.getr('''''' TAG '''''').''] ...']
                            ')'
                            })
            g(1, 'end')
        g(0, 'end')
        g(0, '')
    end

generate_test_2_callbacks()
    function generate_test_2_callbacks()
%         gs(0, {'%% Test 2: Callbacks'; ''})
%         
%         if strcmp(class_name, 'Callback')
%             gs(0, {'% this test is not implemented for Callback'; ''})
%             return
%         end
% 
%         % element
%         g(0, [moniker '_0 = ' class_name '( ...'])
%             for prop = 1:1:prop_number
%                 TAG = upper(eval([class_name '.getPropTag(' int2str(prop) ')']));
%                 if prop < prop_number
%                     g(1, [class_name '.' TAG ', ' class_name '.getPropDefault(' class_name '.' TAG '), ...'])
%                 else
%                     g(1, [class_name '.' TAG ', ' class_name '.getPropDefault(' class_name '.' TAG ') ...'])
%                 end
%             end
%             g(1, ');')
%             g(1, '')
% 
%         % element with 1st callbacks
%         g(0, [moniker '_1 = ' class_name '( ...'])
%             for prop = 1:1:prop_number
%                 TAG = upper(eval([class_name '.getPropTag(' int2str(prop) ')']));
%                 switch eval([class_name '.getPropCategory(' int2str(prop) ')'])
%                     case Category.METADATA
%                         if prop < prop_number
%                             g(1, [class_name '.' TAG ', ' class_name '.getPropDefault(' class_name '.' TAG '), ...'])
%                         else
%                             g(1, [class_name '.' TAG ', ' class_name '.getPropDefault(' class_name '.' TAG ') ...'])
%                         end                    
%                     case {Category.PARAMETER, Category.DATA}
%                         if prop < prop_number
%                             g(1, [class_name '.' TAG ', Callback(''EL'', ' moniker '_0, ''PROP'', ' int2str(prop) '), ...'])
%                         else
%                             g(1, [class_name '.' TAG ', Callback(''EL'', ' moniker '_0, ''PROP'', ' int2str(prop) ') ...'])
%                         end
%                     case Category.RESULT
%                         if prop < prop_number
%                             g(1, [class_name '.' TAG ', NoValue(), ...'])
%                         else
%                             g(1, [class_name '.' TAG ', NoValue() ...'])
%                         end                    
%                 end
%             end
%             g(1, ');')
%             g(1, '')
%         
%         g(0, ['prop_number = ' class_name '.getPropNumber();'])
%         g(0, 'for prop = 1:1:prop_number')
%             g(1, ['TAG = upper(' class_name '.getPropTag(prop));'])
%             g(1, ['switch ' class_name '.getPropCategory(prop)'])
%                 g(2, 'case {Category.PARAMETER, Category.DATA}')
%                     g(3, 'assert( ...')
%                         gs(4, {
%                             ['isa(' moniker '_1.getr(prop),  ''Callback''), ...']
%                             ['[BRAPH2.STR '':' class_name ':'' BRAPH2.BUG_FUNC], ...']
%                             ['[''' class_name '.getr('' int2str(prop) '') must be a callback.''] ...']
%                             ')'
%                             })
%                     g(3, 'assert( ...')
%                         gs(4, {
%                             ['isequal(' moniker '_1.get(prop), ' moniker '_0.get(prop)) && ~isa(' moniker '_1.get(prop), ''Callback''), ...']
%                             ['[BRAPH2.STR '':' class_name ':'' BRAPH2.BUG_FUNC], ...']
%                             ['[''' class_name '.get('' int2str(prop) '') must be the actual property and NOT a callback.''] ...']
%                             ')'
%                             })
%                 g(2, 'case {Category.METADATA, Category.RESULT}')
%                     g(3, 'assert( ...')
%                         gs(4, {
%                             ['~isa(' moniker '_1.getr(prop), ''Callback''), ...']
%                             ['[BRAPH2.STR '':' class_name ':'' BRAPH2.BUG_FUNC], ...']
%                             ['[''' class_name '.getr('' int2str(prop) '') must NOT be a callback.''] ...']
%                             ')'
%                             })
%             g(1, 'end')
%         g(0, 'end')
%         
%         % element with 2nd callbacks
%         g(0, [moniker '_2 = ' class_name '( ...'])
%             for prop = 1:1:prop_number
%                 TAG = upper(eval([class_name '.getPropTag(' int2str(prop) ')']));
%                 switch eval([class_name '.getPropCategory(' int2str(prop) ')'])
%                     case Category.METADATA
%                         if prop < prop_number
%                             g(1, [class_name '.' TAG ', ' class_name '.getPropDefault(' class_name '.' TAG '), ...'])
%                         else
%                             g(1, [class_name '.' TAG ', ' class_name '.getPropDefault(' class_name '.' TAG ') ...'])
%                         end                    
%                     case {Category.PARAMETER, Category.DATA}
%                         if prop < prop_number
%                             g(1, [class_name '.' TAG ', Callback(''EL'', ' moniker '_1, ''PROP'', ' int2str(prop) '), ...'])
%                         else
%                             g(1, [class_name '.' TAG ', Callback(''EL'', ' moniker '_1, ''PROP'', ' int2str(prop) ') ...'])
%                         end
%                     case Category.RESULT
%                         if prop < prop_number
%                             g(1, [class_name '.' TAG ', NoValue(), ...'])
%                         else
%                             g(1, [class_name '.' TAG ', NoValue() ...'])
%                         end                    
%                 end
%             end
%             g(1, ');') 
%             g(1, '')
%         
%         g(0, ['prop_number = ' class_name '.getPropNumber();'])
%         g(0, 'for prop = 1:1:prop_number')
%             g(1, ['TAG = upper(' class_name '.getPropTag(prop));'])
%             g(1, ['switch ' class_name '.getPropCategory(prop)'])
%                 g(2, 'case {Category.PARAMETER, Category.DATA}')
%                     g(3, 'assert( ...')
%                         gs(4, {
%                             ['isa(' moniker '_2.getr(prop),  ''Callback''), ...']
%                             ['[BRAPH2.STR '':' class_name ':'' BRAPH2.BUG_FUNC], ...']
%                             ['[''' class_name '.getr('' int2str(prop) '') must be a callback.''] ...']
%                             ')'
%                             })
%                     g(3, 'assert( ...')
%                         gs(4, {
%                             ['isequal(' moniker '_2.get(prop), ' moniker '_0.get(prop)) && ~isa(' moniker '_1.get(prop), ''Callback''), ...']
%                             ['[BRAPH2.STR '':' class_name ':'' BRAPH2.BUG_FUNC], ...']
%                             ['[''' class_name '.get('' int2str(prop) '') must be the actual property and NOT a callback.''] ...']
%                             ')'
%                             })
%                 g(2, 'case {Category.METADATA, Category.RESULT}')
%                     g(3, 'assert( ...')
%                         gs(4, {
%                             ['~isa(' moniker '_2.getr(prop), ''Callback''), ...']
%                             ['[BRAPH2.STR '':' class_name ':'' BRAPH2.BUG_FUNC], ...']
%                             ['[''' class_name '.getr('' int2str(prop) '') must NOT be a callback.''] ...']
%                             ')'
%                             })
%             g(1, 'end')
%         g(0, 'end')
%         
%         % element with 3rd callbacks
%         g(0, [moniker '_3 = ' class_name '( ...'])
%             for prop = 1:1:prop_number
%                 TAG = upper(eval([class_name '.getPropTag(' int2str(prop) ')']));
%                 switch eval([class_name '.getPropCategory(' int2str(prop) ')'])
%                     case Category.METADATA
%                         if prop < prop_number
%                             g(1, [class_name '.' TAG ', ' class_name '.getPropDefault(' class_name '.' TAG '), ...'])
%                         else
%                             g(1, [class_name '.' TAG ', ' class_name '.getPropDefault(' class_name '.' TAG ') ...'])
%                         end                    
%                     case {Category.PARAMETER, Category.DATA}
%                         if prop < prop_number
%                             g(1, [class_name '.' TAG ', Callback(''EL'', ' moniker '_2, ''PROP'', ' int2str(prop) '), ...'])
%                         else
%                             g(1, [class_name '.' TAG ', Callback(''EL'', ' moniker '_2, ''PROP'', ' int2str(prop) ') ...'])
%                         end
%                     case Category.RESULT
%                         if prop < prop_number
%                             g(1, [class_name '.' TAG ', NoValue(), ...'])
%                         else
%                             g(1, [class_name '.' TAG ', NoValue() ...'])
%                         end                    
%                 end
%             end
%             g(1, ');')
%             g(1, '')
%         
%         g(0, ['prop_number = ' class_name '.getPropNumber();'])
%         g(0, 'for prop = 1:1:prop_number')
%             g(1, ['TAG = upper(' class_name '.getPropTag(prop));'])
%             g(1, ['switch ' class_name '.getPropCategory(prop)'])
%                 g(2, 'case {Category.PARAMETER, Category.DATA}')
%                     g(3, 'assert( ...')
%                         gs(4, {
%                             ['isa(' moniker '_3.getr(prop),  ''Callback''), ...']
%                             ['[BRAPH2.STR '':' class_name ':'' BRAPH2.BUG_FUNC], ...']
%                             ['[''' class_name '.getr('' int2str(prop) '') must be a callback.''] ...']
%                             ')'
%                             })
%                     g(3, 'assert( ...')
%                         gs(4, {
%                             ['isequal(' moniker '_3.get(prop), ' moniker '_0.get(prop)) && ~isa(' moniker '_1.get(prop), ''Callback''), ...']
%                             ['[BRAPH2.STR '':' class_name ':'' BRAPH2.BUG_FUNC], ...']
%                             ['[''' class_name '.get('' int2str(prop) '') must be the actual property and NOT a callback.''] ...']
%                             ')'
%                             })
%                 g(2, 'case {Category.METADATA, Category.RESULT}')
%                     g(3, 'assert( ...')
%                         gs(4, {
%                             ['~isa(' moniker '_3.getr(prop), ''Callback''), ...']
%                             ['[BRAPH2.STR '':' class_name ':'' BRAPH2.BUG_FUNC], ...']
%                             ['[''' class_name '.getr('' int2str(prop) '') must NOT be a callback.''] ...']
%                             ')'
%                             })
%             g(1, 'end')
%         g(0, 'end')
%         g(0, '')
%     end
% 
% generate_test_3_result()
%     function generate_test_3_result()
%         gs(0, {'%% Test 3: Result'; ''})
%         
%         g(0, [moniker ' = ' class_name '( ...'])
%             for prop = 1:1:prop_number
%                 TAG = upper(eval([class_name '.getPropTag(' int2str(prop) ')']));
%                 if prop < prop_number
%                     g(1, [class_name '.' TAG ', ' class_name '.getPropDefault(' class_name '.' TAG '), ...'])
%                 else
%                     g(1, [class_name '.' TAG ', ' class_name '.getPropDefault(' class_name '.' TAG ') ...'])
%                 end
%             end
%             g(1, ');')
%             g(1, '')
%         
%         g(0, ['prop_number = ' class_name '.getPropNumber();'])
%         g(0, 'for prop = 1:1:prop_number')
%             g(1, ['TAG = upper(' class_name '.getPropTag(prop));'])
%             g(1, ['switch ' class_name '.getPropCategory(prop)'])
%                 g(2, 'case {Category.METADATA, Category.PARAMETER, Category.DATA}')
%                 g(2, 'case Category.RESULT')
%                     g(3, 'assert( ...')
%                         gs(4, {
%                             ['~isa(' moniker '.get(prop),  ''NoValue''), ...']
%                             ['[BRAPH2.STR '':' class_name ':'' BRAPH2.BUG_FUNC], ...']
%                             ['[''' class_name '.get('' int2str(prop) '') must NOT be a NoValue, because it should have been calculated.''] ...']
%                             ')'
%                             })
%                     g(3, 'assert( ...')
%                         gs(4, {
%                             ['isa(' moniker '.getr(prop),  ''NoValue''), ...']
%                             ['[BRAPH2.STR '':' class_name ':'' BRAPH2.BUG_FUNC], ...']
%                             ['[''' class_name '.getr('' int2str(prop) '') must be a NoValue, because it has not been memorized.''] ...']
%                             ')'
%                             })                       
%                     g(3, ['if isempty(' moniker '.getPropSettings(prop))'])
%                         g(4, 'assert( ...')
%                             gs(5, {
%                                 [moniker '.checkFormat(' moniker '.getPropFormat(prop), ' moniker '.get(prop)), ...']
%                                 ['[BRAPH2.STR '':' class_name ':'' BRAPH2.BUG_FUNC], ...']
%                                 ['[''' class_name '.get('' int2str(prop) '') returns a value with the wrong format.''] ...']
%                                 ')'
%                                 })
%                     g(3, 'else')
%                         g(4, 'assert( ...')
%                             gs(5, {
%                                 [moniker '.checkFormat(' moniker '.getPropFormat(prop), ' moniker '.get(prop), ' moniker '.getPropSettings(prop)), ...']
%                                 ['[BRAPH2.STR '':' class_name ':'' BRAPH2.BUG_FUNC], ...']
%                                 ['[''' class_name '.get('' int2str(prop) '') returns a value with the wrong format.''] ...']
%                                 ')'
%                                 })
%                     g(3, 'end')
%             g(1, 'end')
%         g(0, 'end')
%         g(0, '')
    end

generate_test_4_memorize()
    function generate_test_4_memorize()
%         gs(0, {'%% Test 4: Memorize'; ''})
% 
%         g(0, [moniker ' = ' class_name '( ...'])
%             for prop = 1:1:prop_number
%                 TAG = upper(eval([class_name '.getPropTag(' int2str(prop) ')']));
%                 if prop < prop_number
%                     g(1, [class_name '.' TAG ', ' class_name '.getPropDefault(' class_name '.' TAG '), ...'])
%                 else
%                     g(1, [class_name '.' TAG ', ' class_name '.getPropDefault(' class_name '.' TAG ') ...'])
%                 end
%             end
%             g(1, ');')
%             g(1, '')
%         
%         g(0, ['prop_number = ' class_name '.getPropNumber();'])
%         g(0, 'for prop = 1:1:prop_number')
%             g(1, ['TAG = upper(' class_name '.getPropTag(prop));'])
%             g(1, ['switch ' class_name '.getPropCategory(prop)'])
%                 g(2, 'case {Category.METADATA, Category.PARAMETER, Category.DATA}')
%                 g(2, 'case Category.RESULT')
%                     g(3, 'assert( ...')
%                         gs(4, {
%                             ['~isa(' moniker '.memorize(prop),  ''NoValue''), ...']
%                             ['[BRAPH2.STR '':' class_name ':'' BRAPH2.BUG_FUNC], ...']
%                             ['[''' class_name '.memorize('' int2str(prop) '') must NOT be a NoValue, because it should have been calculated.''] ...']
%                             ')'
%                             })
%                     g(3, 'assert( ...')
%                         gs(4, {
%                             ['~isa(' moniker '.getr(prop),  ''NoValue''), ...']
%                             ['[BRAPH2.STR '':' class_name ':'' BRAPH2.BUG_FUNC], ...']
%                             ['[''' class_name '.getr('' int2str(prop) '') must NOT be a NoValue, because it should have been memorized.''] ...']
%                             ')'
%                             })
%                     g(4, 'assert( ...')
%                         gs(5, {
%                             [moniker '.checkFormat(' moniker '.getPropFormat(prop), ' moniker '.getr(prop),' moniker '.getPropSettings(prop)), ...']
%                             ['[BRAPH2.STR '':' class_name ':'' BRAPH2.BUG_FUNC], ...']
%                             ['[''' class_name '.getr('' int2str(prop) '') returns a value with the wrong format.''] ...']
%                             ')'
%                             })
%             g(1, 'end')
%         g(0, 'end')
%         g(0, '')
    end

% generate_tests()
%     function generate_tests()    
%         test_number = 4;
%         for i = 1:1:numel(tests)
%             test_number = test_number + 1;
%             gs(0, {['%% Test ' int2str(test_number) ': ' tests{i}.name]; ''})
%             gs(0, tests{i}.code)
%             g(0, '')
%         end
%     end

fclose(object_file);    

disp(['¡! saved file: ' target_file])
disp(' ')

%% Help functions
    function g(tabs, str)
        str = regexprep(str, '%', '%%');
        fprintf(object_file, [repmat('\t', 1, tabs) str '\n']);
    end
    function gs(tabs, lines)
        for i = 1:1:length(lines)
            g(tabs, lines{i})
        end
    end
end