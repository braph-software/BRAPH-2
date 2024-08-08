classdef PathLengthAv < PathLength
	%PathLengthAv is the graph Average Path Length.
	% It is a subclass of <a href="matlab:help PathLength">PathLength</a>.
	%
	% The Average Path Length (PathLengthAv) of a graph is the average of the sum of 
	%  the path lengths within each layer.
	%
	% PathLengthAv methods (constructor):
	%  PathLengthAv - constructor
	%
	% PathLengthAv methods:
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
	% PathLengthAv methods (display):
	%  tostring - string with information about the average path length
	%  disp - displays information about the average path length
	%  tree - displays the tree of the average path length
	%
	% PathLengthAv methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two average path length are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the average path length
	%
	% PathLengthAv methods (save/load, Static):
	%  save - saves BRAPH2 average path length as b2 file
	%  load - loads a BRAPH2 average path length from a b2 file
	%
	% PathLengthAv method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the average path length
	%
	% PathLengthAv method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the average path length
	%
	% PathLengthAv methods (inspection, Static):
	%  getClass - returns the class of the average path length
	%  getSubclasses - returns all subclasses of PathLengthAv
	%  getProps - returns the property list of the average path length
	%  getPropNumber - returns the property number of the average path length
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
	% PathLengthAv methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% PathLengthAv methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% PathLengthAv methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% PathLengthAv methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?PathLengthAv; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">PathLengthAv constants</a>.
	%
	
	methods % constructor
		function m = PathLengthAv(varargin)
			%PathLengthAv() creates a average path length.
			%
			% PathLengthAv(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% PathLengthAv(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			m = m@PathLength(varargin{:});
		end
	end
	methods (Static) % inspection
		function m_class = getClass()
			%GETCLASS returns the class of the average path length.
			%
			% CLASS = PathLengthAv.GETCLASS() returns the class 'PathLengthAv'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the average path length M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('PathLengthAv') returns 'PathLengthAv'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('PathLengthAv')
			%  are less computationally efficient.
			
			m_class = 'PathLengthAv';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the average path length.
			%
			% LIST = PathLengthAv.GETSUBCLASSES() returns all subclasses of 'PathLengthAv'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the average path length M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('PathLengthAv') returns all subclasses of 'PathLengthAv'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('PathLengthAv')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('PathLengthAv', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of average path length.
			%
			% PROPS = PathLengthAv.GETPROPS() returns the property list of average path length
			%  as a row vector.
			%
			% PROPS = PathLengthAv.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the average path length M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('PathLengthAv'[, CATEGORY]) returns the property list of 'PathLengthAv'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('PathLengthAv')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					PathLength.getProps() ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						PathLength.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						PathLength.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						PathLength.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						PathLength.getProps(Category.DATA) ...
						];
				case Category.RESULT
					prop_list = [
						PathLength.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						PathLength.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						PathLength.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						PathLength.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						PathLength.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of average path length.
			%
			% N = PathLengthAv.GETPROPNUMBER() returns the property number of average path length.
			%
			% N = PathLengthAv.GETPROPNUMBER(CATEGORY) returns the property number of average path length
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the average path length M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('PathLengthAv') returns the property number of 'PathLengthAv'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('PathLengthAv')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(PathLengthAv.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in average path length/error.
			%
			% CHECK = PathLengthAv.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(PathLengthAv, PROP) checks whether PROP exists for PathLengthAv.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:PathLengthAv:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:PathLengthAv:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:PathLengthAv:WrongInput]
			%  Element.EXISTSPROP(PathLengthAv, PROP) throws error if PROP does NOT exist for PathLengthAv.
			%   Error id: [BRAPH2:PathLengthAv:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('PathLengthAv')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == PathLengthAv.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PathLengthAv:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PathLengthAv:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for PathLengthAv.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in average path length/error.
			%
			% CHECK = PathLengthAv.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(PathLengthAv, TAG) checks whether TAG exists for PathLengthAv.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:PathLengthAv:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:PathLengthAv:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:PathLengthAv:WrongInput]
			%  Element.EXISTSTAG(PathLengthAv, TAG) throws error if TAG does NOT exist for PathLengthAv.
			%   Error id: [BRAPH2:PathLengthAv:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('PathLengthAv')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			pathlengthav_tag_list = cellfun(@(x) PathLengthAv.getPropTag(x), num2cell(PathLengthAv.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, pathlengthav_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PathLengthAv:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PathLengthAv:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for PathLengthAv.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(PathLengthAv, POINTER) returns property number of POINTER of PathLengthAv.
			%  PROPERTY = M.GETPROPPROP(PathLengthAv, POINTER) returns property number of POINTER of PathLengthAv.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('PathLengthAv')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				pathlengthav_tag_list = cellfun(@(x) PathLengthAv.getPropTag(x), num2cell(PathLengthAv.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, pathlengthav_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(PathLengthAv, POINTER) returns tag of POINTER of PathLengthAv.
			%  TAG = M.GETPROPTAG(PathLengthAv, POINTER) returns tag of POINTER of PathLengthAv.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('PathLengthAv')
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
						tag = getPropTag@PathLength(prop);
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
			%  CATEGORY = Element.GETPROPCATEGORY(PathLengthAv, POINTER) returns category of POINTER of PathLengthAv.
			%  CATEGORY = M.GETPROPCATEGORY(PathLengthAv, POINTER) returns category of POINTER of PathLengthAv.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('PathLengthAv')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = PathLengthAv.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_category = getPropCategory@PathLength(prop);
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
			%  FORMAT = Element.GETPROPFORMAT(PathLengthAv, POINTER) returns format of POINTER of PathLengthAv.
			%  FORMAT = M.GETPROPFORMAT(PathLengthAv, POINTER) returns format of POINTER of PathLengthAv.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('PathLengthAv')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = PathLengthAv.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_format = getPropFormat@PathLength(prop);
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(PathLengthAv, POINTER) returns description of POINTER of PathLengthAv.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(PathLengthAv, POINTER) returns description of POINTER of PathLengthAv.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('PathLengthAv')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = PathLengthAv.getPropProp(pointer);
			
			switch prop
				case PathLengthAv.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the Average Path Length.';
				case PathLengthAv.NAME
					prop_description = 'NAME (constant, string) is the name of the Average Path Length.';
				case PathLengthAv.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the Average Path Length.';
				case PathLengthAv.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the average path length.';
				case PathLengthAv.ID
					prop_description = 'ID (data, string) is a few-letter code of the average path length.';
				case PathLengthAv.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the average path length.';
				case PathLengthAv.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the average path length.';
				case PathLengthAv.SHAPE
					prop_description = 'SHAPE (constant, scalar) is the measure shape __Measure.GLOBAL__.';
				case PathLengthAv.SCOPE
					prop_description = 'SCOPE (constant, scalar) is the measure scope __Measure.UNILAYER__.';
				case PathLengthAv.PARAMETRICITY
					prop_description = 'PARAMETRICITY (constant, scalar) is the parametricity of the measure __Measure.NONPARAMETRIC__.';
				case PathLengthAv.COMPATIBLE_GRAPHS
					prop_description = 'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.';
				case PathLengthAv.M
					prop_description = 'M (result, cell) is the cell containing the average path length.';
				otherwise
					prop_description = getPropDescription@PathLength(prop);
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
			%  SETTINGS = Element.GETPROPSETTINGS(PathLengthAv, POINTER) returns settings of POINTER of PathLengthAv.
			%  SETTINGS = M.GETPROPSETTINGS(PathLengthAv, POINTER) returns settings of POINTER of PathLengthAv.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('PathLengthAv')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = PathLengthAv.getPropProp(pointer);
			
			switch prop
				case PathLengthAv.TEMPLATE
					prop_settings = 'PathLengthAv';
				otherwise
					prop_settings = getPropSettings@PathLength(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = PathLengthAv.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = PathLengthAv.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(PathLengthAv, POINTER) returns the default value of POINTER of PathLengthAv.
			%  DEFAULT = M.GETPROPDEFAULT(PathLengthAv, POINTER) returns the default value of POINTER of PathLengthAv.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('PathLengthAv')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PathLengthAv.getPropProp(pointer);
			
			switch prop
				case PathLengthAv.ELCLASS
					prop_default = 'PathLengthAv';
				case PathLengthAv.NAME
					prop_default = 'Average Path Length';
				case PathLengthAv.DESCRIPTION
					prop_default = 'The Average Path Length (PathLengthAv) of a graph is the average of the sum of the path lengths within each layer.';
				case PathLengthAv.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, PathLengthAv.getPropSettings(prop));
				case PathLengthAv.ID
					prop_default = 'PathLengthAv ID';
				case PathLengthAv.LABEL
					prop_default = 'PathLengthAv label';
				case PathLengthAv.NOTES
					prop_default = 'PathLengthAv notes';
				case PathLengthAv.SHAPE
					prop_default = Measure.GLOBAL;
				case PathLengthAv.SCOPE
					prop_default = Measure.UNILAYER;
				case PathLengthAv.PARAMETRICITY
					prop_default = Measure.NONPARAMETRIC;
				case PathLengthAv.COMPATIBLE_GRAPHS
					prop_default = {'GraphWU' 'GraphBU' 'MultigraphBUD' 'MultigraphBUT' 'MultiplexWU' 'MultiplexBU' 'MultiplexBUD' 'MultiplexBUT' 'OrdMlBUT' 'MultilayerWU'};
				otherwise
					prop_default = getPropDefault@PathLength(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = PathLengthAv.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = PathLengthAv.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(PathLengthAv, POINTER) returns the conditioned default value of POINTER of PathLengthAv.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(PathLengthAv, POINTER) returns the conditioned default value of POINTER of PathLengthAv.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('PathLengthAv')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = PathLengthAv.getPropProp(pointer);
			
			prop_default = PathLengthAv.conditioning(prop, PathLengthAv.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(PathLengthAv, PROP, VALUE) checks VALUE format for PROP of PathLengthAv.
			%  CHECK = M.CHECKPROP(PathLengthAv, PROP, VALUE) checks VALUE format for PROP of PathLengthAv.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:PathLengthAv:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: €BRAPH2.STR€:PathLengthAv:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(PathLengthAv, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PathLengthAv.
			%   Error id: €BRAPH2.STR€:PathLengthAv:€BRAPH2.WRONG_INPUT€
			%  M.CHECKPROP(PathLengthAv, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PathLengthAv.
			%   Error id: €BRAPH2.STR€:PathLengthAv:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('PathLengthAv')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = PathLengthAv.getPropProp(pointer);
			
			switch prop
				case PathLengthAv.TEMPLATE % __PathLengthAv.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, PathLengthAv.getPropSettings(prop));
				otherwise
					if prop <= PathLength.getPropNumber()
						check = checkProp@PathLength(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PathLengthAv:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PathLengthAv:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' PathLengthAv.getPropTag(prop) ' (' PathLengthAv.getFormatTag(PathLengthAv.getPropFormat(prop)) ').'] ...
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
				case PathLengthAv.M % __PathLengthAv.M__
					rng_settings_ = rng(); rng(m.getPropSeed(PathLengthAv.M), 'twister')
					
					g = m.get('G');  % graph from measure class
					
					path_length = calculateValue@PathLength(m, prop);
					L = g.get('LAYERNUMBER');
					path_length_av = cell(L, 1);
					path_length_rule = m.get('RULE');
					parfor li = 1:1:length(path_length_av)
					    switch lower(path_length_rule)
					        case {'subgraphs'}
					            player = path_length{li};
					            path_length_av(li) = {mean(player(player~=Inf))};
					        case {'mean'}
					            path_length_av(li) = {mean(path_length{li})};
					        otherwise  % 'harmonic' 'default'
					            path_length_av(li) = {harmmean(path_length{li})};
					    end
					end
					value = path_length_av;
					
					rng(rng_settings_)
					
				otherwise
					if prop <= PathLength.getPropNumber()
						value = calculateValue@PathLength(m, prop, varargin{:});
					else
						value = calculateValue@Element(m, prop, varargin{:});
					end
			end
			
		end
	end
end
