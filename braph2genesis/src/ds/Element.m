classdef Element < Category & Format & matlab.mixin.Copyable
    %Element is the base class for all elements.
    % Even though it is possible to create instances of Element, typically
    %  one uses its subclasses. It is a subclass of Category, Format,
    %  handle, and matlab.mixin.Copyable.
    %
    % See also Category, Format, NoValue, Callback, IndexedDictionary, handle, matlab.mixin.Copyable.

    properties (Access=private)
        % props is a prvate struct containing the element properties whose
        % details depend on the property category (YOCO, YADIR):
        %
        % METADATA:
        % props{prop}.value     - value
        % props{prop}.seed      - seed for rng
        % props{prop}.check     - true/false
        % props{prop}.locked    - false/true
        %
        % PARAMETER, DATA:
        % props{prop}.value     - NoValue() or value or Callback()
        % props{prop}.seed      - seed for rng
        % props{prop}.check     - true/false
        % props{prop}.locked    - false/true
        %
        % RESULT:
        % props{prop}.value     - NoValue() or value
        % props{prop}.seed      - seed for rng
        % props{prop}.check     - true/false
        % props{prop}.locked    - false/true
        %
        % The parameter and data properties of the element get locked the
        % first time a result is successfully calculated.
        props
    end
    methods (Static) % inspection
        function el_class = getClass(el)
			%GETCLASS returns the class of the element.
			%
            % CLASS = Element.GETCLASS() returns the class 'Element'.
            % 
            % Alternative forms to call this method are:
			%  CLASS = GETCLASS(EL) returns the class of the element EL.
            %  CLASS = EL.GETCLASS() returns the class of the element EL.
			%  CLASS = Element.GETCLASS(CLASS) returns CLASS.
			%  CLASS = EL.GETCLASS(CLASS) returns CLASS.
			%
			% See also getName, getDescription.

            % calls from Element
            if nargin < 1
                el_class = 'Element';
                return
            end
            
            % calls from subclasses of Element
            if isa(el, 'Element')
                el_class = class(el);
            else % el should be a string with the element class
                el_class = el;
                assert( ...
                    exist(el_class, 'class') == 8, ...
                    [BRAPH2.STR ':Element:' BRAPH2.WRONG_INPUT], ...
                    [BRAPH2.STR ':Element:' BRAPH2.WRONG_INPUT ' ' ...
                    'The value ' tostring(el, 100, '...') 'is not a valid class name.'] ...
                    )
            end
        end
        function el_name = getName(el)
			%GETNAME returns the name of the element.
			%
            % NAME = Element.GETNAME() returns the name of the element,
            %  which in this case is 'Base class for all elements.'
            % 
            % Alternative forms to call this method are:
			%  NAME = GETNAME(EL) returns the name of the element EL.
            %  NAME = EL.GETNAME() returns the name of the element EL.
			%  NAME = Element.GETNAME(CLASS) returns the name of CLASS.
			%  NAME = EL.GETNAME(CLASS) returns the name of CLASS.
			%
			% See also getClass, getDescription.

            % calls from Element
            if nargin < 1
                el_name = 'Base class for all elements.';
                return
            end
            
            % calls from subclasses of Element
            el_name = eval([Element.getClass(el) '.getName()']);
        end
        function el_description = getDescription(el)
			% GETNAME returns the description of the element.
			%
            % STR = Element.GETDESCRIPTION() returns the description of the element,
            %  which in this case is:
            %
            %  Element is the base class for all elements. 
            %  Even though it is possible to create instances of Element, 
            %  typically one uses its subclasses.
            %
            % Alternative forms to call this method are:
			%  STR = GETDESCRIPTION(EL) returns the description of the element EL.
            %  STR = EL.GETDESCRIPTION() returns the description of the element EL.
			%  STR = Element.GETDESCRIPTION(CLASS) returns the description of CLASS.
			%  STR = EL.GETDESCRIPTION(CLASS) returns the description of CLASS.
			%
			% See also getClass, getName.

            % calls from Element
            if nargin < 1
                el_description = [ ...
                    'Element is the base class for all elements. ' ...
                    'Even though it is possible to create instances of Element, ' ...
                    'typically one uses its subclasses.' ...
                    ];
                return
            end
            
            % calls from subclasses of Element
            el_description = eval([Element.getClass(el) '.getDescription()']);
        end
        function prop_list = getProps(el, category)
			% GETPROPS returns the property list of an element.
			%
            % PROPS = Element.GETPROPS() returns the property list of Element.
            %
            % PROPS = Element.GETPROPS(CATEGORY) returns the property list
            %  of category CATEGORY.
            %
            % Alternative forms to call this method are:
			%  PROPS = GETPROPS(EL[, CATEGORY]) returns the property list of element EL.
            %  PROPS = EL.GETPROPS([CATEGORY]) returns the property list of element EL.
			%  PROPS = Element.GETPROPS(CLASS[, CATEGORY]) returns the property list of CLASS.
			%  PROPS = EL.GETPROPS(CLASS[, CATEGORY]) returns the property list of CLASS.
			%
			% See also getPropNumber.
            
            % calls from Element
            if nargin < 1 % no arguments
                prop_list = [];
                return
            elseif nargin == 1 && Category.existsCategory(el) % category argument
                prop_list = [];                
                return
            end
            
            % calls from subclasses of Element
            if nargin < 2
                prop_list = eval([Element.getClass(el) '.getProps()']);
            else
                Category.existsCategory(category);
                
                prop_list = eval([Element.getClass(el) '.getProps(category)']);
            end
        end
        function prop_number = getPropNumber(el)
			% GETPROPNUMBER returns the property number of an element.
			%
            % N = Element.GETPROPNUMBER() returns the number of properties in Element.
            %
            % Alternative forms to call this method are:
			%  N = GETPROPNUMBER(EL) returns the property number of element EL.
            %  N = EL.GETPROPNUMBER() returns the property number of element EL.
			%  N = Element.GETPROPNUMBER(CLASS) returns the property number of CLASS.
			%  N = EL.GETPROPNUMBER(CLASS) returns the property number of CLASS.
			%
			% See also getProps.
            
            % calls from Element
            if nargin < 1
                prop_number = 0;
                return
            end
            
            % calls from subclasses of Element
            prop_number = eval([Element.getClass(el) '.getPropNumber()']);
        end
        function check = existsProp(el, prop)
            %EXISTSPROP checks whether property exists/error.
			%
            % CHECK = Element.EXISTSPROP(PROP) checks whether the property 
            %  PROP exists.
            %
            % Alternative forms to call this method are:
            %  CHECK = EXISTSPROP(EL, PROP) checks PROP for EL.
            %  CHECK = EL.EXISTSPROP(PROP) checks PROP for EL.
            %  CHECK = Element.EXISTSPROP(CLASS, PROP) checks PROP for CLASS.
            %  CHECK = EL.EXISTSPROP(CLASS, PROP) checks PROP for CLASS.
            % 
            % Element.EXISTSPROP(PROP) throws an error if the PROP does NOT
            %  exist.
            %  Error id: [BRAPH2:Element:WrongInput]
			%
            % Alternative forms to call this method are:
            %  EXISTSPROP(EL, PROP) throws error if PROP does NOT exist for EL.
            %   Error id: [BRAPH2:Element:WrongInput]
            %  EL.EXISTSPROP(PROP) throws error if PROP does NOT exist for EL.
            %   Error id: [BRAPH2:Element:WrongInput]
            %  Element.EXISTSPROP(CLASS, PROP) throws error if PROP does NOT exist for EL.
            %   Error id: [BRAPH2:CLASS:WrongInput]
            %  EL.EXISTSPROP(CLASS, PROP) throws error if PROP does NOT exist for EL.
            %   Error id: [BRAPH2:CLASS:WrongInput]
            %
			% See also getProps, existsTag.
            
            % calls from Element
            if nargin < 2
                prop = el;
                el = 'Element';
            end
            
            % calls from subclasses of Element
            if nargout == 1
                check = any(prop == Element.getProps(el));
            else
                assert( ...
                    Element.existsProp(el, prop), ...
                    [BRAPH2.STR ':Element:' BRAPH2.WRONG_INPUT], ...
                    [BRAPH2.STR ':Element:' BRAPH2.WRONG_INPUT ' ' ...
                    'The value ' tostring(prop) ' is not a valid prop for ' Element.getClass(el) '.'] ...
                    )
            end
        end
        function check = existsTag(el, tag)
            %EXISTSTAG checks whether tag exists/error.
			%
            % CHECK = Element.EXISTSTAG(TAG) checks whether tag TAG exists.
            %
            % Alternative forms to call this method are:
            %  CHECK = EXISTSTAG(EL, TAG) checks tag TAG for EL.
            %  CHECK = EL.EXISTSTAG(TAG) checks tag TAG for EL.
            %  CHECK = Element.EXISTSTAG(CLASS, TAG) checks tag TAG for EL.
            %  CHECK = EL.EXISTSTAG(CLASS, TAG) checks tag TAG for EL.
            %
            % Element.EXISTSTAG(PROP) throws an error if the TAG NOT exist.
            %  Error id: [BRAPH2:Element:WrongInput]
            %
            % Alternative forms to call this method are:
            %  EXISTSTAG(EL, TAG) throws error if TAG does NOT exist for EL.
            %   Error id: [BRAPH2:Element:WrongInput]
            %  EL.EXISTSTAG(TAG) throws error if TAG does NOT exist for EL.
            %   Error id: [BRAPH2:Element:WrongInput]
            %  Element.EXISTSTAG(CLASS, TAG) throws error if TAG does NOT 
            %   exist for EL. Error id: [BRAPH2:Element:WrongInput]
            %  Element.EXISTSTAG(CLASS, TAG) throws error if TAG does NOT 
            %   exist for EL. Error id: [BRAPH2:Element:WrongInput] 
            %
			% See also getProps, existsProp.
            
            % calls from Element
            if nargin < 2
                tag = el;
                el = 'Element';
            end
            
            % calls from subclasses of Element
            if nargout == 1
                tag_list = cellfun(@(x) Element.getPropTag(el, x), num2cell(Element.getProps(el)'), 'UniformOutput', false);
                check = any(strcmpi(tag, tag_list));
            else
                assert( ...
                    Element.existsTag(el, tag), ...
                    [BRAPH2.STR ':Element:' BRAPH2.WRONG_INPUT], ...
                    [BRAPH2.STR ':Element:' BRAPH2.WRONG_INPUT ' ' ...
                    'The value ''' tag ''' is not a valid tag for ' Element.getClass(el) '.'] ...
                    )
            end
        end
        function prop_prop = getPropProp(el, pointer) %#ok<INUSD>
            % pointer can be prop/tag
            
            % calls from Element
            if nargin < 2
                pointer = el; %#ok<NASGU>
                el = 'Element';
            end
            
            % calls from subclasses of Element
            prop_prop = eval([Element.getClass(el) '.getPropProp(pointer)']);
        end       
        function prop_tag = getPropTag(el, pointer) %#ok<INUSD>
            % pointer can be prop/tag
            
            % calls from Element
            if nargin < 2
                pointer = el; %#ok<NASGU>
                el = 'Element';
            end
            
            % calls from subclasses of Element
            prop_tag = eval([Element.getClass(el) '.getPropTag(pointer)']);
        end
        function prop_category = getPropCategory(el, pointer) %#ok<INUSD>
            
            % calls from Element
            if nargin < 2
                pointer = el; %#ok<NASGU>
                el = 'Element';
            end
            
            % calls from subclasses of Element
            prop_category = eval([Element.getClass(el) '.getPropCategory(pointer)']);
        end
        function prop_format = getPropFormat(el, pointer) %#ok<INUSD>
            % GETPROPFORMAT returns the format of a property.
			%
            % FORMAT = Element.GETPROPFORMAT(PROP) returns the format of
            %  property PROP.
            %
            % FORMAT = Element.GETPROPFORMAT(TAG) returns the format of
            %  the property with tag TAG.
            %
            % Alternative forms to call this method are (POINTER = PROP or TAG):
            %  FORMAT = GETPROPFORMAT(EL, POINTER) returns format of POINTER of EL.
            %  FORMAT = EL.GETPROPFORMAT(POINTER) returns format of POINTER of EL.
			%  FORMAT = Element.GETPROPFORMAT(CLASS, POINTER) returns format of POINTER of CLASS.
			%  FORMAT = EL.GETPROPFORMAT(CLASS, POINTER) returns format of POINTER of CLASS.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.

            % calls from Element
            if nargin < 2
                pointer = el; %#ok<NASGU>
                el = 'Element';
            end
            
            % calls from subclasses of Element
            prop_format = eval([Element.getClass(el) '.getPropFormat(pointer)']);
        end
        function prop_description = getPropDescription(el, pointer) %#ok<INUSD>
            % GETPROPDESCRIPTION returns the description of a property.
			%
            % DESCRIPTION = Element.GETPROPDESCRIPTION(PROP) returns the 
            %  description of the property PROP.
            %
            % DESCRIPTION = Element.GETPROPDESCRIPTION(TAG) returns the
            %  description of the property with tag TAG.
            %
            % Alternative forms to call this method are (POINTER = PROP or TAG):
            %  DESCRIPTION = GETPROPDESCRIPTION(EL, POINTER) returns description of POINTER of EL.
            %  DESCRIPTION = EL.GETPROPDESCRIPTION(POINTER) returns description of POINTER of EL.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(CLASS, POINTER) returns description of POINTER of CLASS.
			%  DESCRIPTION = EL.GETPROPDESCRIPTION(CLASS, POINTER) returns description of POINTER of CLASS.
            %
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
            
            % calls from Element
            if nargin < 2
                pointer = el; %#ok<NASGU>
                el = 'Element';
            end
            
            % calls from subclasses of Element
            prop_description = eval([Element.getClass(el) '.getPropDescription(pointer)']);
        end 
        function prop_settings = getPropSettings(el, pointer) %#ok<INUSD>
            % GETPROPSETTINGS returns the settings of a property.
			%
            % SETTINGS = Element.GETPROPSETTINGS(PROP) returns the 
            %  settings of the property PROP.
            %
            % SETTINGS = Element.GETPROPSETTINGS(TAG) returns the
            %  settings of the property with tag TAG.
            %
            % Alternative forms to call this method are (POINTER = PROP or TAG):
            %  SETTINGS = GETPROPSETTINGS(EL, POINTER) returns settings of POINTER of EL.
            %  SETTINGS = EL.GETPROPSETTINGS(POINTER) returns settings of POINTER of EL.
			%  SETTINGS = Element.GETPROPSETTINGS(CLASS, POINTER) returns settings of POINTER of CLASS.
			%  SETTINGS = EL.GETPROPSETTINGS(CLASS, POINTER) returns settings of POINTER of CLASS.
            %
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
            
            % calls from Element
            if nargin < 2
                pointer = el; %#ok<NASGU>
                el = 'Element';
            end
            
            % calls from subclasses of Element
            prop_settings = eval([Element.getClass(el) '.getPropSettings(pointer)']);
        end 
        function prop_default = getPropDefault(el, pointer) %#ok<INUSD>
            %GETPROPDEFAULT returns the default value of a property/tag.
			%
            % PROPDEFAULT = Element.GETPROPDEFAULT(POINTER) returns the default 
            %  value of Element.
            %
            % PROPDEFAULT = Element.GETPROPDEFAULT(EL, POINTER) returns the default 
            %  value of a property/tag.
            % 
            % Alternative forms to call this method are:
			%  PROPDEFAULT = EL.GETPROPDEFAULT(POINTER) returns the default value of a property/tag.
            %  PROPDEFAULT = EL.GETPROPDEFAULT(CLASS, POINTER) returns the default value of a property/tag.
			%
			% See also getPropSettings, getPropDescription.

            % calls from Element
            if nargin < 2
                pointer = el; %#ok<NASGU>
                el = 'Element';
            end
            
            % calls from subclasses of Element
            prop_default = eval([Element.getClass(el) '.getPropDefault(pointer)']);
        end
        function prop_check = checkProp(el, pointer, value, varargin) %#ok<INUSD>
            %CHECKPROP returns whether  the property/tag is in the correct format.
			%
            % PROPCHECK = Element.GETPROPDEFAULT(EL, POINTER, VALUE) returns
            %  whether the property/tag is in the correct format.
            % 
            % Alternative forms to call this method are:
			%  PROPCHECK = EL.GETPROPDEFAULT(POINTER, VALUE) returns whether  the property/tag is in the correct format.
			%
			% See also getPropSettings, getPropDefault.

            if nargout == 1
                prop_check = eval([Element.getClass(el) '.checkProp(pointer, value)']);
            else
                eval([Element.getClass(el) '.checkProp(pointer, value)']);
            end
        end
    end
    methods % constructor
        function el = Element(varargin)
            % varargin = {prop/tag, value, ...}
            
%             % undocumented trick to avoid inizialization of props             
%             % (e.g. when deep-copying or cloning)
%             % by having a single value in the varargin
%             if length(varargin) == 1
%                 return
%             end
% 
%             % prop -> tag
%             for i = 1:2:length(varargin)
%                 if isnumeric(varargin{i})
%                     prop = varargin{i};
%                     tag = el.getPropTag(prop);
%                     varargin{i} = tag;
%                 end
%             end
%             
%             propvalues = cell(1, el.getPropNumber());
%             for prop = 1:1:el.getPropNumber()
%                 
%                 tag = el.getPropTag(prop);
%                 
%                 switch el.getPropCategory(prop)
%                     case {Category.METADATA, Category.PARAMETER, Category.DATA}
%                         default = el.getPropDefault(prop);
%                         value = get_from_varargin(default, tag, varargin);
%                         
%                     case Category.RESULT
%                         default = NoValue();
%                         value = NoValue();
%                 end
%                 
%                 propvalues{2 * prop - 1} = tag;
%                 propvalues{2 * prop} = value;
%                 
%                 el.props{prop}.value = default;
%                 el.props{prop}.locked = false;
%             end
%             
%             rng('shuffle', 'twister')
%             el.seed()
% 
%             el.set(propvalues{:})
        end
    end
    methods % set/check/get value
%         function set(el, varargin)
%             % varargin = {prop/tag, value, ...}
% 
%             props_backup = el.props; % props backup
%             
%             for i = 1:2:length(varargin)
%                 prop = el.getPropProp(varargin{i});
%                 value = varargin{i+1};
%                 
%                 Element.existsProp(el, prop)
%                 
%                 switch el.getPropCategory(prop)
%                     case Category.METADATA
%                         el.checkProp(prop, value)
%                         
%                         el.props{prop}.value = value;
%                         
%                     case {Category.PARAMETER, Category.DATA}
%                         if ~el.isLocked(prop)
%                             if isa(value, 'Callback')
%                                 if ~isequal(el.getPropFormat(prop), value.get('EL').getPropFormat(value.get('PROP')))
%                                     warning( ...
%                                         [BRAPH2.STR ':' class(el)], ...
%                                         [class(el) ': Different formats for a prop (' el.getPropFormat(prop) ') ' ...
%                                         'and a callback (' value.get('EL').getPropFormat(value.get('PROP')) '). ' ...
%                                         'This is not necessarily an problem.'] ...
%                                         )
%                                 elseif  ~isequal(el.getPropSettings(prop), value.get('EL').getPropSettings(value.get('PROP')))
%                                     warning( ...
%                                         [BRAPH2.STR ':' class(el)], ...
%                                         [class(el) ': Different format settings for a prop (' el.getPropFormat(prop) ', ' tostring(el.getPropSettings(prop)) ') ' ...
%                                         'and a callback (' value.get('EL').getPropFormat(value.get('PROP')) ', ' tostring(value.get('EL').getPropSettings(value.get('PROP'))) '). ' ...
%                                         'This is not necessarily an problem.'] ...
%                                         )                                
%                                 end
% 
%                                 el.props{prop}.value = value;
%                             else
%                                 el.checkProp(prop, value)
% 
%                                 el.props{prop}.value = value;
%                             end
%                         else
%                             warning( ...
%                                 [BRAPH2.STR ':' class(el)], ...
%                                 [class(el) ': Attempt to set the values of a LOCKED property (' el.getPropTag(prop) '), which was obviously not done. ' ...
%                                 'Hopefully this won''t create probblems, but your code shouldn''t let this happen!'] ...
%                                 )                            
%                         end
%                        
%                     case Category.RESULT
%                         if isa(value, 'NoValue')
%                             el.props{prop}.value = value;
%                         else
%                             warning( ...
%                                 [BRAPH2.STR ':' class(el)], ...
%                                 [class(el) ': Rightfully unsuccessful attempt to set result (' el.getPropTag(prop) ') to a value. ' ...
%                                 'Probably not a problem, but shouldn''t happen with well-written code!'] ...
%                                 )
%                         end
%                 end
%             end
%             
%             [check, msg] = el.check();
%             if ~check
%                 el.props = props_backup; % restore props backup
%                 error( ...
%                     [BRAPH2.STR ':' class(el) ':' BRAPH2.WRONG_INPUT], ...
%                     [class(el) ': Wrong inputs: ' msg '\n' ...
%                     'The value of this ' class(el) ' has been restored, \n' ...
%                     'so you can keep on working if you are using command line. \n' ...
%                     'Nevertheless, there might be problems, so better you check your code!'] ...
%                     )
%             end
%         end
%         function [element_check, element_msg] = check(el, varargin)
% 
%             value_checks = ones(el.getPropNumber(), true);
%             value_msgs = repmat({''}, el.getPropNumber(), 1);
%             for prop = 1:1:el.getPropNumber()
%                 value = el.getr(prop);
%                 switch el.getPropCategory(prop)
%                     case Category.METADATA
%                         [value_check, value_msg] = el.checkValue(prop, value);
%                     
%                     case {Category.PARAMETER, Category.DATA}
%                         while isa(value, 'Callback')
%                             value = value.get('EL').get(value.get('PROP'));
%                         end
%                         if ~isa(value, 'NoValue')
%                             [value_check, value_msg] = el.checkValue(prop, value);
%                         else % NoValue()
%                             value_check = true;
%                             value_msg = '';
%                         end
%                         
%                     case Category.RESULT
%                         if ~isa(value, 'NoValue')
%                             [value_check, value_msg] = el.checkValue(prop, value);
%                         else % NoValue()
%                             value_check = true;
%                             value_msg = '';
%                         end
%                 end
%                 value_checks(prop) = value_check;
%                 if ~value_check
%                     value_msgs{prop} = value_msg;
%                 end
%             end
%             check = all(value_checks);
%             msg = join(value_msgs);
%             msg = strtrim(msg{1});
%             
%             if nargout >= 1
%                 element_check = check;
%                 element_msg = msg;
%             else
%                 assert( ...
%                     check, ...
%                     [BRAPH2.STR ':' el.getClass() ':' BRAPH2.BUG_ERR], ...
%                     msg ...
%                     )
%             end
%         end
%         function value = getr(el, pointer)
%             % prop can also be tag
%             
%             prop = el.getPropProp(pointer);
%             
%             Element.existsProp(el, prop)
%             
%             value = el.props{prop}.value; % raw element value
%         end
%         function value = get(el, pointer)
%             % prop can also be tag
% 
%             prop = el.getPropProp(pointer);
%             
%             props_backup = el.props; % props backup
% 
%             value = el.getr(prop);
%             
%             switch el.getPropCategory(prop)
%                 case Category.METADATA
%                     % nothing needs to be done
%                     
%                 case {Category.PARAMETER, Category.DATA}
%                     if isa(value, 'Callback')
%                         value = value.get(Callback.EL).get(value.get(Callback.PROP));
%                     end
%                     
%                 case Category.RESULT
%                     if isa(value, 'NoValue')
%                         value = el.calculateValue(prop);
% 
%                         [check, msg] = el.check();
%                         if check
%                             el.lock()
%                         else
%                             el.props = props_backup; % restore props backup
%                             value = el.props{prop}.value; % value is also set to the original NoValue()
%                             warning( ...
%                                 [BRAPH2.STR ':' class(el)], ...
%                                 [class(el) ': Wrong results: ' msg '\n' ...
%                                 'The value of this ' class(el) ' has been restored,\n' ...
%                                 'but there might be problems, so better you check your code!'] ...
%                                 )
%                         end
%                     end
%                 
%             end
%         end
%         function value = memorize(el, pointer)
%             % prop can also be tag
% 
%             prop = el.getPropProp(pointer);
%             
%             value = el.get(prop);
% 
%             if isequal(el.getPropCategory(prop), Category.RESULT)
%                 el.props{prop}.value = value;
%             end
%         end
%         function lock(el, pointer)
%             % prop can also be tag
% 
%             if nargin < 2
%                 for prop = 1:1:el.getPropNumber()
%                     if any(strcmp(el.getPropCategory(prop), {Category.PARAMETER, Category.DATA}))
%                         el.lock(prop)
%                     end
%                 end
%             else
%                 if ~el.isLocked(pointer) % This condition is for computational efficiency 
%                                          % TODO: check that this is fully correct
% 
%                     prop = el.getPropProp(pointer);
% 
%                     el.props{prop}.locked = true;
% 
%                     value = el.getr(prop);
%                     if isa(value, 'Element')
%                         value.lock();
%                     elseif iscell(value) && all(cellfun(@(x) isa(x, 'Element'), value))
%                         cellfun(@(x) x.lock(), value)
%                     end
%                 end
%             end
%         end
%         function locked = isLocked(el, pointer)
%             % prop can also be tag
% 
%             prop = el.getPropProp(pointer);
%             
%             locked = el.props{prop}.locked;
%         end
%         function seed = getPropSeed(el, pointer)
%             
%             prop = el.getPropProp(pointer);
% 
%             seed = el.props{prop}.seed;
%         end
    end
    methods % operators
%         function check = isequal(el1, el2)
%             
%             check = isa(el2, el1.getClass());
%             
%             if check
%                 for prop = 1:1:el1.getPropNumber()
%                     check = check && isequal(el1.getr(prop), el2.getr(prop)) && (el1.isLocked(prop) == el2.isLocked(prop));
%                 end
%             end
%         end
    end
    methods (Access=private) % unlock/seed
%         function unlock(el, pointer)
%             % prop can also be tag
% 
%             if nargin < 2
%                 for prop = 1:1:el.getPropNumber()
%                     if any(strcmp(el.getPropCategory(prop), {Category.PARAMETER, Category.DATA}))
%                         el.unlock(prop)
%                     end
%                 end
%             else
%                 prop = el.getPropProp(pointer);
% 
%                 el.props{prop}.locked = false;
%                 
%                 value = el.getr(prop);
%                 if isa(value, 'Element')
%                     value.unlock();
%                 elseif iscell(value) && all(cellfun(@(x) isa(x, 'Element'), value))
%                     cellfun(@(x) x.unlock(), value)
%                 end
%             end
%         end
%         function seed(el)
%             
%             prop_number = el.getPropNumber();
%             
%             if prop_number > 0
%                 for prop = 1:1:el.getPropNumber()
%                     el.props{prop}.seed = randi(intmax('uint32'));
%                 end
%             end
%         end
    end
    methods (Access=protected) % check value
%         function [value_check, value_msg] = checkValue(el, prop, value) %#ok<INUSD>
%             value_check = true;
%             value_msg = ['Error while checking ' tostring(el) ' ' el.getPropTag(prop) '.'];
%         end
    end
    methods (Access=protected) % calculate value
%         function value = calculateValue(el, prop)
%             value = el.props{prop}.value;
%         end
    end
    methods % display
%         function str = tostring(el, varargin)
%             if el.getPropNumber() > 0
%                 % str = char(join([class(el) 'with properties' cellfun(@(prod) el.getPropTag(prod), num2cell(Element.getProps(el)'), 'UniformOutput', false)]));
%                 str = [class(el) ' with ' int2str(el.getPropNumber()) ' properties ' el.getPropTag(1) ' = ' tostring(el.get(1)) '.'];
%             else
%                 str = [class(el) ' without properties.'];
%             end
%             str = tostring(str, varargin{:});
%             str = str(2:1:end-1);
%         end
%         function disp(el)
% 
%             disp(['<a href="matlab:help ' class(el) '">' class(el) '</a>']);
% 
%             for prop = 1:1:el.getPropNumber()
%                 if ~el.isLocked(prop)
%                     disp([upper(el.getPropTag(prop)) ...
%                         ' (' ...
%                         Category.getCategoryName(el.getPropCategory(prop)) ...
%                         ', ' ...
%                         Format.getFormatName(el.getPropFormat(prop)) ...
%                         ') = ' ...
%                         tostring(el.getr(prop))])
%                 else % prop locked
%                     disp([upper(el.getPropTag(prop)) ...
%                         ' (' ...
%                         Category.getCategoryName(el.getPropCategory(prop)) ...
%                         ', ' ...
%                         Format.getFormatName(el.getPropFormat(prop)) ...
%                         ', locked' ...
%                         ') = ' ...
%                         tostring(el.getr(prop))])
%                 end
%             end
%         end
%         function txt_output = tree(el, level, prop_list, n, ending)
%                         
%             if nargin < 5
%                 ending = ' ...';
%             end
% 
%             if nargin < 4 || isempty(n)
%                 n = 100;
%             end
% 
%             if nargin < 3 || isempty(prop_list)
%                 prop_list = 1:1:el.getPropNumber();
%             end
%             
%             if nargin < 2 || isempty(level)
%                 level = 0;
%             end
%             
%             txt_el = sprintf(['<strong>' class(el) '</strong>\n']);
%             
%             for prop = prop_list
%                 category = el.getPropCategory(prop);
%                 format = el.getPropFormat(prop);
%                 value = el.getr(prop);
%                 
%                 if el.isLocked(prop)
%                     txt_locked = ['<strong>' char(254) '</strong> '];
%                 else
%                     txt_locked = '  ';
%                 end
%                 
%                 txt_el = [txt_el ...
%                     sprintf([ ...
%                     int2str(prop) ' ' ...
%                     category ' ' ...
%                     format ...
%                     '\t' upper(el.getPropTag(prop)) ...
%                     '\t' txt_locked ...
%                     '\t' int2str(el.getPropSeed(prop)) ...
%                     '\t' tostring(value, n, ending) ...
%                     '\n'])]; %#ok<AGROW>
%                 
%                 if level > 0
%                     if isa(value, 'Callback')
%                         cb = value;
%                         cb_element = cb.get('el');
%                         cb_prop = cb.get('prop');
%                         txt_cd = cb_element.tree(level - 1, cb_prop, n, ending);
%                         lines = splitlines(txt_cd);
%                         for i = 1:1:length(lines)
%                             txt_el = [txt_el ...
%                                 sprintf(['  ' lines{i} '\n']) ... % indent
%                                 ]; %#ok<AGROW>
%                         end
%                     elseif isa(value, 'Element')
%                         value_el = value;
%                         txt_value_el = value_el.tree(level - 1, [], n, ending);
%                         lines = splitlines(txt_value_el);
%                         for i = 1:1:length(lines)
%                             txt_el = [txt_el ...
%                                 sprintf(['  ' lines{i} '\n']) ... % indent
%                                 ]; %#ok<AGROW>
%                         end                    
%                     elseif iscell(value) && all(cellfun(@(x) isa(x, 'Element'), value))
%                         for i = 1:1:length(value)
%                             txt_el = [txt_el ...
%                                 sprintf(['  index:<strong>' int2str(i) '</strong> item:']) ... % indent
%                                 ]; %#ok<AGROW>
%                             txt_value_dict_i = value{i}.tree(level - 1, [], n, ending);
%                             lines = splitlines(txt_value_dict_i);
%                             txt_el = [txt_el ...
%                                 sprintf([lines{1} '\n']) ...
%                                 ]; %#ok<AGROW>
%                             for j = 2:1:length(lines)
%                                 txt_el = [txt_el ...
%                                     sprintf(['  ' lines{j} '\n']) ... % indent
%                                     ]; %#ok<AGROW>
%                             end
%                         end
%                     end
%                 end
%             end
%             
%             txt_el = txt_el(1:end - 1); % eliminates last carriage return
% 
%             if nargout == 1
%                 txt_output = txt_el;
%             else
%                 disp(txt_el)
%             end
%         end
    end
    methods % el_list
%         function el_list = getElementList(el, el_list)
% 
%             if nargin < 2
%                 el_list = {};
%             end
%             
%             if all(cellfun(@(x) el ~= x, el_list))
%                 el_list = [el_list(:); {el}];
%             end
%             
%             for prop = 1:1:el.getPropNumber()
%                 value = el.getr(prop);
%                 
%                 if isa(value, 'Element')
%                     el_list = value.getElementList(el_list);
%                 elseif iscell(value) && all(cellfun(@(x) isa(x, 'Element'), value))
%                     for i = 1:1:length(value)
%                         el_list = value{i}.getElementList(el_list);
%                     end
%                 end
%             end
%         end        
    end
    methods % encodeJSON
%         function [json, struct, el_list] = encodeJSON(el) %#ok<STOUT>
%             
%             el_list = el.getElementList();
%             
%             for i = 1:1:length(el_list)
%                 el = el_list{i};
%                 
%                 eval(['struct{i}.class = ''' el.getClass() ''';'])
%                 
%                 for prop = 1:1:el.getPropNumber()
%                     value = el.getr(prop);
%                     
%                     switch el.getPropFormat(prop)
%                         case {Format.EMPTY, Format.STRING, Format.OPTION, Format.CLASS}
%                             json_str = regexprep(tostring(value), '''', '''''');
%                         case {Format.LOGICAL, Format.SCALAR, Format.RVECTOR, Format.CVECTOR, Format.MATRIX, Format.SMATRIX}
%                             json_str = mat2str(value);
%                         case Format.CLASSLIST
%                             json_str = '{';
%                             for j = 1:1:length(value)
%                                 json_str = [json_str ' ''' value{j} ''' ']; %#ok<AGROW>
%                             end
%                             json_str = [json_str '}']; %#ok<AGROW>
%                             json_str = regexprep(tostring(json_str), '''', '''''');
%                         case {Format.ITEM, Format.IDICT}
%                             json_str = int2str(find(cellfun(@(x) value == x, el_list)));
%                         case Format.ITEMLIST
%                             indices = zeros(1, length(value));
%                             for j = 1:1:length(value)
%                                 indices(j) = find(cellfun(@(x) value{j} == x, el_list));
%                             end
%                             json_str = mat2str(indices);
%                         case Format.ADJACENCY
%                             % TODO correct this once Format.ADJACENCY is finalized
%                             json_str = mat2str(value);
%                         case Format.MEASURE
%                             % TODO correct this once Format.MEASURE is finalized
%                             json_str = mat2str(value);
%                     end
%                     eval(['struct{i}.props{prop}.value = ''' json_str ''';'])
%                     eval(['struct{i}.props{prop}.locked = ' mat2str(el.isLocked(prop)) ';'])
%                 end
%             end
% 
%             json = jsonencode(struct);
%         end
    end
    methods (Static) % decodeJSON
%         function [el, struct, el_list] = decodeJSON(json)
%             
%             struct = jsondecode(json);
% 
%             % creates empty elements
%             el_list = cell(length(struct), 1);
%             for i = 1:1:length(struct)
%                 el_list{i} = eval([struct{i}.class '()']);
%             end
%             
%             % fills in props
%             for i = 1:1:length(el_list)
%                 el = el_list{i};
%                 
%                 for prop = 1:1:el.getPropNumber()
%                     switch el.getPropFormat(prop)
%                         case {Format.EMPTY, Format.STRING, Format.OPTION, Format.CLASS}
%                             el.props{prop}.value = struct{i}.props(prop).value;
%                         case {Format.LOGICAL, Format.SCALAR, Format.RVECTOR, Format.CVECTOR, Format.MATRIX, Format.SMATRIX}
%                             el.props{prop}.value = eval(struct{i}.props(prop).value);
%                         case Format.CLASSLIST
%                             el.props{prop}.value = eval(struct{i}.props(prop).value(2:end-1));
%                         case {Format.ITEM, Format.IDICT}
%                             el.props{prop}.value = el_list(eval(struct{i}.props(prop).value));
%                         case Format.ITEMLIST
%                             indices = eval(struct{i}.props(prop).value);
%                             el.props{prop}.value = el_list(indices);
%                         case Format.ADJACENCY
%                             % TODO correct this once Format.ADJACENCY is finalized
%                             el.props{prop}.value = eval(struct{i}.props(prop).value);
%                         case Format.MEASURE
%                             % TODO correct this once Format.MEASURE is finalized
%                             el.props{prop}.value = eval(struct{i}.props(prop).value);
%                     end
%                     el.props{prop}.value = struct{i}.props(prop).locked;
%                 end
%             end
%             
%             el = el_list{1};
%         end
    end
    methods (Access=protected) % deep copy
%         function el_copy = copyElement(el)
% 
%             el_list = el.getElementList();
%             
%             % creates empty elements
%             % fills them with shallow copies of props
%             el_copy_list = cell(size(el_list));
%             for i = 1:1:length(el_list)
%                 el_copy_list{i} = eval([el_list{i}.getClass() '(42)']);
%                 el_copy_list{i}.props = el_list{i}.props;
%             end
% 
%             % fills in handle props
%             for i = 1:1:length(el_list)
%                 el = el_list{i};
%                 
%                 for prop = 1:1:el.getPropNumber()
%                     value = el.getr(prop);
% 
%                     if isa(value, 'Element')
%                         el_copy_list{i}.props{prop}.value = el_copy_list{cellfun(@(x) x == value, el_list)};
%                     elseif iscell(value) && all(cellfun(@(x) isa(x, 'Element'), value))
%                         for j = 1:1:length(value)
%                             el_copy_list{i}.props{prop}.value{j} = el_copy_list{cellfun(@(x) x == value{j}, el_list)};
%                         end
%                     end
%                 end
%             end
%             
%             el_copy = el_copy_list{1};
%         end
    end
    methods % clone
%         function el_clone = clone(el)
%             el_clone = el.copy();
%             el_clone.unlock()
%             el_clone.seed()
%         end
    end
end