classdef AnalyzeEnsemble_CON_MP_BUD < AnalyzeEnsemble
	%AnalyzeEnsemble_CON_MP_BUD is an ensemble-based graph analysis using connectivity multiplex data of fixed density.
	% It is a subclass of <a href="matlab:help AnalyzeEnsemble">AnalyzeEnsemble</a>.
	%
	% This graph analysis (AnalyzeEnsemble_CON_MP_BUD) analyzes connectivity multiplex data 
	% using binary undirected multigraphs with fixed densities.
	%
	% AnalyzeEnsemble_CON_MP_BUD methods (constructor):
	%  AnalyzeEnsemble_CON_MP_BUD - constructor
	%
	% AnalyzeEnsemble_CON_MP_BUD methods:
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
	% AnalyzeEnsemble_CON_MP_BUD methods (display):
	%  tostring - string with information about the graph analysis with connectivity multiplex data of fixed density
	%  disp - displays information about the graph analysis with connectivity multiplex data of fixed density
	%  tree - displays the tree of the graph analysis with connectivity multiplex data of fixed density
	%
	% AnalyzeEnsemble_CON_MP_BUD methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two graph analysis with connectivity multiplex data of fixed density are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the graph analysis with connectivity multiplex data of fixed density
	%
	% AnalyzeEnsemble_CON_MP_BUD methods (save/load, Static):
	%  save - saves BRAPH2 graph analysis with connectivity multiplex data of fixed density as b2 file
	%  load - loads a BRAPH2 graph analysis with connectivity multiplex data of fixed density from a b2 file
	%
	% AnalyzeEnsemble_CON_MP_BUD method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the graph analysis with connectivity multiplex data of fixed density
	%
	% AnalyzeEnsemble_CON_MP_BUD method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the graph analysis with connectivity multiplex data of fixed density
	%
	% AnalyzeEnsemble_CON_MP_BUD methods (inspection, Static):
	%  getClass - returns the class of the graph analysis with connectivity multiplex data of fixed density
	%  getSubclasses - returns all subclasses of AnalyzeEnsemble_CON_MP_BUD
	%  getProps - returns the property list of the graph analysis with connectivity multiplex data of fixed density
	%  getPropNumber - returns the property number of the graph analysis with connectivity multiplex data of fixed density
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
	% AnalyzeEnsemble_CON_MP_BUD methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% AnalyzeEnsemble_CON_MP_BUD methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% AnalyzeEnsemble_CON_MP_BUD methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% AnalyzeEnsemble_CON_MP_BUD methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?AnalyzeEnsemble_CON_MP_BUD; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">AnalyzeEnsemble_CON_MP_BUD constants</a>.
	%
	%
	% See also SubjectCON_MP, MultiplexBUD.
	
	properties (Constant) % properties
		DENSITIES = AnalyzeEnsemble.getPropNumber() + 1;
		DENSITIES_TAG = 'DENSITIES';
		DENSITIES_CATEGORY = Category.PARAMETER;
		DENSITIES_FORMAT = Format.RVECTOR;
	end
	methods % constructor
		function a = AnalyzeEnsemble_CON_MP_BUD(varargin)
			%AnalyzeEnsemble_CON_MP_BUD() creates a graph analysis with connectivity multiplex data of fixed density.
			%
			% AnalyzeEnsemble_CON_MP_BUD(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% AnalyzeEnsemble_CON_MP_BUD(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			a = a@AnalyzeEnsemble(varargin{:});
		end
	end
	methods (Static) % inspection
		function a_class = getClass()
			%GETCLASS returns the class of the graph analysis with connectivity multiplex data of fixed density.
			%
			% CLASS = AnalyzeEnsemble_CON_MP_BUD.GETCLASS() returns the class 'AnalyzeEnsemble_CON_MP_BUD'.
			%
			% Alternative forms to call this method are:
			%  CLASS = A.GETCLASS() returns the class of the graph analysis with connectivity multiplex data of fixed density A.
			%  CLASS = Element.GETCLASS(A) returns the class of 'A'.
			%  CLASS = Element.GETCLASS('AnalyzeEnsemble_CON_MP_BUD') returns 'AnalyzeEnsemble_CON_MP_BUD'.
			%
			% Note that the Element.GETCLASS(A) and Element.GETCLASS('AnalyzeEnsemble_CON_MP_BUD')
			%  are less computationally efficient.
			
			a_class = 'AnalyzeEnsemble_CON_MP_BUD';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the graph analysis with connectivity multiplex data of fixed density.
			%
			% LIST = AnalyzeEnsemble_CON_MP_BUD.GETSUBCLASSES() returns all subclasses of 'AnalyzeEnsemble_CON_MP_BUD'.
			%
			% Alternative forms to call this method are:
			%  LIST = A.GETSUBCLASSES() returns all subclasses of the graph analysis with connectivity multiplex data of fixed density A.
			%  LIST = Element.GETSUBCLASSES(A) returns all subclasses of 'A'.
			%  LIST = Element.GETSUBCLASSES('AnalyzeEnsemble_CON_MP_BUD') returns all subclasses of 'AnalyzeEnsemble_CON_MP_BUD'.
			%
			% Note that the Element.GETSUBCLASSES(A) and Element.GETSUBCLASSES('AnalyzeEnsemble_CON_MP_BUD')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('AnalyzeEnsemble_CON_MP_BUD', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of graph analysis with connectivity multiplex data of fixed density.
			%
			% PROPS = AnalyzeEnsemble_CON_MP_BUD.GETPROPS() returns the property list of graph analysis with connectivity multiplex data of fixed density
			%  as a row vector.
			%
			% PROPS = AnalyzeEnsemble_CON_MP_BUD.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = A.GETPROPS([CATEGORY]) returns the property list of the graph analysis with connectivity multiplex data of fixed density A.
			%  PROPS = Element.GETPROPS(A[, CATEGORY]) returns the property list of 'A'.
			%  PROPS = Element.GETPROPS('AnalyzeEnsemble_CON_MP_BUD'[, CATEGORY]) returns the property list of 'AnalyzeEnsemble_CON_MP_BUD'.
			%
			% Note that the Element.GETPROPS(A) and Element.GETPROPS('AnalyzeEnsemble_CON_MP_BUD')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					AnalyzeEnsemble.getProps() ...
						AnalyzeEnsemble_CON_MP_BUD.DENSITIES ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						AnalyzeEnsemble.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						AnalyzeEnsemble.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						AnalyzeEnsemble.getProps(Category.PARAMETER) ...
						AnalyzeEnsemble_CON_MP_BUD.DENSITIES ...
						];
				case Category.DATA
					prop_list = [ ...
						AnalyzeEnsemble.getProps(Category.DATA) ...
						];
				case Category.RESULT
					prop_list = [
						AnalyzeEnsemble.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						AnalyzeEnsemble.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						AnalyzeEnsemble.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						AnalyzeEnsemble.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						AnalyzeEnsemble.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of graph analysis with connectivity multiplex data of fixed density.
			%
			% N = AnalyzeEnsemble_CON_MP_BUD.GETPROPNUMBER() returns the property number of graph analysis with connectivity multiplex data of fixed density.
			%
			% N = AnalyzeEnsemble_CON_MP_BUD.GETPROPNUMBER(CATEGORY) returns the property number of graph analysis with connectivity multiplex data of fixed density
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = A.GETPROPNUMBER([CATEGORY]) returns the property number of the graph analysis with connectivity multiplex data of fixed density A.
			%  N = Element.GETPROPNUMBER(A) returns the property number of 'A'.
			%  N = Element.GETPROPNUMBER('AnalyzeEnsemble_CON_MP_BUD') returns the property number of 'AnalyzeEnsemble_CON_MP_BUD'.
			%
			% Note that the Element.GETPROPNUMBER(A) and Element.GETPROPNUMBER('AnalyzeEnsemble_CON_MP_BUD')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(AnalyzeEnsemble_CON_MP_BUD.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in graph analysis with connectivity multiplex data of fixed density/error.
			%
			% CHECK = AnalyzeEnsemble_CON_MP_BUD.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = A.EXISTSPROP(PROP) checks whether PROP exists for A.
			%  CHECK = Element.EXISTSPROP(A, PROP) checks whether PROP exists for A.
			%  CHECK = Element.EXISTSPROP(AnalyzeEnsemble_CON_MP_BUD, PROP) checks whether PROP exists for AnalyzeEnsemble_CON_MP_BUD.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:AnalyzeEnsemble_CON_MP_BUD:WrongInput]
			%
			% Alternative forms to call this method are:
			%  A.EXISTSPROP(PROP) throws error if PROP does NOT exist for A.
			%   Error id: [BRAPH2:AnalyzeEnsemble_CON_MP_BUD:WrongInput]
			%  Element.EXISTSPROP(A, PROP) throws error if PROP does NOT exist for A.
			%   Error id: [BRAPH2:AnalyzeEnsemble_CON_MP_BUD:WrongInput]
			%  Element.EXISTSPROP(AnalyzeEnsemble_CON_MP_BUD, PROP) throws error if PROP does NOT exist for AnalyzeEnsemble_CON_MP_BUD.
			%   Error id: [BRAPH2:AnalyzeEnsemble_CON_MP_BUD:WrongInput]
			%
			% Note that the Element.EXISTSPROP(A) and Element.EXISTSPROP('AnalyzeEnsemble_CON_MP_BUD')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == AnalyzeEnsemble_CON_MP_BUD.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':AnalyzeEnsemble_CON_MP_BUD:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':AnalyzeEnsemble_CON_MP_BUD:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for AnalyzeEnsemble_CON_MP_BUD.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in graph analysis with connectivity multiplex data of fixed density/error.
			%
			% CHECK = AnalyzeEnsemble_CON_MP_BUD.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = A.EXISTSTAG(TAG) checks whether TAG exists for A.
			%  CHECK = Element.EXISTSTAG(A, TAG) checks whether TAG exists for A.
			%  CHECK = Element.EXISTSTAG(AnalyzeEnsemble_CON_MP_BUD, TAG) checks whether TAG exists for AnalyzeEnsemble_CON_MP_BUD.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:AnalyzeEnsemble_CON_MP_BUD:WrongInput]
			%
			% Alternative forms to call this method are:
			%  A.EXISTSTAG(TAG) throws error if TAG does NOT exist for A.
			%   Error id: [BRAPH2:AnalyzeEnsemble_CON_MP_BUD:WrongInput]
			%  Element.EXISTSTAG(A, TAG) throws error if TAG does NOT exist for A.
			%   Error id: [BRAPH2:AnalyzeEnsemble_CON_MP_BUD:WrongInput]
			%  Element.EXISTSTAG(AnalyzeEnsemble_CON_MP_BUD, TAG) throws error if TAG does NOT exist for AnalyzeEnsemble_CON_MP_BUD.
			%   Error id: [BRAPH2:AnalyzeEnsemble_CON_MP_BUD:WrongInput]
			%
			% Note that the Element.EXISTSTAG(A) and Element.EXISTSTAG('AnalyzeEnsemble_CON_MP_BUD')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			analyzeensemble_con_mp_bud_tag_list = cellfun(@(x) AnalyzeEnsemble_CON_MP_BUD.getPropTag(x), num2cell(AnalyzeEnsemble_CON_MP_BUD.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, analyzeensemble_con_mp_bud_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':AnalyzeEnsemble_CON_MP_BUD:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':AnalyzeEnsemble_CON_MP_BUD:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for AnalyzeEnsemble_CON_MP_BUD.'] ...
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
			%  PROPERTY = A.GETPROPPROP(POINTER) returns property number of POINTER of A.
			%  PROPERTY = Element.GETPROPPROP(AnalyzeEnsemble_CON_MP_BUD, POINTER) returns property number of POINTER of AnalyzeEnsemble_CON_MP_BUD.
			%  PROPERTY = A.GETPROPPROP(AnalyzeEnsemble_CON_MP_BUD, POINTER) returns property number of POINTER of AnalyzeEnsemble_CON_MP_BUD.
			%
			% Note that the Element.GETPROPPROP(A) and Element.GETPROPPROP('AnalyzeEnsemble_CON_MP_BUD')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				analyzeensemble_con_mp_bud_tag_list = cellfun(@(x) AnalyzeEnsemble_CON_MP_BUD.getPropTag(x), num2cell(AnalyzeEnsemble_CON_MP_BUD.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, analyzeensemble_con_mp_bud_tag_list)); % tag = pointer
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
			%  TAG = A.GETPROPTAG(POINTER) returns tag of POINTER of A.
			%  TAG = Element.GETPROPTAG(AnalyzeEnsemble_CON_MP_BUD, POINTER) returns tag of POINTER of AnalyzeEnsemble_CON_MP_BUD.
			%  TAG = A.GETPROPTAG(AnalyzeEnsemble_CON_MP_BUD, POINTER) returns tag of POINTER of AnalyzeEnsemble_CON_MP_BUD.
			%
			% Note that the Element.GETPROPTAG(A) and Element.GETPROPTAG('AnalyzeEnsemble_CON_MP_BUD')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case AnalyzeEnsemble_CON_MP_BUD.DENSITIES
						tag = AnalyzeEnsemble_CON_MP_BUD.DENSITIES_TAG;
					otherwise
						tag = getPropTag@AnalyzeEnsemble(prop);
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
			%  CATEGORY = A.GETPROPCATEGORY(POINTER) returns category of POINTER of A.
			%  CATEGORY = Element.GETPROPCATEGORY(AnalyzeEnsemble_CON_MP_BUD, POINTER) returns category of POINTER of AnalyzeEnsemble_CON_MP_BUD.
			%  CATEGORY = A.GETPROPCATEGORY(AnalyzeEnsemble_CON_MP_BUD, POINTER) returns category of POINTER of AnalyzeEnsemble_CON_MP_BUD.
			%
			% Note that the Element.GETPROPCATEGORY(A) and Element.GETPROPCATEGORY('AnalyzeEnsemble_CON_MP_BUD')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = AnalyzeEnsemble_CON_MP_BUD.getPropProp(pointer);
			
			switch prop
				case AnalyzeEnsemble_CON_MP_BUD.DENSITIES
					prop_category = AnalyzeEnsemble_CON_MP_BUD.DENSITIES_CATEGORY;
				otherwise
					prop_category = getPropCategory@AnalyzeEnsemble(prop);
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
			%  FORMAT = A.GETPROPFORMAT(POINTER) returns format of POINTER of A.
			%  FORMAT = Element.GETPROPFORMAT(AnalyzeEnsemble_CON_MP_BUD, POINTER) returns format of POINTER of AnalyzeEnsemble_CON_MP_BUD.
			%  FORMAT = A.GETPROPFORMAT(AnalyzeEnsemble_CON_MP_BUD, POINTER) returns format of POINTER of AnalyzeEnsemble_CON_MP_BUD.
			%
			% Note that the Element.GETPROPFORMAT(A) and Element.GETPROPFORMAT('AnalyzeEnsemble_CON_MP_BUD')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = AnalyzeEnsemble_CON_MP_BUD.getPropProp(pointer);
			
			switch prop
				case AnalyzeEnsemble_CON_MP_BUD.DENSITIES
					prop_format = AnalyzeEnsemble_CON_MP_BUD.DENSITIES_FORMAT;
				otherwise
					prop_format = getPropFormat@AnalyzeEnsemble(prop);
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
			%  DESCRIPTION = A.GETPROPDESCRIPTION(POINTER) returns description of POINTER of A.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(AnalyzeEnsemble_CON_MP_BUD, POINTER) returns description of POINTER of AnalyzeEnsemble_CON_MP_BUD.
			%  DESCRIPTION = A.GETPROPDESCRIPTION(AnalyzeEnsemble_CON_MP_BUD, POINTER) returns description of POINTER of AnalyzeEnsemble_CON_MP_BUD.
			%
			% Note that the Element.GETPROPDESCRIPTION(A) and Element.GETPROPDESCRIPTION('AnalyzeEnsemble_CON_MP_BUD')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = AnalyzeEnsemble_CON_MP_BUD.getPropProp(pointer);
			
			switch prop
				case AnalyzeEnsemble_CON_MP_BUD.DENSITIES
					prop_description = 'DENSITIES (parameter, rvector) is the vector of densities.';
				case AnalyzeEnsemble_CON_MP_BUD.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the % % % .';
				case AnalyzeEnsemble_CON_MP_BUD.NAME
					prop_description = 'NAME (constant, string) is the name of the ensemble-based graph analysis with connectivity multiplex data of fixed density.';
				case AnalyzeEnsemble_CON_MP_BUD.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the ensemble-based graph analysis with connectivity multiplex data of fixed density.';
				case AnalyzeEnsemble_CON_MP_BUD.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the ensemble-based graph analysis with connectivity multiplex data of fixed density.';
				case AnalyzeEnsemble_CON_MP_BUD.ID
					prop_description = 'ID (data, string) is a few-letter code for the ensemble-based graph analysis with connectivity multiplex data of fixed density.';
				case AnalyzeEnsemble_CON_MP_BUD.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the ensemble-based graph analysis with connectivity multiplex data of fixed density.';
				case AnalyzeEnsemble_CON_MP_BUD.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the ensemble-based graph analysis with connectivity multiplex data of fixed density.';
				case AnalyzeEnsemble_CON_MP_BUD.GR
					prop_description = 'GR (data, item) is the subject group, which also defines the subject class SubjectCON_MP.';
				case AnalyzeEnsemble_CON_MP_BUD.GRAPH_TEMPLATE
					prop_description = 'GRAPH_TEMPLATE (parameter, item) is the graph template to set all graph and measure parameters.';
				case AnalyzeEnsemble_CON_MP_BUD.G_DICT
					prop_description = 'G_DICT (result, idict) is the graph (MultiplexBUD) ensemble obtained from this analysis.';
				case AnalyzeEnsemble_CON_MP_BUD.ME_DICT
					prop_description = 'ME_DICT (result, idict) contains the calculated measures of the graph ensemble.';
				otherwise
					prop_description = getPropDescription@AnalyzeEnsemble(prop);
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
			%  SETTINGS = A.GETPROPSETTINGS(POINTER) returns settings of POINTER of A.
			%  SETTINGS = Element.GETPROPSETTINGS(AnalyzeEnsemble_CON_MP_BUD, POINTER) returns settings of POINTER of AnalyzeEnsemble_CON_MP_BUD.
			%  SETTINGS = A.GETPROPSETTINGS(AnalyzeEnsemble_CON_MP_BUD, POINTER) returns settings of POINTER of AnalyzeEnsemble_CON_MP_BUD.
			%
			% Note that the Element.GETPROPSETTINGS(A) and Element.GETPROPSETTINGS('AnalyzeEnsemble_CON_MP_BUD')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = AnalyzeEnsemble_CON_MP_BUD.getPropProp(pointer);
			
			switch prop
				case AnalyzeEnsemble_CON_MP_BUD.DENSITIES
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case AnalyzeEnsemble_CON_MP_BUD.GRAPH_TEMPLATE
					prop_settings = 'MultiplexBUD';
				case AnalyzeEnsemble_CON_MP_BUD.G_DICT
					prop_settings = 'MultiplexBUD';
				otherwise
					prop_settings = getPropSettings@AnalyzeEnsemble(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = AnalyzeEnsemble_CON_MP_BUD.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = AnalyzeEnsemble_CON_MP_BUD.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = A.GETPROPDEFAULT(POINTER) returns the default value of POINTER of A.
			%  DEFAULT = Element.GETPROPDEFAULT(AnalyzeEnsemble_CON_MP_BUD, POINTER) returns the default value of POINTER of AnalyzeEnsemble_CON_MP_BUD.
			%  DEFAULT = A.GETPROPDEFAULT(AnalyzeEnsemble_CON_MP_BUD, POINTER) returns the default value of POINTER of AnalyzeEnsemble_CON_MP_BUD.
			%
			% Note that the Element.GETPROPDEFAULT(A) and Element.GETPROPDEFAULT('AnalyzeEnsemble_CON_MP_BUD')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = AnalyzeEnsemble_CON_MP_BUD.getPropProp(pointer);
			
			switch prop
				case AnalyzeEnsemble_CON_MP_BUD.DENSITIES
					prop_default = [1:1:10];
				case AnalyzeEnsemble_CON_MP_BUD.ELCLASS
					prop_default = 'AnalyzeEnsemble_CON_MP_BUD';
				case AnalyzeEnsemble_CON_MP_BUD.NAME
					prop_default = 'AnalyzeEnsemble_CON_MP_BUD';
				case AnalyzeEnsemble_CON_MP_BUD.DESCRIPTION
					prop_default = 'This graph analysis (AnalyzeEnsemble_CON_MP_BUD) analyzes connectivity multiplex data using binary undirected multigraphs with fixed densities.';
				case AnalyzeEnsemble_CON_MP_BUD.ID
					prop_default = 'AnalyzeEnsemble_CON_MP_BUD ID';
				case AnalyzeEnsemble_CON_MP_BUD.LABEL
					prop_default = 'AnalyzeEnsemble_CON_MP_BUD label';
				case AnalyzeEnsemble_CON_MP_BUD.NOTES
					prop_default = 'AnalyzeEnsemble_CON_MP_BUD notes';
				case AnalyzeEnsemble_CON_MP_BUD.GR
					prop_default = Group('SUB_CLASS', 'SubjectCON_MP');
				case AnalyzeEnsemble_CON_MP_BUD.GRAPH_TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, AnalyzeEnsemble_CON_MP_BUD.getPropSettings(prop));
				case AnalyzeEnsemble_CON_MP_BUD.G_DICT
					prop_default = Format.getFormatDefault(Format.IDICT, AnalyzeEnsemble_CON_MP_BUD.getPropSettings(prop));
				otherwise
					prop_default = getPropDefault@AnalyzeEnsemble(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = AnalyzeEnsemble_CON_MP_BUD.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = AnalyzeEnsemble_CON_MP_BUD.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = A.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of A.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(AnalyzeEnsemble_CON_MP_BUD, POINTER) returns the conditioned default value of POINTER of AnalyzeEnsemble_CON_MP_BUD.
			%  DEFAULT = A.GETPROPDEFAULTCONDITIONED(AnalyzeEnsemble_CON_MP_BUD, POINTER) returns the conditioned default value of POINTER of AnalyzeEnsemble_CON_MP_BUD.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(A) and Element.GETPROPDEFAULTCONDITIONED('AnalyzeEnsemble_CON_MP_BUD')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = AnalyzeEnsemble_CON_MP_BUD.getPropProp(pointer);
			
			prop_default = AnalyzeEnsemble_CON_MP_BUD.conditioning(prop, AnalyzeEnsemble_CON_MP_BUD.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = A.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = A.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of A.
			%  CHECK = Element.CHECKPROP(AnalyzeEnsemble_CON_MP_BUD, PROP, VALUE) checks VALUE format for PROP of AnalyzeEnsemble_CON_MP_BUD.
			%  CHECK = A.CHECKPROP(AnalyzeEnsemble_CON_MP_BUD, PROP, VALUE) checks VALUE format for PROP of AnalyzeEnsemble_CON_MP_BUD.
			% 
			% A.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:AnalyzeEnsemble_CON_MP_BUD:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  A.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of A.
			%   Error id: €BRAPH2.STR€:AnalyzeEnsemble_CON_MP_BUD:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(AnalyzeEnsemble_CON_MP_BUD, PROP, VALUE) throws error if VALUE has not a valid format for PROP of AnalyzeEnsemble_CON_MP_BUD.
			%   Error id: €BRAPH2.STR€:AnalyzeEnsemble_CON_MP_BUD:€BRAPH2.WRONG_INPUT€
			%  A.CHECKPROP(AnalyzeEnsemble_CON_MP_BUD, PROP, VALUE) throws error if VALUE has not a valid format for PROP of AnalyzeEnsemble_CON_MP_BUD.
			%   Error id: €BRAPH2.STR€:AnalyzeEnsemble_CON_MP_BUD:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(A) and Element.CHECKPROP('AnalyzeEnsemble_CON_MP_BUD')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = AnalyzeEnsemble_CON_MP_BUD.getPropProp(pointer);
			
			switch prop
				case AnalyzeEnsemble_CON_MP_BUD.DENSITIES % __AnalyzeEnsemble_CON_MP_BUD.DENSITIES__
					check = Format.checkFormat(Format.RVECTOR, value, AnalyzeEnsemble_CON_MP_BUD.getPropSettings(prop));
				case AnalyzeEnsemble_CON_MP_BUD.GRAPH_TEMPLATE % __AnalyzeEnsemble_CON_MP_BUD.GRAPH_TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, AnalyzeEnsemble_CON_MP_BUD.getPropSettings(prop));
				case AnalyzeEnsemble_CON_MP_BUD.G_DICT % __AnalyzeEnsemble_CON_MP_BUD.G_DICT__
					check = Format.checkFormat(Format.IDICT, value, AnalyzeEnsemble_CON_MP_BUD.getPropSettings(prop));
				otherwise
					if prop <= AnalyzeEnsemble.getPropNumber()
						check = checkProp@AnalyzeEnsemble(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':AnalyzeEnsemble_CON_MP_BUD:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':AnalyzeEnsemble_CON_MP_BUD:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' AnalyzeEnsemble_CON_MP_BUD.getPropTag(prop) ' (' AnalyzeEnsemble_CON_MP_BUD.getFormatTag(AnalyzeEnsemble_CON_MP_BUD.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % postset
		function postset(a, prop)
			%POSTSET postprocessing after a prop has been set.
			%
			% POSTPROCESSING(EL, PROP) postprocessesing after PROP has been set. By
			%  default, this function does not do anything, so it should be implemented
			%  in the subclasses of Element when needed.
			%
			% This postprocessing occurs only when PROP is set.
			%
			% See also conditioning, preset, checkProp, postprocessing, calculateValue,
			%  checkValue.
			
			switch prop
				case AnalyzeEnsemble_CON_MP_BUD.DENSITIES % __AnalyzeEnsemble_CON_MP_BUD.DENSITIES__
					a.memorize('GRAPH_TEMPLATE').set('DENSITIES', a.getCallback('DENSITIES'));
					
				otherwise
					if prop <= AnalyzeEnsemble.getPropNumber()
						postset@AnalyzeEnsemble(a, prop);
					end
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(a, prop, varargin)
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
				case AnalyzeEnsemble_CON_MP_BUD.G_DICT % __AnalyzeEnsemble_CON_MP_BUD.G_DICT__
					rng_settings_ = rng(); rng(a.getPropSeed(AnalyzeEnsemble_CON_MP_BUD.G_DICT), 'twister')
					
					g_dict = IndexedDictionary('IT_CLASS', 'MultiplexBUD');
					gr = a.get('GR');
					
					densities = a.get('DENSITIES'); % this is a vector
					for i = 1:1:gr.get('SUB_DICT').get('LENGTH')
						sub = gr.get('SUB_DICT').get('IT', i);
					    L = sub.get('L');
					
					    g = MultiplexBUD( ...
					        'ID', ['graph ' sub.get('ID')], ...
					        'B', sub.getCallback('CON_MP'), ...
					        'DENSITIES', densities, ...
					        'LAYERLABELS', cellfun(@(x) ['L' num2str(x)], num2cell([1:1:L]), 'UniformOutput', false), ...
					        'NODELABELS', a.get('GR').get('SUB_DICT').get('IT', 1).get('BA').get('BR_DICT').get('KEYS') ...
					        );
					    g_dict.get('ADD', g)
					end
					
					if ~isa(a.get('GRAPH_TEMPLATE'), 'NoValue')
					    for i = 1:1:g_dict.get('LENGTH')
					        g_dict.get('IT', i).set('TEMPLATE', a.get('GRAPH_TEMPLATE'))
					    end
					end
					
					value = g_dict;
					
					rng(rng_settings_)
					
				otherwise
					if prop <= AnalyzeEnsemble.getPropNumber()
						value = calculateValue@AnalyzeEnsemble(a, prop, varargin{:});
					else
						value = calculateValue@Element(a, prop, varargin{:});
					end
			end
			
		end
	end
	methods % GUI
		function pr = getPanelProp(a, prop, varargin)
			%GETPANELPROP returns a prop panel.
			%
			% PR = GETPANELPROP(EL, PROP) returns the panel of prop PROP.
			%
			% PR = GETPANELPROP(EL, PROP, 'Name', Value, ...) sets the properties 
			%  of the panel prop.
			%
			% See also PanelProp, PanelPropAlpha, PanelPropCell, PanelPropClass,
			%  PanelPropClassList, PanelPropColor, PanelPropHandle,
			%  PanelPropHandleList, PanelPropIDict, PanelPropItem, PanelPropLine,
			%  PanelPropItemList, PanelPropLogical, PanelPropMarker, PanelPropMatrix,
			%  PanelPropNet, PanelPropOption, PanelPropScalar, PanelPropSize,
			%  PanelPropString, PanelPropStringList.
			
			switch prop
				case AnalyzeEnsemble_CON_MP_BUD.DENSITIES % __AnalyzeEnsemble_CON_MP_BUD.DENSITIES__
					pr = PanelPropRVectorSmart('EL', a, 'PROP', AnalyzeEnsemble_CON_MP_BUD.DENSITIES, ...
					    'MIN', 0, 'MAX', 100, ...
					    'DEFAULT', AnalyzeEnsemble_CON_MP_BUD.getPropDefault('DENSITIES'), ...
					    varargin{:});
					
				otherwise
					pr = getPanelProp@AnalyzeEnsemble(a, prop, varargin{:});
					
			end
		end
	end
end
