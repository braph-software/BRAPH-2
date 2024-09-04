classdef NNFeatureImportanceMeasure < ConcreteElement
	%NNFeatureImportanceMeasure is the feature importance for graph measure.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% A feature importance for graph measure (NNFeatureImportanceMeasure) provides 
	% the necessary mnethods to present the value of feature importance for all kinds of graph mearsures.
	%
	% The list of NNFeatureImportanceMeasure properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the feature importance for graph measure.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the feature importance for graph measure.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the feature importance for graph measure.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the feature importance for graph measure.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the feature importance for graph measure.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the feature importance for graph measure.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the graph measure.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>G</strong> 	G (data, item) is the measure graph.
	%  <strong>10</strong> <strong>M</strong> 	M (data, item) is the measure.
	%  <strong>11</strong> <strong>FI</strong> 	FI (data, cell) is the feature importance value.
	%
	% NNFeatureImportanceMeasure methods (constructor):
	%  NNFeatureImportanceMeasure - constructor
	%
	% NNFeatureImportanceMeasure methods:
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
	% NNFeatureImportanceMeasure methods (display):
	%  tostring - string with information about the feature importance for graph measure
	%  disp - displays information about the feature importance for graph measure
	%  tree - displays the tree of the feature importance for graph measure
	%
	% NNFeatureImportanceMeasure methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two feature importance for graph measure are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the feature importance for graph measure
	%
	% NNFeatureImportanceMeasure methods (save/load, Static):
	%  save - saves BRAPH2 feature importance for graph measure as b2 file
	%  load - loads a BRAPH2 feature importance for graph measure from a b2 file
	%
	% NNFeatureImportanceMeasure method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the feature importance for graph measure
	%
	% NNFeatureImportanceMeasure method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the feature importance for graph measure
	%
	% NNFeatureImportanceMeasure methods (inspection, Static):
	%  getClass - returns the class of the feature importance for graph measure
	%  getSubclasses - returns all subclasses of NNFeatureImportanceMeasure
	%  getProps - returns the property list of the feature importance for graph measure
	%  getPropNumber - returns the property number of the feature importance for graph measure
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
	% NNFeatureImportanceMeasure methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% NNFeatureImportanceMeasure methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% NNFeatureImportanceMeasure methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% NNFeatureImportanceMeasure methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?NNFeatureImportanceMeasure; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">NNFeatureImportanceMeasure constants</a>.
	%
	%
	% See also NNFeatureImportanceBrainSurfacePP_Measure.
	%
	% BUILD BRAPH2 6 class_name 1
	
	properties (Constant) % properties
		G = 9; %CET: Computational Efficiency Trick
		G_TAG = 'G';
		G_CATEGORY = 4;
		G_FORMAT = 8;
		
		M = 10; %CET: Computational Efficiency Trick
		M_TAG = 'M';
		M_CATEGORY = 4;
		M_FORMAT = 8;
		
		FI = 11; %CET: Computational Efficiency Trick
		FI_TAG = 'FI';
		FI_CATEGORY = 4;
		FI_FORMAT = 16;
	end
	methods % constructor
		function fim = NNFeatureImportanceMeasure(varargin)
			%NNFeatureImportanceMeasure() creates a feature importance for graph measure.
			%
			% NNFeatureImportanceMeasure(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% NNFeatureImportanceMeasure(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of NNFeatureImportanceMeasure properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the feature importance for graph measure.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the feature importance for graph measure.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the feature importance for graph measure.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the feature importance for graph measure.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the feature importance for graph measure.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the feature importance for graph measure.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the graph measure.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>G</strong> 	G (data, item) is the measure graph.
			%  <strong>10</strong> <strong>M</strong> 	M (data, item) is the measure.
			%  <strong>11</strong> <strong>FI</strong> 	FI (data, cell) is the feature importance value.
			%
			% See also Category, Format.
			
			fim = fim@ConcreteElement(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the feature importance for graph measure.
			%
			% BUILD = NNFeatureImportanceMeasure.GETBUILD() returns the build of 'NNFeatureImportanceMeasure'.
			%
			% Alternative forms to call this method are:
			%  BUILD = FIM.GETBUILD() returns the build of the feature importance for graph measure FIM.
			%  BUILD = Element.GETBUILD(FIM) returns the build of 'FIM'.
			%  BUILD = Element.GETBUILD('NNFeatureImportanceMeasure') returns the build of 'NNFeatureImportanceMeasure'.
			%
			% Note that the Element.GETBUILD(FIM) and Element.GETBUILD('NNFeatureImportanceMeasure')
			%  are less computationally efficient.
			
			build = 1;
		end
		function fim_class = getClass()
			%GETCLASS returns the class of the feature importance for graph measure.
			%
			% CLASS = NNFeatureImportanceMeasure.GETCLASS() returns the class 'NNFeatureImportanceMeasure'.
			%
			% Alternative forms to call this method are:
			%  CLASS = FIM.GETCLASS() returns the class of the feature importance for graph measure FIM.
			%  CLASS = Element.GETCLASS(FIM) returns the class of 'FIM'.
			%  CLASS = Element.GETCLASS('NNFeatureImportanceMeasure') returns 'NNFeatureImportanceMeasure'.
			%
			% Note that the Element.GETCLASS(FIM) and Element.GETCLASS('NNFeatureImportanceMeasure')
			%  are less computationally efficient.
			
			fim_class = 'NNFeatureImportanceMeasure';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the feature importance for graph measure.
			%
			% LIST = NNFeatureImportanceMeasure.GETSUBCLASSES() returns all subclasses of 'NNFeatureImportanceMeasure'.
			%
			% Alternative forms to call this method are:
			%  LIST = FIM.GETSUBCLASSES() returns all subclasses of the feature importance for graph measure FIM.
			%  LIST = Element.GETSUBCLASSES(FIM) returns all subclasses of 'FIM'.
			%  LIST = Element.GETSUBCLASSES('NNFeatureImportanceMeasure') returns all subclasses of 'NNFeatureImportanceMeasure'.
			%
			% Note that the Element.GETSUBCLASSES(FIM) and Element.GETSUBCLASSES('NNFeatureImportanceMeasure')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'NNFeatureImportanceMeasure' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of feature importance for graph measure.
			%
			% PROPS = NNFeatureImportanceMeasure.GETPROPS() returns the property list of feature importance for graph measure
			%  as a row vector.
			%
			% PROPS = NNFeatureImportanceMeasure.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = FIM.GETPROPS([CATEGORY]) returns the property list of the feature importance for graph measure FIM.
			%  PROPS = Element.GETPROPS(FIM[, CATEGORY]) returns the property list of 'FIM'.
			%  PROPS = Element.GETPROPS('NNFeatureImportanceMeasure'[, CATEGORY]) returns the property list of 'NNFeatureImportanceMeasure'.
			%
			% Note that the Element.GETPROPS(FIM) and Element.GETPROPS('NNFeatureImportanceMeasure')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11];
				return
			end
			
			switch category
				case 1 % Category.CONSTANT
					prop_list = [1 2 3];
				case 2 % Category.METADATA
					prop_list = [6 7];
				case 3 % Category.PARAMETER
					prop_list = 4;
				case 4 % Category.DATA
					prop_list = [5 9 10 11];
				case 6 % Category.QUERY
					prop_list = 8;
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of feature importance for graph measure.
			%
			% N = NNFeatureImportanceMeasure.GETPROPNUMBER() returns the property number of feature importance for graph measure.
			%
			% N = NNFeatureImportanceMeasure.GETPROPNUMBER(CATEGORY) returns the property number of feature importance for graph measure
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = FIM.GETPROPNUMBER([CATEGORY]) returns the property number of the feature importance for graph measure FIM.
			%  N = Element.GETPROPNUMBER(FIM) returns the property number of 'FIM'.
			%  N = Element.GETPROPNUMBER('NNFeatureImportanceMeasure') returns the property number of 'NNFeatureImportanceMeasure'.
			%
			% Note that the Element.GETPROPNUMBER(FIM) and Element.GETPROPNUMBER('NNFeatureImportanceMeasure')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 11;
				return
			end
			
			switch varargin{1} % category = varargin{1}
				case 1 % Category.CONSTANT
					prop_number = 3;
				case 2 % Category.METADATA
					prop_number = 2;
				case 3 % Category.PARAMETER
					prop_number = 1;
				case 4 % Category.DATA
					prop_number = 4;
				case 6 % Category.QUERY
					prop_number = 1;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in feature importance for graph measure/error.
			%
			% CHECK = NNFeatureImportanceMeasure.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = FIM.EXISTSPROP(PROP) checks whether PROP exists for FIM.
			%  CHECK = Element.EXISTSPROP(FIM, PROP) checks whether PROP exists for FIM.
			%  CHECK = Element.EXISTSPROP(NNFeatureImportanceMeasure, PROP) checks whether PROP exists for NNFeatureImportanceMeasure.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:NNFeatureImportanceMeasure:WrongInput]
			%
			% Alternative forms to call this method are:
			%  FIM.EXISTSPROP(PROP) throws error if PROP does NOT exist for FIM.
			%   Error id: [BRAPH2:NNFeatureImportanceMeasure:WrongInput]
			%  Element.EXISTSPROP(FIM, PROP) throws error if PROP does NOT exist for FIM.
			%   Error id: [BRAPH2:NNFeatureImportanceMeasure:WrongInput]
			%  Element.EXISTSPROP(NNFeatureImportanceMeasure, PROP) throws error if PROP does NOT exist for NNFeatureImportanceMeasure.
			%   Error id: [BRAPH2:NNFeatureImportanceMeasure:WrongInput]
			%
			% Note that the Element.EXISTSPROP(FIM) and Element.EXISTSPROP('NNFeatureImportanceMeasure')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 11 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNFeatureImportanceMeasure:' 'WrongInput'], ...
					['BRAPH2' ':NNFeatureImportanceMeasure:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for NNFeatureImportanceMeasure.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in feature importance for graph measure/error.
			%
			% CHECK = NNFeatureImportanceMeasure.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = FIM.EXISTSTAG(TAG) checks whether TAG exists for FIM.
			%  CHECK = Element.EXISTSTAG(FIM, TAG) checks whether TAG exists for FIM.
			%  CHECK = Element.EXISTSTAG(NNFeatureImportanceMeasure, TAG) checks whether TAG exists for NNFeatureImportanceMeasure.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:NNFeatureImportanceMeasure:WrongInput]
			%
			% Alternative forms to call this method are:
			%  FIM.EXISTSTAG(TAG) throws error if TAG does NOT exist for FIM.
			%   Error id: [BRAPH2:NNFeatureImportanceMeasure:WrongInput]
			%  Element.EXISTSTAG(FIM, TAG) throws error if TAG does NOT exist for FIM.
			%   Error id: [BRAPH2:NNFeatureImportanceMeasure:WrongInput]
			%  Element.EXISTSTAG(NNFeatureImportanceMeasure, TAG) throws error if TAG does NOT exist for NNFeatureImportanceMeasure.
			%   Error id: [BRAPH2:NNFeatureImportanceMeasure:WrongInput]
			%
			% Note that the Element.EXISTSTAG(FIM) and Element.EXISTSTAG('NNFeatureImportanceMeasure')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'G'  'M'  'FI' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNFeatureImportanceMeasure:' 'WrongInput'], ...
					['BRAPH2' ':NNFeatureImportanceMeasure:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for NNFeatureImportanceMeasure.'] ...
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
			%  PROPERTY = FIM.GETPROPPROP(POINTER) returns property number of POINTER of FIM.
			%  PROPERTY = Element.GETPROPPROP(NNFeatureImportanceMeasure, POINTER) returns property number of POINTER of NNFeatureImportanceMeasure.
			%  PROPERTY = FIM.GETPROPPROP(NNFeatureImportanceMeasure, POINTER) returns property number of POINTER of NNFeatureImportanceMeasure.
			%
			% Note that the Element.GETPROPPROP(FIM) and Element.GETPROPPROP('NNFeatureImportanceMeasure')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'G'  'M'  'FI' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = FIM.GETPROPTAG(POINTER) returns tag of POINTER of FIM.
			%  TAG = Element.GETPROPTAG(NNFeatureImportanceMeasure, POINTER) returns tag of POINTER of NNFeatureImportanceMeasure.
			%  TAG = FIM.GETPROPTAG(NNFeatureImportanceMeasure, POINTER) returns tag of POINTER of NNFeatureImportanceMeasure.
			%
			% Note that the Element.GETPROPTAG(FIM) and Element.GETPROPTAG('NNFeatureImportanceMeasure')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				nnfeatureimportancemeasure_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'G'  'M'  'FI' };
				tag = nnfeatureimportancemeasure_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = FIM.GETPROPCATEGORY(POINTER) returns category of POINTER of FIM.
			%  CATEGORY = Element.GETPROPCATEGORY(NNFeatureImportanceMeasure, POINTER) returns category of POINTER of NNFeatureImportanceMeasure.
			%  CATEGORY = FIM.GETPROPCATEGORY(NNFeatureImportanceMeasure, POINTER) returns category of POINTER of NNFeatureImportanceMeasure.
			%
			% Note that the Element.GETPROPCATEGORY(FIM) and Element.GETPROPCATEGORY('NNFeatureImportanceMeasure')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = NNFeatureImportanceMeasure.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nnfeatureimportancemeasure_category_list = { 1  1  1  3  4  2  2  6  4  4  4 };
			prop_category = nnfeatureimportancemeasure_category_list{prop};
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
			%  FORMAT = FIM.GETPROPFORMAT(POINTER) returns format of POINTER of FIM.
			%  FORMAT = Element.GETPROPFORMAT(NNFeatureImportanceMeasure, POINTER) returns format of POINTER of NNFeatureImportanceMeasure.
			%  FORMAT = FIM.GETPROPFORMAT(NNFeatureImportanceMeasure, POINTER) returns format of POINTER of NNFeatureImportanceMeasure.
			%
			% Note that the Element.GETPROPFORMAT(FIM) and Element.GETPROPFORMAT('NNFeatureImportanceMeasure')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = NNFeatureImportanceMeasure.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nnfeatureimportancemeasure_format_list = { 2  2  2  8  2  2  2  2  8  8  16 };
			prop_format = nnfeatureimportancemeasure_format_list{prop};
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
			%  DESCRIPTION = FIM.GETPROPDESCRIPTION(POINTER) returns description of POINTER of FIM.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(NNFeatureImportanceMeasure, POINTER) returns description of POINTER of NNFeatureImportanceMeasure.
			%  DESCRIPTION = FIM.GETPROPDESCRIPTION(NNFeatureImportanceMeasure, POINTER) returns description of POINTER of NNFeatureImportanceMeasure.
			%
			% Note that the Element.GETPROPDESCRIPTION(FIM) and Element.GETPROPDESCRIPTION('NNFeatureImportanceMeasure')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = NNFeatureImportanceMeasure.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nnfeatureimportancemeasure_description_list = { 'ELCLASS (constant, string) is the class of the feature importance for graph measure.'  'NAME (constant, string) is the name of the feature importance for graph measure.'  'DESCRIPTION (constant, string) is the description of the feature importance for graph measure.'  'TEMPLATE (parameter, item) is the template of the feature importance for graph measure.'  'ID (data, string) is a few-letter code for the feature importance for graph measure.'  'LABEL (metadata, string) is an extended label of the feature importance for graph measure.'  'NOTES (metadata, string) are some specific notes about the graph measure.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'G (data, item) is the measure graph.'  'M (data, item) is the measure.'  'FI (data, cell) is the feature importance value.' };
			prop_description = nnfeatureimportancemeasure_description_list{prop};
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
			%  SETTINGS = FIM.GETPROPSETTINGS(POINTER) returns settings of POINTER of FIM.
			%  SETTINGS = Element.GETPROPSETTINGS(NNFeatureImportanceMeasure, POINTER) returns settings of POINTER of NNFeatureImportanceMeasure.
			%  SETTINGS = FIM.GETPROPSETTINGS(NNFeatureImportanceMeasure, POINTER) returns settings of POINTER of NNFeatureImportanceMeasure.
			%
			% Note that the Element.GETPROPSETTINGS(FIM) and Element.GETPROPSETTINGS('NNFeatureImportanceMeasure')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = NNFeatureImportanceMeasure.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % NNFeatureImportance13
					prop_settings = 'Graph';
				case 10 % NNFeatureImportance14
					prop_settings = 'Measure';
				case 11 % NNFeatureImportanceMeasure.FI
					prop_settings = Format.getFormatSettings(16);
				case 4 % NNFeatureImportance4
					prop_settings = 'NNFeatureImportanceMeasure';
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = NNFeatureImportanceMeasure.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = NNFeatureImportanceMeasure.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = FIM.GETPROPDEFAULT(POINTER) returns the default value of POINTER of FIM.
			%  DEFAULT = Element.GETPROPDEFAULT(NNFeatureImportanceMeasure, POINTER) returns the default value of POINTER of NNFeatureImportanceMeasure.
			%  DEFAULT = FIM.GETPROPDEFAULT(NNFeatureImportanceMeasure, POINTER) returns the default value of POINTER of NNFeatureImportanceMeasure.
			%
			% Note that the Element.GETPROPDEFAULT(FIM) and Element.GETPROPDEFAULT('NNFeatureImportanceMeasure')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNFeatureImportanceMeasure.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % NNFeatureImportance13
					prop_default = Format.getFormatDefault(8, NNFeatureImportanceMeasure.getPropSettings(prop));
				case 10 % NNFeatureImportance14
					prop_default = Format.getFormatDefault(8, NNFeatureImportanceMeasure.getPropSettings(prop));
				case 11 % NNFeatureImportanceMeasure.FI
					prop_default = Format.getFormatDefault(16, NNFeatureImportanceMeasure.getPropSettings(prop));
				case 1 % NNFeatureImportance1
					prop_default = 'NNFeatureImportanceMeasure';
				case 2 % NNFeatureImportance2
					prop_default = 'NNFeatureImportanceMeasure';
				case 3 % NNFeatureImportance3
					prop_default = 'A feature importance for graph measure (NNFeatureImportanceMeasure) provides the necessary mnethods to fit feature importance for all kinds of graph mearsures.';
				case 4 % NNFeatureImportance4
					prop_default = Format.getFormatDefault(8, NNFeatureImportanceMeasure.getPropSettings(prop));
				case 5 % NNFeatureImportance5
					prop_default = 'NNFeatureImportanceMeasure ID';
				case 6 % NNFeatureImportance6
					prop_default = 'NNFeatureImportanceMeasure label';
				case 7 % NNFeatureImportance7
					prop_default = 'NNFeatureImportanceMeasure notes';
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = NNFeatureImportanceMeasure.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = NNFeatureImportanceMeasure.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = FIM.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of FIM.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(NNFeatureImportanceMeasure, POINTER) returns the conditioned default value of POINTER of NNFeatureImportanceMeasure.
			%  DEFAULT = FIM.GETPROPDEFAULTCONDITIONED(NNFeatureImportanceMeasure, POINTER) returns the conditioned default value of POINTER of NNFeatureImportanceMeasure.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(FIM) and Element.GETPROPDEFAULTCONDITIONED('NNFeatureImportanceMeasure')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = NNFeatureImportanceMeasure.getPropProp(pointer);
			
			prop_default = NNFeatureImportanceMeasure.conditioning(prop, NNFeatureImportanceMeasure.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = FIM.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = FIM.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of FIM.
			%  CHECK = Element.CHECKPROP(NNFeatureImportanceMeasure, PROP, VALUE) checks VALUE format for PROP of NNFeatureImportanceMeasure.
			%  CHECK = FIM.CHECKPROP(NNFeatureImportanceMeasure, PROP, VALUE) checks VALUE format for PROP of NNFeatureImportanceMeasure.
			% 
			% FIM.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:NNFeatureImportanceMeasure:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  FIM.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of FIM.
			%   Error id: BRAPH2:NNFeatureImportanceMeasure:WrongInput
			%  Element.CHECKPROP(NNFeatureImportanceMeasure, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNFeatureImportanceMeasure.
			%   Error id: BRAPH2:NNFeatureImportanceMeasure:WrongInput
			%  FIM.CHECKPROP(NNFeatureImportanceMeasure, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNFeatureImportanceMeasure.
			%   Error id: BRAPH2:NNFeatureImportanceMeasure:WrongInput]
			% 
			% Note that the Element.CHECKPROP(FIM) and Element.CHECKPROP('NNFeatureImportanceMeasure')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = NNFeatureImportanceMeasure.getPropProp(pointer);
			
			switch prop
				case 9 % NNFeatureImportance13
					check = Format.checkFormat(8, value, NNFeatureImportanceMeasure.getPropSettings(prop));
				case 10 % NNFeatureImportance14
					check = Format.checkFormat(8, value, NNFeatureImportanceMeasure.getPropSettings(prop));
				case 11 % NNFeatureImportanceMeasure.FI
					check = Format.checkFormat(16, value, NNFeatureImportanceMeasure.getPropSettings(prop));
				case 4 % NNFeatureImportance4
					check = Format.checkFormat(8, value, NNFeatureImportanceMeasure.getPropSettings(prop));
				otherwise
					if prop <= 8
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNFeatureImportanceMeasure:' 'WrongInput'], ...
					['BRAPH2' ':NNFeatureImportanceMeasure:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' NNFeatureImportanceMeasure.getPropTag(prop) ' (' NNFeatureImportanceMeasure.getFormatTag(NNFeatureImportanceMeasure.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods % GUI
		function pr = getPanelProp(fim, prop, varargin)
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
				case 11 % NNFeatureImportanceMeasure.FI
					m = fim.get('M');
					g = fim.get('G');
					
					pr = PanelPropCell('EL', fim, 'PROP', 11, varargin{:});
					
					if m.get('SHAPE') == 1 % Measure.GLOBAL
					    pr.set( ...
					        'TABLE_HEIGHT', 48, ...
					        'ROWNAME', {}, ...
					        'COLUMNNAME', {} ...
					        )
					elseif m.get('SHAPE') == 2 % Measure.NODAL
					    pr.set( ...
					        'TABLE_HEIGHT', 480, ...
					        'ROWNAME', g.getCallback('ANODELABELS'), ...
					        'COLUMNNAME', {} ...
					        )
					elseif m.get('SHAPE') == 3 % Measure.BINODAL
					    pr.set( ...
					        'TABLE_HEIGHT', 480, ...
					        'ROWNAME', g.getCallback('ANODELABELS'), ...
					        'COLUMNNAME', g.getCallback('ANODELABELS') ...
					        )
					end
					
					if g.get('LAYERNUMBER') == 1
					    pr.set( ...
					        'XSLIDERSHOW', false, ...
					        'YSLIDERSHOW', false ...
					        )
					else % multigraph, multiplex, multilayer
					    if m.get('SCOPE') == 1 % Measure.SUPERGLOBAL
					        if isempty(g.get('APARTITIONLABELS'))
					            pr.set( ...
					                'XSLIDERSHOW', false, ...
					                'YSLIDERSHOW', false ...
					                )
					        else
					            pr.set( ...
					                'TABLE_HEIGHT', max(pr.get('TABLE_HEIGHT'), 12 * length(g.get('APARTITIONLABELS'))), ...
					                'XSLIDERSHOW', false, ...
					                'YSLIDERSHOW', true, ...
					                'YSLIDERLABELS', g.getCallback('APARTITIONLABELS'), ...
					                'YSLIDERWIDTH', 60 ...
					                )
					        end
					    elseif m.get('SCOPE') == 2 % Measure.UNILAYER
					        pr.set( ...
					            'TABLE_HEIGHT', max(pr.get('TABLE_HEIGHT'), 12 * g.get('LAYERNUMBER')), ...
					            'XSLIDERSHOW', false, ...
					            'YSLIDERSHOW', true, ...
					            'YSLIDERLABELS', g.getCallback('ALAYERLABELS'), ...
					            'YSLIDERWIDTH', 60 ...
					            )
					    elseif m.get('SCOPE') == 3 % Measure.BILAYER
					        pr.set( ...
					            'TABLE_HEIGHT', max(36 + pr.get('TABLE_HEIGHT'), 36 + 12 * g.get('LAYERNUMBER')), ...
					            'XSLIDERSHOW', true, ...
					            'XSLIDERLABELS', g.getCallback('ALAYERLABELS'), ...
					            'XSLIDERHEIGHT', 36, ...
					            'YSLIDERSHOW', true, ...
					            'YSLIDERLABELS', g.getCallback('ALAYERLABELS'), ...
					            'YSLIDERWIDTH', 60 ...
					            )
					    end
					end
					
				otherwise
					pr = getPanelProp@ConcreteElement(fim, prop, varargin{:});
					
			end
		end
	end
end
