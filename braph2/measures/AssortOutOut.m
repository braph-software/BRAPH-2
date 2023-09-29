classdef AssortOutOut < Measure
	%AssortOutOut is the graph Out-Out-Assortativity.
	% It is a subclass of <a href="matlab:help Measure">Measure</a>.
	%
	% The Out-Out-Assortativity coefficient (AssortOutOut) of a graph is the correlation coefficient between 
	%   the degrees/strengths of all nodes on two opposite ends of an edge within a layer. 
	% The corresponding coefficient for directed and weighted networks is calculated by using 
	%   the weighted and directed variants of out-degree/out-strength.
	%
	% AssortOutOut methods (constructor):
	%  AssortOutOut - constructor
	%
	% AssortOutOut methods:
	%  set - sets values of a property
	%  check - checks the values of all properties
	%  getr - returns the raw value of a property
	%  get - returns the value of a property
	%  memorize - returns the value of a property and memorizes it
	%             (for RESULT, QUERY, and EVANESCENT properties)
	%  getPropSeed - returns the seed of a property
	%  isLocked - returns whether a property is locked
	%  lock - locks unreversibly a property
	%  isChecked - returns whether a property is checked
	%  checked - sets a property to checked
	%  unchecked - sets a property to NOT checked
	%
	% AssortOutOut methods (display):
	%  tostring - string with information about the out-out-assortativity
	%  disp - displays information about the out-out-assortativity
	%  tree - displays the tree of the out-out-assortativity
	%
	% AssortOutOut methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two out-out-assortativity are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the out-out-assortativity
	%
	% AssortOutOut methods (save/load, Static):
	%  save - saves BRAPH2 out-out-assortativity as b2 file
	%  load - loads a BRAPH2 out-out-assortativity from a b2 file
	%
	% AssortOutOut method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the out-out-assortativity
	%
	% AssortOutOut method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the out-out-assortativity
	%
	% AssortOutOut methods (inspection, Static):
	%  getClass - returns the class of the out-out-assortativity
	%  getSubclasses - returns all subclasses of AssortOutOut
	%  getProps - returns the property list of the out-out-assortativity
	%  getPropNumber - returns the property number of the out-out-assortativity
	%  existsProp - checks whether property exists/error
	%  existsTag - checks whether tag exists/error
	%  getPropProp - returns the property number of a property
	%  getPropTag - returns the tag of a property
	%  getPropCategory - returns the category of a property
	%  getPropFormat - returns the format of a property
	%  getPropDescription - returns the description of a property
	%  getPropSettings - returns the settings of a property
	%  getPropDefault - returns the default value of a property
	%  getPropDefaultConditioned - returns the conditioned default value of a property
	%  checkProp - checks whether a value has the correct format/error
	%
	% AssortOutOut methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% AssortOutOut methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% AssortOutOut methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% AssortOutOut methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatTag - returns the tag of a format
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% To print full list of constants, click here <a href="matlab:metaclass = ?AssortOutOut; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">AssortOutOut constants</a>.
	%
	
	methods % constructor
		function m = AssortOutOut(varargin)
			%AssortOutOut() creates a out-out-assortativity.
			%
			% AssortOutOut(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% AssortOutOut(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			m = m@Measure(varargin{:});
		end
	end
	methods (Static) % inspection
		function m_class = getClass()
			%GETCLASS returns the class of the out-out-assortativity.
			%
			% CLASS = AssortOutOut.GETCLASS() returns the class 'AssortOutOut'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the out-out-assortativity M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('AssortOutOut') returns 'AssortOutOut'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('AssortOutOut')
			%  are less computationally efficient.
			
			m_class = 'AssortOutOut';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the out-out-assortativity.
			%
			% LIST = AssortOutOut.GETSUBCLASSES() returns all subclasses of 'AssortOutOut'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the out-out-assortativity M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('AssortOutOut') returns all subclasses of 'AssortOutOut'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('AssortOutOut')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('AssortOutOut', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of out-out-assortativity.
			%
			% PROPS = AssortOutOut.GETPROPS() returns the property list of out-out-assortativity
			%  as a row vector.
			%
			% PROPS = AssortOutOut.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the out-out-assortativity M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('AssortOutOut'[, CATEGORY]) returns the property list of 'AssortOutOut'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('AssortOutOut')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					Measure.getProps() ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						Measure.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						Measure.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						Measure.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						Measure.getProps(Category.DATA) ...
						];
				case Category.RESULT
					prop_list = [
						Measure.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						Measure.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						Measure.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						Measure.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						Measure.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of out-out-assortativity.
			%
			% N = AssortOutOut.GETPROPNUMBER() returns the property number of out-out-assortativity.
			%
			% N = AssortOutOut.GETPROPNUMBER(CATEGORY) returns the property number of out-out-assortativity
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the out-out-assortativity M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('AssortOutOut') returns the property number of 'AssortOutOut'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('AssortOutOut')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(AssortOutOut.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in out-out-assortativity/error.
			%
			% CHECK = AssortOutOut.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(AssortOutOut, PROP) checks whether PROP exists for AssortOutOut.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:AssortOutOut:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:AssortOutOut:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:AssortOutOut:WrongInput]
			%  Element.EXISTSPROP(AssortOutOut, PROP) throws error if PROP does NOT exist for AssortOutOut.
			%   Error id: [BRAPH2:AssortOutOut:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('AssortOutOut')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == AssortOutOut.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':AssortOutOut:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':AssortOutOut:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for AssortOutOut.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in out-out-assortativity/error.
			%
			% CHECK = AssortOutOut.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(AssortOutOut, TAG) checks whether TAG exists for AssortOutOut.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:AssortOutOut:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:AssortOutOut:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:AssortOutOut:WrongInput]
			%  Element.EXISTSTAG(AssortOutOut, TAG) throws error if TAG does NOT exist for AssortOutOut.
			%   Error id: [BRAPH2:AssortOutOut:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('AssortOutOut')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			assortoutout_tag_list = cellfun(@(x) AssortOutOut.getPropTag(x), num2cell(AssortOutOut.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, assortoutout_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':AssortOutOut:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':AssortOutOut:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for AssortOutOut.'] ...
					)
			end
		end
		function prop = getPropProp(pointer)
			%GETPROPPROP returns the property number of a property.
			%
			% PROP = Element.GETPROPPROP(PROP) returns PROP, i.e., the 
			%  property number of the property PROP.
			%
			% PROP = Element.GETPROPPROP(TAG) returns the property number 
			%  of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PROPERTY = M.GETPROPPROP(POINTER) returns property number of POINTER of M.
			%  PROPERTY = Element.GETPROPPROP(AssortOutOut, POINTER) returns property number of POINTER of AssortOutOut.
			%  PROPERTY = M.GETPROPPROP(AssortOutOut, POINTER) returns property number of POINTER of AssortOutOut.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('AssortOutOut')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				assortoutout_tag_list = cellfun(@(x) AssortOutOut.getPropTag(x), num2cell(AssortOutOut.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, assortoutout_tag_list)); % tag = pointer
			else % numeric
				prop = pointer;
			end
		end
		function tag = getPropTag(pointer)
			%GETPROPTAG returns the tag of a property.
			%
			% TAG = Element.GETPROPTAG(PROP) returns the tag TAG of the 
			%  property PROP.
			%
			% TAG = Element.GETPROPTAG(TAG) returns TAG, i.e. the tag of 
			%  the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  TAG = M.GETPROPTAG(POINTER) returns tag of POINTER of M.
			%  TAG = Element.GETPROPTAG(AssortOutOut, POINTER) returns tag of POINTER of AssortOutOut.
			%  TAG = M.GETPROPTAG(AssortOutOut, POINTER) returns tag of POINTER of AssortOutOut.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('AssortOutOut')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					otherwise
						tag = getPropTag@Measure(prop);
				end
			end
		end
		function prop_category = getPropCategory(pointer)
			%GETPROPCATEGORY returns the category of a property.
			%
			% CATEGORY = Element.GETPROPCATEGORY(PROP) returns the category of the
			%  property PROP.
			%
			% CATEGORY = Element.GETPROPCATEGORY(TAG) returns the category of the
			%  property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CATEGORY = M.GETPROPCATEGORY(POINTER) returns category of POINTER of M.
			%  CATEGORY = Element.GETPROPCATEGORY(AssortOutOut, POINTER) returns category of POINTER of AssortOutOut.
			%  CATEGORY = M.GETPROPCATEGORY(AssortOutOut, POINTER) returns category of POINTER of AssortOutOut.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('AssortOutOut')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = AssortOutOut.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_category = getPropCategory@Measure(prop);
			end
		end
		function prop_format = getPropFormat(pointer)
			%GETPROPFORMAT returns the format of a property.
			%
			% FORMAT = Element.GETPROPFORMAT(PROP) returns the
			%  format of the property PROP.
			%
			% FORMAT = Element.GETPROPFORMAT(TAG) returns the
			%  format of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  FORMAT = M.GETPROPFORMAT(POINTER) returns format of POINTER of M.
			%  FORMAT = Element.GETPROPFORMAT(AssortOutOut, POINTER) returns format of POINTER of AssortOutOut.
			%  FORMAT = M.GETPROPFORMAT(AssortOutOut, POINTER) returns format of POINTER of AssortOutOut.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('AssortOutOut')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = AssortOutOut.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_format = getPropFormat@Measure(prop);
			end
		end
		function prop_description = getPropDescription(pointer)
			%GETPROPDESCRIPTION returns the description of a property.
			%
			% DESCRIPTION = Element.GETPROPDESCRIPTION(PROP) returns the
			%  description of the property PROP.
			%
			% DESCRIPTION = Element.GETPROPDESCRIPTION(TAG) returns the
			%  description of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DESCRIPTION = M.GETPROPDESCRIPTION(POINTER) returns description of POINTER of M.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(AssortOutOut, POINTER) returns description of POINTER of AssortOutOut.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(AssortOutOut, POINTER) returns description of POINTER of AssortOutOut.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('AssortOutOut')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = AssortOutOut.getPropProp(pointer);
			
			switch prop
				case AssortOutOut.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the Out-Out-Assortativity.';
				case AssortOutOut.NAME
					prop_description = 'NAME (constant, string) is the name of the Out-Out-Assortativity.';
				case AssortOutOut.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the Out-Out-Assortativity.';
				case AssortOutOut.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the Out-Out-Assortativity.';
				case AssortOutOut.ID
					prop_description = 'ID (data, string) is a few-letter code of the Out-Out-Assortativity.';
				case AssortOutOut.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the Out-Out-Assortativity.';
				case AssortOutOut.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the Out-Out-Assortativity.';
				case AssortOutOut.SHAPE
					prop_description = 'SHAPE (constant, scalar) is the measure shape __Measure.GLOBAL__.';
				case AssortOutOut.SCOPE
					prop_description = 'SCOPE (constant, scalar) is the measure scope __Measure.UNILAYER__.';
				case AssortOutOut.PARAMETRICITY
					prop_description = 'PARAMETRICITY (constant, scalar) is the parametricity of the measure __Measure.NONPARAMETRIC__.';
				case AssortOutOut.COMPATIBLE_GRAPHS
					prop_description = 'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.';
				case AssortOutOut.M
					prop_description = 'M (result, cell) is the Out-Out-Assortativity.';
				otherwise
					prop_description = getPropDescription@Measure(prop);
			end
		end
		function prop_settings = getPropSettings(pointer)
			%GETPROPSETTINGS returns the settings of a property.
			%
			% SETTINGS = Element.GETPROPSETTINGS(PROP) returns the
			%  settings of the property PROP.
			%
			% SETTINGS = Element.GETPROPSETTINGS(TAG) returns the
			%  settings of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  SETTINGS = M.GETPROPSETTINGS(POINTER) returns settings of POINTER of M.
			%  SETTINGS = Element.GETPROPSETTINGS(AssortOutOut, POINTER) returns settings of POINTER of AssortOutOut.
			%  SETTINGS = M.GETPROPSETTINGS(AssortOutOut, POINTER) returns settings of POINTER of AssortOutOut.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('AssortOutOut')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = AssortOutOut.getPropProp(pointer);
			
			switch prop
				case AssortOutOut.TEMPLATE
					prop_settings = 'AssortOutOut';
				otherwise
					prop_settings = getPropSettings@Measure(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = AssortOutOut.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = AssortOutOut.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(AssortOutOut, POINTER) returns the default value of POINTER of AssortOutOut.
			%  DEFAULT = M.GETPROPDEFAULT(AssortOutOut, POINTER) returns the default value of POINTER of AssortOutOut.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('AssortOutOut')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = AssortOutOut.getPropProp(pointer);
			
			switch prop
				case AssortOutOut.ELCLASS
					prop_default = 'AssortOutOut';
				case AssortOutOut.NAME
					prop_default = 'Out-Out-Assortativity';
				case AssortOutOut.DESCRIPTION
					prop_default = 'The out-out-assortativity coefficient (AssortOutOut) of a graph is the correlation coefficient between the degrees/strengths of all nodes on two opposite ends of an edge within a layer. The corresponding coefficient for directed and weighted networks is calculated by using the weighted and directed variants of out-degree/out-strength.';
				case AssortOutOut.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, AssortOutOut.getPropSettings(prop));
				case AssortOutOut.ID
					prop_default = 'AssortOutOut ID';
				case AssortOutOut.LABEL
					prop_default = 'Out-Out-Assortativity label';
				case AssortOutOut.NOTES
					prop_default = 'Out-Out-Assortativity notes';
				case AssortOutOut.SHAPE
					prop_default = Measure.GLOBAL;
				case AssortOutOut.SCOPE
					prop_default = Measure.UNILAYER;
				case AssortOutOut.PARAMETRICITY
					prop_default = Measure.NONPARAMETRIC;
				case AssortOutOut.COMPATIBLE_GRAPHS
					prop_default = {'GraphBD' 'GraphWD' 'MultiplexWD' 'MultiplexBD'};;
				otherwise
					prop_default = getPropDefault@Measure(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = AssortOutOut.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = AssortOutOut.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(AssortOutOut, POINTER) returns the conditioned default value of POINTER of AssortOutOut.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(AssortOutOut, POINTER) returns the conditioned default value of POINTER of AssortOutOut.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('AssortOutOut')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = AssortOutOut.getPropProp(pointer);
			
			prop_default = AssortOutOut.conditioning(prop, AssortOutOut.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = M.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = M.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of M.
			%  CHECK = Element.CHECKPROP(AssortOutOut, PROP, VALUE) checks VALUE format for PROP of AssortOutOut.
			%  CHECK = M.CHECKPROP(AssortOutOut, PROP, VALUE) checks VALUE format for PROP of AssortOutOut.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:AssortOutOut:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: €BRAPH2.STR€:AssortOutOut:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(AssortOutOut, PROP, VALUE) throws error if VALUE has not a valid format for PROP of AssortOutOut.
			%   Error id: €BRAPH2.STR€:AssortOutOut:€BRAPH2.WRONG_INPUT€
			%  M.CHECKPROP(AssortOutOut, PROP, VALUE) throws error if VALUE has not a valid format for PROP of AssortOutOut.
			%   Error id: €BRAPH2.STR€:AssortOutOut:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('AssortOutOut')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = AssortOutOut.getPropProp(pointer);
			
			switch prop
				case AssortOutOut.TEMPLATE % __AssortOutOut.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, AssortOutOut.getPropSettings(prop));
				otherwise
					if prop <= Measure.getPropNumber()
						check = checkProp@Measure(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':AssortOutOut:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':AssortOutOut:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' AssortOutOut.getPropTag(prop) ' (' AssortOutOut.getFormatTag(AssortOutOut.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(m, prop, varargin)
			%CALCULATEVALUE calculates the value of a property.
			%
			% VALUE = CALCULATEVALUE(EL, PROP) calculates the value of the property
			%  PROP. It works only with properties with Category.RESULT,
			%  Category.QUERY, and Category.EVANESCENT. By default this function
			%  returns the default value for the prop and should be implemented in the
			%  subclasses of Element when needed.
			%
			% VALUE = CALCULATEVALUE(EL, PROP, VARARGIN) works with properties with
			%  Category.QUERY.
			%
			% See also getPropDefaultConditioned, conditioning, preset, checkProp,
			%  postset, postprocessing, checkValue.
			
			switch prop
				case AssortOutOut.M % __AssortOutOut.M__
					rng_settings_ = rng(); rng(m.getPropSeed(AssortOutOut.M), 'twister')
					
					g = m.get('G'); % graph from measure class
					A = g.get('A'); % adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
					L = g.get('LAYERNUMBER');
					N = g.get('NODENUMBER');
					out_out_assortativity = cell(L, 1);
					connectivity_types = g.get('CONNECTIVITY_TYPE', L);  
					parfor li = 1:L
					    Aii = A{li, li};
					    connectivity_type = connectivity_types(li, li);
					    [i, j] = find(Aii ~= 0);  % nodes [i, j]
					    M = length(i);  % Number of edges
					    k_i = zeros(M, L);
					    k_j = zeros(length(j), L);
					    
					    if connectivity_type == Graph.WEIGHTED  % weighted graphs
					        out_strength = StrengthOut('G', g).get('M');
					        d = out_strength{li};
					    else  % binary graphs
					        out_degree = DegreeOut('G', g).get('M');
					        d= out_degree{li};
					    end
					    
					    k_i(:, li) = d(i);  % in-degree/in-strength node i
					    k_j(:, li) = d(j);  % in-degree/in-strength node j
					    % compute assortativity
					    assortativity_layer = (sum(k_i(:, li) .* k_j(:, li)) / M - (sum(0.5 * (k_i(:, li) + k_j(:, li))) / M)^2)...
					        / (sum(0.5 * (k_i(:, li).^2 + k_j(:, li).^2)) / M - (sum(0.5 * (k_i(:, li) + k_j(:, li))) / M)^2);
					    assortativity_layer(isnan(assortativity_layer)) = 0;  % Should return zeros, not NaN    
					    out_out_assortativity(li) = {assortativity_layer};
					end
					
					value = out_out_assortativity;
					
					rng(rng_settings_)
					
				otherwise
					if prop <= Measure.getPropNumber()
						value = calculateValue@Measure(m, prop, varargin{:});
					else
						value = calculateValue@Element(m, prop, varargin{:});
					end
			end
			
		end
	end
end
