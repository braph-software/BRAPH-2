classdef NNRegressorMLP_CrossValidationPF_Scatter < PanelFig
	%NNRegressorMLP_CrossValidationPF_Scatter is the base element to plot an ensemble-based comparison.
	% It is a subclass of <a href="matlab:help PanelFig">PanelFig</a>.
	%
	% NNRegressorMLP_CrossValidationPF_Scatter manages the basic functionalities to plot of an ensemble-based comparison.
	%
	% NNRegressorMLP_CrossValidationPF_Scatter methods (constructor):
	%  NNRegressorMLP_CrossValidationPF_Scatter - constructor
	%
	% NNRegressorMLP_CrossValidationPF_Scatter methods:
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
	% NNRegressorMLP_CrossValidationPF_Scatter methods (display):
	%  tostring - string with information about the panel ensemble-based comparison figure
	%  disp - displays information about the panel ensemble-based comparison figure
	%  tree - displays the tree of the panel ensemble-based comparison figure
	%
	% NNRegressorMLP_CrossValidationPF_Scatter methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two panel ensemble-based comparison figure are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the panel ensemble-based comparison figure
	%
	% NNRegressorMLP_CrossValidationPF_Scatter methods (save/load, Static):
	%  save - saves BRAPH2 panel ensemble-based comparison figure as b2 file
	%  load - loads a BRAPH2 panel ensemble-based comparison figure from a b2 file
	%
	% NNRegressorMLP_CrossValidationPF_Scatter method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the panel ensemble-based comparison figure
	%
	% NNRegressorMLP_CrossValidationPF_Scatter method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the panel ensemble-based comparison figure
	%
	% NNRegressorMLP_CrossValidationPF_Scatter methods (inspection, Static):
	%  getClass - returns the class of the panel ensemble-based comparison figure
	%  getSubclasses - returns all subclasses of NNRegressorMLP_CrossValidationPF_Scatter
	%  getProps - returns the property list of the panel ensemble-based comparison figure
	%  getPropNumber - returns the property number of the panel ensemble-based comparison figure
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
	% NNRegressorMLP_CrossValidationPF_Scatter methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% NNRegressorMLP_CrossValidationPF_Scatter methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% NNRegressorMLP_CrossValidationPF_Scatter methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% NNRegressorMLP_CrossValidationPF_Scatter methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?NNRegressorMLP_CrossValidationPF_Scatter; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">NNRegressorMLP_CrossValidationPF_Scatter constants</a>.
	%
	%
	% See also ComparisonEnsemble.
	
	properties (Constant) % properties
		H_AXES = PanelFig.getPropNumber() + 1;
		H_AXES_TAG = 'H_AXES';
		H_AXES_CATEGORY = Category.EVANESCENT;
		H_AXES_FORMAT = Format.HANDLE;
		
		ST_AXIS = PanelFig.getPropNumber() + 2;
		ST_AXIS_TAG = 'ST_AXIS';
		ST_AXIS_CATEGORY = Category.FIGURE;
		ST_AXIS_FORMAT = Format.ITEM;
		
		LISTENER_ST_AXIS = PanelFig.getPropNumber() + 3;
		LISTENER_ST_AXIS_TAG = 'LISTENER_ST_AXIS';
		LISTENER_ST_AXIS_CATEGORY = Category.EVANESCENT;
		LISTENER_ST_AXIS_FORMAT = Format.HANDLE;
		
		NNCV = PanelFig.getPropNumber() + 4;
		NNCV_TAG = 'NNCV';
		NNCV_CATEGORY = Category.METADATA;
		NNCV_FORMAT = Format.ITEM;
		
		PREDICTIONS_VALUE = PanelFig.getPropNumber() + 5;
		PREDICTIONS_VALUE_TAG = 'PREDICTIONS_VALUE';
		PREDICTIONS_VALUE_CATEGORY = Category.METADATA;
		PREDICTIONS_VALUE_FORMAT = Format.MATRIX;
		
		GROUNDTRUTH_VALUE = PanelFig.getPropNumber() + 6;
		GROUNDTRUTH_VALUE_TAG = 'GROUNDTRUTH_VALUE';
		GROUNDTRUTH_VALUE_CATEGORY = Category.METADATA;
		GROUNDTRUTH_VALUE_FORMAT = Format.MATRIX;
		
		SETUP = PanelFig.getPropNumber() + 7;
		SETUP_TAG = 'SETUP';
		SETUP_CATEGORY = Category.QUERY;
		SETUP_FORMAT = Format.EMPTY;
		
		H_PREDICTIONS = PanelFig.getPropNumber() + 8;
		H_PREDICTIONS_TAG = 'H_PREDICTIONS';
		H_PREDICTIONS_CATEGORY = Category.EVANESCENT;
		H_PREDICTIONS_FORMAT = Format.HANDLELIST;
		
		PREDICTIONS = PanelFig.getPropNumber() + 9;
		PREDICTIONS_TAG = 'PREDICTIONS';
		PREDICTIONS_CATEGORY = Category.FIGURE;
		PREDICTIONS_FORMAT = Format.LOGICAL;
		
		PREDICTION_DICT = PanelFig.getPropNumber() + 10;
		PREDICTION_DICT_TAG = 'PREDICTION_DICT';
		PREDICTION_DICT_CATEGORY = Category.FIGURE;
		PREDICTION_DICT_FORMAT = Format.IDICT;
		
		H_LINE_BASE = PanelFig.getPropNumber() + 11;
		H_LINE_BASE_TAG = 'H_LINE_BASE';
		H_LINE_BASE_CATEGORY = Category.EVANESCENT;
		H_LINE_BASE_FORMAT = Format.HANDLE;
		
		ST_LINE_BASE = PanelFig.getPropNumber() + 12;
		ST_LINE_BASE_TAG = 'ST_LINE_BASE';
		ST_LINE_BASE_CATEGORY = Category.FIGURE;
		ST_LINE_BASE_FORMAT = Format.ITEM;
		
		LISTENER_ST_LINE_BASE = PanelFig.getPropNumber() + 13;
		LISTENER_ST_LINE_BASE_TAG = 'LISTENER_ST_LINE_BASE';
		LISTENER_ST_LINE_BASE_CATEGORY = Category.EVANESCENT;
		LISTENER_ST_LINE_BASE_FORMAT = Format.HANDLE;
		
		H_TITLE = PanelFig.getPropNumber() + 14;
		H_TITLE_TAG = 'H_TITLE';
		H_TITLE_CATEGORY = Category.EVANESCENT;
		H_TITLE_FORMAT = Format.HANDLE;
		
		ST_TITLE = PanelFig.getPropNumber() + 15;
		ST_TITLE_TAG = 'ST_TITLE';
		ST_TITLE_CATEGORY = Category.FIGURE;
		ST_TITLE_FORMAT = Format.ITEM;
		
		H_XLABEL = PanelFig.getPropNumber() + 16;
		H_XLABEL_TAG = 'H_XLABEL';
		H_XLABEL_CATEGORY = Category.EVANESCENT;
		H_XLABEL_FORMAT = Format.HANDLE;
		
		ST_XLABEL = PanelFig.getPropNumber() + 17;
		ST_XLABEL_TAG = 'ST_XLABEL';
		ST_XLABEL_CATEGORY = Category.FIGURE;
		ST_XLABEL_FORMAT = Format.ITEM;
		
		H_YLABEL = PanelFig.getPropNumber() + 18;
		H_YLABEL_TAG = 'H_YLABEL';
		H_YLABEL_CATEGORY = Category.EVANESCENT;
		H_YLABEL_FORMAT = Format.HANDLE;
		
		ST_YLABEL = PanelFig.getPropNumber() + 19;
		ST_YLABEL_TAG = 'ST_YLABEL';
		ST_YLABEL_CATEGORY = Category.FIGURE;
		ST_YLABEL_FORMAT = Format.ITEM;
	end
	methods % constructor
		function pf = NNRegressorMLP_CrossValidationPF_Scatter(varargin)
			%NNRegressorMLP_CrossValidationPF_Scatter() creates a panel ensemble-based comparison figure.
			%
			% NNRegressorMLP_CrossValidationPF_Scatter(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% NNRegressorMLP_CrossValidationPF_Scatter(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			pf = pf@PanelFig(varargin{:});
		end
	end
	methods (Static) % inspection
		function pf_class = getClass()
			%GETCLASS returns the class of the panel ensemble-based comparison figure.
			%
			% CLASS = NNRegressorMLP_CrossValidationPF_Scatter.GETCLASS() returns the class 'NNRegressorMLP_CrossValidationPF_Scatter'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PF.GETCLASS() returns the class of the panel ensemble-based comparison figure PF.
			%  CLASS = Element.GETCLASS(PF) returns the class of 'PF'.
			%  CLASS = Element.GETCLASS('NNRegressorMLP_CrossValidationPF_Scatter') returns 'NNRegressorMLP_CrossValidationPF_Scatter'.
			%
			% Note that the Element.GETCLASS(PF) and Element.GETCLASS('NNRegressorMLP_CrossValidationPF_Scatter')
			%  are less computationally efficient.
			
			pf_class = 'NNRegressorMLP_CrossValidationPF_Scatter';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the panel ensemble-based comparison figure.
			%
			% LIST = NNRegressorMLP_CrossValidationPF_Scatter.GETSUBCLASSES() returns all subclasses of 'NNRegressorMLP_CrossValidationPF_Scatter'.
			%
			% Alternative forms to call this method are:
			%  LIST = PF.GETSUBCLASSES() returns all subclasses of the panel ensemble-based comparison figure PF.
			%  LIST = Element.GETSUBCLASSES(PF) returns all subclasses of 'PF'.
			%  LIST = Element.GETSUBCLASSES('NNRegressorMLP_CrossValidationPF_Scatter') returns all subclasses of 'NNRegressorMLP_CrossValidationPF_Scatter'.
			%
			% Note that the Element.GETSUBCLASSES(PF) and Element.GETSUBCLASSES('NNRegressorMLP_CrossValidationPF_Scatter')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('NNRegressorMLP_CrossValidationPF_Scatter', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of panel ensemble-based comparison figure.
			%
			% PROPS = NNRegressorMLP_CrossValidationPF_Scatter.GETPROPS() returns the property list of panel ensemble-based comparison figure
			%  as a row vector.
			%
			% PROPS = NNRegressorMLP_CrossValidationPF_Scatter.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PF.GETPROPS([CATEGORY]) returns the property list of the panel ensemble-based comparison figure PF.
			%  PROPS = Element.GETPROPS(PF[, CATEGORY]) returns the property list of 'PF'.
			%  PROPS = Element.GETPROPS('NNRegressorMLP_CrossValidationPF_Scatter'[, CATEGORY]) returns the property list of 'NNRegressorMLP_CrossValidationPF_Scatter'.
			%
			% Note that the Element.GETPROPS(PF) and Element.GETPROPS('NNRegressorMLP_CrossValidationPF_Scatter')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					PanelFig.getProps() ...
						NNRegressorMLP_CrossValidationPF_Scatter.H_AXES ...
						NNRegressorMLP_CrossValidationPF_Scatter.ST_AXIS ...
						NNRegressorMLP_CrossValidationPF_Scatter.LISTENER_ST_AXIS ...
						NNRegressorMLP_CrossValidationPF_Scatter.NNCV ...
						NNRegressorMLP_CrossValidationPF_Scatter.PREDICTIONS_VALUE ...
						NNRegressorMLP_CrossValidationPF_Scatter.GROUNDTRUTH_VALUE ...
						NNRegressorMLP_CrossValidationPF_Scatter.SETUP ...
						NNRegressorMLP_CrossValidationPF_Scatter.H_PREDICTIONS ...
						NNRegressorMLP_CrossValidationPF_Scatter.PREDICTIONS ...
						NNRegressorMLP_CrossValidationPF_Scatter.PREDICTION_DICT ...
						NNRegressorMLP_CrossValidationPF_Scatter.H_LINE_BASE ...
						NNRegressorMLP_CrossValidationPF_Scatter.ST_LINE_BASE ...
						NNRegressorMLP_CrossValidationPF_Scatter.LISTENER_ST_LINE_BASE ...
						NNRegressorMLP_CrossValidationPF_Scatter.H_TITLE ...
						NNRegressorMLP_CrossValidationPF_Scatter.ST_TITLE ...
						NNRegressorMLP_CrossValidationPF_Scatter.H_XLABEL ...
						NNRegressorMLP_CrossValidationPF_Scatter.ST_XLABEL ...
						NNRegressorMLP_CrossValidationPF_Scatter.H_YLABEL ...
						NNRegressorMLP_CrossValidationPF_Scatter.ST_YLABEL ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						PanelFig.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						PanelFig.getProps(Category.METADATA) ...
						NNRegressorMLP_CrossValidationPF_Scatter.NNCV ...
						NNRegressorMLP_CrossValidationPF_Scatter.PREDICTIONS_VALUE ...
						NNRegressorMLP_CrossValidationPF_Scatter.GROUNDTRUTH_VALUE ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						PanelFig.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						PanelFig.getProps(Category.DATA) ...
						];
				case Category.RESULT
					prop_list = [
						PanelFig.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						PanelFig.getProps(Category.QUERY) ...
						NNRegressorMLP_CrossValidationPF_Scatter.SETUP ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						PanelFig.getProps(Category.EVANESCENT) ...
						NNRegressorMLP_CrossValidationPF_Scatter.H_AXES ...
						NNRegressorMLP_CrossValidationPF_Scatter.LISTENER_ST_AXIS ...
						NNRegressorMLP_CrossValidationPF_Scatter.H_PREDICTIONS ...
						NNRegressorMLP_CrossValidationPF_Scatter.H_LINE_BASE ...
						NNRegressorMLP_CrossValidationPF_Scatter.LISTENER_ST_LINE_BASE ...
						NNRegressorMLP_CrossValidationPF_Scatter.H_TITLE ...
						NNRegressorMLP_CrossValidationPF_Scatter.H_XLABEL ...
						NNRegressorMLP_CrossValidationPF_Scatter.H_YLABEL ...
						];
				case Category.FIGURE
					prop_list = [ ...
						PanelFig.getProps(Category.FIGURE) ...
						NNRegressorMLP_CrossValidationPF_Scatter.ST_AXIS ...
						NNRegressorMLP_CrossValidationPF_Scatter.PREDICTIONS ...
						NNRegressorMLP_CrossValidationPF_Scatter.PREDICTION_DICT ...
						NNRegressorMLP_CrossValidationPF_Scatter.ST_LINE_BASE ...
						NNRegressorMLP_CrossValidationPF_Scatter.ST_TITLE ...
						NNRegressorMLP_CrossValidationPF_Scatter.ST_XLABEL ...
						NNRegressorMLP_CrossValidationPF_Scatter.ST_YLABEL ...
						];
				case Category.GUI
					prop_list = [ ...
						PanelFig.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of panel ensemble-based comparison figure.
			%
			% N = NNRegressorMLP_CrossValidationPF_Scatter.GETPROPNUMBER() returns the property number of panel ensemble-based comparison figure.
			%
			% N = NNRegressorMLP_CrossValidationPF_Scatter.GETPROPNUMBER(CATEGORY) returns the property number of panel ensemble-based comparison figure
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PF.GETPROPNUMBER([CATEGORY]) returns the property number of the panel ensemble-based comparison figure PF.
			%  N = Element.GETPROPNUMBER(PF) returns the property number of 'PF'.
			%  N = Element.GETPROPNUMBER('NNRegressorMLP_CrossValidationPF_Scatter') returns the property number of 'NNRegressorMLP_CrossValidationPF_Scatter'.
			%
			% Note that the Element.GETPROPNUMBER(PF) and Element.GETPROPNUMBER('NNRegressorMLP_CrossValidationPF_Scatter')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(NNRegressorMLP_CrossValidationPF_Scatter.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in panel ensemble-based comparison figure/error.
			%
			% CHECK = NNRegressorMLP_CrossValidationPF_Scatter.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSPROP(PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(PF, PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(NNRegressorMLP_CrossValidationPF_Scatter, PROP) checks whether PROP exists for NNRegressorMLP_CrossValidationPF_Scatter.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:NNRegressorMLP_CrossValidationPF_Scatter:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSPROP(PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:NNRegressorMLP_CrossValidationPF_Scatter:WrongInput]
			%  Element.EXISTSPROP(PF, PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:NNRegressorMLP_CrossValidationPF_Scatter:WrongInput]
			%  Element.EXISTSPROP(NNRegressorMLP_CrossValidationPF_Scatter, PROP) throws error if PROP does NOT exist for NNRegressorMLP_CrossValidationPF_Scatter.
			%   Error id: [BRAPH2:NNRegressorMLP_CrossValidationPF_Scatter:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PF) and Element.EXISTSPROP('NNRegressorMLP_CrossValidationPF_Scatter')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == NNRegressorMLP_CrossValidationPF_Scatter.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNRegressorMLP_CrossValidationPF_Scatter:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNRegressorMLP_CrossValidationPF_Scatter:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for NNRegressorMLP_CrossValidationPF_Scatter.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in panel ensemble-based comparison figure/error.
			%
			% CHECK = NNRegressorMLP_CrossValidationPF_Scatter.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSTAG(TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(PF, TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(NNRegressorMLP_CrossValidationPF_Scatter, TAG) checks whether TAG exists for NNRegressorMLP_CrossValidationPF_Scatter.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:NNRegressorMLP_CrossValidationPF_Scatter:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSTAG(TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:NNRegressorMLP_CrossValidationPF_Scatter:WrongInput]
			%  Element.EXISTSTAG(PF, TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:NNRegressorMLP_CrossValidationPF_Scatter:WrongInput]
			%  Element.EXISTSTAG(NNRegressorMLP_CrossValidationPF_Scatter, TAG) throws error if TAG does NOT exist for NNRegressorMLP_CrossValidationPF_Scatter.
			%   Error id: [BRAPH2:NNRegressorMLP_CrossValidationPF_Scatter:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PF) and Element.EXISTSTAG('NNRegressorMLP_CrossValidationPF_Scatter')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			nnregressormlp_crossvalidationpf_scatter_tag_list = cellfun(@(x) NNRegressorMLP_CrossValidationPF_Scatter.getPropTag(x), num2cell(NNRegressorMLP_CrossValidationPF_Scatter.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, nnregressormlp_crossvalidationpf_scatter_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNRegressorMLP_CrossValidationPF_Scatter:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNRegressorMLP_CrossValidationPF_Scatter:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for NNRegressorMLP_CrossValidationPF_Scatter.'] ...
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
			%  PROPERTY = PF.GETPROPPROP(POINTER) returns property number of POINTER of PF.
			%  PROPERTY = Element.GETPROPPROP(NNRegressorMLP_CrossValidationPF_Scatter, POINTER) returns property number of POINTER of NNRegressorMLP_CrossValidationPF_Scatter.
			%  PROPERTY = PF.GETPROPPROP(NNRegressorMLP_CrossValidationPF_Scatter, POINTER) returns property number of POINTER of NNRegressorMLP_CrossValidationPF_Scatter.
			%
			% Note that the Element.GETPROPPROP(PF) and Element.GETPROPPROP('NNRegressorMLP_CrossValidationPF_Scatter')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				nnregressormlp_crossvalidationpf_scatter_tag_list = cellfun(@(x) NNRegressorMLP_CrossValidationPF_Scatter.getPropTag(x), num2cell(NNRegressorMLP_CrossValidationPF_Scatter.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, nnregressormlp_crossvalidationpf_scatter_tag_list)); % tag = pointer
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
			%  TAG = PF.GETPROPTAG(POINTER) returns tag of POINTER of PF.
			%  TAG = Element.GETPROPTAG(NNRegressorMLP_CrossValidationPF_Scatter, POINTER) returns tag of POINTER of NNRegressorMLP_CrossValidationPF_Scatter.
			%  TAG = PF.GETPROPTAG(NNRegressorMLP_CrossValidationPF_Scatter, POINTER) returns tag of POINTER of NNRegressorMLP_CrossValidationPF_Scatter.
			%
			% Note that the Element.GETPROPTAG(PF) and Element.GETPROPTAG('NNRegressorMLP_CrossValidationPF_Scatter')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case NNRegressorMLP_CrossValidationPF_Scatter.H_AXES
						tag = NNRegressorMLP_CrossValidationPF_Scatter.H_AXES_TAG;
					case NNRegressorMLP_CrossValidationPF_Scatter.ST_AXIS
						tag = NNRegressorMLP_CrossValidationPF_Scatter.ST_AXIS_TAG;
					case NNRegressorMLP_CrossValidationPF_Scatter.LISTENER_ST_AXIS
						tag = NNRegressorMLP_CrossValidationPF_Scatter.LISTENER_ST_AXIS_TAG;
					case NNRegressorMLP_CrossValidationPF_Scatter.NNCV
						tag = NNRegressorMLP_CrossValidationPF_Scatter.NNCV_TAG;
					case NNRegressorMLP_CrossValidationPF_Scatter.PREDICTIONS_VALUE
						tag = NNRegressorMLP_CrossValidationPF_Scatter.PREDICTIONS_VALUE_TAG;
					case NNRegressorMLP_CrossValidationPF_Scatter.GROUNDTRUTH_VALUE
						tag = NNRegressorMLP_CrossValidationPF_Scatter.GROUNDTRUTH_VALUE_TAG;
					case NNRegressorMLP_CrossValidationPF_Scatter.SETUP
						tag = NNRegressorMLP_CrossValidationPF_Scatter.SETUP_TAG;
					case NNRegressorMLP_CrossValidationPF_Scatter.H_PREDICTIONS
						tag = NNRegressorMLP_CrossValidationPF_Scatter.H_PREDICTIONS_TAG;
					case NNRegressorMLP_CrossValidationPF_Scatter.PREDICTIONS
						tag = NNRegressorMLP_CrossValidationPF_Scatter.PREDICTIONS_TAG;
					case NNRegressorMLP_CrossValidationPF_Scatter.PREDICTION_DICT
						tag = NNRegressorMLP_CrossValidationPF_Scatter.PREDICTION_DICT_TAG;
					case NNRegressorMLP_CrossValidationPF_Scatter.H_LINE_BASE
						tag = NNRegressorMLP_CrossValidationPF_Scatter.H_LINE_BASE_TAG;
					case NNRegressorMLP_CrossValidationPF_Scatter.ST_LINE_BASE
						tag = NNRegressorMLP_CrossValidationPF_Scatter.ST_LINE_BASE_TAG;
					case NNRegressorMLP_CrossValidationPF_Scatter.LISTENER_ST_LINE_BASE
						tag = NNRegressorMLP_CrossValidationPF_Scatter.LISTENER_ST_LINE_BASE_TAG;
					case NNRegressorMLP_CrossValidationPF_Scatter.H_TITLE
						tag = NNRegressorMLP_CrossValidationPF_Scatter.H_TITLE_TAG;
					case NNRegressorMLP_CrossValidationPF_Scatter.ST_TITLE
						tag = NNRegressorMLP_CrossValidationPF_Scatter.ST_TITLE_TAG;
					case NNRegressorMLP_CrossValidationPF_Scatter.H_XLABEL
						tag = NNRegressorMLP_CrossValidationPF_Scatter.H_XLABEL_TAG;
					case NNRegressorMLP_CrossValidationPF_Scatter.ST_XLABEL
						tag = NNRegressorMLP_CrossValidationPF_Scatter.ST_XLABEL_TAG;
					case NNRegressorMLP_CrossValidationPF_Scatter.H_YLABEL
						tag = NNRegressorMLP_CrossValidationPF_Scatter.H_YLABEL_TAG;
					case NNRegressorMLP_CrossValidationPF_Scatter.ST_YLABEL
						tag = NNRegressorMLP_CrossValidationPF_Scatter.ST_YLABEL_TAG;
					otherwise
						tag = getPropTag@PanelFig(prop);
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
			%  CATEGORY = PF.GETPROPCATEGORY(POINTER) returns category of POINTER of PF.
			%  CATEGORY = Element.GETPROPCATEGORY(NNRegressorMLP_CrossValidationPF_Scatter, POINTER) returns category of POINTER of NNRegressorMLP_CrossValidationPF_Scatter.
			%  CATEGORY = PF.GETPROPCATEGORY(NNRegressorMLP_CrossValidationPF_Scatter, POINTER) returns category of POINTER of NNRegressorMLP_CrossValidationPF_Scatter.
			%
			% Note that the Element.GETPROPCATEGORY(PF) and Element.GETPROPCATEGORY('NNRegressorMLP_CrossValidationPF_Scatter')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = NNRegressorMLP_CrossValidationPF_Scatter.getPropProp(pointer);
			
			switch prop
				case NNRegressorMLP_CrossValidationPF_Scatter.H_AXES
					prop_category = NNRegressorMLP_CrossValidationPF_Scatter.H_AXES_CATEGORY;
				case NNRegressorMLP_CrossValidationPF_Scatter.ST_AXIS
					prop_category = NNRegressorMLP_CrossValidationPF_Scatter.ST_AXIS_CATEGORY;
				case NNRegressorMLP_CrossValidationPF_Scatter.LISTENER_ST_AXIS
					prop_category = NNRegressorMLP_CrossValidationPF_Scatter.LISTENER_ST_AXIS_CATEGORY;
				case NNRegressorMLP_CrossValidationPF_Scatter.NNCV
					prop_category = NNRegressorMLP_CrossValidationPF_Scatter.NNCV_CATEGORY;
				case NNRegressorMLP_CrossValidationPF_Scatter.PREDICTIONS_VALUE
					prop_category = NNRegressorMLP_CrossValidationPF_Scatter.PREDICTIONS_VALUE_CATEGORY;
				case NNRegressorMLP_CrossValidationPF_Scatter.GROUNDTRUTH_VALUE
					prop_category = NNRegressorMLP_CrossValidationPF_Scatter.GROUNDTRUTH_VALUE_CATEGORY;
				case NNRegressorMLP_CrossValidationPF_Scatter.SETUP
					prop_category = NNRegressorMLP_CrossValidationPF_Scatter.SETUP_CATEGORY;
				case NNRegressorMLP_CrossValidationPF_Scatter.H_PREDICTIONS
					prop_category = NNRegressorMLP_CrossValidationPF_Scatter.H_PREDICTIONS_CATEGORY;
				case NNRegressorMLP_CrossValidationPF_Scatter.PREDICTIONS
					prop_category = NNRegressorMLP_CrossValidationPF_Scatter.PREDICTIONS_CATEGORY;
				case NNRegressorMLP_CrossValidationPF_Scatter.PREDICTION_DICT
					prop_category = NNRegressorMLP_CrossValidationPF_Scatter.PREDICTION_DICT_CATEGORY;
				case NNRegressorMLP_CrossValidationPF_Scatter.H_LINE_BASE
					prop_category = NNRegressorMLP_CrossValidationPF_Scatter.H_LINE_BASE_CATEGORY;
				case NNRegressorMLP_CrossValidationPF_Scatter.ST_LINE_BASE
					prop_category = NNRegressorMLP_CrossValidationPF_Scatter.ST_LINE_BASE_CATEGORY;
				case NNRegressorMLP_CrossValidationPF_Scatter.LISTENER_ST_LINE_BASE
					prop_category = NNRegressorMLP_CrossValidationPF_Scatter.LISTENER_ST_LINE_BASE_CATEGORY;
				case NNRegressorMLP_CrossValidationPF_Scatter.H_TITLE
					prop_category = NNRegressorMLP_CrossValidationPF_Scatter.H_TITLE_CATEGORY;
				case NNRegressorMLP_CrossValidationPF_Scatter.ST_TITLE
					prop_category = NNRegressorMLP_CrossValidationPF_Scatter.ST_TITLE_CATEGORY;
				case NNRegressorMLP_CrossValidationPF_Scatter.H_XLABEL
					prop_category = NNRegressorMLP_CrossValidationPF_Scatter.H_XLABEL_CATEGORY;
				case NNRegressorMLP_CrossValidationPF_Scatter.ST_XLABEL
					prop_category = NNRegressorMLP_CrossValidationPF_Scatter.ST_XLABEL_CATEGORY;
				case NNRegressorMLP_CrossValidationPF_Scatter.H_YLABEL
					prop_category = NNRegressorMLP_CrossValidationPF_Scatter.H_YLABEL_CATEGORY;
				case NNRegressorMLP_CrossValidationPF_Scatter.ST_YLABEL
					prop_category = NNRegressorMLP_CrossValidationPF_Scatter.ST_YLABEL_CATEGORY;
				otherwise
					prop_category = getPropCategory@PanelFig(prop);
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
			%  FORMAT = PF.GETPROPFORMAT(POINTER) returns format of POINTER of PF.
			%  FORMAT = Element.GETPROPFORMAT(NNRegressorMLP_CrossValidationPF_Scatter, POINTER) returns format of POINTER of NNRegressorMLP_CrossValidationPF_Scatter.
			%  FORMAT = PF.GETPROPFORMAT(NNRegressorMLP_CrossValidationPF_Scatter, POINTER) returns format of POINTER of NNRegressorMLP_CrossValidationPF_Scatter.
			%
			% Note that the Element.GETPROPFORMAT(PF) and Element.GETPROPFORMAT('NNRegressorMLP_CrossValidationPF_Scatter')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = NNRegressorMLP_CrossValidationPF_Scatter.getPropProp(pointer);
			
			switch prop
				case NNRegressorMLP_CrossValidationPF_Scatter.H_AXES
					prop_format = NNRegressorMLP_CrossValidationPF_Scatter.H_AXES_FORMAT;
				case NNRegressorMLP_CrossValidationPF_Scatter.ST_AXIS
					prop_format = NNRegressorMLP_CrossValidationPF_Scatter.ST_AXIS_FORMAT;
				case NNRegressorMLP_CrossValidationPF_Scatter.LISTENER_ST_AXIS
					prop_format = NNRegressorMLP_CrossValidationPF_Scatter.LISTENER_ST_AXIS_FORMAT;
				case NNRegressorMLP_CrossValidationPF_Scatter.NNCV
					prop_format = NNRegressorMLP_CrossValidationPF_Scatter.NNCV_FORMAT;
				case NNRegressorMLP_CrossValidationPF_Scatter.PREDICTIONS_VALUE
					prop_format = NNRegressorMLP_CrossValidationPF_Scatter.PREDICTIONS_VALUE_FORMAT;
				case NNRegressorMLP_CrossValidationPF_Scatter.GROUNDTRUTH_VALUE
					prop_format = NNRegressorMLP_CrossValidationPF_Scatter.GROUNDTRUTH_VALUE_FORMAT;
				case NNRegressorMLP_CrossValidationPF_Scatter.SETUP
					prop_format = NNRegressorMLP_CrossValidationPF_Scatter.SETUP_FORMAT;
				case NNRegressorMLP_CrossValidationPF_Scatter.H_PREDICTIONS
					prop_format = NNRegressorMLP_CrossValidationPF_Scatter.H_PREDICTIONS_FORMAT;
				case NNRegressorMLP_CrossValidationPF_Scatter.PREDICTIONS
					prop_format = NNRegressorMLP_CrossValidationPF_Scatter.PREDICTIONS_FORMAT;
				case NNRegressorMLP_CrossValidationPF_Scatter.PREDICTION_DICT
					prop_format = NNRegressorMLP_CrossValidationPF_Scatter.PREDICTION_DICT_FORMAT;
				case NNRegressorMLP_CrossValidationPF_Scatter.H_LINE_BASE
					prop_format = NNRegressorMLP_CrossValidationPF_Scatter.H_LINE_BASE_FORMAT;
				case NNRegressorMLP_CrossValidationPF_Scatter.ST_LINE_BASE
					prop_format = NNRegressorMLP_CrossValidationPF_Scatter.ST_LINE_BASE_FORMAT;
				case NNRegressorMLP_CrossValidationPF_Scatter.LISTENER_ST_LINE_BASE
					prop_format = NNRegressorMLP_CrossValidationPF_Scatter.LISTENER_ST_LINE_BASE_FORMAT;
				case NNRegressorMLP_CrossValidationPF_Scatter.H_TITLE
					prop_format = NNRegressorMLP_CrossValidationPF_Scatter.H_TITLE_FORMAT;
				case NNRegressorMLP_CrossValidationPF_Scatter.ST_TITLE
					prop_format = NNRegressorMLP_CrossValidationPF_Scatter.ST_TITLE_FORMAT;
				case NNRegressorMLP_CrossValidationPF_Scatter.H_XLABEL
					prop_format = NNRegressorMLP_CrossValidationPF_Scatter.H_XLABEL_FORMAT;
				case NNRegressorMLP_CrossValidationPF_Scatter.ST_XLABEL
					prop_format = NNRegressorMLP_CrossValidationPF_Scatter.ST_XLABEL_FORMAT;
				case NNRegressorMLP_CrossValidationPF_Scatter.H_YLABEL
					prop_format = NNRegressorMLP_CrossValidationPF_Scatter.H_YLABEL_FORMAT;
				case NNRegressorMLP_CrossValidationPF_Scatter.ST_YLABEL
					prop_format = NNRegressorMLP_CrossValidationPF_Scatter.ST_YLABEL_FORMAT;
				otherwise
					prop_format = getPropFormat@PanelFig(prop);
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
			%  DESCRIPTION = PF.GETPROPDESCRIPTION(POINTER) returns description of POINTER of PF.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(NNRegressorMLP_CrossValidationPF_Scatter, POINTER) returns description of POINTER of NNRegressorMLP_CrossValidationPF_Scatter.
			%  DESCRIPTION = PF.GETPROPDESCRIPTION(NNRegressorMLP_CrossValidationPF_Scatter, POINTER) returns description of POINTER of NNRegressorMLP_CrossValidationPF_Scatter.
			%
			% Note that the Element.GETPROPDESCRIPTION(PF) and Element.GETPROPDESCRIPTION('NNRegressorMLP_CrossValidationPF_Scatter')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = NNRegressorMLP_CrossValidationPF_Scatter.getPropProp(pointer);
			
			switch prop
				case NNRegressorMLP_CrossValidationPF_Scatter.H_AXES
					prop_description = 'H_AXES (evanescent, handle) is the handle for the axes.';
				case NNRegressorMLP_CrossValidationPF_Scatter.ST_AXIS
					prop_description = 'ST_AXIS (figure, item) determines the axis settings.';
				case NNRegressorMLP_CrossValidationPF_Scatter.LISTENER_ST_AXIS
					prop_description = 'LISTENER_ST_AXIS (evanescent, handle) contains the listener to the axis settings to update the pushbuttons.';
				case NNRegressorMLP_CrossValidationPF_Scatter.NNCV
					prop_description = 'NNCV (metadata, item) is the ensemble-based comparison.';
				case NNRegressorMLP_CrossValidationPF_Scatter.PREDICTIONS_VALUE
					prop_description = 'PREDICTIONS_VALUE (metadata, matrix) is the predictions value.';
				case NNRegressorMLP_CrossValidationPF_Scatter.GROUNDTRUTH_VALUE
					prop_description = 'GROUNDTRUTH_VALUE (metadata, matrix) is the ground truth value.';
				case NNRegressorMLP_CrossValidationPF_Scatter.SETUP
					prop_description = 'SETUP (query, empty) calculates the ensemble-based comparison value and stores it to be implemented in the subelements.';
				case NNRegressorMLP_CrossValidationPF_Scatter.H_PREDICTIONS
					prop_description = 'H_PREDICTIONS (evanescent, handlelist) is the set of handles for the prediction plots.';
				case NNRegressorMLP_CrossValidationPF_Scatter.PREDICTIONS
					prop_description = 'PREDICTIONS (figure, logical) determines whether the prediction plot are shown.';
				case NNRegressorMLP_CrossValidationPF_Scatter.PREDICTION_DICT
					prop_description = 'PREDICTION_DICT (figure, idict) contains the prediction plot for each target.';
				case NNRegressorMLP_CrossValidationPF_Scatter.H_LINE_BASE
					prop_description = 'H_LINE_BASE (evanescent, handle) is the handle for the ensemble-based comparison line.';
				case NNRegressorMLP_CrossValidationPF_Scatter.ST_LINE_BASE
					prop_description = 'ST_LINE_BASE (figure, item) determines the line settings.';
				case NNRegressorMLP_CrossValidationPF_Scatter.LISTENER_ST_LINE_BASE
					prop_description = 'LISTENER_ST_LINE_BASE (evanescent, handle) contains the listener to the measure line settings to update the pushbutton.';
				case NNRegressorMLP_CrossValidationPF_Scatter.H_TITLE
					prop_description = 'H_TITLE (evanescent, handle) is the axis title.';
				case NNRegressorMLP_CrossValidationPF_Scatter.ST_TITLE
					prop_description = 'ST_TITLE (figure, item) determines the title settings.';
				case NNRegressorMLP_CrossValidationPF_Scatter.H_XLABEL
					prop_description = 'H_XLABEL (evanescent, handle) is the axis x-label.';
				case NNRegressorMLP_CrossValidationPF_Scatter.ST_XLABEL
					prop_description = 'ST_XLABEL (figure, item) determines the x-label settings.';
				case NNRegressorMLP_CrossValidationPF_Scatter.H_YLABEL
					prop_description = 'H_YLABEL (evanescent, handle) is the axis y-label.';
				case NNRegressorMLP_CrossValidationPF_Scatter.ST_YLABEL
					prop_description = 'ST_YLABEL (figure, item) determines the y-label settings.';
				case NNRegressorMLP_CrossValidationPF_Scatter.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the % % % .';
				case NNRegressorMLP_CrossValidationPF_Scatter.NAME
					prop_description = 'NAME (constant, string) is the name of the panel ensemble-based comparison figure.';
				case NNRegressorMLP_CrossValidationPF_Scatter.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the panel ensemble-based comparison figure.';
				case NNRegressorMLP_CrossValidationPF_Scatter.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the panel ensemble-based comparison figure.';
				case NNRegressorMLP_CrossValidationPF_Scatter.ID
					prop_description = 'ID (data, string) is a few-letter code for the panel ensemble-based comparison figure.';
				case NNRegressorMLP_CrossValidationPF_Scatter.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the panel ensemble-based comparison figure.';
				case NNRegressorMLP_CrossValidationPF_Scatter.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the panel ensemble-based comparison figure.';
				case NNRegressorMLP_CrossValidationPF_Scatter.DRAW
					prop_description = 'DRAW (query, logical) draws the figure comparison figure.';
				case NNRegressorMLP_CrossValidationPF_Scatter.DELETE
					prop_description = 'DELETE (query, logical) resets the handles when the panel figure graph is deleted.';
				case NNRegressorMLP_CrossValidationPF_Scatter.H_TOOLS
					prop_description = 'H_TOOLS (evanescent, handlelist) is the list of panel-specific tools from the first.';
				otherwise
					prop_description = getPropDescription@PanelFig(prop);
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
			%  SETTINGS = PF.GETPROPSETTINGS(POINTER) returns settings of POINTER of PF.
			%  SETTINGS = Element.GETPROPSETTINGS(NNRegressorMLP_CrossValidationPF_Scatter, POINTER) returns settings of POINTER of NNRegressorMLP_CrossValidationPF_Scatter.
			%  SETTINGS = PF.GETPROPSETTINGS(NNRegressorMLP_CrossValidationPF_Scatter, POINTER) returns settings of POINTER of NNRegressorMLP_CrossValidationPF_Scatter.
			%
			% Note that the Element.GETPROPSETTINGS(PF) and Element.GETPROPSETTINGS('NNRegressorMLP_CrossValidationPF_Scatter')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = NNRegressorMLP_CrossValidationPF_Scatter.getPropProp(pointer);
			
			switch prop
				case NNRegressorMLP_CrossValidationPF_Scatter.H_AXES
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case NNRegressorMLP_CrossValidationPF_Scatter.ST_AXIS
					prop_settings = 'SettingsAxis';
				case NNRegressorMLP_CrossValidationPF_Scatter.LISTENER_ST_AXIS
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case NNRegressorMLP_CrossValidationPF_Scatter.NNCV
					prop_settings = 'NNRegressorMLP_CrossValidation';
				case NNRegressorMLP_CrossValidationPF_Scatter.PREDICTIONS_VALUE
					prop_settings = Format.getFormatSettings(Format.MATRIX);
				case NNRegressorMLP_CrossValidationPF_Scatter.GROUNDTRUTH_VALUE
					prop_settings = Format.getFormatSettings(Format.MATRIX);
				case NNRegressorMLP_CrossValidationPF_Scatter.SETUP
					prop_settings = Format.getFormatSettings(Format.EMPTY);
				case NNRegressorMLP_CrossValidationPF_Scatter.H_PREDICTIONS
					prop_settings = Format.getFormatSettings(Format.HANDLELIST);
				case NNRegressorMLP_CrossValidationPF_Scatter.PREDICTIONS
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case NNRegressorMLP_CrossValidationPF_Scatter.PREDICTION_DICT
					prop_settings = 'SettingsLine';
				case NNRegressorMLP_CrossValidationPF_Scatter.H_LINE_BASE
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case NNRegressorMLP_CrossValidationPF_Scatter.ST_LINE_BASE
					prop_settings = 'SettingsLine';
				case NNRegressorMLP_CrossValidationPF_Scatter.LISTENER_ST_LINE_BASE
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case NNRegressorMLP_CrossValidationPF_Scatter.H_TITLE
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case NNRegressorMLP_CrossValidationPF_Scatter.ST_TITLE
					prop_settings = 'SettingsText';
				case NNRegressorMLP_CrossValidationPF_Scatter.H_XLABEL
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case NNRegressorMLP_CrossValidationPF_Scatter.ST_XLABEL
					prop_settings = 'SettingsText';
				case NNRegressorMLP_CrossValidationPF_Scatter.H_YLABEL
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case NNRegressorMLP_CrossValidationPF_Scatter.ST_YLABEL
					prop_settings = 'SettingsText';
				case NNRegressorMLP_CrossValidationPF_Scatter.TEMPLATE
					prop_settings = 'NNRegressorMLP_CrossValidationPF_Scatter';
				otherwise
					prop_settings = getPropSettings@PanelFig(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = NNRegressorMLP_CrossValidationPF_Scatter.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = NNRegressorMLP_CrossValidationPF_Scatter.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULT(NNRegressorMLP_CrossValidationPF_Scatter, POINTER) returns the default value of POINTER of NNRegressorMLP_CrossValidationPF_Scatter.
			%  DEFAULT = PF.GETPROPDEFAULT(NNRegressorMLP_CrossValidationPF_Scatter, POINTER) returns the default value of POINTER of NNRegressorMLP_CrossValidationPF_Scatter.
			%
			% Note that the Element.GETPROPDEFAULT(PF) and Element.GETPROPDEFAULT('NNRegressorMLP_CrossValidationPF_Scatter')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNRegressorMLP_CrossValidationPF_Scatter.getPropProp(pointer);
			
			switch prop
				case NNRegressorMLP_CrossValidationPF_Scatter.H_AXES
					prop_default = Format.getFormatDefault(Format.HANDLE, NNRegressorMLP_CrossValidationPF_Scatter.getPropSettings(prop));
				case NNRegressorMLP_CrossValidationPF_Scatter.ST_AXIS
					prop_default = SettingsAxis('AXIS', true, 'GRID', false, 'EQUAL', false);
				case NNRegressorMLP_CrossValidationPF_Scatter.LISTENER_ST_AXIS
					prop_default = Format.getFormatDefault(Format.HANDLE, NNRegressorMLP_CrossValidationPF_Scatter.getPropSettings(prop));
				case NNRegressorMLP_CrossValidationPF_Scatter.NNCV
					prop_default = Format.getFormatDefault(Format.ITEM, NNRegressorMLP_CrossValidationPF_Scatter.getPropSettings(prop));
				case NNRegressorMLP_CrossValidationPF_Scatter.PREDICTIONS_VALUE
					prop_default = Format.getFormatDefault(Format.MATRIX, NNRegressorMLP_CrossValidationPF_Scatter.getPropSettings(prop));
				case NNRegressorMLP_CrossValidationPF_Scatter.GROUNDTRUTH_VALUE
					prop_default = Format.getFormatDefault(Format.MATRIX, NNRegressorMLP_CrossValidationPF_Scatter.getPropSettings(prop));
				case NNRegressorMLP_CrossValidationPF_Scatter.SETUP
					prop_default = Format.getFormatDefault(Format.EMPTY, NNRegressorMLP_CrossValidationPF_Scatter.getPropSettings(prop));
				case NNRegressorMLP_CrossValidationPF_Scatter.H_PREDICTIONS
					prop_default = Format.getFormatDefault(Format.HANDLELIST, NNRegressorMLP_CrossValidationPF_Scatter.getPropSettings(prop));
				case NNRegressorMLP_CrossValidationPF_Scatter.PREDICTIONS
					prop_default = true;
				case NNRegressorMLP_CrossValidationPF_Scatter.PREDICTION_DICT
					prop_default = Format.getFormatDefault(Format.IDICT, NNRegressorMLP_CrossValidationPF_Scatter.getPropSettings(prop));
				case NNRegressorMLP_CrossValidationPF_Scatter.H_LINE_BASE
					prop_default = Format.getFormatDefault(Format.HANDLE, NNRegressorMLP_CrossValidationPF_Scatter.getPropSettings(prop));
				case NNRegressorMLP_CrossValidationPF_Scatter.ST_LINE_BASE
					prop_default = Format.getFormatDefault(Format.ITEM, NNRegressorMLP_CrossValidationPF_Scatter.getPropSettings(prop));
				case NNRegressorMLP_CrossValidationPF_Scatter.LISTENER_ST_LINE_BASE
					prop_default = Format.getFormatDefault(Format.HANDLE, NNRegressorMLP_CrossValidationPF_Scatter.getPropSettings(prop));
				case NNRegressorMLP_CrossValidationPF_Scatter.H_TITLE
					prop_default = Format.getFormatDefault(Format.HANDLE, NNRegressorMLP_CrossValidationPF_Scatter.getPropSettings(prop));
				case NNRegressorMLP_CrossValidationPF_Scatter.ST_TITLE
					prop_default = SettingsText('VISIBLE', true, 'FONTSIZE', s(2), 'HALIGN', 'center', 'VALIGN', 'middle');
				case NNRegressorMLP_CrossValidationPF_Scatter.H_XLABEL
					prop_default = Format.getFormatDefault(Format.HANDLE, NNRegressorMLP_CrossValidationPF_Scatter.getPropSettings(prop));
				case NNRegressorMLP_CrossValidationPF_Scatter.ST_XLABEL
					prop_default = SettingsText('VISIBLE', true, 'FONTSIZE', s(2), 'HALIGN', 'center', 'VALIGN', 'middle');
				case NNRegressorMLP_CrossValidationPF_Scatter.H_YLABEL
					prop_default = Format.getFormatDefault(Format.HANDLE, NNRegressorMLP_CrossValidationPF_Scatter.getPropSettings(prop));
				case NNRegressorMLP_CrossValidationPF_Scatter.ST_YLABEL
					prop_default = SettingsText('VISIBLE', true, 'FONTSIZE', s(2), 'HALIGN', 'center', 'VALIGN', 'middle', 'ROTATION', 90);
				case NNRegressorMLP_CrossValidationPF_Scatter.ELCLASS
					prop_default = 'NNRegressorMLP_CrossValidationPF_Scatter';
				case NNRegressorMLP_CrossValidationPF_Scatter.NAME
					prop_default = 'NNRegressorMLP_CrossValidationPF_Scatter';
				case NNRegressorMLP_CrossValidationPF_Scatter.DESCRIPTION
					prop_default = 'NNRegressorMLP_CrossValidationPF_Scatter manages the basic functionalities to plot of an ensemble-based comparison.';
				case NNRegressorMLP_CrossValidationPF_Scatter.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, NNRegressorMLP_CrossValidationPF_Scatter.getPropSettings(prop));
				case NNRegressorMLP_CrossValidationPF_Scatter.ID
					prop_default = 'NNRegressorMLP_CrossValidationPF_Scatter ID';
				case NNRegressorMLP_CrossValidationPF_Scatter.LABEL
					prop_default = 'NNRegressorMLP_CrossValidationPF_Scatter label';
				case NNRegressorMLP_CrossValidationPF_Scatter.NOTES
					prop_default = 'NNRegressorMLP_CrossValidationPF_Scatter notes';
				otherwise
					prop_default = getPropDefault@PanelFig(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = NNRegressorMLP_CrossValidationPF_Scatter.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = NNRegressorMLP_CrossValidationPF_Scatter.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(NNRegressorMLP_CrossValidationPF_Scatter, POINTER) returns the conditioned default value of POINTER of NNRegressorMLP_CrossValidationPF_Scatter.
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(NNRegressorMLP_CrossValidationPF_Scatter, POINTER) returns the conditioned default value of POINTER of NNRegressorMLP_CrossValidationPF_Scatter.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PF) and Element.GETPROPDEFAULTCONDITIONED('NNRegressorMLP_CrossValidationPF_Scatter')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = NNRegressorMLP_CrossValidationPF_Scatter.getPropProp(pointer);
			
			prop_default = NNRegressorMLP_CrossValidationPF_Scatter.conditioning(prop, NNRegressorMLP_CrossValidationPF_Scatter.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = PF.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = PF.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of PF.
			%  CHECK = Element.CHECKPROP(NNRegressorMLP_CrossValidationPF_Scatter, PROP, VALUE) checks VALUE format for PROP of NNRegressorMLP_CrossValidationPF_Scatter.
			%  CHECK = PF.CHECKPROP(NNRegressorMLP_CrossValidationPF_Scatter, PROP, VALUE) checks VALUE format for PROP of NNRegressorMLP_CrossValidationPF_Scatter.
			% 
			% PF.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:NNRegressorMLP_CrossValidationPF_Scatter:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PF.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PF.
			%   Error id: €BRAPH2.STR€:NNRegressorMLP_CrossValidationPF_Scatter:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(NNRegressorMLP_CrossValidationPF_Scatter, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNRegressorMLP_CrossValidationPF_Scatter.
			%   Error id: €BRAPH2.STR€:NNRegressorMLP_CrossValidationPF_Scatter:€BRAPH2.WRONG_INPUT€
			%  PF.CHECKPROP(NNRegressorMLP_CrossValidationPF_Scatter, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNRegressorMLP_CrossValidationPF_Scatter.
			%   Error id: €BRAPH2.STR€:NNRegressorMLP_CrossValidationPF_Scatter:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PF) and Element.CHECKPROP('NNRegressorMLP_CrossValidationPF_Scatter')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = NNRegressorMLP_CrossValidationPF_Scatter.getPropProp(pointer);
			
			switch prop
				case NNRegressorMLP_CrossValidationPF_Scatter.H_AXES % __NNRegressorMLP_CrossValidationPF_Scatter.H_AXES__
					check = Format.checkFormat(Format.HANDLE, value, NNRegressorMLP_CrossValidationPF_Scatter.getPropSettings(prop));
				case NNRegressorMLP_CrossValidationPF_Scatter.ST_AXIS % __NNRegressorMLP_CrossValidationPF_Scatter.ST_AXIS__
					check = Format.checkFormat(Format.ITEM, value, NNRegressorMLP_CrossValidationPF_Scatter.getPropSettings(prop));
				case NNRegressorMLP_CrossValidationPF_Scatter.LISTENER_ST_AXIS % __NNRegressorMLP_CrossValidationPF_Scatter.LISTENER_ST_AXIS__
					check = Format.checkFormat(Format.HANDLE, value, NNRegressorMLP_CrossValidationPF_Scatter.getPropSettings(prop));
				case NNRegressorMLP_CrossValidationPF_Scatter.NNCV % __NNRegressorMLP_CrossValidationPF_Scatter.NNCV__
					check = Format.checkFormat(Format.ITEM, value, NNRegressorMLP_CrossValidationPF_Scatter.getPropSettings(prop));
				case NNRegressorMLP_CrossValidationPF_Scatter.PREDICTIONS_VALUE % __NNRegressorMLP_CrossValidationPF_Scatter.PREDICTIONS_VALUE__
					check = Format.checkFormat(Format.MATRIX, value, NNRegressorMLP_CrossValidationPF_Scatter.getPropSettings(prop));
				case NNRegressorMLP_CrossValidationPF_Scatter.GROUNDTRUTH_VALUE % __NNRegressorMLP_CrossValidationPF_Scatter.GROUNDTRUTH_VALUE__
					check = Format.checkFormat(Format.MATRIX, value, NNRegressorMLP_CrossValidationPF_Scatter.getPropSettings(prop));
				case NNRegressorMLP_CrossValidationPF_Scatter.SETUP % __NNRegressorMLP_CrossValidationPF_Scatter.SETUP__
					check = Format.checkFormat(Format.EMPTY, value, NNRegressorMLP_CrossValidationPF_Scatter.getPropSettings(prop));
				case NNRegressorMLP_CrossValidationPF_Scatter.H_PREDICTIONS % __NNRegressorMLP_CrossValidationPF_Scatter.H_PREDICTIONS__
					check = Format.checkFormat(Format.HANDLELIST, value, NNRegressorMLP_CrossValidationPF_Scatter.getPropSettings(prop));
				case NNRegressorMLP_CrossValidationPF_Scatter.PREDICTIONS % __NNRegressorMLP_CrossValidationPF_Scatter.PREDICTIONS__
					check = Format.checkFormat(Format.LOGICAL, value, NNRegressorMLP_CrossValidationPF_Scatter.getPropSettings(prop));
				case NNRegressorMLP_CrossValidationPF_Scatter.PREDICTION_DICT % __NNRegressorMLP_CrossValidationPF_Scatter.PREDICTION_DICT__
					check = Format.checkFormat(Format.IDICT, value, NNRegressorMLP_CrossValidationPF_Scatter.getPropSettings(prop));
				case NNRegressorMLP_CrossValidationPF_Scatter.H_LINE_BASE % __NNRegressorMLP_CrossValidationPF_Scatter.H_LINE_BASE__
					check = Format.checkFormat(Format.HANDLE, value, NNRegressorMLP_CrossValidationPF_Scatter.getPropSettings(prop));
				case NNRegressorMLP_CrossValidationPF_Scatter.ST_LINE_BASE % __NNRegressorMLP_CrossValidationPF_Scatter.ST_LINE_BASE__
					check = Format.checkFormat(Format.ITEM, value, NNRegressorMLP_CrossValidationPF_Scatter.getPropSettings(prop));
				case NNRegressorMLP_CrossValidationPF_Scatter.LISTENER_ST_LINE_BASE % __NNRegressorMLP_CrossValidationPF_Scatter.LISTENER_ST_LINE_BASE__
					check = Format.checkFormat(Format.HANDLE, value, NNRegressorMLP_CrossValidationPF_Scatter.getPropSettings(prop));
				case NNRegressorMLP_CrossValidationPF_Scatter.H_TITLE % __NNRegressorMLP_CrossValidationPF_Scatter.H_TITLE__
					check = Format.checkFormat(Format.HANDLE, value, NNRegressorMLP_CrossValidationPF_Scatter.getPropSettings(prop));
				case NNRegressorMLP_CrossValidationPF_Scatter.ST_TITLE % __NNRegressorMLP_CrossValidationPF_Scatter.ST_TITLE__
					check = Format.checkFormat(Format.ITEM, value, NNRegressorMLP_CrossValidationPF_Scatter.getPropSettings(prop));
				case NNRegressorMLP_CrossValidationPF_Scatter.H_XLABEL % __NNRegressorMLP_CrossValidationPF_Scatter.H_XLABEL__
					check = Format.checkFormat(Format.HANDLE, value, NNRegressorMLP_CrossValidationPF_Scatter.getPropSettings(prop));
				case NNRegressorMLP_CrossValidationPF_Scatter.ST_XLABEL % __NNRegressorMLP_CrossValidationPF_Scatter.ST_XLABEL__
					check = Format.checkFormat(Format.ITEM, value, NNRegressorMLP_CrossValidationPF_Scatter.getPropSettings(prop));
				case NNRegressorMLP_CrossValidationPF_Scatter.H_YLABEL % __NNRegressorMLP_CrossValidationPF_Scatter.H_YLABEL__
					check = Format.checkFormat(Format.HANDLE, value, NNRegressorMLP_CrossValidationPF_Scatter.getPropSettings(prop));
				case NNRegressorMLP_CrossValidationPF_Scatter.ST_YLABEL % __NNRegressorMLP_CrossValidationPF_Scatter.ST_YLABEL__
					check = Format.checkFormat(Format.ITEM, value, NNRegressorMLP_CrossValidationPF_Scatter.getPropSettings(prop));
				case NNRegressorMLP_CrossValidationPF_Scatter.TEMPLATE % __NNRegressorMLP_CrossValidationPF_Scatter.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, NNRegressorMLP_CrossValidationPF_Scatter.getPropSettings(prop));
				otherwise
					if prop <= PanelFig.getPropNumber()
						check = checkProp@PanelFig(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNRegressorMLP_CrossValidationPF_Scatter:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNRegressorMLP_CrossValidationPF_Scatter:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' NNRegressorMLP_CrossValidationPF_Scatter.getPropTag(prop) ' (' NNRegressorMLP_CrossValidationPF_Scatter.getFormatTag(NNRegressorMLP_CrossValidationPF_Scatter.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % postset
		function postset(pf, prop)
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
				case NNRegressorMLP_CrossValidationPF_Scatter.ST_AXIS % __NNRegressorMLP_CrossValidationPF_Scatter.ST_AXIS__
					if pf.get('DRAWN')
					    toolbar = pf.get('H_TOOLBAR');
					    if check_graphics(toolbar, 'uitoolbar')
					        set(findobj(toolbar, 'Tag', 'TOOL.Grid'), 'State', pf.get('ST_AXIS').get('GRID'))
					        set(findobj(toolbar, 'Tag', 'TOOL.Axis'), 'State', pf.get('ST_AXIS').get('AXIS'))
					    end
					end
					
				case NNRegressorMLP_CrossValidationPF_Scatter.PREDICTIONS % __NNRegressorMLP_CrossValidationPF_Scatter.PREDICTIONS__
					if ~pf.get('PREDICTIONS') % false
					    h_predictions = pf.get('H_PREDICTIONS');
					    for i = 1:1:length(h_predictions)
					        set(h_predictions{i}, 'Visible', false)
					    end
					else % true
					    % triggers the update of SPH_DICT
					    pf.set('PREDICTION_DICT', pf.get('PREDICTION_DICT'))
					end
					
					% update state of toggle tool
					toolbar = pf.get('H_TOOLBAR');
					if check_graphics(toolbar, 'uitoolbar')
					    set(findobj(toolbar, 'Tag', 'TOOL.Predictions'), 'State', pf.get('PREDICTIONS'))
					end
					
					pf.get('SETUP');
					
				case NNRegressorMLP_CrossValidationPF_Scatter.PREDICTION_DICT % __NNRegressorMLP_CrossValidationPF_Scatter.PREDICTION_DICT__
					if pf.get('PREDICTIONS') && ~isa(pf.getr('NNCV'), 'NoValue')
					    predictions = pf.memorize('PREDICTIONS_VALUE');
					    ground_truth = pf.memorize('GROUNDTRUTH_VALUE');
					    targets = pf.memorize('NNCV').get('D_LIST_IT', 1).get('DP_DICT').get('IT', 1).get('TARGET_IDS');
					    
					    if pf.get('PREDICTION_DICT').get('LENGTH') == 0 && ~isempty(ground_truth)
					        for i = 1:1:length(targets)
					            target = targets{i};
					            prediction_st_lines{i} = SettingsLine( ...
					                'ID', target, ...
					                'X', ground_truth(:, i), ...
					                'Y', predictions(:, i), ...
					                'I', i, ...
					                'PANEL', pf, ...
					                'PROP', NNRegressorMLP_CrossValidationPF_Scatter.H_PREDICTIONS, ...
					                'LINESTYLE', 'none', ...
					                'VISIBLE', false ...
					                );
					        end
					        prediction_st_lines{1}.set('VISIBLE', true);
					        pf.get('PREDICTION_DICT').set('IT_LIST', prediction_st_lines)
					    end
					    for i = 1:1:length(targets)
					        pf.get('PREDICTION_DICT').get('IT', i).get('SETUP')
					    end
					end
					
				case NNRegressorMLP_CrossValidationPF_Scatter.ST_TITLE % __NNRegressorMLP_CrossValidationPF_Scatter.ST_TITLE__
					pf.get('SETUP');
					
				otherwise
					if prop <= PanelFig.getPropNumber()
						postset@PanelFig(pf, prop);
					end
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(pf, prop, varargin)
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
				case NNRegressorMLP_CrossValidationPF_Scatter.H_AXES % __NNRegressorMLP_CrossValidationPF_Scatter.H_AXES__
					h_axes = uiaxes( ...
					    'Parent', pf.memorize('H'), ...
					    'Tag', 'H_AXES', ...
					    'Units', 'normalized', ...
					    'OuterPosition', [.2 .2 .6 .6] ... % % % %TODO transform this into a prop?
					    );
					h_axes.Toolbar.Visible = 'off';
					h_axes.Interactions = [];
					box(h_axes, 'on')
					hold(h_axes, 'on')
					value = h_axes;
					
				case NNRegressorMLP_CrossValidationPF_Scatter.LISTENER_ST_AXIS % __NNRegressorMLP_CrossValidationPF_Scatter.LISTENER_ST_AXIS__
					value = listener(pf.get('ST_AXIS'), 'PropSet', @cb_listener_st_axis);
					
				case NNRegressorMLP_CrossValidationPF_Scatter.SETUP % __NNRegressorMLP_CrossValidationPF_Scatter.SETUP__
					pf.memorize('H_PREDICTIONS');
					
					nncv = pf.get('NNCV');
					if isa(pf.getr('PREDICTIONS_VALUE'), 'NoValue') && ~isa(pf.getr('NNCV'), 'NoValue')
					    predictions = cellfun(@(nn, nne) cell2mat(nn.get('PREDICT', nne.get('D'))), nncv.get('NN_LIST'), nncv.get('EVALUATOR_LIST'), 'UniformOutput', false);
					    predictions = cell2mat(predictions);
					    pf.set('PREDICTIONS_VALUE', predictions);
					end
					
					if isa(pf.getr('GROUNDTRUTH_VALUE'), 'NoValue') && ~isa(pf.getr('NNCV'), 'NoValue')
					    ground_truth = cellfun(@(nne) nne.get('GROUND_TRUTH'), nncv.get('EVALUATOR_LIST'), 'UniformOutput', false);
					    ground_truth = cell2mat(ground_truth);
					    pf.set('GROUNDTRUTH_VALUE', ground_truth);
					end
					
					predictions = pf.get('PREDICTIONS_VALUE');
					ground_truth = pf.get('GROUNDTRUTH_VALUE');
					
					pf.memorize('PREDICTION_DICT');
					
					if pf.get('PREDICTIONS')
					    pred_st_list = pf.get('PREDICTION_DICT').get('IT_LIST');
					    visible_status = find(cell2mat(cellfun(@(pred_st_line) pred_st_line.get('VISIBLE') , pred_st_list,'UniformOutput', false)) == 1);
					    if any(visible_status)
					        baseline_X = pred_st_list{visible_status(1)}.get('X');
					        baseline_Y = pred_st_list{visible_status(1)}.get('X');
					    else
					        baseline_X = [0];
					        baseline_Y = [0];
					    end
					    pf.memorize('ST_LINE_BASE').set('X', [min(baseline_X) max(baseline_X)], ...
					        'Y', [min(baseline_Y) max(baseline_Y)], ...
					        'SYMBOL', 'none', ...
					        'LINECOLOR', [0.8 0.8 0.8])
					end
					
					xlim = pf.get('H_AXES').get('XLim');
					ylim = pf.get('H_AXES').get('YLim');
					plot_title = nncv.get('LABEL');
					pf.get('ST_TITLE').set( ...
					    'TXT', plot_title, ...
					    'X', .5 * (xlim(2) + xlim(1)), ...
					    'Y', ylim(2) + .07 * (ylim(2) - ylim(1)), ...
					    'Z', 0 ...
					    )
					pf.get('ST_XLABEL').set( ...
					    'TXT', 'Ground Truth', ...
					    'X', .5 * (xlim(2) + xlim(1)), ...
					    'Y', ylim(1) - .07 * (ylim(2) - ylim(1)), ...
					    'Z', 0 ...
					    )
					pf.get('ST_YLABEL').set( ...
						'TXT', 'Prediction', ...
					    'X', xlim(1) - .14 * (xlim(2) - xlim(1)), ...
					    'Y', .5 * (ylim(2) + ylim(1)), ...
					    'Z', 0 ...
					    )
					
					value = [];
					
				case NNRegressorMLP_CrossValidationPF_Scatter.H_PREDICTIONS % __NNRegressorMLP_CrossValidationPF_Scatter.H_PREDICTIONS__
					targets = pf.memorize('NNCV').get('D_LIST_IT', 1).get('DP_DICT').get('IT', 1).get('TARGET_IDS');
					L = length(targets);
					h_predictions = cell(1, L);
					for i = 1:1:L
					    h_predictions{i} = plot(pf.get('H_AXES'), [0], [0], 'x');
					end
					value = h_predictions;
					
				case NNRegressorMLP_CrossValidationPF_Scatter.H_LINE_BASE % __NNRegressorMLP_CrossValidationPF_Scatter.H_LINE_BASE__
					value = plot(pf.get('H_AXES'), [0], [0], 'b', 'LineWidth', 2);
					
				case NNRegressorMLP_CrossValidationPF_Scatter.LISTENER_ST_LINE_BASE % __NNRegressorMLP_CrossValidationPF_Scatter.LISTENER_ST_LINE_BASE__
					value = listener(pf.get('ST_LINE_BASE'), 'PropSet', @cb_listener_st_line_base);
					
				case NNRegressorMLP_CrossValidationPF_Scatter.H_TITLE % __NNRegressorMLP_CrossValidationPF_Scatter.H_TITLE__
					value = title(pf.get('H_AXES'), '');
					
					if isa(pf.getr('ST_TITLE'), 'NoValue')
					    st = pf.memorize('ST_TITLE');
					    
					    position = get(value, 'Position');
					    st.set( ...
					        'TXT', pf.get('NNCV').get('LABEL'), ...
					        'X', position(1), ...
					        'Y', position(2), ...
					        'Z', position(3) ...
					        )
					end
					
				case NNRegressorMLP_CrossValidationPF_Scatter.H_XLABEL % __NNRegressorMLP_CrossValidationPF_Scatter.H_XLABEL__
					value = xlabel(pf.get('H_AXES'), '');
					
					if isa(pf.getr('ST_XLABEL'), 'NoValue')
					    st = pf.memorize('ST_XLABEL');
					    
					    position = get(value, 'Position');
					    st.set( ...
					        'TXT', 'Layer', ...
					        'X', position(1), ...
					        'Y', position(2), ...
					        'Z', position(3) ...
					        )
					end
					
				case NNRegressorMLP_CrossValidationPF_Scatter.H_YLABEL % __NNRegressorMLP_CrossValidationPF_Scatter.H_YLABEL__
					value = ylabel(pf.get('H_AXES'), '');
					
					if isa(pf.getr('ST_YLABEL'), 'NoValue')
					    st = pf.memorize('ST_YLABEL');
					    
					    position = get(value, 'Position');
					    st.set( ...
					        'TXT', 'Difference', ...
					        'X', position(1), ...
					        'Y', position(2), ...
					        'Z', position(3) ...
					        )
					end
					
				case NNRegressorMLP_CrossValidationPF_Scatter.DRAW % __NNRegressorMLP_CrossValidationPF_Scatter.DRAW__
					value = calculateValue@PanelFig(pf, PanelFig.DRAW, varargin{:}); % also warning
					if value
					    pf.memorize('H_AXES')
					    
					    pf.memorize('ST_AXIS').set('PANEL', pf, 'PROP', NNRegressorMLP_CrossValidationPF_Scatter.H_AXES).get('SETUP')
					    pf.memorize('LISTENER_ST_AXIS');
					    
					    pf.memorize('H_PREDICTIONS')
					    
					    pf.memorize('H_LINE_BASE')
					    pf.memorize('ST_LINE_BASE').set('PANEL', pf, 'PROP', NNRegressorMLP_CrossValidationPF_Scatter.H_LINE_BASE).get('SETUP')
						pf.memorize('LISTENER_ST_LINE_BASE');
					
					    pf.memorize('H_TITLE')
					    pf.memorize('ST_TITLE').set('PANEL', pf, 'PROP', NNRegressorMLP_CrossValidationPF_Scatter.H_TITLE).get('SETUP')
					
					    pf.memorize('H_XLABEL')
					    pf.memorize('ST_XLABEL').set('PANEL', pf, 'PROP', NNRegressorMLP_CrossValidationPF_Scatter.H_XLABEL).get('SETUP')
					    
					    pf.memorize('H_YLABEL')
					    pf.memorize('ST_YLABEL').set('PANEL', pf, 'PROP', NNRegressorMLP_CrossValidationPF_Scatter.H_YLABEL).get('SETUP')
					
					    pf.get('SETUP')
					end
					
				case NNRegressorMLP_CrossValidationPF_Scatter.DELETE % __NNRegressorMLP_CrossValidationPF_Scatter.DELETE__
					value = calculateValue@PanelFig(pf, PanelFig.DELETE, varargin{:}); % also warning
					if value
					    pf.set('H_AXES', Element.getNoValue())
					
					    pf.set('LISTENER_ST_AXIS', Element.getNoValue())
					 
					    pf.set('H_PREDICTIONS', Element.getNoValue())
					
					    pf.set('H_LINE_BASE', Element.getNoValue())
					    pf.set('LISTENER_ST_LINE_BASE', Element.getNoValue())
					
					    pf.set('H_TITLE', Element.getNoValue())
					
					    pf.set('H_XLABEL', Element.getNoValue())
					    
					    pf.set('H_YLABEL', Element.getNoValue())
					end
					
				case NNRegressorMLP_CrossValidationPF_Scatter.H_TOOLS % __NNRegressorMLP_CrossValidationPF_Scatter.H_TOOLS__
					toolbar = pf.memorize('H_TOOLBAR');
					if check_graphics(toolbar, 'uitoolbar')
					    value = calculateValue@PanelFig(pf, PanelFig.H_TOOLS);
					    
					    tool_separator_1 = uipushtool(toolbar, 'Separator', 'on', 'Visible', 'off');
					
					    % Axis
					    tool_axis = uitoggletool(toolbar, ...
					        'Tag', 'TOOL.Axis', ...
					        'Separator', 'on', ...
					        'State', pf.get('ST_AXIS').get('AXIS'), ...
					        'Tooltip', 'Show axis', ...
					        'CData', imread('icon_axis.png'), ...
					        'OnCallback', {@cb_axis, true}, ...
					        'OffCallback', {@cb_axis, false});
					
					    % Grid
					    tool_grid = uitoggletool(toolbar, ...
					        'Tag', 'TOOL.Grid', ...
					        'State', pf.get('ST_AXIS').get('GRID'), ...
					        'Tooltip', 'Show grid', ...
					        'CData', imread('icon_grid.png'), ...
					        'OnCallback', {@cb_grid, true}, ...
					        'OffCallback', {@cb_grid, false});
					
					    tool_separator_2 = uipushtool(toolbar, 'Separator', 'on', 'Visible', 'off');
					    
					    % Prediction Line
					    tool_predictions = uitoggletool(toolbar, ...
					        'Tag', 'TOOL.Predictions', ...
					        'State', pf.get('PREDICTIONS'), ...
					        'Tooltip', 'Show Prediction plots', ...
					        'CData', imresize(imread('icon_line.png'), [24 24]), ... % % % make icon 16x16
					        'OnCallback', {@cb_predictions, true}, ...
					        'OffCallback', {@cb_predictions, false});
					
					    % Base Line
					    tool_line_base = uitoggletool(toolbar, ...
					        'Tag', 'TOOL.Line_CI', ...
					        'State', pf.get('ST_LINE_BASE').get('VISIBLE'), ...
					        'Tooltip', 'Show base line (slope = 1)', ...
					        'CData', imresize(imread('icon_line.png'), [24 24]), ... % % % imread('icon_lines_two.png'), ...
					        'OnCallback', {@cb_line_base, true}, ...
					        'OffCallback', {@cb_line_base, false});
					
					    value = {value{:}, ...
					        tool_separator_1, ...
					        tool_axis, tool_grid, ... 
					        tool_separator_2, ... 
					        tool_predictions, tool_line_base ...
					        };
					else
					    value = {};
					end
					
				otherwise
					if prop <= PanelFig.getPropNumber()
						value = calculateValue@PanelFig(pf, prop, varargin{:});
					else
						value = calculateValue@Element(pf, prop, varargin{:});
					end
			end
			
			function cb_listener_st_axis(~, ~)
			    if pf.get('DRAWN')
			        toolbar = pf.get('H_TOOLBAR');
			        if check_graphics(toolbar, 'uitoolbar')
			            set(findobj(toolbar, 'Tag', 'TOOL.Grid'), 'State', pf.get('ST_AXIS').get('GRID'))
			            set(findobj(toolbar, 'Tag', 'TOOL.Axis'), 'State', pf.get('ST_AXIS').get('AXIS'))
			        end
			    end
			end
			function cb_listener_st_line_base(~, ~)
			    if pf.get('DRAWN')
			        toolbar = pf.get('H_TOOLBAR');
			        if check_graphics(toolbar, 'uitoolbar')
			            set(findobj(toolbar, 'Tag', 'TOOL.Line_Base'), 'State', pf.get('ST_LINE_BASE').get('VISIBLE'))
			        end
			    end
			end
			function cb_axis(~, ~, axis) % (src, event)
			    pf.get('ST_AXIS').set('AXIS', axis);
			    
			    % triggers the update of ST_AXIS
			    pf.set('ST_AXIS', pf.get('ST_AXIS'))
			end
			function cb_grid(~, ~, grid) % (src, event)
			    pf.get('ST_AXIS').set('GRID', grid);
			
			    % triggers the update of ST_AXIS
			    pf.set('ST_AXIS', pf.get('ST_AXIS'))
			end
			function cb_predictions(~, ~, visible) % (src, event)
				pf.set('PREDICTIONS', visible)
			end
			function cb_line_base(~, ~, visible) % (src, event)
				pf.get('ST_LINE_BASE').set('VISIBLE', visible)
			
			    % triggers the update of ST_LINE_DIFF
			    pf.set('ST_LINE_BASE', pf.get('ST_LINE_BASE'))
			end
		end
	end
	methods % GUI
		function pr = getPanelProp(pf, prop, varargin)
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
				case NNRegressorMLP_CrossValidationPF_Scatter.ST_AXIS % __NNRegressorMLP_CrossValidationPF_Scatter.ST_AXIS__
					pr = SettingsAxisPP('EL', pf, 'PROP', NNRegressorMLP_CrossValidationPF_Scatter.ST_AXIS, varargin{:});
					
				case NNRegressorMLP_CrossValidationPF_Scatter.PREDICTION_DICT % __NNRegressorMLP_CrossValidationPF_Scatter.PREDICTION_DICT__
					SETUP = pf.getPropProp('SETUP');
					EL = PanelPropIDictTable.getPropProp('EL');
					pr = PanelPropIDictTable('EL', pf, 'PROP', NNRegressorMLP_CrossValidationPF_Scatter.PREDICTION_DICT, ...
					    'CB_TAB_EDIT', ['cb_table_edit_default(); pr.get(' num2str(EL) ').get(' num2str(SETUP) ')'], ...
					    'TABLE_HEIGHT', s(40), ...
					    'COLS', [PanelPropIDictTable.SELECTOR SettingsLine.VISIBLE SettingsLine.SYMBOL SettingsLine.SYMBOLSIZE SettingsLine.EDGECOLOR SettingsLine.FACECOLOR], ...
					    varargin{:});
					
				case NNRegressorMLP_CrossValidationPF_Scatter.ST_LINE_BASE % __NNRegressorMLP_CrossValidationPF_Scatter.ST_LINE_BASE__
					pr = SettingsLinePP('EL', pf, 'PROP', NNRegressorMLP_CrossValidationPF_Scatter.ST_LINE_BASE, varargin{:});
					
				case NNRegressorMLP_CrossValidationPF_Scatter.ST_TITLE % __NNRegressorMLP_CrossValidationPF_Scatter.ST_TITLE__
					pr = SettingsTextPP('EL', pf, 'PROP', NNRegressorMLP_CrossValidationPF_Scatter.ST_TITLE, varargin{:});
					
				case NNRegressorMLP_CrossValidationPF_Scatter.ST_XLABEL % __NNRegressorMLP_CrossValidationPF_Scatter.ST_XLABEL__
					pr = SettingsTextPP('EL', pf, 'PROP', NNRegressorMLP_CrossValidationPF_Scatter.ST_XLABEL, varargin{:});
					
				case NNRegressorMLP_CrossValidationPF_Scatter.ST_YLABEL % __NNRegressorMLP_CrossValidationPF_Scatter.ST_YLABEL__
					pr = SettingsTextPP('EL', pf, 'PROP', NNRegressorMLP_CrossValidationPF_Scatter.ST_YLABEL, varargin{:});
					
				otherwise
					pr = getPanelProp@PanelFig(pf, prop, varargin{:});
					
			end
		end
	end
end
