classdef NNFeatureImportanceBrainSurfacePP_FI_Graph < PanelProp
	%NNFeatureImportanceBrainSurfacePP_FI_Graph plots the panel to manage the feature importance of a neural network analysis with the graph.
	% It is a subclass of <a href="matlab:help PanelProp">PanelProp</a>.
	%
	% A panel for feature importance of a neural network analysis with the graph (NNFeatureImportanceBrainSurfacePP_FI_Graph) 
	%  plots the panel to show the feature importance, mathcing the layer number and node number of the graph.
	% It is supposed to be used with the property FEATURE_IMPORTANCE of 
	%  NNClassifierMLP_Evaluator, NNClassifierMLP_CrossValidation, NNRegressorMLP_Evaluator,
	%  and NNRegressorMLP_CrossValidation.
	%
	% NNFeatureImportanceBrainSurfacePP_FI_Graph methods (constructor):
	%  NNFeatureImportanceBrainSurfacePP_FI_Graph - constructor
	%
	% NNFeatureImportanceBrainSurfacePP_FI_Graph methods:
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
	% NNFeatureImportanceBrainSurfacePP_FI_Graph methods (display):
	%  tostring - string with information about the panel property feature importance
	%  disp - displays information about the panel property feature importance
	%  tree - displays the tree of the panel property feature importance
	%
	% NNFeatureImportanceBrainSurfacePP_FI_Graph methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two panel property feature importance are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the panel property feature importance
	%
	% NNFeatureImportanceBrainSurfacePP_FI_Graph methods (save/load, Static):
	%  save - saves BRAPH2 panel property feature importance as b2 file
	%  load - loads a BRAPH2 panel property feature importance from a b2 file
	%
	% NNFeatureImportanceBrainSurfacePP_FI_Graph method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the panel property feature importance
	%
	% NNFeatureImportanceBrainSurfacePP_FI_Graph method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the panel property feature importance
	%
	% NNFeatureImportanceBrainSurfacePP_FI_Graph methods (inspection, Static):
	%  getClass - returns the class of the panel property feature importance
	%  getSubclasses - returns all subclasses of NNFeatureImportanceBrainSurfacePP_FI_Graph
	%  getProps - returns the property list of the panel property feature importance
	%  getPropNumber - returns the property number of the panel property feature importance
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
	% NNFeatureImportanceBrainSurfacePP_FI_Graph methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% NNFeatureImportanceBrainSurfacePP_FI_Graph methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% NNFeatureImportanceBrainSurfacePP_FI_Graph methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% NNFeatureImportanceBrainSurfacePP_FI_Graph methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?NNFeatureImportanceBrainSurfacePP_FI_Graph; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">NNFeatureImportanceBrainSurfacePP_FI_Graph constants</a>.
	%
	%
	% See also NNClassifierMLP_Evaluator, NNClassifierMLP_CrossValidation, NNRegressorMLP_Evaluator, NNRegressorMLP_CrossValidation..
	
	properties (Constant) % properties
		D = PanelProp.getPropNumber() + 1;
		D_TAG = 'D';
		D_CATEGORY = Category.METADATA;
		D_FORMAT = Format.ITEM;
		
		XSLIDERSHOW = PanelProp.getPropNumber() + 2;
		XSLIDERSHOW_TAG = 'XSLIDERSHOW';
		XSLIDERSHOW_CATEGORY = Category.GUI;
		XSLIDERSHOW_FORMAT = Format.LOGICAL;
		
		XSLIDERLABELS = PanelProp.getPropNumber() + 3;
		XSLIDERLABELS_TAG = 'XSLIDERLABELS';
		XSLIDERLABELS_CATEGORY = Category.GUI;
		XSLIDERLABELS_FORMAT = Format.STRINGLIST;
		
		XSLIDERHEIGHT = PanelProp.getPropNumber() + 4;
		XSLIDERHEIGHT_TAG = 'XSLIDERHEIGHT';
		XSLIDERHEIGHT_CATEGORY = Category.GUI;
		XSLIDERHEIGHT_FORMAT = Format.SIZE;
		
		XSLIDER = PanelProp.getPropNumber() + 5;
		XSLIDER_TAG = 'XSLIDER';
		XSLIDER_CATEGORY = Category.EVANESCENT;
		XSLIDER_FORMAT = Format.HANDLE;
		
		YSLIDERSHOW = PanelProp.getPropNumber() + 6;
		YSLIDERSHOW_TAG = 'YSLIDERSHOW';
		YSLIDERSHOW_CATEGORY = Category.GUI;
		YSLIDERSHOW_FORMAT = Format.LOGICAL;
		
		YSLIDERLABELS = PanelProp.getPropNumber() + 7;
		YSLIDERLABELS_TAG = 'YSLIDERLABELS';
		YSLIDERLABELS_CATEGORY = Category.GUI;
		YSLIDERLABELS_FORMAT = Format.STRINGLIST;
		
		YSLIDERWIDTH = PanelProp.getPropNumber() + 8;
		YSLIDERWIDTH_TAG = 'YSLIDERWIDTH';
		YSLIDERWIDTH_CATEGORY = Category.GUI;
		YSLIDERWIDTH_FORMAT = Format.SIZE;
		
		YSLIDER = PanelProp.getPropNumber() + 9;
		YSLIDER_TAG = 'YSLIDER';
		YSLIDER_CATEGORY = Category.EVANESCENT;
		YSLIDER_FORMAT = Format.HANDLE;
		
		XYSLIDERLOCK = PanelProp.getPropNumber() + 10;
		XYSLIDERLOCK_TAG = 'XYSLIDERLOCK';
		XYSLIDERLOCK_CATEGORY = Category.GUI;
		XYSLIDERLOCK_FORMAT = Format.LOGICAL;
		
		ENABLE = PanelProp.getPropNumber() + 11;
		ENABLE_TAG = 'ENABLE';
		ENABLE_CATEGORY = Category.GUI;
		ENABLE_FORMAT = Format.OPTION;
		
		ROWNAME = PanelProp.getPropNumber() + 12;
		ROWNAME_TAG = 'ROWNAME';
		ROWNAME_CATEGORY = Category.GUI;
		ROWNAME_FORMAT = Format.STRINGLIST;
		
		COLUMNNAME = PanelProp.getPropNumber() + 13;
		COLUMNNAME_TAG = 'COLUMNNAME';
		COLUMNNAME_CATEGORY = Category.GUI;
		COLUMNNAME_FORMAT = Format.STRINGLIST;
		
		MENU_EXPORT = PanelProp.getPropNumber() + 14;
		MENU_EXPORT_TAG = 'MENU_EXPORT';
		MENU_EXPORT_CATEGORY = Category.GUI;
		MENU_EXPORT_FORMAT = Format.LOGICAL;
		
		TABLE_HEIGHT = PanelProp.getPropNumber() + 15;
		TABLE_HEIGHT_TAG = 'TABLE_HEIGHT';
		TABLE_HEIGHT_CATEGORY = Category.GUI;
		TABLE_HEIGHT_FORMAT = Format.SIZE;
		
		TABLE = PanelProp.getPropNumber() + 16;
		TABLE_TAG = 'TABLE';
		TABLE_CATEGORY = Category.EVANESCENT;
		TABLE_FORMAT = Format.HANDLE;
		
		CONTEXTMENU = PanelProp.getPropNumber() + 17;
		CONTEXTMENU_TAG = 'CONTEXTMENU';
		CONTEXTMENU_CATEGORY = Category.EVANESCENT;
		CONTEXTMENU_FORMAT = Format.HANDLE;
		
		MAP_TO_CELL = PanelProp.getPropNumber() + 18;
		MAP_TO_CELL_TAG = 'MAP_TO_CELL';
		MAP_TO_CELL_CATEGORY = Category.QUERY;
		MAP_TO_CELL_FORMAT = Format.EMPTY;
	end
	methods % constructor
		function pr = NNFeatureImportanceBrainSurfacePP_FI_Graph(varargin)
			%NNFeatureImportanceBrainSurfacePP_FI_Graph() creates a panel property feature importance.
			%
			% NNFeatureImportanceBrainSurfacePP_FI_Graph(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% NNFeatureImportanceBrainSurfacePP_FI_Graph(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			pr = pr@PanelProp(varargin{:});
		end
	end
	methods (Static) % inspection
		function pr_class = getClass()
			%GETCLASS returns the class of the panel property feature importance.
			%
			% CLASS = NNFeatureImportanceBrainSurfacePP_FI_Graph.GETCLASS() returns the class 'NNFeatureImportanceBrainSurfacePP_FI_Graph'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the panel property feature importance PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('NNFeatureImportanceBrainSurfacePP_FI_Graph') returns 'NNFeatureImportanceBrainSurfacePP_FI_Graph'.
			%
			% Note that the Element.GETCLASS(PR) and Element.GETCLASS('NNFeatureImportanceBrainSurfacePP_FI_Graph')
			%  are less computationally efficient.
			
			pr_class = 'NNFeatureImportanceBrainSurfacePP_FI_Graph';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the panel property feature importance.
			%
			% LIST = NNFeatureImportanceBrainSurfacePP_FI_Graph.GETSUBCLASSES() returns all subclasses of 'NNFeatureImportanceBrainSurfacePP_FI_Graph'.
			%
			% Alternative forms to call this method are:
			%  LIST = PR.GETSUBCLASSES() returns all subclasses of the panel property feature importance PR.
			%  LIST = Element.GETSUBCLASSES(PR) returns all subclasses of 'PR'.
			%  LIST = Element.GETSUBCLASSES('NNFeatureImportanceBrainSurfacePP_FI_Graph') returns all subclasses of 'NNFeatureImportanceBrainSurfacePP_FI_Graph'.
			%
			% Note that the Element.GETSUBCLASSES(PR) and Element.GETSUBCLASSES('NNFeatureImportanceBrainSurfacePP_FI_Graph')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('NNFeatureImportanceBrainSurfacePP_FI_Graph', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of panel property feature importance.
			%
			% PROPS = NNFeatureImportanceBrainSurfacePP_FI_Graph.GETPROPS() returns the property list of panel property feature importance
			%  as a row vector.
			%
			% PROPS = NNFeatureImportanceBrainSurfacePP_FI_Graph.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the panel property feature importance PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('NNFeatureImportanceBrainSurfacePP_FI_Graph'[, CATEGORY]) returns the property list of 'NNFeatureImportanceBrainSurfacePP_FI_Graph'.
			%
			% Note that the Element.GETPROPS(PR) and Element.GETPROPS('NNFeatureImportanceBrainSurfacePP_FI_Graph')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					PanelProp.getProps() ...
						NNFeatureImportanceBrainSurfacePP_FI_Graph.D ...
						NNFeatureImportanceBrainSurfacePP_FI_Graph.XSLIDERSHOW ...
						NNFeatureImportanceBrainSurfacePP_FI_Graph.XSLIDERLABELS ...
						NNFeatureImportanceBrainSurfacePP_FI_Graph.XSLIDERHEIGHT ...
						NNFeatureImportanceBrainSurfacePP_FI_Graph.XSLIDER ...
						NNFeatureImportanceBrainSurfacePP_FI_Graph.YSLIDERSHOW ...
						NNFeatureImportanceBrainSurfacePP_FI_Graph.YSLIDERLABELS ...
						NNFeatureImportanceBrainSurfacePP_FI_Graph.YSLIDERWIDTH ...
						NNFeatureImportanceBrainSurfacePP_FI_Graph.YSLIDER ...
						NNFeatureImportanceBrainSurfacePP_FI_Graph.XYSLIDERLOCK ...
						NNFeatureImportanceBrainSurfacePP_FI_Graph.ENABLE ...
						NNFeatureImportanceBrainSurfacePP_FI_Graph.ROWNAME ...
						NNFeatureImportanceBrainSurfacePP_FI_Graph.COLUMNNAME ...
						NNFeatureImportanceBrainSurfacePP_FI_Graph.MENU_EXPORT ...
						NNFeatureImportanceBrainSurfacePP_FI_Graph.TABLE_HEIGHT ...
						NNFeatureImportanceBrainSurfacePP_FI_Graph.TABLE ...
						NNFeatureImportanceBrainSurfacePP_FI_Graph.CONTEXTMENU ...
						NNFeatureImportanceBrainSurfacePP_FI_Graph.MAP_TO_CELL ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						PanelProp.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						PanelProp.getProps(Category.METADATA) ...
						NNFeatureImportanceBrainSurfacePP_FI_Graph.D ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						PanelProp.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						PanelProp.getProps(Category.DATA) ...
						];
				case Category.RESULT
					prop_list = [
						PanelProp.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						PanelProp.getProps(Category.QUERY) ...
						NNFeatureImportanceBrainSurfacePP_FI_Graph.MAP_TO_CELL ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						PanelProp.getProps(Category.EVANESCENT) ...
						NNFeatureImportanceBrainSurfacePP_FI_Graph.XSLIDER ...
						NNFeatureImportanceBrainSurfacePP_FI_Graph.YSLIDER ...
						NNFeatureImportanceBrainSurfacePP_FI_Graph.TABLE ...
						NNFeatureImportanceBrainSurfacePP_FI_Graph.CONTEXTMENU ...
						];
				case Category.FIGURE
					prop_list = [ ...
						PanelProp.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						PanelProp.getProps(Category.GUI) ...
						NNFeatureImportanceBrainSurfacePP_FI_Graph.XSLIDERSHOW ...
						NNFeatureImportanceBrainSurfacePP_FI_Graph.XSLIDERLABELS ...
						NNFeatureImportanceBrainSurfacePP_FI_Graph.XSLIDERHEIGHT ...
						NNFeatureImportanceBrainSurfacePP_FI_Graph.YSLIDERSHOW ...
						NNFeatureImportanceBrainSurfacePP_FI_Graph.YSLIDERLABELS ...
						NNFeatureImportanceBrainSurfacePP_FI_Graph.YSLIDERWIDTH ...
						NNFeatureImportanceBrainSurfacePP_FI_Graph.XYSLIDERLOCK ...
						NNFeatureImportanceBrainSurfacePP_FI_Graph.ENABLE ...
						NNFeatureImportanceBrainSurfacePP_FI_Graph.ROWNAME ...
						NNFeatureImportanceBrainSurfacePP_FI_Graph.COLUMNNAME ...
						NNFeatureImportanceBrainSurfacePP_FI_Graph.MENU_EXPORT ...
						NNFeatureImportanceBrainSurfacePP_FI_Graph.TABLE_HEIGHT ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of panel property feature importance.
			%
			% N = NNFeatureImportanceBrainSurfacePP_FI_Graph.GETPROPNUMBER() returns the property number of panel property feature importance.
			%
			% N = NNFeatureImportanceBrainSurfacePP_FI_Graph.GETPROPNUMBER(CATEGORY) returns the property number of panel property feature importance
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER([CATEGORY]) returns the property number of the panel property feature importance PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('NNFeatureImportanceBrainSurfacePP_FI_Graph') returns the property number of 'NNFeatureImportanceBrainSurfacePP_FI_Graph'.
			%
			% Note that the Element.GETPROPNUMBER(PR) and Element.GETPROPNUMBER('NNFeatureImportanceBrainSurfacePP_FI_Graph')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(NNFeatureImportanceBrainSurfacePP_FI_Graph.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in panel property feature importance/error.
			%
			% CHECK = NNFeatureImportanceBrainSurfacePP_FI_Graph.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(NNFeatureImportanceBrainSurfacePP_FI_Graph, PROP) checks whether PROP exists for NNFeatureImportanceBrainSurfacePP_FI_Graph.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:NNFeatureImportanceBrainSurfacePP_FI_Graph:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:NNFeatureImportanceBrainSurfacePP_FI_Graph:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:NNFeatureImportanceBrainSurfacePP_FI_Graph:WrongInput]
			%  Element.EXISTSPROP(NNFeatureImportanceBrainSurfacePP_FI_Graph, PROP) throws error if PROP does NOT exist for NNFeatureImportanceBrainSurfacePP_FI_Graph.
			%   Error id: [BRAPH2:NNFeatureImportanceBrainSurfacePP_FI_Graph:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PR) and Element.EXISTSPROP('NNFeatureImportanceBrainSurfacePP_FI_Graph')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == NNFeatureImportanceBrainSurfacePP_FI_Graph.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNFeatureImportanceBrainSurfacePP_FI_Graph:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNFeatureImportanceBrainSurfacePP_FI_Graph:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for NNFeatureImportanceBrainSurfacePP_FI_Graph.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in panel property feature importance/error.
			%
			% CHECK = NNFeatureImportanceBrainSurfacePP_FI_Graph.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(NNFeatureImportanceBrainSurfacePP_FI_Graph, TAG) checks whether TAG exists for NNFeatureImportanceBrainSurfacePP_FI_Graph.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:NNFeatureImportanceBrainSurfacePP_FI_Graph:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:NNFeatureImportanceBrainSurfacePP_FI_Graph:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:NNFeatureImportanceBrainSurfacePP_FI_Graph:WrongInput]
			%  Element.EXISTSTAG(NNFeatureImportanceBrainSurfacePP_FI_Graph, TAG) throws error if TAG does NOT exist for NNFeatureImportanceBrainSurfacePP_FI_Graph.
			%   Error id: [BRAPH2:NNFeatureImportanceBrainSurfacePP_FI_Graph:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PR) and Element.EXISTSTAG('NNFeatureImportanceBrainSurfacePP_FI_Graph')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			nnfeatureimportancebrainsurfacepp_fi_graph_tag_list = cellfun(@(x) NNFeatureImportanceBrainSurfacePP_FI_Graph.getPropTag(x), num2cell(NNFeatureImportanceBrainSurfacePP_FI_Graph.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, nnfeatureimportancebrainsurfacepp_fi_graph_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNFeatureImportanceBrainSurfacePP_FI_Graph:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNFeatureImportanceBrainSurfacePP_FI_Graph:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for NNFeatureImportanceBrainSurfacePP_FI_Graph.'] ...
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
			%  PROPERTY = PR.GETPROPPROP(POINTER) returns property number of POINTER of PR.
			%  PROPERTY = Element.GETPROPPROP(NNFeatureImportanceBrainSurfacePP_FI_Graph, POINTER) returns property number of POINTER of NNFeatureImportanceBrainSurfacePP_FI_Graph.
			%  PROPERTY = PR.GETPROPPROP(NNFeatureImportanceBrainSurfacePP_FI_Graph, POINTER) returns property number of POINTER of NNFeatureImportanceBrainSurfacePP_FI_Graph.
			%
			% Note that the Element.GETPROPPROP(PR) and Element.GETPROPPROP('NNFeatureImportanceBrainSurfacePP_FI_Graph')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				nnfeatureimportancebrainsurfacepp_fi_graph_tag_list = cellfun(@(x) NNFeatureImportanceBrainSurfacePP_FI_Graph.getPropTag(x), num2cell(NNFeatureImportanceBrainSurfacePP_FI_Graph.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, nnfeatureimportancebrainsurfacepp_fi_graph_tag_list)); % tag = pointer
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
			%  TAG = PR.GETPROPTAG(POINTER) returns tag of POINTER of PR.
			%  TAG = Element.GETPROPTAG(NNFeatureImportanceBrainSurfacePP_FI_Graph, POINTER) returns tag of POINTER of NNFeatureImportanceBrainSurfacePP_FI_Graph.
			%  TAG = PR.GETPROPTAG(NNFeatureImportanceBrainSurfacePP_FI_Graph, POINTER) returns tag of POINTER of NNFeatureImportanceBrainSurfacePP_FI_Graph.
			%
			% Note that the Element.GETPROPTAG(PR) and Element.GETPROPTAG('NNFeatureImportanceBrainSurfacePP_FI_Graph')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case NNFeatureImportanceBrainSurfacePP_FI_Graph.D
						tag = NNFeatureImportanceBrainSurfacePP_FI_Graph.D_TAG;
					case NNFeatureImportanceBrainSurfacePP_FI_Graph.XSLIDERSHOW
						tag = NNFeatureImportanceBrainSurfacePP_FI_Graph.XSLIDERSHOW_TAG;
					case NNFeatureImportanceBrainSurfacePP_FI_Graph.XSLIDERLABELS
						tag = NNFeatureImportanceBrainSurfacePP_FI_Graph.XSLIDERLABELS_TAG;
					case NNFeatureImportanceBrainSurfacePP_FI_Graph.XSLIDERHEIGHT
						tag = NNFeatureImportanceBrainSurfacePP_FI_Graph.XSLIDERHEIGHT_TAG;
					case NNFeatureImportanceBrainSurfacePP_FI_Graph.XSLIDER
						tag = NNFeatureImportanceBrainSurfacePP_FI_Graph.XSLIDER_TAG;
					case NNFeatureImportanceBrainSurfacePP_FI_Graph.YSLIDERSHOW
						tag = NNFeatureImportanceBrainSurfacePP_FI_Graph.YSLIDERSHOW_TAG;
					case NNFeatureImportanceBrainSurfacePP_FI_Graph.YSLIDERLABELS
						tag = NNFeatureImportanceBrainSurfacePP_FI_Graph.YSLIDERLABELS_TAG;
					case NNFeatureImportanceBrainSurfacePP_FI_Graph.YSLIDERWIDTH
						tag = NNFeatureImportanceBrainSurfacePP_FI_Graph.YSLIDERWIDTH_TAG;
					case NNFeatureImportanceBrainSurfacePP_FI_Graph.YSLIDER
						tag = NNFeatureImportanceBrainSurfacePP_FI_Graph.YSLIDER_TAG;
					case NNFeatureImportanceBrainSurfacePP_FI_Graph.XYSLIDERLOCK
						tag = NNFeatureImportanceBrainSurfacePP_FI_Graph.XYSLIDERLOCK_TAG;
					case NNFeatureImportanceBrainSurfacePP_FI_Graph.ENABLE
						tag = NNFeatureImportanceBrainSurfacePP_FI_Graph.ENABLE_TAG;
					case NNFeatureImportanceBrainSurfacePP_FI_Graph.ROWNAME
						tag = NNFeatureImportanceBrainSurfacePP_FI_Graph.ROWNAME_TAG;
					case NNFeatureImportanceBrainSurfacePP_FI_Graph.COLUMNNAME
						tag = NNFeatureImportanceBrainSurfacePP_FI_Graph.COLUMNNAME_TAG;
					case NNFeatureImportanceBrainSurfacePP_FI_Graph.MENU_EXPORT
						tag = NNFeatureImportanceBrainSurfacePP_FI_Graph.MENU_EXPORT_TAG;
					case NNFeatureImportanceBrainSurfacePP_FI_Graph.TABLE_HEIGHT
						tag = NNFeatureImportanceBrainSurfacePP_FI_Graph.TABLE_HEIGHT_TAG;
					case NNFeatureImportanceBrainSurfacePP_FI_Graph.TABLE
						tag = NNFeatureImportanceBrainSurfacePP_FI_Graph.TABLE_TAG;
					case NNFeatureImportanceBrainSurfacePP_FI_Graph.CONTEXTMENU
						tag = NNFeatureImportanceBrainSurfacePP_FI_Graph.CONTEXTMENU_TAG;
					case NNFeatureImportanceBrainSurfacePP_FI_Graph.MAP_TO_CELL
						tag = NNFeatureImportanceBrainSurfacePP_FI_Graph.MAP_TO_CELL_TAG;
					otherwise
						tag = getPropTag@PanelProp(prop);
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
			%  CATEGORY = PR.GETPROPCATEGORY(POINTER) returns category of POINTER of PR.
			%  CATEGORY = Element.GETPROPCATEGORY(NNFeatureImportanceBrainSurfacePP_FI_Graph, POINTER) returns category of POINTER of NNFeatureImportanceBrainSurfacePP_FI_Graph.
			%  CATEGORY = PR.GETPROPCATEGORY(NNFeatureImportanceBrainSurfacePP_FI_Graph, POINTER) returns category of POINTER of NNFeatureImportanceBrainSurfacePP_FI_Graph.
			%
			% Note that the Element.GETPROPCATEGORY(PR) and Element.GETPROPCATEGORY('NNFeatureImportanceBrainSurfacePP_FI_Graph')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = NNFeatureImportanceBrainSurfacePP_FI_Graph.getPropProp(pointer);
			
			switch prop
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.D
					prop_category = NNFeatureImportanceBrainSurfacePP_FI_Graph.D_CATEGORY;
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.XSLIDERSHOW
					prop_category = NNFeatureImportanceBrainSurfacePP_FI_Graph.XSLIDERSHOW_CATEGORY;
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.XSLIDERLABELS
					prop_category = NNFeatureImportanceBrainSurfacePP_FI_Graph.XSLIDERLABELS_CATEGORY;
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.XSLIDERHEIGHT
					prop_category = NNFeatureImportanceBrainSurfacePP_FI_Graph.XSLIDERHEIGHT_CATEGORY;
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.XSLIDER
					prop_category = NNFeatureImportanceBrainSurfacePP_FI_Graph.XSLIDER_CATEGORY;
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.YSLIDERSHOW
					prop_category = NNFeatureImportanceBrainSurfacePP_FI_Graph.YSLIDERSHOW_CATEGORY;
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.YSLIDERLABELS
					prop_category = NNFeatureImportanceBrainSurfacePP_FI_Graph.YSLIDERLABELS_CATEGORY;
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.YSLIDERWIDTH
					prop_category = NNFeatureImportanceBrainSurfacePP_FI_Graph.YSLIDERWIDTH_CATEGORY;
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.YSLIDER
					prop_category = NNFeatureImportanceBrainSurfacePP_FI_Graph.YSLIDER_CATEGORY;
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.XYSLIDERLOCK
					prop_category = NNFeatureImportanceBrainSurfacePP_FI_Graph.XYSLIDERLOCK_CATEGORY;
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.ENABLE
					prop_category = NNFeatureImportanceBrainSurfacePP_FI_Graph.ENABLE_CATEGORY;
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.ROWNAME
					prop_category = NNFeatureImportanceBrainSurfacePP_FI_Graph.ROWNAME_CATEGORY;
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.COLUMNNAME
					prop_category = NNFeatureImportanceBrainSurfacePP_FI_Graph.COLUMNNAME_CATEGORY;
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.MENU_EXPORT
					prop_category = NNFeatureImportanceBrainSurfacePP_FI_Graph.MENU_EXPORT_CATEGORY;
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.TABLE_HEIGHT
					prop_category = NNFeatureImportanceBrainSurfacePP_FI_Graph.TABLE_HEIGHT_CATEGORY;
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.TABLE
					prop_category = NNFeatureImportanceBrainSurfacePP_FI_Graph.TABLE_CATEGORY;
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.CONTEXTMENU
					prop_category = NNFeatureImportanceBrainSurfacePP_FI_Graph.CONTEXTMENU_CATEGORY;
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.MAP_TO_CELL
					prop_category = NNFeatureImportanceBrainSurfacePP_FI_Graph.MAP_TO_CELL_CATEGORY;
				otherwise
					prop_category = getPropCategory@PanelProp(prop);
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
			%  FORMAT = PR.GETPROPFORMAT(POINTER) returns format of POINTER of PR.
			%  FORMAT = Element.GETPROPFORMAT(NNFeatureImportanceBrainSurfacePP_FI_Graph, POINTER) returns format of POINTER of NNFeatureImportanceBrainSurfacePP_FI_Graph.
			%  FORMAT = PR.GETPROPFORMAT(NNFeatureImportanceBrainSurfacePP_FI_Graph, POINTER) returns format of POINTER of NNFeatureImportanceBrainSurfacePP_FI_Graph.
			%
			% Note that the Element.GETPROPFORMAT(PR) and Element.GETPROPFORMAT('NNFeatureImportanceBrainSurfacePP_FI_Graph')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = NNFeatureImportanceBrainSurfacePP_FI_Graph.getPropProp(pointer);
			
			switch prop
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.D
					prop_format = NNFeatureImportanceBrainSurfacePP_FI_Graph.D_FORMAT;
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.XSLIDERSHOW
					prop_format = NNFeatureImportanceBrainSurfacePP_FI_Graph.XSLIDERSHOW_FORMAT;
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.XSLIDERLABELS
					prop_format = NNFeatureImportanceBrainSurfacePP_FI_Graph.XSLIDERLABELS_FORMAT;
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.XSLIDERHEIGHT
					prop_format = NNFeatureImportanceBrainSurfacePP_FI_Graph.XSLIDERHEIGHT_FORMAT;
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.XSLIDER
					prop_format = NNFeatureImportanceBrainSurfacePP_FI_Graph.XSLIDER_FORMAT;
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.YSLIDERSHOW
					prop_format = NNFeatureImportanceBrainSurfacePP_FI_Graph.YSLIDERSHOW_FORMAT;
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.YSLIDERLABELS
					prop_format = NNFeatureImportanceBrainSurfacePP_FI_Graph.YSLIDERLABELS_FORMAT;
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.YSLIDERWIDTH
					prop_format = NNFeatureImportanceBrainSurfacePP_FI_Graph.YSLIDERWIDTH_FORMAT;
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.YSLIDER
					prop_format = NNFeatureImportanceBrainSurfacePP_FI_Graph.YSLIDER_FORMAT;
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.XYSLIDERLOCK
					prop_format = NNFeatureImportanceBrainSurfacePP_FI_Graph.XYSLIDERLOCK_FORMAT;
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.ENABLE
					prop_format = NNFeatureImportanceBrainSurfacePP_FI_Graph.ENABLE_FORMAT;
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.ROWNAME
					prop_format = NNFeatureImportanceBrainSurfacePP_FI_Graph.ROWNAME_FORMAT;
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.COLUMNNAME
					prop_format = NNFeatureImportanceBrainSurfacePP_FI_Graph.COLUMNNAME_FORMAT;
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.MENU_EXPORT
					prop_format = NNFeatureImportanceBrainSurfacePP_FI_Graph.MENU_EXPORT_FORMAT;
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.TABLE_HEIGHT
					prop_format = NNFeatureImportanceBrainSurfacePP_FI_Graph.TABLE_HEIGHT_FORMAT;
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.TABLE
					prop_format = NNFeatureImportanceBrainSurfacePP_FI_Graph.TABLE_FORMAT;
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.CONTEXTMENU
					prop_format = NNFeatureImportanceBrainSurfacePP_FI_Graph.CONTEXTMENU_FORMAT;
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.MAP_TO_CELL
					prop_format = NNFeatureImportanceBrainSurfacePP_FI_Graph.MAP_TO_CELL_FORMAT;
				otherwise
					prop_format = getPropFormat@PanelProp(prop);
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
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(POINTER) returns description of POINTER of PR.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(NNFeatureImportanceBrainSurfacePP_FI_Graph, POINTER) returns description of POINTER of NNFeatureImportanceBrainSurfacePP_FI_Graph.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(NNFeatureImportanceBrainSurfacePP_FI_Graph, POINTER) returns description of POINTER of NNFeatureImportanceBrainSurfacePP_FI_Graph.
			%
			% Note that the Element.GETPROPDESCRIPTION(PR) and Element.GETPROPDESCRIPTION('NNFeatureImportanceBrainSurfacePP_FI_Graph')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = NNFeatureImportanceBrainSurfacePP_FI_Graph.getPropProp(pointer);
			
			switch prop
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.D
					prop_description = 'D (metadata, item) is the input dataset.';
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.XSLIDERSHOW
					prop_description = 'XSLIDERSHOW (gui, logical) determines whether to show the xslider.';
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.XSLIDERLABELS
					prop_description = 'XSLIDERLABELS (gui, stringlist) determines the xslider labels.';
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.XSLIDERHEIGHT
					prop_description = 'XSLIDERHEIGHT (gui, size) is the height below the xslider in font size units.';
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.XSLIDER
					prop_description = 'XSLIDER (evanescent, handle) is the x-slider.';
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.YSLIDERSHOW
					prop_description = 'YSLIDERSHOW (gui, logical) determines whether to show the yslider.';
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.YSLIDERLABELS
					prop_description = 'YSLIDERLABELS (gui, stringlist) determines the yslider labels.';
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.YSLIDERWIDTH
					prop_description = 'YSLIDERWIDTH (gui, size) is the width to the right of the yslider in font size units.';
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.YSLIDER
					prop_description = 'YSLIDER (evanescent, handle) is the y-slider.';
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.XYSLIDERLOCK
					prop_description = 'XYSLIDERLOCK (gui, logical) determines whether the sliders are locked so that only the diagonal is shown.';
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.ENABLE
					prop_description = 'ENABLE (gui, option) switches table between on and off.';
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.ROWNAME
					prop_description = 'ROWNAME (gui, stringlist) determines the table row names.';
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.COLUMNNAME
					prop_description = 'COLUMNNAME (gui, stringlist) determines the table column names.';
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.MENU_EXPORT
					prop_description = 'MENU_EXPORT (gui, logical) determines whether to show the context menu to export data.';
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.TABLE_HEIGHT
					prop_description = 'TABLE_HEIGHT (gui, size) is the pixel height of the prop panel when the table is shown.';
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.TABLE
					prop_description = 'TABLE (evanescent, handle) is the alpha value edit field.';
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.CONTEXTMENU
					prop_description = 'CONTEXTMENU (evanescent, handle) is the context menu.';
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.MAP_TO_CELL
					prop_description = 'MAP_TO_CELL (query, empty) maps a single vector back to the original cell array structure.';
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the panel for feature importance.';
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.NAME
					prop_description = 'NAME (constant, string) is the name of the panel for feature importance.';
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the panel for feature importance.';
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the panel for feature importance.';
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.ID
					prop_description = 'ID (data, string) is a few-letter code for the panel for feature importance.';
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the panel for feature importance.';
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the panel for feature importance.';
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.EL
					prop_description = 'EL (data, item) is the element.';
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.PROP
					prop_description = 'PROP (data, scalar) is the prop number.';
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.X_DRAW
					prop_description = 'X_DRAW (query, logical) draws the prop panel.';
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.UPDATE
					prop_description = 'UPDATE (query, logical) updates the content and permissions of the table.';
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.REDRAW
					prop_description = 'REDRAW (query, logical) resizes the prop panel and repositions its graphical objects.';
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.DELETE
					prop_description = 'DELETE (query, logical) resets the handles when the panel is deleted.';
				otherwise
					prop_description = getPropDescription@PanelProp(prop);
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
			%  SETTINGS = PR.GETPROPSETTINGS(POINTER) returns settings of POINTER of PR.
			%  SETTINGS = Element.GETPROPSETTINGS(NNFeatureImportanceBrainSurfacePP_FI_Graph, POINTER) returns settings of POINTER of NNFeatureImportanceBrainSurfacePP_FI_Graph.
			%  SETTINGS = PR.GETPROPSETTINGS(NNFeatureImportanceBrainSurfacePP_FI_Graph, POINTER) returns settings of POINTER of NNFeatureImportanceBrainSurfacePP_FI_Graph.
			%
			% Note that the Element.GETPROPSETTINGS(PR) and Element.GETPROPSETTINGS('NNFeatureImportanceBrainSurfacePP_FI_Graph')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = NNFeatureImportanceBrainSurfacePP_FI_Graph.getPropProp(pointer);
			
			switch prop
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.D
					prop_settings = Format.getFormatSettings(Format.ITEM);
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.XSLIDERSHOW
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.XSLIDERLABELS
					prop_settings = Format.getFormatSettings(Format.STRINGLIST);
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.XSLIDERHEIGHT
					prop_settings = Format.getFormatSettings(Format.SIZE);
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.XSLIDER
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.YSLIDERSHOW
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.YSLIDERLABELS
					prop_settings = Format.getFormatSettings(Format.STRINGLIST);
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.YSLIDERWIDTH
					prop_settings = Format.getFormatSettings(Format.SIZE);
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.YSLIDER
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.XYSLIDERLOCK
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.ENABLE
					prop_settings = {'on', 'off'};
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.ROWNAME
					prop_settings = Format.getFormatSettings(Format.STRINGLIST);
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.COLUMNNAME
					prop_settings = Format.getFormatSettings(Format.STRINGLIST);
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.MENU_EXPORT
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.TABLE_HEIGHT
					prop_settings = Format.getFormatSettings(Format.SIZE);
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.TABLE
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.CONTEXTMENU
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.MAP_TO_CELL
					prop_settings = Format.getFormatSettings(Format.EMPTY);
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.TEMPLATE
					prop_settings = 'NNFeatureImportanceBrainSurfacePP_FI_Graph';
				otherwise
					prop_settings = getPropSettings@PanelProp(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = NNFeatureImportanceBrainSurfacePP_FI_Graph.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = NNFeatureImportanceBrainSurfacePP_FI_Graph.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(NNFeatureImportanceBrainSurfacePP_FI_Graph, POINTER) returns the default value of POINTER of NNFeatureImportanceBrainSurfacePP_FI_Graph.
			%  DEFAULT = PR.GETPROPDEFAULT(NNFeatureImportanceBrainSurfacePP_FI_Graph, POINTER) returns the default value of POINTER of NNFeatureImportanceBrainSurfacePP_FI_Graph.
			%
			% Note that the Element.GETPROPDEFAULT(PR) and Element.GETPROPDEFAULT('NNFeatureImportanceBrainSurfacePP_FI_Graph')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNFeatureImportanceBrainSurfacePP_FI_Graph.getPropProp(pointer);
			
			switch prop
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.D
					prop_default = NNDataset();
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.XSLIDERSHOW
					prop_default = true;
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.XSLIDERLABELS
					prop_default = Format.getFormatDefault(Format.STRINGLIST, NNFeatureImportanceBrainSurfacePP_FI_Graph.getPropSettings(prop));
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.XSLIDERHEIGHT
					prop_default = s(3);
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.XSLIDER
					prop_default = Format.getFormatDefault(Format.HANDLE, NNFeatureImportanceBrainSurfacePP_FI_Graph.getPropSettings(prop));
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.YSLIDERSHOW
					prop_default = true;
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.YSLIDERLABELS
					prop_default = Format.getFormatDefault(Format.STRINGLIST, NNFeatureImportanceBrainSurfacePP_FI_Graph.getPropSettings(prop));
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.YSLIDERWIDTH
					prop_default = s(3);
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.YSLIDER
					prop_default = Format.getFormatDefault(Format.HANDLE, NNFeatureImportanceBrainSurfacePP_FI_Graph.getPropSettings(prop));
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.XYSLIDERLOCK
					prop_default = false;
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.ENABLE
					prop_default = 'on';
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.ROWNAME
					prop_default = {'numbered'};
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.COLUMNNAME
					prop_default = {'numbered'};
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.MENU_EXPORT
					prop_default = true;
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.TABLE_HEIGHT
					prop_default = s(20);
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.TABLE
					prop_default = Format.getFormatDefault(Format.HANDLE, NNFeatureImportanceBrainSurfacePP_FI_Graph.getPropSettings(prop));
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.CONTEXTMENU
					prop_default = Format.getFormatDefault(Format.HANDLE, NNFeatureImportanceBrainSurfacePP_FI_Graph.getPropSettings(prop));
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.MAP_TO_CELL
					prop_default = Format.getFormatDefault(Format.EMPTY, NNFeatureImportanceBrainSurfacePP_FI_Graph.getPropSettings(prop));
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.ELCLASS
					prop_default = 'NNFeatureImportanceBrainSurfacePP_FI_Graph';
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.NAME
					prop_default = 'A Panel for Feature Importance of a Neural Network Analysis';
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.DESCRIPTION
					prop_default = 'A panel for feature importance of a neural network analysis with the graph (NNFeatureImportanceBrainSurfacePP_FI_Graph) plots the panel to show the feature importance, mathcing the layer number and node number of the graph. It is supposed to be used with the property FEATURE_IMPORTANCE of NNClassifierMLP_Evaluator, NNClassifierMLP_CrossValidation, NNRegressorMLP_Evaluator, and NNRegressorMLP_CrossValidation.';
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, NNFeatureImportanceBrainSurfacePP_FI_Graph.getPropSettings(prop));
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.ID
					prop_default = 'NNFeatureImportanceBrainSurfacePP_FI_Graph ID';
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.LABEL
					prop_default = 'NNFeatureImportanceBrainSurfacePP_FI_Graph label';
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.NOTES
					prop_default = 'NNFeatureImportanceBrainSurfacePP_FI_Graph notes';
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.EL
					prop_default = NNFeatureImportanceBrainSurface();
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.PROP
					prop_default = NNClassifierMLP_CrossValidation.AV_FEATURE_IMPORTANCE;
				otherwise
					prop_default = getPropDefault@PanelProp(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = NNFeatureImportanceBrainSurfacePP_FI_Graph.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = NNFeatureImportanceBrainSurfacePP_FI_Graph.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(NNFeatureImportanceBrainSurfacePP_FI_Graph, POINTER) returns the conditioned default value of POINTER of NNFeatureImportanceBrainSurfacePP_FI_Graph.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(NNFeatureImportanceBrainSurfacePP_FI_Graph, POINTER) returns the conditioned default value of POINTER of NNFeatureImportanceBrainSurfacePP_FI_Graph.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PR) and Element.GETPROPDEFAULTCONDITIONED('NNFeatureImportanceBrainSurfacePP_FI_Graph')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = NNFeatureImportanceBrainSurfacePP_FI_Graph.getPropProp(pointer);
			
			prop_default = NNFeatureImportanceBrainSurfacePP_FI_Graph.conditioning(prop, NNFeatureImportanceBrainSurfacePP_FI_Graph.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = PR.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = PR.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of PR.
			%  CHECK = Element.CHECKPROP(NNFeatureImportanceBrainSurfacePP_FI_Graph, PROP, VALUE) checks VALUE format for PROP of NNFeatureImportanceBrainSurfacePP_FI_Graph.
			%  CHECK = PR.CHECKPROP(NNFeatureImportanceBrainSurfacePP_FI_Graph, PROP, VALUE) checks VALUE format for PROP of NNFeatureImportanceBrainSurfacePP_FI_Graph.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:NNFeatureImportanceBrainSurfacePP_FI_Graph:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: €BRAPH2.STR€:NNFeatureImportanceBrainSurfacePP_FI_Graph:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(NNFeatureImportanceBrainSurfacePP_FI_Graph, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNFeatureImportanceBrainSurfacePP_FI_Graph.
			%   Error id: €BRAPH2.STR€:NNFeatureImportanceBrainSurfacePP_FI_Graph:€BRAPH2.WRONG_INPUT€
			%  PR.CHECKPROP(NNFeatureImportanceBrainSurfacePP_FI_Graph, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNFeatureImportanceBrainSurfacePP_FI_Graph.
			%   Error id: €BRAPH2.STR€:NNFeatureImportanceBrainSurfacePP_FI_Graph:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PR) and Element.CHECKPROP('NNFeatureImportanceBrainSurfacePP_FI_Graph')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = NNFeatureImportanceBrainSurfacePP_FI_Graph.getPropProp(pointer);
			
			switch prop
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.D % __NNFeatureImportanceBrainSurfacePP_FI_Graph.D__
					check = Format.checkFormat(Format.ITEM, value, NNFeatureImportanceBrainSurfacePP_FI_Graph.getPropSettings(prop));
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.XSLIDERSHOW % __NNFeatureImportanceBrainSurfacePP_FI_Graph.XSLIDERSHOW__
					check = Format.checkFormat(Format.LOGICAL, value, NNFeatureImportanceBrainSurfacePP_FI_Graph.getPropSettings(prop));
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.XSLIDERLABELS % __NNFeatureImportanceBrainSurfacePP_FI_Graph.XSLIDERLABELS__
					check = Format.checkFormat(Format.STRINGLIST, value, NNFeatureImportanceBrainSurfacePP_FI_Graph.getPropSettings(prop));
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.XSLIDERHEIGHT % __NNFeatureImportanceBrainSurfacePP_FI_Graph.XSLIDERHEIGHT__
					check = Format.checkFormat(Format.SIZE, value, NNFeatureImportanceBrainSurfacePP_FI_Graph.getPropSettings(prop));
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.XSLIDER % __NNFeatureImportanceBrainSurfacePP_FI_Graph.XSLIDER__
					check = Format.checkFormat(Format.HANDLE, value, NNFeatureImportanceBrainSurfacePP_FI_Graph.getPropSettings(prop));
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.YSLIDERSHOW % __NNFeatureImportanceBrainSurfacePP_FI_Graph.YSLIDERSHOW__
					check = Format.checkFormat(Format.LOGICAL, value, NNFeatureImportanceBrainSurfacePP_FI_Graph.getPropSettings(prop));
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.YSLIDERLABELS % __NNFeatureImportanceBrainSurfacePP_FI_Graph.YSLIDERLABELS__
					check = Format.checkFormat(Format.STRINGLIST, value, NNFeatureImportanceBrainSurfacePP_FI_Graph.getPropSettings(prop));
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.YSLIDERWIDTH % __NNFeatureImportanceBrainSurfacePP_FI_Graph.YSLIDERWIDTH__
					check = Format.checkFormat(Format.SIZE, value, NNFeatureImportanceBrainSurfacePP_FI_Graph.getPropSettings(prop));
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.YSLIDER % __NNFeatureImportanceBrainSurfacePP_FI_Graph.YSLIDER__
					check = Format.checkFormat(Format.HANDLE, value, NNFeatureImportanceBrainSurfacePP_FI_Graph.getPropSettings(prop));
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.XYSLIDERLOCK % __NNFeatureImportanceBrainSurfacePP_FI_Graph.XYSLIDERLOCK__
					check = Format.checkFormat(Format.LOGICAL, value, NNFeatureImportanceBrainSurfacePP_FI_Graph.getPropSettings(prop));
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.ENABLE % __NNFeatureImportanceBrainSurfacePP_FI_Graph.ENABLE__
					check = Format.checkFormat(Format.OPTION, value, NNFeatureImportanceBrainSurfacePP_FI_Graph.getPropSettings(prop));
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.ROWNAME % __NNFeatureImportanceBrainSurfacePP_FI_Graph.ROWNAME__
					check = Format.checkFormat(Format.STRINGLIST, value, NNFeatureImportanceBrainSurfacePP_FI_Graph.getPropSettings(prop));
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.COLUMNNAME % __NNFeatureImportanceBrainSurfacePP_FI_Graph.COLUMNNAME__
					check = Format.checkFormat(Format.STRINGLIST, value, NNFeatureImportanceBrainSurfacePP_FI_Graph.getPropSettings(prop));
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.MENU_EXPORT % __NNFeatureImportanceBrainSurfacePP_FI_Graph.MENU_EXPORT__
					check = Format.checkFormat(Format.LOGICAL, value, NNFeatureImportanceBrainSurfacePP_FI_Graph.getPropSettings(prop));
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.TABLE_HEIGHT % __NNFeatureImportanceBrainSurfacePP_FI_Graph.TABLE_HEIGHT__
					check = Format.checkFormat(Format.SIZE, value, NNFeatureImportanceBrainSurfacePP_FI_Graph.getPropSettings(prop));
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.TABLE % __NNFeatureImportanceBrainSurfacePP_FI_Graph.TABLE__
					check = Format.checkFormat(Format.HANDLE, value, NNFeatureImportanceBrainSurfacePP_FI_Graph.getPropSettings(prop));
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.CONTEXTMENU % __NNFeatureImportanceBrainSurfacePP_FI_Graph.CONTEXTMENU__
					check = Format.checkFormat(Format.HANDLE, value, NNFeatureImportanceBrainSurfacePP_FI_Graph.getPropSettings(prop));
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.MAP_TO_CELL % __NNFeatureImportanceBrainSurfacePP_FI_Graph.MAP_TO_CELL__
					check = Format.checkFormat(Format.EMPTY, value, NNFeatureImportanceBrainSurfacePP_FI_Graph.getPropSettings(prop));
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.TEMPLATE % __NNFeatureImportanceBrainSurfacePP_FI_Graph.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, NNFeatureImportanceBrainSurfacePP_FI_Graph.getPropSettings(prop));
				otherwise
					if prop <= PanelProp.getPropNumber()
						check = checkProp@PanelProp(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNFeatureImportanceBrainSurfacePP_FI_Graph:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNFeatureImportanceBrainSurfacePP_FI_Graph:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' NNFeatureImportanceBrainSurfacePP_FI_Graph.getPropTag(prop) ' (' NNFeatureImportanceBrainSurfacePP_FI_Graph.getFormatTag(NNFeatureImportanceBrainSurfacePP_FI_Graph.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % postset
		function postset(pr, prop)
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
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.ROWNAME % __NNFeatureImportanceBrainSurfacePP_FI_Graph.ROWNAME__
					if pr.get('DRAWN')
					    pr.get('UPDATE')
					end
					
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.COLUMNNAME % __NNFeatureImportanceBrainSurfacePP_FI_Graph.COLUMNNAME__
					if pr.get('DRAWN')
					    pr.get('UPDATE')
					end
					
				otherwise
					if prop <= PanelProp.getPropNumber()
						postset@PanelProp(pr, prop);
					end
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(pr, prop, varargin)
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
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.XSLIDER % __NNFeatureImportanceBrainSurfacePP_FI_Graph.XSLIDER__
					el = pr.get('EL');
					prop = pr.get('PROP');
					
					xslider = uislider( ...
					    'Parent', pr.get('H'), ...
					    'Tag', 'XSLIDER', ...
					    'MajorTicksMode', 'manual', ...
					    'MajorTickLabelsMode', 'manual', ...
					    'MinorTicksMode', 'manual', ...
					    'MinorTicks', [], ...
					    'FontSize', BRAPH2.FONTSIZE, ...
					    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
					    'ValueChangedFcn', {@cb_xslider} ...
					    );
					
					value = xslider;
					
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.YSLIDER % __NNFeatureImportanceBrainSurfacePP_FI_Graph.YSLIDER__
					el = pr.get('EL');
					prop = pr.get('PROP');
					
					yslider = uislider( ...
					    'Parent', pr.get('H'), ...
					    'Tag', 'YSLIDER', ...
					    'Orientation', 'vertical', ...
					    'MajorTicksMode', 'manual', ...
					    'MajorTickLabelsMode', 'manual', ...
					    'MinorTicksMode', 'manual', ...
					    'MinorTicks', [], ...
					    'FontSize', BRAPH2.FONTSIZE, ...
					    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
					    'ValueChangedFcn', {@cb_yslider} ...
					    );
					
					value = yslider;
					
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.TABLE % __NNFeatureImportanceBrainSurfacePP_FI_Graph.TABLE__
					el = pr.get('EL');
					prop = pr.get('PROP');
					
					table = uitable( ...
					    'Parent', pr.memorize('H'), ... % H = p for Panel
					    'Tag', 'TABLE', ...
					    'FontSize', BRAPH2.FONTSIZE, ...
					    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
					    'CellEditCallback', {@cb_table} ...
					    );
					
					value = table;
					
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.CONTEXTMENU % __NNFeatureImportanceBrainSurfacePP_FI_Graph.CONTEXTMENU__
					contextmenu = uicontextmenu(...
					    'Parent', ancestor(pr.get('H'), 'figure'), ...
					    'Tag', 'CONTEXTMENU' ...
					    );
					menu_export_to_xls = uimenu( ...
					    'Parent', contextmenu, ...
					    'Tag', 'MENU_EXPORT_TO_XLS', ...
					    'Text', 'Export to XLS', ...
					    'MenuSelectedFcn', {@cb_export_to_xls} ...
					    );
					if pr.get('MENU_EXPORT')
					    set(pr.get('TABLE'), 'ContextMenu', contextmenu)
					end
					value = contextmenu;
					
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.MAP_TO_CELL % __NNFeatureImportanceBrainSurfacePP_FI_Graph.MAP_TO_CELL__
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
					        nestedVector = pr.get('MAP_TO_CELL', vector(index:end), cellData);
					        mappedCellArray{i} = nestedVector;
					    else
					        % Assign elements from the vector to cells
					        numElements = numel(cellData);
					        mappedCellArray{i} = reshape(vector(index:index+numElements-1), size(cellData));
					        index = index + numElements;
					    end
					end
					
					value = mappedCellArray;
					
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.X_DRAW % __NNFeatureImportanceBrainSurfacePP_FI_Graph.X_DRAW__
					value = calculateValue@PanelProp(pr, PanelProp.X_DRAW, varargin{:}); % also warning
					if value
					    pr.memorize('TABLE')
					    pr.memorize('CONTEXTMENU')
					    pr.memorize('XSLIDER')
					    pr.memorize('YSLIDER')
					end
					
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.UPDATE % __NNFeatureImportanceBrainSurfacePP_FI_Graph.UPDATE__
					value = calculateValue@PanelProp(pr, PanelProp.UPDATE, varargin{:}); % also warning
					if value
					    el = pr.get('EL');
					    prop = pr.get('PROP');
					
					    if any(el.getPropCategory(prop) == [Category.RESULT Category.QUERY Category.EVANESCENT]) && isa(el.getr(prop), 'NoValue')
					        pr.set('HEIGHT', s(2))
					    else
					        pr.set('HEIGHT', pr.get('TABLE_HEIGHT'))
					    end
					    
					    el = pr.get('EL');
					    prop = pr.get('PROP');
					    
					    input_dataset = pr.get('D'); 
					    
					    g = input_dataset.get('DP_DICT').get('IT', 1).get('G');
					    if g.get('LAYERNUMBER') == 1
					        pr.set('TABLE_HEIGHT', s(40), ...
					            'XSLIDERSHOW', false, ...
					            'YSLIDERSHOW', false, ...
					            'ROWNAME', g.getCallback('ANODELABELS'), ...
					            'COLUMNNAME', g.getCallback('ANODELABELS'), ...
					            varargin{:} ...
					            );
					    else % multilayer
					        pr.set('TABLE_HEIGHT', s(40), ...
					            'XYSLIDERLOCK', true, ...
					            'XSLIDERSHOW', false, ...
					            'YSLIDERSHOW', true, ...
					            'YSLIDERLABELS', g.getCallback('ALAYERLABELS'), ...
					            'YSLIDERWIDTH', s(5), ...
					            'ROWNAME', g.getCallback('ANODELABELS'), ...
					            'COLUMNNAME', g.getCallback('ANODELABELS'), ...
					            varargin{:});
					    end
					
					    rowname = pr.get('ROWNAME');
					    if isempty(rowname)
					        rowname = 'numbered';
					    end
					    columnname = pr.get('COLUMNNAME');
					    if isempty(rowname)
					        columnname = 'numbered';
					    end
					    set(pr.get('TABLE'), ...
					        'RowName', rowname, ...
					        'ColumnName', columnname ...
					        );
					
					    if el.isLocked(prop)
					        set(pr.get('TABLE'), 'Enable', pr.get('ENABLE'))
					    end
					    
					    prop_value = el.getr(prop);
					
					    if isa(prop_value, 'NoValue')
					        % don't plot anything for a result not yet calculated
					        set(pr.get('TABLE'), 'Visible', 'off')
					        set(pr.get('XSLIDER'), 'Visible', 'off')
					        set(pr.get('YSLIDER'), 'Visible', 'off')
					    else
					        set(pr.get('TABLE'), ...
					            'Data', set_sliders_and_get_value(), ...
					            'Enable', pr.get('ENABLE'), ...
					            'ColumnEditable', false, ...
					            'Visible', 'on' ...
					            )
					    end
					end
					
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.REDRAW % __NNFeatureImportanceBrainSurfacePP_FI_Graph.REDRAW__
					value = calculateValue@PanelProp(pr, PanelProp.REDRAW, varargin{:}); % also warning
					if value
					    w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
					    
					    if ~pr.get('XSLIDERSHOW') && ~pr.get('YSLIDERSHOW')
					        set(pr.get('TABLE'), 'Position', [s(.3) s(.3) max(1, w_p-s(.6)) max(1, pr.get('HEIGHT')-s(2.2))])
					    elseif pr.get('XSLIDERSHOW') && ~pr.get('YSLIDERSHOW')
					        set(pr.get('TABLE'), 'Position', [s(.3) s(.3) max(1, w_p-s(.6)) max(1, pr.get('HEIGHT')-s(2.2)-pr.get('XSLIDERHEIGHT'))])
					        set(pr.get('XSLIDER'), 'Position', [s(.3) max(1, pr.get('HEIGHT')-s(2.0)-s(.3)) max(1, w_p-s(.6)) 3])
					    elseif ~pr.get('XSLIDERSHOW') && pr.get('YSLIDERSHOW')
					        set(pr.get('TABLE'), 'Position', [s(.3)+pr.get('YSLIDERWIDTH') s(.3) max(1, w_p-s(.6)-pr.get('YSLIDERWIDTH')) max(1, pr.get('HEIGHT')-s(2.2))])
					        set(pr.get('YSLIDER'), 'Position', [s(.3) s(.3) 3 max(1, pr.get('HEIGHT')-s(2.2))])
					    else % pr.get('XSLIDERSHOW') && pr.get('YSLIDERSHOW')
					        set(pr.get('TABLE'), 'Position', [s(.3)+pr.get('YSLIDERWIDTH') s(.3) max(1, w_p-s(.6)-pr.get('YSLIDERWIDTH')) max(1, pr.get('HEIGHT')-s(2.2)-pr.get('XSLIDERHEIGHT'))])
					        set(pr.get('XSLIDER'), 'Position', [s(.3)+pr.get('YSLIDERWIDTH') max(1, pr.get('HEIGHT')-s(2.0)-s(.3)) max(1, w_p-s(.6)-pr.get('YSLIDERWIDTH')) 3])
					        set(pr.get('YSLIDER'), 'Position', [s(.3) s(.3) 3 max(1, pr.get('HEIGHT')-s(2.2)-s(.6)-pr.get('XSLIDERHEIGHT'))])
					    end
					end
					
				case NNFeatureImportanceBrainSurfacePP_FI_Graph.DELETE % __NNFeatureImportanceBrainSurfacePP_FI_Graph.DELETE__
					value = calculateValue@PanelProp(pr, PanelProp.DELETE, varargin{:}); % also warning
					if value
					    pr.set('TABLE', Element.getNoValue())
					    pr.set('CONTEXTMENU', Element.getNoValue())
					    pr.set('XSLIDER', Element.getNoValue())
					    pr.set('YSLIDER', Element.getNoValue())
					end
					
				otherwise
					if prop <= PanelProp.getPropNumber()
						value = calculateValue@PanelProp(pr, prop, varargin{:});
					else
						value = calculateValue@Element(pr, prop, varargin{:});
					end
			end
			
			function cb_xslider(~, ~)
			    set(pr.get('XSLIDER'), 'Value', round(get(pr.get('XSLIDER'), 'Value')))
			    
			    % if pr.get('XYSLIDERLOCK')
			    %     el = pr.get('EL');
			    %     prop = pr.get('PROP');
			    %     value = el.get(prop);
			    %     [R, C] = size(value);
			    % 
			    %     R = max(R, 1); % to manage the case in which C = R = 0 (empty cell)
			    % 
			    %     set(pr.get('YSLIDER'), 'Value', R + 1 - get(pr.get('XSLIDER'), 'Value'))
			    % end
			    
			    pr.get('UPDATE')
			end
			function cb_yslider(~, ~)
			    set(pr.get('YSLIDER'), 'Value', round(get(pr.get('YSLIDER'), 'Value')))
			    
			    if pr.get('XYSLIDERLOCK')
			        el = pr.get('EL');
			        prop = pr.get('PROP');
			        value_vectored = el.get(prop);
			
			        cell_template = pr.get('D').get('DP_DICT').get('IT', 1).get('INPUT');
			        value = pr.get('MAP_TO_CELL', cell2mat(value_vectored), cell_template);
			
			        [R, C] = size(value);
			        
			        C = max(C, 1); % to manage the case in which C = R = 0 (empty cell)
			
			        set(pr.get('XSLIDER'), 'Value', C + 1 - get(pr.get('YSLIDER'), 'Value'))
			    end
			
			    pr.get('UPDATE')
			end
			function cb_table(~, event)
			    i = event.Indices(1);
			    j = event.Indices(2); 
			    newdata = event.NewData;
			
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			    
			    value = el.get(prop);
			    [R, C] = size(value);
			    
			    r = R + 1 - get(pr.get('YSLIDER'), 'Value');
			    c = get(pr.get('XSLIDER'), 'Value');
			    
			    value_rc = value{r, c};
			    value_rc(i, j) = newdata;
			    value{r, c} = value_rc;
			    el.set(prop, value)
			end
			function cb_export_to_xls(~, ~)
			    table = pr.get('TABLE');
			    data = table.Data;
			    
			    columns = table.ColumnName;
			    if isempty(columns)
			        columns = cellfun(@(x) ['Column ' num2str(x)], num2cell([1:1:size(data, 2)]), 'UniformOutput', false);
			    elseif isequal(columns, 'numbered')
			        columns = cellfun(@(x) num2str(x), num2cell([1:1:size(data, 2)]), 'UniformOutput', false);
			    end
			    
			    rows = table.RowName;
			    if isempty(rows)
			        rows = cellfun(@(x) ['Column ' num2str(x)], num2cell([1:1:size(data, 1)]), 'UniformOutput', false);
			    elseif isequal(rows, 'numbered')
			        rows = cellfun(@(x) num2str(x), num2cell([1:1:size(data, 1)]), 'UniformOutput', false);
			    end
			    
			    t = array2table(data, ...
			        'VariableNames', columns, ...
			        'RowNames', rows ...
			        );
			
			    % save file
			    [filename, filepath, filterindex] = uiputfile({'*.xlsx';'*.xls'}, 'Select Excel file');
			    if filterindex
			        file = [filepath filename];
			        writetable(t, file, 'WriteRowNames', true);
			    end
			end
			function value = set_sliders_and_get_value()
			    value_vectored = el.get(prop);
			    
			    cell_template = pr.get('D').get('DP_DICT').get('IT', 1).get('INPUT');
			    value = pr.get('MAP_TO_CELL', cell2mat(value_vectored), cell_template);
			
			    if isempty(value)
			        set(pr.get('XSLIDER'), ...
			            'Limits', [.6 1.4], ...
			            'MajorTicks', [1], ...
			            'MajorTickLabels', {}, ...
			            'Value', 1, ...
			            'Visible', pr.get('XSLIDERSHOW') ...
			            )
			        set(pr.get('YSLIDER'), ...
			            'Limits', [.6 1.4], ...
			            'MajorTicks', [1], ...
			            'MajorTickLabels', {}, ...
			            'Value', 1, ...
			            'Visible', pr.get('YSLIDERSHOW') ...
			            )
			    else
			        [R, C] = size(value);
			        set(pr.get('XSLIDER'), ...
			            'Limits', [.6 C+.4], ...
			            'MajorTicks', [1:1:C], ...
			            'MajorTickLabels', pr.get('XSLIDERLABELS'), ...
			            'Value', max(1, min(round(get(pr.get('XSLIDER'), 'Value'), C))), ...
			            'Visible', pr.get('XSLIDERSHOW') ...
			            )
			        set(pr.get('YSLIDER'), ...
			            'Limits', [.6 R+.4], ...
			            'MajorTicks', [1:1:R], ...
			            'MajorTickLabels', flip(pr.get('YSLIDERLABELS')), ...
			            'Value', max(1, min(round(get(pr.get('YSLIDER'), 'Value'), R))), ...
			            'Visible', pr.get('YSLIDERSHOW') ...
			            )
			
			        if pr.get('XYSLIDERLOCK')
			            set(pr.get('YSLIDER'), 'Value', R + 1 - get(pr.get('XSLIDER'), 'Value'))
			        end
			
			        value = value{R + 1 - get(pr.get('YSLIDER'), 'Value'), get(pr.get('XSLIDER'), 'Value')};
			    end
			end
		end
	end
end
