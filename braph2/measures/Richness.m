classdef Richness < Degree
	%Richness is the graph Richness.
	% It is a subclass of <a href="matlab:help Degree">Degree</a>.
	%
	% The Richness of a node is the sum of the edges that connect nodes 
	% of higher degree within a layer.
	%
	% Richness methods (constructor):
	%  Richness - constructor
	%
	% Richness methods:
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
	% Richness methods (display):
	%  tostring - string with information about the richness
	%  disp - displays information about the richness
	%  tree - displays the tree of the richness
	%
	% Richness methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two richness are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the richness
	%
	% Richness methods (save/load, Static):
	%  save - saves BRAPH2 richness as b2 file
	%  load - loads a BRAPH2 richness from a b2 file
	%
	% Richness method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the richness
	%
	% Richness method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the richness
	%
	% Richness methods (inspection, Static):
	%  getClass - returns the class of the richness
	%  getSubclasses - returns all subclasses of Richness
	%  getProps - returns the property list of the richness
	%  getPropNumber - returns the property number of the richness
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
	% Richness methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% Richness methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% Richness methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% Richness methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?Richness; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">Richness constants</a>.
	%
	
	methods % constructor
		function m = Richness(varargin)
			%Richness() creates a richness.
			%
			% Richness(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% Richness(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			m = m@Degree(varargin{:});
		end
	end
	methods (Static) % inspection
		function m_class = getClass()
			%GETCLASS returns the class of the richness.
			%
			% CLASS = Richness.GETCLASS() returns the class 'Richness'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the richness M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('Richness') returns 'Richness'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('Richness')
			%  are less computationally efficient.
			
			m_class = 'Richness';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the richness.
			%
			% LIST = Richness.GETSUBCLASSES() returns all subclasses of 'Richness'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the richness M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('Richness') returns all subclasses of 'Richness'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('Richness')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('Richness', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of richness.
			%
			% PROPS = Richness.GETPROPS() returns the property list of richness
			%  as a row vector.
			%
			% PROPS = Richness.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the richness M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('Richness'[, CATEGORY]) returns the property list of 'Richness'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('Richness')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					Degree.getProps() ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						Degree.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						Degree.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						Degree.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						Degree.getProps(Category.DATA) ...
						];
				case Category.RESULT
					prop_list = [
						Degree.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						Degree.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						Degree.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						Degree.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						Degree.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of richness.
			%
			% N = Richness.GETPROPNUMBER() returns the property number of richness.
			%
			% N = Richness.GETPROPNUMBER(CATEGORY) returns the property number of richness
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the richness M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('Richness') returns the property number of 'Richness'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('Richness')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(Richness.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in richness/error.
			%
			% CHECK = Richness.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(Richness, PROP) checks whether PROP exists for Richness.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:Richness:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:Richness:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:Richness:WrongInput]
			%  Element.EXISTSPROP(Richness, PROP) throws error if PROP does NOT exist for Richness.
			%   Error id: [BRAPH2:Richness:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('Richness')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == Richness.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':Richness:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':Richness:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for Richness.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in richness/error.
			%
			% CHECK = Richness.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(Richness, TAG) checks whether TAG exists for Richness.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:Richness:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:Richness:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:Richness:WrongInput]
			%  Element.EXISTSTAG(Richness, TAG) throws error if TAG does NOT exist for Richness.
			%   Error id: [BRAPH2:Richness:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('Richness')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			richness_tag_list = cellfun(@(x) Richness.getPropTag(x), num2cell(Richness.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, richness_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':Richness:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':Richness:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for Richness.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(Richness, POINTER) returns property number of POINTER of Richness.
			%  PROPERTY = M.GETPROPPROP(Richness, POINTER) returns property number of POINTER of Richness.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('Richness')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				richness_tag_list = cellfun(@(x) Richness.getPropTag(x), num2cell(Richness.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, richness_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(Richness, POINTER) returns tag of POINTER of Richness.
			%  TAG = M.GETPROPTAG(Richness, POINTER) returns tag of POINTER of Richness.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('Richness')
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
						tag = getPropTag@Degree(prop);
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
			%  CATEGORY = Element.GETPROPCATEGORY(Richness, POINTER) returns category of POINTER of Richness.
			%  CATEGORY = M.GETPROPCATEGORY(Richness, POINTER) returns category of POINTER of Richness.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('Richness')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = Richness.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_category = getPropCategory@Degree(prop);
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
			%  FORMAT = Element.GETPROPFORMAT(Richness, POINTER) returns format of POINTER of Richness.
			%  FORMAT = M.GETPROPFORMAT(Richness, POINTER) returns format of POINTER of Richness.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('Richness')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = Richness.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_format = getPropFormat@Degree(prop);
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(Richness, POINTER) returns description of POINTER of Richness.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(Richness, POINTER) returns description of POINTER of Richness.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('Richness')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = Richness.getPropProp(pointer);
			
			switch prop
				case Richness.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the Richness.';
				case Richness.NAME
					prop_description = 'NAME (constant, string) is the name of the Richness.';
				case Richness.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the Richness.';
				case Richness.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the Richness.';
				case Richness.ID
					prop_description = 'ID (data, string) is a few-letter code of the Richness.';
				case Richness.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the Richness.';
				case Richness.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the Richness.';
				case Richness.SHAPE
					prop_description = 'SHAPE (constant, scalar) is the measure shape __Measure.NODAL__.';
				case Richness.SCOPE
					prop_description = 'SCOPE (constant, scalar) is the measure scope __Measure.UNILAYER__.';
				case Richness.PARAMETRICITY
					prop_description = 'PARAMETRICITY (constant, scalar) is the parametricity of the measure __Measure.NONPARAMETRIC__.';
				case Richness.COMPATIBLE_GRAPHS
					prop_description = 'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.';
				case Richness.M
					prop_description = 'M (result, cell) is the Richness.';
				otherwise
					prop_description = getPropDescription@Degree(prop);
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
			%  SETTINGS = Element.GETPROPSETTINGS(Richness, POINTER) returns settings of POINTER of Richness.
			%  SETTINGS = M.GETPROPSETTINGS(Richness, POINTER) returns settings of POINTER of Richness.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('Richness')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = Richness.getPropProp(pointer);
			
			switch prop
				case Richness.TEMPLATE
					prop_settings = 'Richness';
				otherwise
					prop_settings = getPropSettings@Degree(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = Richness.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = Richness.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(Richness, POINTER) returns the default value of POINTER of Richness.
			%  DEFAULT = M.GETPROPDEFAULT(Richness, POINTER) returns the default value of POINTER of Richness.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('Richness')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = Richness.getPropProp(pointer);
			
			switch prop
				case Richness.ELCLASS
					prop_default = 'Richness';
				case Richness.NAME
					prop_default = 'Richness';
				case Richness.DESCRIPTION
					prop_default = 'The Richness of a node is the sum of the edges that connect nodes of higher degree within a layer.';
				case Richness.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, Richness.getPropSettings(prop));
				case Richness.ID
					prop_default = 'Richness ID';
				case Richness.LABEL
					prop_default = 'Richness label';
				case Richness.NOTES
					prop_default = 'Richness notes';
				case Richness.SHAPE
					prop_default = Measure.NODAL;
				case Richness.SCOPE
					prop_default = Measure.UNILAYER;
				case Richness.PARAMETRICITY
					prop_default = Measure.NONPARAMETRIC;
				case Richness.COMPATIBLE_GRAPHS
					prop_default = {'GraphWU' 'GraphWD' 'GraphBU' 'GraphBD' 'MultigraphBUD' 'MultigraphBUT' 'MultiplexWU' 'MultiplexWD' 'MultiplexBU' 'MultiplexBD' 'MultiplexBUD' 'MultiplexBUT'} ;;
				otherwise
					prop_default = getPropDefault@Degree(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = Richness.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = Richness.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(Richness, POINTER) returns the conditioned default value of POINTER of Richness.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(Richness, POINTER) returns the conditioned default value of POINTER of Richness.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('Richness')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = Richness.getPropProp(pointer);
			
			prop_default = Richness.conditioning(prop, Richness.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(Richness, PROP, VALUE) checks VALUE format for PROP of Richness.
			%  CHECK = M.CHECKPROP(Richness, PROP, VALUE) checks VALUE format for PROP of Richness.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:Richness:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: €BRAPH2.STR€:Richness:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(Richness, PROP, VALUE) throws error if VALUE has not a valid format for PROP of Richness.
			%   Error id: €BRAPH2.STR€:Richness:€BRAPH2.WRONG_INPUT€
			%  M.CHECKPROP(Richness, PROP, VALUE) throws error if VALUE has not a valid format for PROP of Richness.
			%   Error id: €BRAPH2.STR€:Richness:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('Richness')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = Richness.getPropProp(pointer);
			
			switch prop
				case Richness.TEMPLATE % __Richness.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, Richness.getPropSettings(prop));
				otherwise
					if prop <= Degree.getPropNumber()
						check = checkProp@Degree(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':Richness:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':Richness:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' Richness.getPropTag(prop) ' (' Richness.getFormatTag(Richness.getPropFormat(prop)) ').'] ...
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
				case Richness.M % __Richness.M__
					rng_settings_ = rng(); rng(m.getPropSeed(Richness.M), 'twister')
					
					g = m.get('G'); % graph from measure class
					A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
					L = g.get('LAYERNUMBER');
					N = g.get('NODENUMBER');
					
					richness = cell(L, 1);
					directionality_type = g.get('DIRECTIONALITY_TYPE', L); 
					
					for li = 1:1:L
					    
					    Aii = A{li, li};
					    directionality_layer = directionality_type(li, li);
					
					    if directionality_layer == Graph.UNDIRECTED  % undirected graphs
					        
					        degree = calculateValue@Degree(m, prop);    
					        k = degree{li};
					        
					    else  % directed graphs
					                
					        in_degree = DegreeIn('G', g).get('M');        
					        out_degree = DegreeOut('G', g).get('M');        
					        
					        k = in_degree{li} + out_degree{li};
					    end
					    
					    kMinus = zeros(size(k));
					    kPlus = zeros(size(k));
					    
					    for i = 1:N(li)
					        lrInd = k <= k(i); % Indices of nodes with Lower Richness (LR)
					        hrInd = k > k(i); % Indices of nodes with Higher Richness (HR)
					        lrA = Aii;
					        lrA(i, hrInd) = 0;
					        lrA(hrInd, i) = 0;
					        hrA = Aii;
					        hrA(i, lrInd) = 0;
					        hrA(lrInd, i) = 0;
					        
					        if directionality_layer == Graph.UNDIRECTED  % undirected graphs
					            kMinusForI = sum(lrA, 1)';
					            kPlusForI = sum(hrA, 1)';
					        else
					            kMinusForI = (sum(lrA, 1)' + sum(lrA, 2))/2;
					            kPlusForI = (sum(hrA, 1)' + sum(hrA, 2))/2;
					        end
					        kMinus(i) = kMinusForI(i);
					        kPlus(i) = kPlusForI(i);
					    end
					    richness(li) = {kPlus};  % add richness of layer li
					end
					
					value = richness;
					
					rng(rng_settings_)
					
				otherwise
					if prop <= Degree.getPropNumber()
						value = calculateValue@Degree(m, prop, varargin{:});
					else
						value = calculateValue@Element(m, prop, varargin{:});
					end
			end
			
		end
	end
end
