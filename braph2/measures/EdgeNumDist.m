classdef EdgeNumDist < Measure
	%EdgeNumDist is the Edge Number Distance.
	% It is a subclass of <a href="matlab:help Measure">Measure</a>.
	%
	% The Edge Number Distance (EdgeNumDist) of a graph is the number of edges in the shortest 
	% weighted path between two nodes within a layer.
	%
	% EdgeNumDist methods (constructor):
	%  EdgeNumDist - constructor
	%
	% EdgeNumDist methods:
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
	% EdgeNumDist methods (display):
	%  tostring - string with information about the edge number distance
	%  disp - displays information about the edge number distance
	%  tree - displays the tree of the edge number distance
	%
	% EdgeNumDist methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two edge number distance are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the edge number distance
	%
	% EdgeNumDist methods (save/load, Static):
	%  save - saves BRAPH2 edge number distance as b2 file
	%  load - loads a BRAPH2 edge number distance from a b2 file
	%
	% EdgeNumDist method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the edge number distance
	%
	% EdgeNumDist method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the edge number distance
	%
	% EdgeNumDist methods (inspection, Static):
	%  getClass - returns the class of the edge number distance
	%  getSubclasses - returns all subclasses of EdgeNumDist
	%  getProps - returns the property list of the edge number distance
	%  getPropNumber - returns the property number of the edge number distance
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
	% EdgeNumDist methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% EdgeNumDist methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% EdgeNumDist methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% EdgeNumDist methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?EdgeNumDist; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">EdgeNumDist constants</a>.
	%
	
	methods % constructor
		function m = EdgeNumDist(varargin)
			%EdgeNumDist() creates a edge number distance.
			%
			% EdgeNumDist(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% EdgeNumDist(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the edge number distance.
			%
			% CLASS = EdgeNumDist.GETCLASS() returns the class 'EdgeNumDist'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the edge number distance M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('EdgeNumDist') returns 'EdgeNumDist'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('EdgeNumDist')
			%  are less computationally efficient.
			
			m_class = 'EdgeNumDist';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the edge number distance.
			%
			% LIST = EdgeNumDist.GETSUBCLASSES() returns all subclasses of 'EdgeNumDist'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the edge number distance M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('EdgeNumDist') returns all subclasses of 'EdgeNumDist'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('EdgeNumDist')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('EdgeNumDist', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of edge number distance.
			%
			% PROPS = EdgeNumDist.GETPROPS() returns the property list of edge number distance
			%  as a row vector.
			%
			% PROPS = EdgeNumDist.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the edge number distance M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('EdgeNumDist'[, CATEGORY]) returns the property list of 'EdgeNumDist'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('EdgeNumDist')
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
			%GETPROPNUMBER returns the property number of edge number distance.
			%
			% N = EdgeNumDist.GETPROPNUMBER() returns the property number of edge number distance.
			%
			% N = EdgeNumDist.GETPROPNUMBER(CATEGORY) returns the property number of edge number distance
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the edge number distance M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('EdgeNumDist') returns the property number of 'EdgeNumDist'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('EdgeNumDist')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(EdgeNumDist.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in edge number distance/error.
			%
			% CHECK = EdgeNumDist.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(EdgeNumDist, PROP) checks whether PROP exists for EdgeNumDist.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:EdgeNumDist:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:EdgeNumDist:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:EdgeNumDist:WrongInput]
			%  Element.EXISTSPROP(EdgeNumDist, PROP) throws error if PROP does NOT exist for EdgeNumDist.
			%   Error id: [BRAPH2:EdgeNumDist:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('EdgeNumDist')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == EdgeNumDist.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':EdgeNumDist:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':EdgeNumDist:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for EdgeNumDist.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in edge number distance/error.
			%
			% CHECK = EdgeNumDist.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(EdgeNumDist, TAG) checks whether TAG exists for EdgeNumDist.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:EdgeNumDist:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:EdgeNumDist:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:EdgeNumDist:WrongInput]
			%  Element.EXISTSTAG(EdgeNumDist, TAG) throws error if TAG does NOT exist for EdgeNumDist.
			%   Error id: [BRAPH2:EdgeNumDist:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('EdgeNumDist')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			edgenumdist_tag_list = cellfun(@(x) EdgeNumDist.getPropTag(x), num2cell(EdgeNumDist.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, edgenumdist_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':EdgeNumDist:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':EdgeNumDist:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for EdgeNumDist.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(EdgeNumDist, POINTER) returns property number of POINTER of EdgeNumDist.
			%  PROPERTY = M.GETPROPPROP(EdgeNumDist, POINTER) returns property number of POINTER of EdgeNumDist.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('EdgeNumDist')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				edgenumdist_tag_list = cellfun(@(x) EdgeNumDist.getPropTag(x), num2cell(EdgeNumDist.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, edgenumdist_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(EdgeNumDist, POINTER) returns tag of POINTER of EdgeNumDist.
			%  TAG = M.GETPROPTAG(EdgeNumDist, POINTER) returns tag of POINTER of EdgeNumDist.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('EdgeNumDist')
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
			%  CATEGORY = Element.GETPROPCATEGORY(EdgeNumDist, POINTER) returns category of POINTER of EdgeNumDist.
			%  CATEGORY = M.GETPROPCATEGORY(EdgeNumDist, POINTER) returns category of POINTER of EdgeNumDist.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('EdgeNumDist')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = EdgeNumDist.getPropProp(pointer);
			
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
			%  FORMAT = Element.GETPROPFORMAT(EdgeNumDist, POINTER) returns format of POINTER of EdgeNumDist.
			%  FORMAT = M.GETPROPFORMAT(EdgeNumDist, POINTER) returns format of POINTER of EdgeNumDist.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('EdgeNumDist')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = EdgeNumDist.getPropProp(pointer);
			
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(EdgeNumDist, POINTER) returns description of POINTER of EdgeNumDist.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(EdgeNumDist, POINTER) returns description of POINTER of EdgeNumDist.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('EdgeNumDist')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = EdgeNumDist.getPropProp(pointer);
			
			switch prop
				case EdgeNumDist.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the Edge Number Distance.';
				case EdgeNumDist.NAME
					prop_description = 'NAME (constant, string) is the name of the Edge Number Distance.';
				case EdgeNumDist.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the Edge Number Distance.';
				case EdgeNumDist.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the Edge Number Distance.';
				case EdgeNumDist.ID
					prop_description = 'ID (data, string) is a few-letter code of the Edge Number Distance.';
				case EdgeNumDist.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the Edge Number Distance.';
				case EdgeNumDist.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the Edge Number Distance.';
				case EdgeNumDist.SHAPE
					prop_description = 'SHAPE (constant, scalar) is the measure shape __Measure.BINODAL__.';
				case EdgeNumDist.SCOPE
					prop_description = 'SCOPE (constant, scalar) is the measure scope __Measure.UNILAYER__.';
				case EdgeNumDist.PARAMETRICITY
					prop_description = 'PARAMETRICITY (constant, scalar) is the parametricity of the measure __Measure.NONPARAMETRIC__.';
				case EdgeNumDist.COMPATIBLE_GRAPHS
					prop_description = 'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.';
				case EdgeNumDist.M
					prop_description = 'M (result, cell) is the Edge Number Distance.';
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
			%  SETTINGS = Element.GETPROPSETTINGS(EdgeNumDist, POINTER) returns settings of POINTER of EdgeNumDist.
			%  SETTINGS = M.GETPROPSETTINGS(EdgeNumDist, POINTER) returns settings of POINTER of EdgeNumDist.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('EdgeNumDist')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = EdgeNumDist.getPropProp(pointer);
			
			switch prop
				case EdgeNumDist.TEMPLATE
					prop_settings = 'EdgeNumDist';
				otherwise
					prop_settings = getPropSettings@Measure(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = EdgeNumDist.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = EdgeNumDist.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(EdgeNumDist, POINTER) returns the default value of POINTER of EdgeNumDist.
			%  DEFAULT = M.GETPROPDEFAULT(EdgeNumDist, POINTER) returns the default value of POINTER of EdgeNumDist.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('EdgeNumDist')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = EdgeNumDist.getPropProp(pointer);
			
			switch prop
				case EdgeNumDist.ELCLASS
					prop_default = 'EdgeNumDist';
				case EdgeNumDist.NAME
					prop_default = 'Edge Number Distance';
				case EdgeNumDist.DESCRIPTION
					prop_default = 'The Edge Number Distance (EdgeNumDist) of a graph is the number of edges in the shortest weighted path between two nodes within a layer.';
				case EdgeNumDist.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, EdgeNumDist.getPropSettings(prop));
				case EdgeNumDist.ID
					prop_default = 'EdgeNumDist ID';
				case EdgeNumDist.LABEL
					prop_default = 'Edge Number Distance label';
				case EdgeNumDist.NOTES
					prop_default = 'Edge Number Distance notes';
				case EdgeNumDist.SHAPE
					prop_default = Measure.BINODAL;
				case EdgeNumDist.SCOPE
					prop_default = Measure.UNILAYER;
				case EdgeNumDist.PARAMETRICITY
					prop_default = Measure.NONPARAMETRIC;
				case EdgeNumDist.COMPATIBLE_GRAPHS
					prop_default = {'GraphWD' 'GraphWU' 'MultiplexWD' 'MultiplexWU'};;
				otherwise
					prop_default = getPropDefault@Measure(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = EdgeNumDist.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = EdgeNumDist.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(EdgeNumDist, POINTER) returns the conditioned default value of POINTER of EdgeNumDist.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(EdgeNumDist, POINTER) returns the conditioned default value of POINTER of EdgeNumDist.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('EdgeNumDist')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = EdgeNumDist.getPropProp(pointer);
			
			prop_default = EdgeNumDist.conditioning(prop, EdgeNumDist.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(EdgeNumDist, PROP, VALUE) checks VALUE format for PROP of EdgeNumDist.
			%  CHECK = M.CHECKPROP(EdgeNumDist, PROP, VALUE) checks VALUE format for PROP of EdgeNumDist.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:EdgeNumDist:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: €BRAPH2.STR€:EdgeNumDist:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(EdgeNumDist, PROP, VALUE) throws error if VALUE has not a valid format for PROP of EdgeNumDist.
			%   Error id: €BRAPH2.STR€:EdgeNumDist:€BRAPH2.WRONG_INPUT€
			%  M.CHECKPROP(EdgeNumDist, PROP, VALUE) throws error if VALUE has not a valid format for PROP of EdgeNumDist.
			%   Error id: €BRAPH2.STR€:EdgeNumDist:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('EdgeNumDist')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = EdgeNumDist.getPropProp(pointer);
			
			switch prop
				case EdgeNumDist.TEMPLATE % __EdgeNumDist.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, EdgeNumDist.getPropSettings(prop));
				otherwise
					if prop <= Measure.getPropNumber()
						check = checkProp@Measure(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':EdgeNumDist:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':EdgeNumDist:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' EdgeNumDist.getPropTag(prop) ' (' EdgeNumDist.getFormatTag(EdgeNumDist.getPropFormat(prop)) ').'] ...
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
				case EdgeNumDist.M % __EdgeNumDist.M__
					rng_settings_ = rng(); rng(m.getPropSeed(EdgeNumDist.M), 'twister')
					
					g = m.get('G'); % graph from measure class
					A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
					L = g.get('LAYERNUMBER');
					edge_number_distance = cell(L, 1);
					
					for li = 1:L
					    Aii = A{li, li};
					    edge_number_distance(li) = {getEdgeNumDistance(Aii)};
					end
					
					value = edge_number_distance;
					
					rng(rng_settings_)
					
				otherwise
					if prop <= Measure.getPropNumber()
						value = calculateValue@Measure(m, prop, varargin{:});
					else
						value = calculateValue@Element(m, prop, varargin{:});
					end
			end
			
			function edge_number_distance = getEdgeNumDistance(A)
			    %GETEDGENUMBERDISTANCE calculates the edge distance number of a graph.
			    
			    ind = A~=0;
			    A(ind) = A(ind).^-1;
			    n = length(A);
			    D = inf(n);
			    D(1:n+1:end) = 0; % distance matrix
			    B = zeros(n); % number of edges matrix
			    
			    for u = 1:n
			        S = true(1, n); % distance permanence (true is temporary)
			        L1 = A;
			        V = u;
			    
			        while 1
			            S(V) = 0; % distance u->V is now permanent
			            L1(:, V) = 0; % no in-edges as already shortest
			    
			            for v = V
			                T = find(L1(v, :)); % neighbours of shortest nodes
			                [d, wi] = min([D(u, T);D(u, v)+L1(v, T)]);
			                D(u, T) = d; % smallest of old/new path lengths
			                ind = T(wi==2); % indices of lengthened paths
			                B(u, ind) = B(u, v) + 1; % increment no. of edges in lengthened paths
			            end
			    
			            minD = min(D(u, S));
			            if isempty(minD) || isinf(minD) % isempty: all nodes reached;
			                break % isinf: some nodes cannot be reached
			            end
			    
			            V = find(D(u,:)==minD);
			        end
			    end
			    edge_number_distance = B;
			end
		end
	end
end
