classdef NNFeatureImportanceBrainSurface < ConcreteElement
	%NNFeatureImportanceBrainSurface manages the visuazation of the feature importance on the brain surface within neural network evaluators.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% A neural network feature importace on brain surface (NNFeatureImportanceBrainSurface) 
	%  manages the visualization of feature importance within neural network evaluators, particularly on the brain surface.
	% It handles different types of neural network inputs, including graph data 
	%  (for visualizng the importance of connections between nodes), measures (for visualizing the importance of nodal measures),
	%  and the subject data (connectivity data or structural data).
	%
	% The list of NNFeatureImportanceBrainSurface properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the element to manage the visuazation of the neural network feature importance on the brain surface.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the element to manage the visuazation of the neural network feature importance on the brain surface.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the element to manage the visuazation of the neural network feature importance on the brain surface.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the element to manage the visuazation of the neural network feature importance on the brain surface.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the element to manage the visuazation of the neural network feature importance on the brain surface.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the element to manage the visuazation of the neural network feature importance on the brain surface.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about managing the visuazation of the neural network feature importance on the brain surface.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>BA</strong> 	BA (data, item) is a brain atlas.
	%  <strong>10</strong> <strong>D</strong> 	D (data, item) is a NN dataset.
	%  <strong>11</strong> <strong>FEATURE_IMPORTANCE</strong> 	FEATURE_IMPORTANCE (data, cell) is the feature importances.
	%  <strong>12</strong> <strong>RESHAPED_FEATURE_IMPORTANCE</strong> 	RESHAPED_FEATURE_IMPORTANCE (query, empty) reshapes the cell of feature importances with the input data.
	%  <strong>13</strong> <strong>MAP_TO_CELL</strong> 	MAP_TO_CELL (query, empty) maps a single vector back to the original cell array structure.
	%
	% NNFeatureImportanceBrainSurface methods (constructor):
	%  NNFeatureImportanceBrainSurface - constructor
	%
	% NNFeatureImportanceBrainSurface methods:
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
	% NNFeatureImportanceBrainSurface methods (display):
	%  tostring - string with information about the neural network feature importace on brain surface
	%  disp - displays information about the neural network feature importace on brain surface
	%  tree - displays the tree of the neural network feature importace on brain surface
	%
	% NNFeatureImportanceBrainSurface methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two neural network feature importace on brain surface are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the neural network feature importace on brain surface
	%
	% NNFeatureImportanceBrainSurface methods (save/load, Static):
	%  save - saves BRAPH2 neural network feature importace on brain surface as b2 file
	%  load - loads a BRAPH2 neural network feature importace on brain surface from a b2 file
	%
	% NNFeatureImportanceBrainSurface method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the neural network feature importace on brain surface
	%
	% NNFeatureImportanceBrainSurface method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the neural network feature importace on brain surface
	%
	% NNFeatureImportanceBrainSurface methods (inspection, Static):
	%  getClass - returns the class of the neural network feature importace on brain surface
	%  getSubclasses - returns all subclasses of NNFeatureImportanceBrainSurface
	%  getProps - returns the property list of the neural network feature importace on brain surface
	%  getPropNumber - returns the property number of the neural network feature importace on brain surface
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
	% NNFeatureImportanceBrainSurface methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% NNFeatureImportanceBrainSurface methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% NNFeatureImportanceBrainSurface methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% NNFeatureImportanceBrainSurface methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?NNFeatureImportanceBrainSurface; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">NNFeatureImportanceBrainSurface constants</a>.
	%
	%
	% See also NNEvaluator, NNDataPoint_Graph_CLA, NNDataPoint_Measure_REG, NNDataPoint_CON_CLA, NNDataPoint_ST_CLA.
	%
	% BUILD BRAPH2 6 class_name 1
	
	properties (Constant) % properties
		BA = 9; %CET: Computational Efficiency Trick
		BA_TAG = 'BA';
		BA_CATEGORY = 4;
		BA_FORMAT = 8;
		
		D = 10; %CET: Computational Efficiency Trick
		D_TAG = 'D';
		D_CATEGORY = 4;
		D_FORMAT = 8;
		
		FEATURE_IMPORTANCE = 11; %CET: Computational Efficiency Trick
		FEATURE_IMPORTANCE_TAG = 'FEATURE_IMPORTANCE';
		FEATURE_IMPORTANCE_CATEGORY = 4;
		FEATURE_IMPORTANCE_FORMAT = 16;
		
		RESHAPED_FEATURE_IMPORTANCE = 12; %CET: Computational Efficiency Trick
		RESHAPED_FEATURE_IMPORTANCE_TAG = 'RESHAPED_FEATURE_IMPORTANCE';
		RESHAPED_FEATURE_IMPORTANCE_CATEGORY = 6;
		RESHAPED_FEATURE_IMPORTANCE_FORMAT = 1;
		
		MAP_TO_CELL = 13; %CET: Computational Efficiency Trick
		MAP_TO_CELL_TAG = 'MAP_TO_CELL';
		MAP_TO_CELL_CATEGORY = 6;
		MAP_TO_CELL_FORMAT = 1;
	end
	methods % constructor
		function nnfib = NNFeatureImportanceBrainSurface(varargin)
			%NNFeatureImportanceBrainSurface() creates a neural network feature importace on brain surface.
			%
			% NNFeatureImportanceBrainSurface(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% NNFeatureImportanceBrainSurface(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of NNFeatureImportanceBrainSurface properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the element to manage the visuazation of the neural network feature importance on the brain surface.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the element to manage the visuazation of the neural network feature importance on the brain surface.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the element to manage the visuazation of the neural network feature importance on the brain surface.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the element to manage the visuazation of the neural network feature importance on the brain surface.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the element to manage the visuazation of the neural network feature importance on the brain surface.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the element to manage the visuazation of the neural network feature importance on the brain surface.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about managing the visuazation of the neural network feature importance on the brain surface.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>BA</strong> 	BA (data, item) is a brain atlas.
			%  <strong>10</strong> <strong>D</strong> 	D (data, item) is a NN dataset.
			%  <strong>11</strong> <strong>FEATURE_IMPORTANCE</strong> 	FEATURE_IMPORTANCE (data, cell) is the feature importances.
			%  <strong>12</strong> <strong>RESHAPED_FEATURE_IMPORTANCE</strong> 	RESHAPED_FEATURE_IMPORTANCE (query, empty) reshapes the cell of feature importances with the input data.
			%  <strong>13</strong> <strong>MAP_TO_CELL</strong> 	MAP_TO_CELL (query, empty) maps a single vector back to the original cell array structure.
			%
			% See also Category, Format.
			
			nnfib = nnfib@ConcreteElement(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the neural network feature importace on brain surface.
			%
			% BUILD = NNFeatureImportanceBrainSurface.GETBUILD() returns the build of 'NNFeatureImportanceBrainSurface'.
			%
			% Alternative forms to call this method are:
			%  BUILD = NNFIB.GETBUILD() returns the build of the neural network feature importace on brain surface NNFIB.
			%  BUILD = Element.GETBUILD(NNFIB) returns the build of 'NNFIB'.
			%  BUILD = Element.GETBUILD('NNFeatureImportanceBrainSurface') returns the build of 'NNFeatureImportanceBrainSurface'.
			%
			% Note that the Element.GETBUILD(NNFIB) and Element.GETBUILD('NNFeatureImportanceBrainSurface')
			%  are less computationally efficient.
			
			build = 1;
		end
		function nnfib_class = getClass()
			%GETCLASS returns the class of the neural network feature importace on brain surface.
			%
			% CLASS = NNFeatureImportanceBrainSurface.GETCLASS() returns the class 'NNFeatureImportanceBrainSurface'.
			%
			% Alternative forms to call this method are:
			%  CLASS = NNFIB.GETCLASS() returns the class of the neural network feature importace on brain surface NNFIB.
			%  CLASS = Element.GETCLASS(NNFIB) returns the class of 'NNFIB'.
			%  CLASS = Element.GETCLASS('NNFeatureImportanceBrainSurface') returns 'NNFeatureImportanceBrainSurface'.
			%
			% Note that the Element.GETCLASS(NNFIB) and Element.GETCLASS('NNFeatureImportanceBrainSurface')
			%  are less computationally efficient.
			
			nnfib_class = 'NNFeatureImportanceBrainSurface';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the neural network feature importace on brain surface.
			%
			% LIST = NNFeatureImportanceBrainSurface.GETSUBCLASSES() returns all subclasses of 'NNFeatureImportanceBrainSurface'.
			%
			% Alternative forms to call this method are:
			%  LIST = NNFIB.GETSUBCLASSES() returns all subclasses of the neural network feature importace on brain surface NNFIB.
			%  LIST = Element.GETSUBCLASSES(NNFIB) returns all subclasses of 'NNFIB'.
			%  LIST = Element.GETSUBCLASSES('NNFeatureImportanceBrainSurface') returns all subclasses of 'NNFeatureImportanceBrainSurface'.
			%
			% Note that the Element.GETSUBCLASSES(NNFIB) and Element.GETSUBCLASSES('NNFeatureImportanceBrainSurface')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'NNFeatureImportanceBrainSurface' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of neural network feature importace on brain surface.
			%
			% PROPS = NNFeatureImportanceBrainSurface.GETPROPS() returns the property list of neural network feature importace on brain surface
			%  as a row vector.
			%
			% PROPS = NNFeatureImportanceBrainSurface.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = NNFIB.GETPROPS([CATEGORY]) returns the property list of the neural network feature importace on brain surface NNFIB.
			%  PROPS = Element.GETPROPS(NNFIB[, CATEGORY]) returns the property list of 'NNFIB'.
			%  PROPS = Element.GETPROPS('NNFeatureImportanceBrainSurface'[, CATEGORY]) returns the property list of 'NNFeatureImportanceBrainSurface'.
			%
			% Note that the Element.GETPROPS(NNFIB) and Element.GETPROPS('NNFeatureImportanceBrainSurface')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13];
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
					prop_list = [8 12 13];
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of neural network feature importace on brain surface.
			%
			% N = NNFeatureImportanceBrainSurface.GETPROPNUMBER() returns the property number of neural network feature importace on brain surface.
			%
			% N = NNFeatureImportanceBrainSurface.GETPROPNUMBER(CATEGORY) returns the property number of neural network feature importace on brain surface
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = NNFIB.GETPROPNUMBER([CATEGORY]) returns the property number of the neural network feature importace on brain surface NNFIB.
			%  N = Element.GETPROPNUMBER(NNFIB) returns the property number of 'NNFIB'.
			%  N = Element.GETPROPNUMBER('NNFeatureImportanceBrainSurface') returns the property number of 'NNFeatureImportanceBrainSurface'.
			%
			% Note that the Element.GETPROPNUMBER(NNFIB) and Element.GETPROPNUMBER('NNFeatureImportanceBrainSurface')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 13;
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
					prop_number = 3;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in neural network feature importace on brain surface/error.
			%
			% CHECK = NNFeatureImportanceBrainSurface.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NNFIB.EXISTSPROP(PROP) checks whether PROP exists for NNFIB.
			%  CHECK = Element.EXISTSPROP(NNFIB, PROP) checks whether PROP exists for NNFIB.
			%  CHECK = Element.EXISTSPROP(NNFeatureImportanceBrainSurface, PROP) checks whether PROP exists for NNFeatureImportanceBrainSurface.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:NNFeatureImportanceBrainSurface:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NNFIB.EXISTSPROP(PROP) throws error if PROP does NOT exist for NNFIB.
			%   Error id: [BRAPH2:NNFeatureImportanceBrainSurface:WrongInput]
			%  Element.EXISTSPROP(NNFIB, PROP) throws error if PROP does NOT exist for NNFIB.
			%   Error id: [BRAPH2:NNFeatureImportanceBrainSurface:WrongInput]
			%  Element.EXISTSPROP(NNFeatureImportanceBrainSurface, PROP) throws error if PROP does NOT exist for NNFeatureImportanceBrainSurface.
			%   Error id: [BRAPH2:NNFeatureImportanceBrainSurface:WrongInput]
			%
			% Note that the Element.EXISTSPROP(NNFIB) and Element.EXISTSPROP('NNFeatureImportanceBrainSurface')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 13 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNFeatureImportanceBrainSurface:' 'WrongInput'], ...
					['BRAPH2' ':NNFeatureImportanceBrainSurface:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for NNFeatureImportanceBrainSurface.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in neural network feature importace on brain surface/error.
			%
			% CHECK = NNFeatureImportanceBrainSurface.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NNFIB.EXISTSTAG(TAG) checks whether TAG exists for NNFIB.
			%  CHECK = Element.EXISTSTAG(NNFIB, TAG) checks whether TAG exists for NNFIB.
			%  CHECK = Element.EXISTSTAG(NNFeatureImportanceBrainSurface, TAG) checks whether TAG exists for NNFeatureImportanceBrainSurface.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:NNFeatureImportanceBrainSurface:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NNFIB.EXISTSTAG(TAG) throws error if TAG does NOT exist for NNFIB.
			%   Error id: [BRAPH2:NNFeatureImportanceBrainSurface:WrongInput]
			%  Element.EXISTSTAG(NNFIB, TAG) throws error if TAG does NOT exist for NNFIB.
			%   Error id: [BRAPH2:NNFeatureImportanceBrainSurface:WrongInput]
			%  Element.EXISTSTAG(NNFeatureImportanceBrainSurface, TAG) throws error if TAG does NOT exist for NNFeatureImportanceBrainSurface.
			%   Error id: [BRAPH2:NNFeatureImportanceBrainSurface:WrongInput]
			%
			% Note that the Element.EXISTSTAG(NNFIB) and Element.EXISTSTAG('NNFeatureImportanceBrainSurface')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'BA'  'D'  'FEATURE_IMPORTANCE'  'RESHAPED_FEATURE_IMPORTANCE'  'MAP_TO_CELL' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNFeatureImportanceBrainSurface:' 'WrongInput'], ...
					['BRAPH2' ':NNFeatureImportanceBrainSurface:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for NNFeatureImportanceBrainSurface.'] ...
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
			%  PROPERTY = NNFIB.GETPROPPROP(POINTER) returns property number of POINTER of NNFIB.
			%  PROPERTY = Element.GETPROPPROP(NNFeatureImportanceBrainSurface, POINTER) returns property number of POINTER of NNFeatureImportanceBrainSurface.
			%  PROPERTY = NNFIB.GETPROPPROP(NNFeatureImportanceBrainSurface, POINTER) returns property number of POINTER of NNFeatureImportanceBrainSurface.
			%
			% Note that the Element.GETPROPPROP(NNFIB) and Element.GETPROPPROP('NNFeatureImportanceBrainSurface')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'BA'  'D'  'FEATURE_IMPORTANCE'  'RESHAPED_FEATURE_IMPORTANCE'  'MAP_TO_CELL' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = NNFIB.GETPROPTAG(POINTER) returns tag of POINTER of NNFIB.
			%  TAG = Element.GETPROPTAG(NNFeatureImportanceBrainSurface, POINTER) returns tag of POINTER of NNFeatureImportanceBrainSurface.
			%  TAG = NNFIB.GETPROPTAG(NNFeatureImportanceBrainSurface, POINTER) returns tag of POINTER of NNFeatureImportanceBrainSurface.
			%
			% Note that the Element.GETPROPTAG(NNFIB) and Element.GETPROPTAG('NNFeatureImportanceBrainSurface')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				nnfeatureimportancebrainsurface_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'BA'  'D'  'FEATURE_IMPORTANCE'  'RESHAPED_FEATURE_IMPORTANCE'  'MAP_TO_CELL' };
				tag = nnfeatureimportancebrainsurface_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = NNFIB.GETPROPCATEGORY(POINTER) returns category of POINTER of NNFIB.
			%  CATEGORY = Element.GETPROPCATEGORY(NNFeatureImportanceBrainSurface, POINTER) returns category of POINTER of NNFeatureImportanceBrainSurface.
			%  CATEGORY = NNFIB.GETPROPCATEGORY(NNFeatureImportanceBrainSurface, POINTER) returns category of POINTER of NNFeatureImportanceBrainSurface.
			%
			% Note that the Element.GETPROPCATEGORY(NNFIB) and Element.GETPROPCATEGORY('NNFeatureImportanceBrainSurface')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = NNFeatureImportanceBrainSurface.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nnfeatureimportancebrainsurface_category_list = { 1  1  1  3  4  2  2  6  4  4  4  6  6 };
			prop_category = nnfeatureimportancebrainsurface_category_list{prop};
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
			%  FORMAT = NNFIB.GETPROPFORMAT(POINTER) returns format of POINTER of NNFIB.
			%  FORMAT = Element.GETPROPFORMAT(NNFeatureImportanceBrainSurface, POINTER) returns format of POINTER of NNFeatureImportanceBrainSurface.
			%  FORMAT = NNFIB.GETPROPFORMAT(NNFeatureImportanceBrainSurface, POINTER) returns format of POINTER of NNFeatureImportanceBrainSurface.
			%
			% Note that the Element.GETPROPFORMAT(NNFIB) and Element.GETPROPFORMAT('NNFeatureImportanceBrainSurface')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = NNFeatureImportanceBrainSurface.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nnfeatureimportancebrainsurface_format_list = { 2  2  2  8  2  2  2  2  8  8  16  1  1 };
			prop_format = nnfeatureimportancebrainsurface_format_list{prop};
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
			%  DESCRIPTION = NNFIB.GETPROPDESCRIPTION(POINTER) returns description of POINTER of NNFIB.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(NNFeatureImportanceBrainSurface, POINTER) returns description of POINTER of NNFeatureImportanceBrainSurface.
			%  DESCRIPTION = NNFIB.GETPROPDESCRIPTION(NNFeatureImportanceBrainSurface, POINTER) returns description of POINTER of NNFeatureImportanceBrainSurface.
			%
			% Note that the Element.GETPROPDESCRIPTION(NNFIB) and Element.GETPROPDESCRIPTION('NNFeatureImportanceBrainSurface')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = NNFeatureImportanceBrainSurface.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nnfeatureimportancebrainsurface_description_list = { 'ELCLASS (constant, string) is the class of the element to manage the visuazation of the neural network feature importance on the brain surface.'  'NAME (constant, string) is the name of the element to manage the visuazation of the neural network feature importance on the brain surface.'  'DESCRIPTION (constant, string) is the description of the element to manage the visuazation of the neural network feature importance on the brain surface.'  'TEMPLATE (parameter, item) is the template of the element to manage the visuazation of the neural network feature importance on the brain surface.'  'ID (data, string) is a few-letter code of the element to manage the visuazation of the neural network feature importance on the brain surface.'  'LABEL (metadata, string) is an extended label of the element to manage the visuazation of the neural network feature importance on the brain surface.'  'NOTES (metadata, string) are some specific notes about managing the visuazation of the neural network feature importance on the brain surface.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'BA (data, item) is a brain atlas.'  'D (data, item) is a NN dataset.'  'FEATURE_IMPORTANCE (data, cell) is the feature importances.'  'RESHAPED_FEATURE_IMPORTANCE (query, empty) reshapes the cell of feature importances with the input data.'  'MAP_TO_CELL (query, empty) maps a single vector back to the original cell array structure.' };
			prop_description = nnfeatureimportancebrainsurface_description_list{prop};
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
			%  SETTINGS = NNFIB.GETPROPSETTINGS(POINTER) returns settings of POINTER of NNFIB.
			%  SETTINGS = Element.GETPROPSETTINGS(NNFeatureImportanceBrainSurface, POINTER) returns settings of POINTER of NNFeatureImportanceBrainSurface.
			%  SETTINGS = NNFIB.GETPROPSETTINGS(NNFeatureImportanceBrainSurface, POINTER) returns settings of POINTER of NNFeatureImportanceBrainSurface.
			%
			% Note that the Element.GETPROPSETTINGS(NNFIB) and Element.GETPROPSETTINGS('NNFeatureImportanceBrainSurface')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = NNFeatureImportanceBrainSurface.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % NNFeatureImportanceBrainSurface.BA
					prop_settings = 'BrainAtlas';
				case 10 % NNFeatureImportanceBrainSurface.D
					prop_settings = 'NNDataset';
				case 11 % NNFeatureImportanceBrainSurface.FEATURE_IMPORTANCE
					prop_settings = Format.getFormatSettings(16);
				case 12 % NNFeatureImportanceBrainSurface.RESHAPED_FEATURE_IMPORTANCE
					prop_settings = Format.getFormatSettings(1);
				case 13 % NNFeatureImportanceBrainSurface.MAP_TO_CELL
					prop_settings = Format.getFormatSettings(1);
				case 4 % NNFeatureImportance4
					prop_settings = 'NNFeatureImportanceBrainSurface';
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = NNFeatureImportanceBrainSurface.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = NNFeatureImportanceBrainSurface.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NNFIB.GETPROPDEFAULT(POINTER) returns the default value of POINTER of NNFIB.
			%  DEFAULT = Element.GETPROPDEFAULT(NNFeatureImportanceBrainSurface, POINTER) returns the default value of POINTER of NNFeatureImportanceBrainSurface.
			%  DEFAULT = NNFIB.GETPROPDEFAULT(NNFeatureImportanceBrainSurface, POINTER) returns the default value of POINTER of NNFeatureImportanceBrainSurface.
			%
			% Note that the Element.GETPROPDEFAULT(NNFIB) and Element.GETPROPDEFAULT('NNFeatureImportanceBrainSurface')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNFeatureImportanceBrainSurface.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % NNFeatureImportanceBrainSurface.BA
					prop_default = Format.getFormatDefault(8, NNFeatureImportanceBrainSurface.getPropSettings(prop));
				case 10 % NNFeatureImportanceBrainSurface.D
					prop_default = Format.getFormatDefault(8, NNFeatureImportanceBrainSurface.getPropSettings(prop));
				case 11 % NNFeatureImportanceBrainSurface.FEATURE_IMPORTANCE
					prop_default = Format.getFormatDefault(16, NNFeatureImportanceBrainSurface.getPropSettings(prop));
				case 12 % NNFeatureImportanceBrainSurface.RESHAPED_FEATURE_IMPORTANCE
					prop_default = Format.getFormatDefault(1, NNFeatureImportanceBrainSurface.getPropSettings(prop));
				case 13 % NNFeatureImportanceBrainSurface.MAP_TO_CELL
					prop_default = Format.getFormatDefault(1, NNFeatureImportanceBrainSurface.getPropSettings(prop));
				case 1 % NNFeatureImportance1
					prop_default = 'NNFeatureImportanceBrainSurface';
				case 2 % NNFeatureImportance2
					prop_default = 'Neural Network Feature Importace on Brain Surface';
				case 3 % NNFeatureImportance3
					prop_default = 'A neural network feature importace on brain surface (NNFeatureImportanceBrainSurface) manages the visualization of feature importance within neural network evaluators, particularly on the brain surface. It handles different types of neural network inputs, including graph data (for visualizng the importance of connections between nodes), measures (for visualizing the importance of nodal measures), and the subject data (connectivity data or structural data).';
				case 4 % NNFeatureImportance4
					prop_default = Format.getFormatDefault(8, NNFeatureImportanceBrainSurface.getPropSettings(prop));
				case 5 % NNFeatureImportance5
					prop_default = 'NNFeatureImportanceBrainSurface ID';
				case 6 % NNFeatureImportance6
					prop_default = 'NNFeatureImportanceBrainSurface label';
				case 7 % NNFeatureImportance7
					prop_default = 'NNFeatureImportanceBrainSurface notes';
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = NNFeatureImportanceBrainSurface.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = NNFeatureImportanceBrainSurface.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NNFIB.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of NNFIB.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(NNFeatureImportanceBrainSurface, POINTER) returns the conditioned default value of POINTER of NNFeatureImportanceBrainSurface.
			%  DEFAULT = NNFIB.GETPROPDEFAULTCONDITIONED(NNFeatureImportanceBrainSurface, POINTER) returns the conditioned default value of POINTER of NNFeatureImportanceBrainSurface.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(NNFIB) and Element.GETPROPDEFAULTCONDITIONED('NNFeatureImportanceBrainSurface')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = NNFeatureImportanceBrainSurface.getPropProp(pointer);
			
			prop_default = NNFeatureImportanceBrainSurface.conditioning(prop, NNFeatureImportanceBrainSurface.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = NNFIB.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = NNFIB.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of NNFIB.
			%  CHECK = Element.CHECKPROP(NNFeatureImportanceBrainSurface, PROP, VALUE) checks VALUE format for PROP of NNFeatureImportanceBrainSurface.
			%  CHECK = NNFIB.CHECKPROP(NNFeatureImportanceBrainSurface, PROP, VALUE) checks VALUE format for PROP of NNFeatureImportanceBrainSurface.
			% 
			% NNFIB.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:NNFeatureImportanceBrainSurface:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  NNFIB.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of NNFIB.
			%   Error id: BRAPH2:NNFeatureImportanceBrainSurface:WrongInput
			%  Element.CHECKPROP(NNFeatureImportanceBrainSurface, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNFeatureImportanceBrainSurface.
			%   Error id: BRAPH2:NNFeatureImportanceBrainSurface:WrongInput
			%  NNFIB.CHECKPROP(NNFeatureImportanceBrainSurface, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNFeatureImportanceBrainSurface.
			%   Error id: BRAPH2:NNFeatureImportanceBrainSurface:WrongInput]
			% 
			% Note that the Element.CHECKPROP(NNFIB) and Element.CHECKPROP('NNFeatureImportanceBrainSurface')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = NNFeatureImportanceBrainSurface.getPropProp(pointer);
			
			switch prop
				case 9 % NNFeatureImportanceBrainSurface.BA
					check = Format.checkFormat(8, value, NNFeatureImportanceBrainSurface.getPropSettings(prop));
				case 10 % NNFeatureImportanceBrainSurface.D
					check = Format.checkFormat(8, value, NNFeatureImportanceBrainSurface.getPropSettings(prop));
				case 11 % NNFeatureImportanceBrainSurface.FEATURE_IMPORTANCE
					check = Format.checkFormat(16, value, NNFeatureImportanceBrainSurface.getPropSettings(prop));
				case 12 % NNFeatureImportanceBrainSurface.RESHAPED_FEATURE_IMPORTANCE
					check = Format.checkFormat(1, value, NNFeatureImportanceBrainSurface.getPropSettings(prop));
				case 13 % NNFeatureImportanceBrainSurface.MAP_TO_CELL
					check = Format.checkFormat(1, value, NNFeatureImportanceBrainSurface.getPropSettings(prop));
				case 4 % NNFeatureImportance4
					check = Format.checkFormat(8, value, NNFeatureImportanceBrainSurface.getPropSettings(prop));
				otherwise
					if prop <= 8
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNFeatureImportanceBrainSurface:' 'WrongInput'], ...
					['BRAPH2' ':NNFeatureImportanceBrainSurface:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' NNFeatureImportanceBrainSurface.getPropTag(prop) ' (' NNFeatureImportanceBrainSurface.getFormatTag(NNFeatureImportanceBrainSurface.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(nnfib, prop, varargin)
			%CALCULATEVALUE calculates the value of a property.
			%
			% VALUE = CALCULATEVALUE(EL, PROP) calculates the value of the property
			%  PROP. It works only with properties with 5,
			%  6, and 7. By default this function
			%  returns the default value for the prop and should be implemented in the
			%  subclasses of Element when needed.
			%
			% VALUE = CALCULATEVALUE(EL, PROP, VARARGIN) works with properties with
			%  6.
			%
			% See also getPropDefaultConditioned, conditioning, preset, checkProp,
			%  postset, postprocessing, checkValue.
			
			switch prop
				case 12 % NNFeatureImportanceBrainSurface.RESHAPED_FEATURE_IMPORTANCE
					cell1 = nnfib.get('FEATURE_IMPORTANCE');
					if nnfib.get('D').get('DP_DICT').get('LENGTH') > 0
					    cell2 = nnfib.get('D').get('DP_DICT').get('IT', 1).get('INPUT');
					else
					    cell2 = {};
					end
					if ~isequal(numel(cell1), numel(cell2)) 
					    cell1 = nnfib.get('MAP_TO_CELL', cell2mat(cell1), cell2);
					end
					
					value = cell1;
					
				case 13 % NNFeatureImportanceBrainSurface.MAP_TO_CELL
					if isempty(varargin)
					    value = {};
					    return
					end
					vector = varargin{1};
					cell_template = varargin{2};
					mappedCellArray = cell_template;
					index = 1;
					for i = 1:numel(cell_template)
					    cellData = cell_template{i};
					    if iscell(cellData)
					        % Map the vector to nested cell arrays recursively
					        nestedVector = nnfib.get('MAP_TO_CELL', vector(index:end), cellData);
					        mappedCellArray{i} = nestedVector;
					    else
					        % Assign elements from the vector to cells
					        numElements = numel(cellData);
					        mappedCellArray{i} = reshape(vector(index:index+numElements-1), size(cellData));
					        index = index + numElements;
					    end
					end
					
					value = mappedCellArray;
					
				otherwise
					if prop <= 8
						value = calculateValue@ConcreteElement(nnfib, prop, varargin{:});
					else
						value = calculateValue@Element(nnfib, prop, varargin{:});
					end
			end
			
		end
	end
	methods % GUI
		function pr = getPanelProp(nnfib, prop, varargin)
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
				case 11 % NNFeatureImportanceBrainSurface.FEATURE_IMPORTANCE
					input_dataset = nnfib.get('D');
					dp_class = input_dataset.get('DP_CLASS');
					graph_dp_classes = {NNDataPoint_Graph_CLA().get('NAME'), NNDataPoint_Graph_REG().get('NAME')};
					measure_dp_classes = {NNDataPoint_Measure_CLA().get('NAME'), NNDataPoint_Measure_REG().get('NAME')};
					
					if any(strcmp(dp_class, graph_dp_classes)) % GRAPH input
					    pr = NNFeatureImportanceBrainSurfacePP_Graph('EL', nnfib, 'D', input_dataset, 'PROP', 11, varargin{:});
					elseif any(strcmp(dp_class, measure_dp_classes))% MEASURE input
					    pr = NNFeatureImportanceBrainSurfacePP_Measure('EL', nnfib, 'D', input_dataset, 'PROP', 11, varargin{:});
					else % DATA input
					    pr = NNFeatureImportanceBrainSurfacePP_Data('EL', nnfib, 'D', input_dataset, 'PROP', 11, varargin{:});
					end
					
				otherwise
					pr = getPanelProp@ConcreteElement(nnfib, prop, varargin{:});
					
			end
		end
	end
end
