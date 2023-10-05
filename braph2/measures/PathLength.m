classdef PathLength < Measure
	%PathLength is the graph Path Length.
	% It is a subclass of <a href="matlab:help Measure">Measure</a>.
	%
	% The Path Length is the average shortest pathlength of one node to all 
	%  other nodes within a layer.
	%
	% PathLength methods (constructor):
	%  PathLength - constructor
	%
	% PathLength methods:
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
	% PathLength methods (display):
	%  tostring - string with information about the pathlength
	%  disp - displays information about the pathlength
	%  tree - displays the tree of the pathlength
	%
	% PathLength methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two pathlength are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the pathlength
	%
	% PathLength methods (save/load, Static):
	%  save - saves BRAPH2 pathlength as b2 file
	%  load - loads a BRAPH2 pathlength from a b2 file
	%
	% PathLength method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the pathlength
	%
	% PathLength method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the pathlength
	%
	% PathLength methods (inspection, Static):
	%  getClass - returns the class of the pathlength
	%  getSubclasses - returns all subclasses of PathLength
	%  getProps - returns the property list of the pathlength
	%  getPropNumber - returns the property number of the pathlength
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
	% PathLength methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% PathLength methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% PathLength methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% PathLength methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?PathLength; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">PathLength constants</a>.
	%
	
	properties (Constant) % properties
		RULE = Measure.getPropNumber() + 1;
		RULE_TAG = 'RULE';
		RULE_CATEGORY = Category.PARAMETER;
		RULE_FORMAT = Format.OPTION;
	end
	methods % constructor
		function m = PathLength(varargin)
			%PathLength() creates a pathlength.
			%
			% PathLength(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% PathLength(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the pathlength.
			%
			% CLASS = PathLength.GETCLASS() returns the class 'PathLength'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the pathlength M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('PathLength') returns 'PathLength'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('PathLength')
			%  are less computationally efficient.
			
			m_class = 'PathLength';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the pathlength.
			%
			% LIST = PathLength.GETSUBCLASSES() returns all subclasses of 'PathLength'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the pathlength M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('PathLength') returns all subclasses of 'PathLength'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('PathLength')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('PathLength', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of pathlength.
			%
			% PROPS = PathLength.GETPROPS() returns the property list of pathlength
			%  as a row vector.
			%
			% PROPS = PathLength.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the pathlength M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('PathLength'[, CATEGORY]) returns the property list of 'PathLength'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('PathLength')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					Measure.getProps() ...
						PathLength.RULE ...
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
						PathLength.RULE ...
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
			%GETPROPNUMBER returns the property number of pathlength.
			%
			% N = PathLength.GETPROPNUMBER() returns the property number of pathlength.
			%
			% N = PathLength.GETPROPNUMBER(CATEGORY) returns the property number of pathlength
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the pathlength M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('PathLength') returns the property number of 'PathLength'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('PathLength')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(PathLength.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in pathlength/error.
			%
			% CHECK = PathLength.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(PathLength, PROP) checks whether PROP exists for PathLength.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:PathLength:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:PathLength:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:PathLength:WrongInput]
			%  Element.EXISTSPROP(PathLength, PROP) throws error if PROP does NOT exist for PathLength.
			%   Error id: [BRAPH2:PathLength:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('PathLength')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == PathLength.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PathLength:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PathLength:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for PathLength.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in pathlength/error.
			%
			% CHECK = PathLength.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(PathLength, TAG) checks whether TAG exists for PathLength.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:PathLength:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:PathLength:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:PathLength:WrongInput]
			%  Element.EXISTSTAG(PathLength, TAG) throws error if TAG does NOT exist for PathLength.
			%   Error id: [BRAPH2:PathLength:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('PathLength')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			pathlength_tag_list = cellfun(@(x) PathLength.getPropTag(x), num2cell(PathLength.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, pathlength_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PathLength:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PathLength:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for PathLength.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(PathLength, POINTER) returns property number of POINTER of PathLength.
			%  PROPERTY = M.GETPROPPROP(PathLength, POINTER) returns property number of POINTER of PathLength.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('PathLength')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				pathlength_tag_list = cellfun(@(x) PathLength.getPropTag(x), num2cell(PathLength.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, pathlength_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(PathLength, POINTER) returns tag of POINTER of PathLength.
			%  TAG = M.GETPROPTAG(PathLength, POINTER) returns tag of POINTER of PathLength.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('PathLength')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case PathLength.RULE
						tag = PathLength.RULE_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(PathLength, POINTER) returns category of POINTER of PathLength.
			%  CATEGORY = M.GETPROPCATEGORY(PathLength, POINTER) returns category of POINTER of PathLength.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('PathLength')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = PathLength.getPropProp(pointer);
			
			switch prop
				case PathLength.RULE
					prop_category = PathLength.RULE_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(PathLength, POINTER) returns format of POINTER of PathLength.
			%  FORMAT = M.GETPROPFORMAT(PathLength, POINTER) returns format of POINTER of PathLength.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('PathLength')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = PathLength.getPropProp(pointer);
			
			switch prop
				case PathLength.RULE
					prop_format = PathLength.RULE_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(PathLength, POINTER) returns description of POINTER of PathLength.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(PathLength, POINTER) returns description of POINTER of PathLength.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('PathLength')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = PathLength.getPropProp(pointer);
			
			switch prop
				case PathLength.RULE
					prop_description = 'RULE (parameter, option) is the pathlength algorithm';
				case PathLength.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the Path Length.';
				case PathLength.NAME
					prop_description = 'NAME (constant, string) is the name of the Path Length.';
				case PathLength.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the Path Length.';
				case PathLength.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the Path Length.';
				case PathLength.ID
					prop_description = 'ID (data, string) is a few-letter code of the Path Length.';
				case PathLength.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the Path Length.';
				case PathLength.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the Path Length.';
				case PathLength.SHAPE
					prop_description = 'SHAPE (constant, scalar) is the measure shape __Measure.NODAL__.';
				case PathLength.SCOPE
					prop_description = 'SCOPE (constant, scalar) is the measure scope __Measure.UNILAYER__.';
				case PathLength.PARAMETRICITY
					prop_description = 'PARAMETRICITY (constant, scalar) is the parametricity of the measure __Measure.NONPARAMETRIC__.';
				case PathLength.COMPATIBLE_GRAPHS
					prop_description = 'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.';
				case PathLength.M
					prop_description = 'M (result, cell) is the cell containing the Path Length.';
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
			%  SETTINGS = Element.GETPROPSETTINGS(PathLength, POINTER) returns settings of POINTER of PathLength.
			%  SETTINGS = M.GETPROPSETTINGS(PathLength, POINTER) returns settings of POINTER of PathLength.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('PathLength')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = PathLength.getPropProp(pointer);
			
			switch prop
				case PathLength.RULE
					prop_settings = {'subgraphs' 'harmonic' 'mean'};
				case PathLength.TEMPLATE
					prop_settings = 'PathLength';
				otherwise
					prop_settings = getPropSettings@Measure(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = PathLength.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = PathLength.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(PathLength, POINTER) returns the default value of POINTER of PathLength.
			%  DEFAULT = M.GETPROPDEFAULT(PathLength, POINTER) returns the default value of POINTER of PathLength.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('PathLength')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PathLength.getPropProp(pointer);
			
			switch prop
				case PathLength.RULE
					prop_default = 'harmonic';
				case PathLength.ELCLASS
					prop_default = 'PathLength';
				case PathLength.NAME
					prop_default = 'Path Length';
				case PathLength.DESCRIPTION
					prop_default = 'The Path Length is the average shortest path length of one node to all other nodes within a layer.';
				case PathLength.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, PathLength.getPropSettings(prop));
				case PathLength.ID
					prop_default = 'PathLength ID';
				case PathLength.LABEL
					prop_default = 'Path Length label';
				case PathLength.NOTES
					prop_default = 'Path Length notes';
				case PathLength.SHAPE
					prop_default = Measure.NODAL;
				case PathLength.SCOPE
					prop_default = Measure.UNILAYER;
				case PathLength.PARAMETRICITY
					prop_default = Measure.NONPARAMETRIC;
				case PathLength.COMPATIBLE_GRAPHS
					prop_default = {'GraphWU' 'GraphBU' 'MultigraphBUD' 'MultigraphBUT' 'MultiplexWU' 'MultiplexBU' 'MultiplexBUD' 'MultiplexBUT' 'MultilayerWU' 'OrdMlWU'};
				otherwise
					prop_default = getPropDefault@Measure(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = PathLength.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = PathLength.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(PathLength, POINTER) returns the conditioned default value of POINTER of PathLength.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(PathLength, POINTER) returns the conditioned default value of POINTER of PathLength.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('PathLength')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = PathLength.getPropProp(pointer);
			
			prop_default = PathLength.conditioning(prop, PathLength.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(PathLength, PROP, VALUE) checks VALUE format for PROP of PathLength.
			%  CHECK = M.CHECKPROP(PathLength, PROP, VALUE) checks VALUE format for PROP of PathLength.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:PathLength:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: €BRAPH2.STR€:PathLength:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(PathLength, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PathLength.
			%   Error id: €BRAPH2.STR€:PathLength:€BRAPH2.WRONG_INPUT€
			%  M.CHECKPROP(PathLength, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PathLength.
			%   Error id: €BRAPH2.STR€:PathLength:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('PathLength')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = PathLength.getPropProp(pointer);
			
			switch prop
				case PathLength.RULE % __PathLength.RULE__
					check = Format.checkFormat(Format.OPTION, value, PathLength.getPropSettings(prop));
				case PathLength.TEMPLATE % __PathLength.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, PathLength.getPropSettings(prop));
				otherwise
					if prop <= Measure.getPropNumber()
						check = checkProp@Measure(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PathLength:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PathLength:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' PathLength.getPropTag(prop) ' (' PathLength.getFormatTag(PathLength.getPropFormat(prop)) ').'] ...
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
				case PathLength.M % __PathLength.M__
					rng_settings_ = rng(); rng(m.getPropSeed(PathLength.M), 'twister')
					
					g = m.get('G');  % graph from measure class
					A = g.get('A');  % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
					N = g.get('NODENUMBER');
					L = g.get('LAYERNUMBER');
					
					path_length = cell(L, 1);                    
					path_length_rule = m.get('RULE');
					
					distance = Distance('G', g).get('M');
					
					parfor li = 1:1:L
					    path_length_layer = zeros(N(1), 1);
					    distance_layer = distance{li};
					
					    switch lower(path_length_rule)
					        case {'subgraphs'}
					            for u = 1:1:N
					                Du = distance_layer(:, u);
					                path_length_layer(u) = mean(Du(Du~=Inf & Du~=0));
					            end
					        case {'mean'}
					            for u = 1:1:N
					                Du = distance_layer(:, u);
					                path_length_layer(u) = mean(Du(Du~=0));
					            end
					        otherwise  % 'harmonic' 'default'
					            for u = 1:1:N
					                Du = distance_layer(:, u);
					                path_length_layer(u) = harmmean(Du(Du~=0));
					            end
					    end 
					    path_length(li) = {path_length_layer}; % node Inf corresponds to isolated nodes
					end
					value = path_length;
					
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
