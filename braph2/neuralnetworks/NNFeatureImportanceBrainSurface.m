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
	
	properties (Constant) % properties
		BA = ConcreteElement.getPropNumber() + 1;
		BA_TAG = 'BA';
		BA_CATEGORY = Category.DATA;
		BA_FORMAT = Format.ITEM;
		
		D = ConcreteElement.getPropNumber() + 2;
		D_TAG = 'D';
		D_CATEGORY = Category.DATA;
		D_FORMAT = Format.ITEM;
		
		AV_FEATURE_IMPORTANCE = ConcreteElement.getPropNumber() + 3;
		AV_FEATURE_IMPORTANCE_TAG = 'AV_FEATURE_IMPORTANCE';
		AV_FEATURE_IMPORTANCE_CATEGORY = Category.DATA;
		AV_FEATURE_IMPORTANCE_FORMAT = Format.CELL;
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
			%
			% See also Category, Format.
			
			nnfib = nnfib@ConcreteElement(varargin{:});
		end
	end
	methods (Static) % inspection
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
			
			subclass_list = subclasses('NNFeatureImportanceBrainSurface', [], [], true);
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
			
			if nargin == 0
				prop_list = [ ...
					ConcreteElement.getProps() ...
						NNFeatureImportanceBrainSurface.BA ...
						NNFeatureImportanceBrainSurface.D ...
						NNFeatureImportanceBrainSurface.AV_FEATURE_IMPORTANCE ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						ConcreteElement.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						ConcreteElement.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						ConcreteElement.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						ConcreteElement.getProps(Category.DATA) ...
						NNFeatureImportanceBrainSurface.BA ...
						NNFeatureImportanceBrainSurface.D ...
						NNFeatureImportanceBrainSurface.AV_FEATURE_IMPORTANCE ...
						];
				case Category.RESULT
					prop_list = [
						ConcreteElement.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						ConcreteElement.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						ConcreteElement.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						ConcreteElement.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						ConcreteElement.getProps(Category.GUI) ...
						];
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
			
			prop_number = numel(NNFeatureImportanceBrainSurface.getProps(varargin{:}));
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
			
			check = any(prop == NNFeatureImportanceBrainSurface.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNFeatureImportanceBrainSurface:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNFeatureImportanceBrainSurface:' BRAPH2.WRONG_INPUT '\n' ...
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
			
			nnfeatureimportancebrainsurface_tag_list = cellfun(@(x) NNFeatureImportanceBrainSurface.getPropTag(x), num2cell(NNFeatureImportanceBrainSurface.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, nnfeatureimportancebrainsurface_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNFeatureImportanceBrainSurface:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNFeatureImportanceBrainSurface:' BRAPH2.WRONG_INPUT '\n' ...
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
				nnfeatureimportancebrainsurface_tag_list = cellfun(@(x) NNFeatureImportanceBrainSurface.getPropTag(x), num2cell(NNFeatureImportanceBrainSurface.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, nnfeatureimportancebrainsurface_tag_list)); % tag = pointer
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
				prop = pointer;
				
				switch prop
					case NNFeatureImportanceBrainSurface.BA
						tag = NNFeatureImportanceBrainSurface.BA_TAG;
					case NNFeatureImportanceBrainSurface.D
						tag = NNFeatureImportanceBrainSurface.D_TAG;
					case NNFeatureImportanceBrainSurface.AV_FEATURE_IMPORTANCE
						tag = NNFeatureImportanceBrainSurface.AV_FEATURE_IMPORTANCE_TAG;
					otherwise
						tag = getPropTag@ConcreteElement(prop);
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
			
			switch prop
				case NNFeatureImportanceBrainSurface.BA
					prop_category = NNFeatureImportanceBrainSurface.BA_CATEGORY;
				case NNFeatureImportanceBrainSurface.D
					prop_category = NNFeatureImportanceBrainSurface.D_CATEGORY;
				case NNFeatureImportanceBrainSurface.AV_FEATURE_IMPORTANCE
					prop_category = NNFeatureImportanceBrainSurface.AV_FEATURE_IMPORTANCE_CATEGORY;
				otherwise
					prop_category = getPropCategory@ConcreteElement(prop);
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
			
			switch prop
				case NNFeatureImportanceBrainSurface.BA
					prop_format = NNFeatureImportanceBrainSurface.BA_FORMAT;
				case NNFeatureImportanceBrainSurface.D
					prop_format = NNFeatureImportanceBrainSurface.D_FORMAT;
				case NNFeatureImportanceBrainSurface.AV_FEATURE_IMPORTANCE
					prop_format = NNFeatureImportanceBrainSurface.AV_FEATURE_IMPORTANCE_FORMAT;
				otherwise
					prop_format = getPropFormat@ConcreteElement(prop);
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
			
			switch prop
				case NNFeatureImportanceBrainSurface.BA
					prop_description = 'BA (data, item) is a brain atlas.';
				case NNFeatureImportanceBrainSurface.D
					prop_description = 'D (data, item) is a NN dataset.';
				case NNFeatureImportanceBrainSurface.AV_FEATURE_IMPORTANCE
					prop_description = 'AV_FEATURE_IMPORTANCE (data, cell) is the feature importances.';
				case NNFeatureImportanceBrainSurface.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the element to manage the visuazation of the neural network feature importance on the brain surface.';
				case NNFeatureImportanceBrainSurface.NAME
					prop_description = 'NAME (constant, string) is the name of the element to manage the visuazation of the neural network feature importance on the brain surface.';
				case NNFeatureImportanceBrainSurface.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the element to manage the visuazation of the neural network feature importance on the brain surface.';
				case NNFeatureImportanceBrainSurface.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the element to manage the visuazation of the neural network feature importance on the brain surface.';
				case NNFeatureImportanceBrainSurface.ID
					prop_description = 'ID (data, string) is a few-letter code of the element to manage the visuazation of the neural network feature importance on the brain surface.';
				case NNFeatureImportanceBrainSurface.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the element to manage the visuazation of the neural network feature importance on the brain surface.';
				case NNFeatureImportanceBrainSurface.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about managing the visuazation of the neural network feature importance on the brain surface.';
				otherwise
					prop_description = getPropDescription@ConcreteElement(prop);
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
			
			switch prop
				case NNFeatureImportanceBrainSurface.BA
					prop_settings = 'BrainAtlas';
				case NNFeatureImportanceBrainSurface.D
					prop_settings = 'NNDataset';
				case NNFeatureImportanceBrainSurface.AV_FEATURE_IMPORTANCE
					prop_settings = Format.getFormatSettings(Format.CELL);
				case NNFeatureImportanceBrainSurface.TEMPLATE
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
			
			switch prop
				case NNFeatureImportanceBrainSurface.BA
					prop_default = Format.getFormatDefault(Format.ITEM, NNFeatureImportanceBrainSurface.getPropSettings(prop));
				case NNFeatureImportanceBrainSurface.D
					prop_default = Format.getFormatDefault(Format.ITEM, NNFeatureImportanceBrainSurface.getPropSettings(prop));
				case NNFeatureImportanceBrainSurface.AV_FEATURE_IMPORTANCE
					prop_default = Format.getFormatDefault(Format.CELL, NNFeatureImportanceBrainSurface.getPropSettings(prop));
				case NNFeatureImportanceBrainSurface.ELCLASS
					prop_default = 'NNFeatureImportanceBrainSurface';
				case NNFeatureImportanceBrainSurface.NAME
					prop_default = 'Neural Network Feature Importace on Brain Surface';
				case NNFeatureImportanceBrainSurface.DESCRIPTION
					prop_default = 'A neural network feature importace on brain surface (NNFeatureImportanceBrainSurface) manages the visualization of feature importance within neural network evaluators, particularly on the brain surface. It handles different types of neural network inputs, including graph data (for visualizng the importance of connections between nodes), measures (for visualizing the importance of nodal measures), and the subject data (connectivity data or structural data).';
				case NNFeatureImportanceBrainSurface.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, NNFeatureImportanceBrainSurface.getPropSettings(prop));
				case NNFeatureImportanceBrainSurface.ID
					prop_default = 'NNFeatureImportanceBrainSurface ID';
				case NNFeatureImportanceBrainSurface.LABEL
					prop_default = 'NNFeatureImportanceBrainSurface label';
				case NNFeatureImportanceBrainSurface.NOTES
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
			%  Error id: €BRAPH2.STR€:NNFeatureImportanceBrainSurface:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  NNFIB.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of NNFIB.
			%   Error id: €BRAPH2.STR€:NNFeatureImportanceBrainSurface:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(NNFeatureImportanceBrainSurface, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNFeatureImportanceBrainSurface.
			%   Error id: €BRAPH2.STR€:NNFeatureImportanceBrainSurface:€BRAPH2.WRONG_INPUT€
			%  NNFIB.CHECKPROP(NNFeatureImportanceBrainSurface, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNFeatureImportanceBrainSurface.
			%   Error id: €BRAPH2.STR€:NNFeatureImportanceBrainSurface:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(NNFIB) and Element.CHECKPROP('NNFeatureImportanceBrainSurface')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = NNFeatureImportanceBrainSurface.getPropProp(pointer);
			
			switch prop
				case NNFeatureImportanceBrainSurface.BA % __NNFeatureImportanceBrainSurface.BA__
					check = Format.checkFormat(Format.ITEM, value, NNFeatureImportanceBrainSurface.getPropSettings(prop));
				case NNFeatureImportanceBrainSurface.D % __NNFeatureImportanceBrainSurface.D__
					check = Format.checkFormat(Format.ITEM, value, NNFeatureImportanceBrainSurface.getPropSettings(prop));
				case NNFeatureImportanceBrainSurface.AV_FEATURE_IMPORTANCE % __NNFeatureImportanceBrainSurface.AV_FEATURE_IMPORTANCE__
					check = Format.checkFormat(Format.CELL, value, NNFeatureImportanceBrainSurface.getPropSettings(prop));
				case NNFeatureImportanceBrainSurface.TEMPLATE % __NNFeatureImportanceBrainSurface.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, NNFeatureImportanceBrainSurface.getPropSettings(prop));
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNFeatureImportanceBrainSurface:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNFeatureImportanceBrainSurface:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' NNFeatureImportanceBrainSurface.getPropTag(prop) ' (' NNFeatureImportanceBrainSurface.getFormatTag(NNFeatureImportanceBrainSurface.getPropFormat(prop)) ').'] ...
					)
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
				case NNFeatureImportanceBrainSurface.AV_FEATURE_IMPORTANCE % __NNFeatureImportanceBrainSurface.AV_FEATURE_IMPORTANCE__
					input_dataset = nnfib.get('D');
					dp_class = input_dataset.get('DP_CLASS');
					graph_dp_classes = {NNDataPoint_Graph_CLA().get('NAME'), NNDataPoint_Graph_REG().get('NAME')};
					measure_dp_classes = {NNDataPoint_Measure_CLA().get('NAME'), NNDataPoint_Measure_REG().get('NAME')};
					
					if any(strcmp(dp_class, graph_dp_classes)) % GRAPH input
					    pr = NNFeatureImportanceBrainSurfacePP_FI_Graph('EL', nnfib, 'D', input_dataset, 'PROP', NNFeatureImportanceBrainSurface.AV_FEATURE_IMPORTANCE, varargin{:});
					elseif any(strcmp(dp_class, measure_dp_classes))% MEASURE input
					    pr = NNFeatureImportanceBrainSurfacePP_FI_Measure('EL', nnfib, 'D', input_dataset, 'PROP', NNFeatureImportanceBrainSurface.AV_FEATURE_IMPORTANCE, varargin{:});
					else % DATA input
					    pr = NNFeatureImportanceBrainSurfacePP_FI_Data('EL', nnfib, 'D', input_dataset, 'PROP', NNFeatureImportanceBrainSurface.AV_FEATURE_IMPORTANCE, varargin{:});
					end
					
				otherwise
					pr = getPanelProp@ConcreteElement(nnfib, prop, varargin{:});
					
			end
		end
	end
end
