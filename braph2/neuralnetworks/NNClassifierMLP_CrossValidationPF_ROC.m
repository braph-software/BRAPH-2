classdef NNClassifierMLP_CrossValidationPF_ROC < PanelFig
	%NNClassifierMLP_CrossValidationPF_ROC plots a panel of receiver operating characteristic curves.
	% It is a subclass of <a href="matlab:help PanelFig">PanelFig</a>.
	%
	% The receiver operating characteristic panel for cross-validation MLP classifier 
	%  (NNClassifierMLP_CrossValidationPF_ROC) manages the functionalities to plot 
	%  a panel of the receiver operating characteristic curves.
	%
	% NNClassifierMLP_CrossValidationPF_ROC methods (constructor):
	%  NNClassifierMLP_CrossValidationPF_ROC - constructor
	%
	% NNClassifierMLP_CrossValidationPF_ROC methods:
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
	% NNClassifierMLP_CrossValidationPF_ROC methods (display):
	%  tostring - string with information about the panel receiver operating characteristic figure
	%  disp - displays information about the panel receiver operating characteristic figure
	%  tree - displays the tree of the panel receiver operating characteristic figure
	%
	% NNClassifierMLP_CrossValidationPF_ROC methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two panel receiver operating characteristic figure are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the panel receiver operating characteristic figure
	%
	% NNClassifierMLP_CrossValidationPF_ROC methods (save/load, Static):
	%  save - saves BRAPH2 panel receiver operating characteristic figure as b2 file
	%  load - loads a BRAPH2 panel receiver operating characteristic figure from a b2 file
	%
	% NNClassifierMLP_CrossValidationPF_ROC method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the panel receiver operating characteristic figure
	%
	% NNClassifierMLP_CrossValidationPF_ROC method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the panel receiver operating characteristic figure
	%
	% NNClassifierMLP_CrossValidationPF_ROC methods (inspection, Static):
	%  getClass - returns the class of the panel receiver operating characteristic figure
	%  getSubclasses - returns all subclasses of NNClassifierMLP_CrossValidationPF_ROC
	%  getProps - returns the property list of the panel receiver operating characteristic figure
	%  getPropNumber - returns the property number of the panel receiver operating characteristic figure
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
	% NNClassifierMLP_CrossValidationPF_ROC methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% NNClassifierMLP_CrossValidationPF_ROC methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% NNClassifierMLP_CrossValidationPF_ROC methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% NNClassifierMLP_CrossValidationPF_ROC methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?NNClassifierMLP_CrossValidationPF_ROC; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">NNClassifierMLP_CrossValidationPF_ROC constants</a>.
	%
	%
	% See also NNClassifierMLP_CrossValidation.
	
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
		
		CLASSNAMES = PanelFig.getPropNumber() + 5;
		CLASSNAMES_TAG = 'CLASSNAMES';
		CLASSNAMES_CATEGORY = Category.METADATA;
		CLASSNAMES_FORMAT = Format.STRINGLIST;
		
		X_VALUES = PanelFig.getPropNumber() + 6;
		X_VALUES_TAG = 'X_VALUES';
		X_VALUES_CATEGORY = Category.METADATA;
		X_VALUES_FORMAT = Format.MATRIX;
		
		Y_VALUES = PanelFig.getPropNumber() + 7;
		Y_VALUES_TAG = 'Y_VALUES';
		Y_VALUES_CATEGORY = Category.METADATA;
		Y_VALUES_FORMAT = Format.MATRIX;
		
		SETUP = PanelFig.getPropNumber() + 8;
		SETUP_TAG = 'SETUP';
		SETUP_CATEGORY = Category.QUERY;
		SETUP_FORMAT = Format.EMPTY;
		
		H_ROC = PanelFig.getPropNumber() + 9;
		H_ROC_TAG = 'H_ROC';
		H_ROC_CATEGORY = Category.EVANESCENT;
		H_ROC_FORMAT = Format.HANDLELIST;
		
		ROC = PanelFig.getPropNumber() + 10;
		ROC_TAG = 'ROC';
		ROC_CATEGORY = Category.FIGURE;
		ROC_FORMAT = Format.LOGICAL;
		
		ROC_DICT = PanelFig.getPropNumber() + 11;
		ROC_DICT_TAG = 'ROC_DICT';
		ROC_DICT_CATEGORY = Category.FIGURE;
		ROC_DICT_FORMAT = Format.IDICT;
		
		H_TITLE = PanelFig.getPropNumber() + 12;
		H_TITLE_TAG = 'H_TITLE';
		H_TITLE_CATEGORY = Category.EVANESCENT;
		H_TITLE_FORMAT = Format.HANDLE;
		
		ST_TITLE = PanelFig.getPropNumber() + 13;
		ST_TITLE_TAG = 'ST_TITLE';
		ST_TITLE_CATEGORY = Category.FIGURE;
		ST_TITLE_FORMAT = Format.ITEM;
		
		H_XLABEL = PanelFig.getPropNumber() + 14;
		H_XLABEL_TAG = 'H_XLABEL';
		H_XLABEL_CATEGORY = Category.EVANESCENT;
		H_XLABEL_FORMAT = Format.HANDLE;
		
		ST_XLABEL = PanelFig.getPropNumber() + 15;
		ST_XLABEL_TAG = 'ST_XLABEL';
		ST_XLABEL_CATEGORY = Category.FIGURE;
		ST_XLABEL_FORMAT = Format.ITEM;
		
		H_YLABEL = PanelFig.getPropNumber() + 16;
		H_YLABEL_TAG = 'H_YLABEL';
		H_YLABEL_CATEGORY = Category.EVANESCENT;
		H_YLABEL_FORMAT = Format.HANDLE;
		
		ST_YLABEL = PanelFig.getPropNumber() + 17;
		ST_YLABEL_TAG = 'ST_YLABEL';
		ST_YLABEL_CATEGORY = Category.FIGURE;
		ST_YLABEL_FORMAT = Format.ITEM;
	end
	methods % constructor
		function pf = NNClassifierMLP_CrossValidationPF_ROC(varargin)
			%NNClassifierMLP_CrossValidationPF_ROC() creates a panel receiver operating characteristic figure.
			%
			% NNClassifierMLP_CrossValidationPF_ROC(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% NNClassifierMLP_CrossValidationPF_ROC(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the panel receiver operating characteristic figure.
			%
			% CLASS = NNClassifierMLP_CrossValidationPF_ROC.GETCLASS() returns the class 'NNClassifierMLP_CrossValidationPF_ROC'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PF.GETCLASS() returns the class of the panel receiver operating characteristic figure PF.
			%  CLASS = Element.GETCLASS(PF) returns the class of 'PF'.
			%  CLASS = Element.GETCLASS('NNClassifierMLP_CrossValidationPF_ROC') returns 'NNClassifierMLP_CrossValidationPF_ROC'.
			%
			% Note that the Element.GETCLASS(PF) and Element.GETCLASS('NNClassifierMLP_CrossValidationPF_ROC')
			%  are less computationally efficient.
			
			pf_class = 'NNClassifierMLP_CrossValidationPF_ROC';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the panel receiver operating characteristic figure.
			%
			% LIST = NNClassifierMLP_CrossValidationPF_ROC.GETSUBCLASSES() returns all subclasses of 'NNClassifierMLP_CrossValidationPF_ROC'.
			%
			% Alternative forms to call this method are:
			%  LIST = PF.GETSUBCLASSES() returns all subclasses of the panel receiver operating characteristic figure PF.
			%  LIST = Element.GETSUBCLASSES(PF) returns all subclasses of 'PF'.
			%  LIST = Element.GETSUBCLASSES('NNClassifierMLP_CrossValidationPF_ROC') returns all subclasses of 'NNClassifierMLP_CrossValidationPF_ROC'.
			%
			% Note that the Element.GETSUBCLASSES(PF) and Element.GETSUBCLASSES('NNClassifierMLP_CrossValidationPF_ROC')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('NNClassifierMLP_CrossValidationPF_ROC', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of panel receiver operating characteristic figure.
			%
			% PROPS = NNClassifierMLP_CrossValidationPF_ROC.GETPROPS() returns the property list of panel receiver operating characteristic figure
			%  as a row vector.
			%
			% PROPS = NNClassifierMLP_CrossValidationPF_ROC.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PF.GETPROPS([CATEGORY]) returns the property list of the panel receiver operating characteristic figure PF.
			%  PROPS = Element.GETPROPS(PF[, CATEGORY]) returns the property list of 'PF'.
			%  PROPS = Element.GETPROPS('NNClassifierMLP_CrossValidationPF_ROC'[, CATEGORY]) returns the property list of 'NNClassifierMLP_CrossValidationPF_ROC'.
			%
			% Note that the Element.GETPROPS(PF) and Element.GETPROPS('NNClassifierMLP_CrossValidationPF_ROC')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					PanelFig.getProps() ...
						NNClassifierMLP_CrossValidationPF_ROC.H_AXES ...
						NNClassifierMLP_CrossValidationPF_ROC.ST_AXIS ...
						NNClassifierMLP_CrossValidationPF_ROC.LISTENER_ST_AXIS ...
						NNClassifierMLP_CrossValidationPF_ROC.NNCV ...
						NNClassifierMLP_CrossValidationPF_ROC.CLASSNAMES ...
						NNClassifierMLP_CrossValidationPF_ROC.X_VALUES ...
						NNClassifierMLP_CrossValidationPF_ROC.Y_VALUES ...
						NNClassifierMLP_CrossValidationPF_ROC.SETUP ...
						NNClassifierMLP_CrossValidationPF_ROC.H_ROC ...
						NNClassifierMLP_CrossValidationPF_ROC.ROC ...
						NNClassifierMLP_CrossValidationPF_ROC.ROC_DICT ...
						NNClassifierMLP_CrossValidationPF_ROC.H_TITLE ...
						NNClassifierMLP_CrossValidationPF_ROC.ST_TITLE ...
						NNClassifierMLP_CrossValidationPF_ROC.H_XLABEL ...
						NNClassifierMLP_CrossValidationPF_ROC.ST_XLABEL ...
						NNClassifierMLP_CrossValidationPF_ROC.H_YLABEL ...
						NNClassifierMLP_CrossValidationPF_ROC.ST_YLABEL ...
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
						NNClassifierMLP_CrossValidationPF_ROC.NNCV ...
						NNClassifierMLP_CrossValidationPF_ROC.CLASSNAMES ...
						NNClassifierMLP_CrossValidationPF_ROC.X_VALUES ...
						NNClassifierMLP_CrossValidationPF_ROC.Y_VALUES ...
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
						NNClassifierMLP_CrossValidationPF_ROC.SETUP ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						PanelFig.getProps(Category.EVANESCENT) ...
						NNClassifierMLP_CrossValidationPF_ROC.H_AXES ...
						NNClassifierMLP_CrossValidationPF_ROC.LISTENER_ST_AXIS ...
						NNClassifierMLP_CrossValidationPF_ROC.H_ROC ...
						NNClassifierMLP_CrossValidationPF_ROC.H_TITLE ...
						NNClassifierMLP_CrossValidationPF_ROC.H_XLABEL ...
						NNClassifierMLP_CrossValidationPF_ROC.H_YLABEL ...
						];
				case Category.FIGURE
					prop_list = [ ...
						PanelFig.getProps(Category.FIGURE) ...
						NNClassifierMLP_CrossValidationPF_ROC.ST_AXIS ...
						NNClassifierMLP_CrossValidationPF_ROC.ROC ...
						NNClassifierMLP_CrossValidationPF_ROC.ROC_DICT ...
						NNClassifierMLP_CrossValidationPF_ROC.ST_TITLE ...
						NNClassifierMLP_CrossValidationPF_ROC.ST_XLABEL ...
						NNClassifierMLP_CrossValidationPF_ROC.ST_YLABEL ...
						];
				case Category.GUI
					prop_list = [ ...
						PanelFig.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of panel receiver operating characteristic figure.
			%
			% N = NNClassifierMLP_CrossValidationPF_ROC.GETPROPNUMBER() returns the property number of panel receiver operating characteristic figure.
			%
			% N = NNClassifierMLP_CrossValidationPF_ROC.GETPROPNUMBER(CATEGORY) returns the property number of panel receiver operating characteristic figure
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PF.GETPROPNUMBER([CATEGORY]) returns the property number of the panel receiver operating characteristic figure PF.
			%  N = Element.GETPROPNUMBER(PF) returns the property number of 'PF'.
			%  N = Element.GETPROPNUMBER('NNClassifierMLP_CrossValidationPF_ROC') returns the property number of 'NNClassifierMLP_CrossValidationPF_ROC'.
			%
			% Note that the Element.GETPROPNUMBER(PF) and Element.GETPROPNUMBER('NNClassifierMLP_CrossValidationPF_ROC')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(NNClassifierMLP_CrossValidationPF_ROC.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in panel receiver operating characteristic figure/error.
			%
			% CHECK = NNClassifierMLP_CrossValidationPF_ROC.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSPROP(PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(PF, PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(NNClassifierMLP_CrossValidationPF_ROC, PROP) checks whether PROP exists for NNClassifierMLP_CrossValidationPF_ROC.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:NNClassifierMLP_CrossValidationPF_ROC:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSPROP(PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:NNClassifierMLP_CrossValidationPF_ROC:WrongInput]
			%  Element.EXISTSPROP(PF, PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:NNClassifierMLP_CrossValidationPF_ROC:WrongInput]
			%  Element.EXISTSPROP(NNClassifierMLP_CrossValidationPF_ROC, PROP) throws error if PROP does NOT exist for NNClassifierMLP_CrossValidationPF_ROC.
			%   Error id: [BRAPH2:NNClassifierMLP_CrossValidationPF_ROC:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PF) and Element.EXISTSPROP('NNClassifierMLP_CrossValidationPF_ROC')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == NNClassifierMLP_CrossValidationPF_ROC.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNClassifierMLP_CrossValidationPF_ROC:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNClassifierMLP_CrossValidationPF_ROC:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for NNClassifierMLP_CrossValidationPF_ROC.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in panel receiver operating characteristic figure/error.
			%
			% CHECK = NNClassifierMLP_CrossValidationPF_ROC.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSTAG(TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(PF, TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(NNClassifierMLP_CrossValidationPF_ROC, TAG) checks whether TAG exists for NNClassifierMLP_CrossValidationPF_ROC.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:NNClassifierMLP_CrossValidationPF_ROC:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSTAG(TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:NNClassifierMLP_CrossValidationPF_ROC:WrongInput]
			%  Element.EXISTSTAG(PF, TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:NNClassifierMLP_CrossValidationPF_ROC:WrongInput]
			%  Element.EXISTSTAG(NNClassifierMLP_CrossValidationPF_ROC, TAG) throws error if TAG does NOT exist for NNClassifierMLP_CrossValidationPF_ROC.
			%   Error id: [BRAPH2:NNClassifierMLP_CrossValidationPF_ROC:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PF) and Element.EXISTSTAG('NNClassifierMLP_CrossValidationPF_ROC')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			nnclassifiermlp_crossvalidationpf_roc_tag_list = cellfun(@(x) NNClassifierMLP_CrossValidationPF_ROC.getPropTag(x), num2cell(NNClassifierMLP_CrossValidationPF_ROC.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, nnclassifiermlp_crossvalidationpf_roc_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNClassifierMLP_CrossValidationPF_ROC:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNClassifierMLP_CrossValidationPF_ROC:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for NNClassifierMLP_CrossValidationPF_ROC.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(NNClassifierMLP_CrossValidationPF_ROC, POINTER) returns property number of POINTER of NNClassifierMLP_CrossValidationPF_ROC.
			%  PROPERTY = PF.GETPROPPROP(NNClassifierMLP_CrossValidationPF_ROC, POINTER) returns property number of POINTER of NNClassifierMLP_CrossValidationPF_ROC.
			%
			% Note that the Element.GETPROPPROP(PF) and Element.GETPROPPROP('NNClassifierMLP_CrossValidationPF_ROC')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				nnclassifiermlp_crossvalidationpf_roc_tag_list = cellfun(@(x) NNClassifierMLP_CrossValidationPF_ROC.getPropTag(x), num2cell(NNClassifierMLP_CrossValidationPF_ROC.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, nnclassifiermlp_crossvalidationpf_roc_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(NNClassifierMLP_CrossValidationPF_ROC, POINTER) returns tag of POINTER of NNClassifierMLP_CrossValidationPF_ROC.
			%  TAG = PF.GETPROPTAG(NNClassifierMLP_CrossValidationPF_ROC, POINTER) returns tag of POINTER of NNClassifierMLP_CrossValidationPF_ROC.
			%
			% Note that the Element.GETPROPTAG(PF) and Element.GETPROPTAG('NNClassifierMLP_CrossValidationPF_ROC')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case NNClassifierMLP_CrossValidationPF_ROC.H_AXES
						tag = NNClassifierMLP_CrossValidationPF_ROC.H_AXES_TAG;
					case NNClassifierMLP_CrossValidationPF_ROC.ST_AXIS
						tag = NNClassifierMLP_CrossValidationPF_ROC.ST_AXIS_TAG;
					case NNClassifierMLP_CrossValidationPF_ROC.LISTENER_ST_AXIS
						tag = NNClassifierMLP_CrossValidationPF_ROC.LISTENER_ST_AXIS_TAG;
					case NNClassifierMLP_CrossValidationPF_ROC.NNCV
						tag = NNClassifierMLP_CrossValidationPF_ROC.NNCV_TAG;
					case NNClassifierMLP_CrossValidationPF_ROC.CLASSNAMES
						tag = NNClassifierMLP_CrossValidationPF_ROC.CLASSNAMES_TAG;
					case NNClassifierMLP_CrossValidationPF_ROC.X_VALUES
						tag = NNClassifierMLP_CrossValidationPF_ROC.X_VALUES_TAG;
					case NNClassifierMLP_CrossValidationPF_ROC.Y_VALUES
						tag = NNClassifierMLP_CrossValidationPF_ROC.Y_VALUES_TAG;
					case NNClassifierMLP_CrossValidationPF_ROC.SETUP
						tag = NNClassifierMLP_CrossValidationPF_ROC.SETUP_TAG;
					case NNClassifierMLP_CrossValidationPF_ROC.H_ROC
						tag = NNClassifierMLP_CrossValidationPF_ROC.H_ROC_TAG;
					case NNClassifierMLP_CrossValidationPF_ROC.ROC
						tag = NNClassifierMLP_CrossValidationPF_ROC.ROC_TAG;
					case NNClassifierMLP_CrossValidationPF_ROC.ROC_DICT
						tag = NNClassifierMLP_CrossValidationPF_ROC.ROC_DICT_TAG;
					case NNClassifierMLP_CrossValidationPF_ROC.H_TITLE
						tag = NNClassifierMLP_CrossValidationPF_ROC.H_TITLE_TAG;
					case NNClassifierMLP_CrossValidationPF_ROC.ST_TITLE
						tag = NNClassifierMLP_CrossValidationPF_ROC.ST_TITLE_TAG;
					case NNClassifierMLP_CrossValidationPF_ROC.H_XLABEL
						tag = NNClassifierMLP_CrossValidationPF_ROC.H_XLABEL_TAG;
					case NNClassifierMLP_CrossValidationPF_ROC.ST_XLABEL
						tag = NNClassifierMLP_CrossValidationPF_ROC.ST_XLABEL_TAG;
					case NNClassifierMLP_CrossValidationPF_ROC.H_YLABEL
						tag = NNClassifierMLP_CrossValidationPF_ROC.H_YLABEL_TAG;
					case NNClassifierMLP_CrossValidationPF_ROC.ST_YLABEL
						tag = NNClassifierMLP_CrossValidationPF_ROC.ST_YLABEL_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(NNClassifierMLP_CrossValidationPF_ROC, POINTER) returns category of POINTER of NNClassifierMLP_CrossValidationPF_ROC.
			%  CATEGORY = PF.GETPROPCATEGORY(NNClassifierMLP_CrossValidationPF_ROC, POINTER) returns category of POINTER of NNClassifierMLP_CrossValidationPF_ROC.
			%
			% Note that the Element.GETPROPCATEGORY(PF) and Element.GETPROPCATEGORY('NNClassifierMLP_CrossValidationPF_ROC')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = NNClassifierMLP_CrossValidationPF_ROC.getPropProp(pointer);
			
			switch prop
				case NNClassifierMLP_CrossValidationPF_ROC.H_AXES
					prop_category = NNClassifierMLP_CrossValidationPF_ROC.H_AXES_CATEGORY;
				case NNClassifierMLP_CrossValidationPF_ROC.ST_AXIS
					prop_category = NNClassifierMLP_CrossValidationPF_ROC.ST_AXIS_CATEGORY;
				case NNClassifierMLP_CrossValidationPF_ROC.LISTENER_ST_AXIS
					prop_category = NNClassifierMLP_CrossValidationPF_ROC.LISTENER_ST_AXIS_CATEGORY;
				case NNClassifierMLP_CrossValidationPF_ROC.NNCV
					prop_category = NNClassifierMLP_CrossValidationPF_ROC.NNCV_CATEGORY;
				case NNClassifierMLP_CrossValidationPF_ROC.CLASSNAMES
					prop_category = NNClassifierMLP_CrossValidationPF_ROC.CLASSNAMES_CATEGORY;
				case NNClassifierMLP_CrossValidationPF_ROC.X_VALUES
					prop_category = NNClassifierMLP_CrossValidationPF_ROC.X_VALUES_CATEGORY;
				case NNClassifierMLP_CrossValidationPF_ROC.Y_VALUES
					prop_category = NNClassifierMLP_CrossValidationPF_ROC.Y_VALUES_CATEGORY;
				case NNClassifierMLP_CrossValidationPF_ROC.SETUP
					prop_category = NNClassifierMLP_CrossValidationPF_ROC.SETUP_CATEGORY;
				case NNClassifierMLP_CrossValidationPF_ROC.H_ROC
					prop_category = NNClassifierMLP_CrossValidationPF_ROC.H_ROC_CATEGORY;
				case NNClassifierMLP_CrossValidationPF_ROC.ROC
					prop_category = NNClassifierMLP_CrossValidationPF_ROC.ROC_CATEGORY;
				case NNClassifierMLP_CrossValidationPF_ROC.ROC_DICT
					prop_category = NNClassifierMLP_CrossValidationPF_ROC.ROC_DICT_CATEGORY;
				case NNClassifierMLP_CrossValidationPF_ROC.H_TITLE
					prop_category = NNClassifierMLP_CrossValidationPF_ROC.H_TITLE_CATEGORY;
				case NNClassifierMLP_CrossValidationPF_ROC.ST_TITLE
					prop_category = NNClassifierMLP_CrossValidationPF_ROC.ST_TITLE_CATEGORY;
				case NNClassifierMLP_CrossValidationPF_ROC.H_XLABEL
					prop_category = NNClassifierMLP_CrossValidationPF_ROC.H_XLABEL_CATEGORY;
				case NNClassifierMLP_CrossValidationPF_ROC.ST_XLABEL
					prop_category = NNClassifierMLP_CrossValidationPF_ROC.ST_XLABEL_CATEGORY;
				case NNClassifierMLP_CrossValidationPF_ROC.H_YLABEL
					prop_category = NNClassifierMLP_CrossValidationPF_ROC.H_YLABEL_CATEGORY;
				case NNClassifierMLP_CrossValidationPF_ROC.ST_YLABEL
					prop_category = NNClassifierMLP_CrossValidationPF_ROC.ST_YLABEL_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(NNClassifierMLP_CrossValidationPF_ROC, POINTER) returns format of POINTER of NNClassifierMLP_CrossValidationPF_ROC.
			%  FORMAT = PF.GETPROPFORMAT(NNClassifierMLP_CrossValidationPF_ROC, POINTER) returns format of POINTER of NNClassifierMLP_CrossValidationPF_ROC.
			%
			% Note that the Element.GETPROPFORMAT(PF) and Element.GETPROPFORMAT('NNClassifierMLP_CrossValidationPF_ROC')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = NNClassifierMLP_CrossValidationPF_ROC.getPropProp(pointer);
			
			switch prop
				case NNClassifierMLP_CrossValidationPF_ROC.H_AXES
					prop_format = NNClassifierMLP_CrossValidationPF_ROC.H_AXES_FORMAT;
				case NNClassifierMLP_CrossValidationPF_ROC.ST_AXIS
					prop_format = NNClassifierMLP_CrossValidationPF_ROC.ST_AXIS_FORMAT;
				case NNClassifierMLP_CrossValidationPF_ROC.LISTENER_ST_AXIS
					prop_format = NNClassifierMLP_CrossValidationPF_ROC.LISTENER_ST_AXIS_FORMAT;
				case NNClassifierMLP_CrossValidationPF_ROC.NNCV
					prop_format = NNClassifierMLP_CrossValidationPF_ROC.NNCV_FORMAT;
				case NNClassifierMLP_CrossValidationPF_ROC.CLASSNAMES
					prop_format = NNClassifierMLP_CrossValidationPF_ROC.CLASSNAMES_FORMAT;
				case NNClassifierMLP_CrossValidationPF_ROC.X_VALUES
					prop_format = NNClassifierMLP_CrossValidationPF_ROC.X_VALUES_FORMAT;
				case NNClassifierMLP_CrossValidationPF_ROC.Y_VALUES
					prop_format = NNClassifierMLP_CrossValidationPF_ROC.Y_VALUES_FORMAT;
				case NNClassifierMLP_CrossValidationPF_ROC.SETUP
					prop_format = NNClassifierMLP_CrossValidationPF_ROC.SETUP_FORMAT;
				case NNClassifierMLP_CrossValidationPF_ROC.H_ROC
					prop_format = NNClassifierMLP_CrossValidationPF_ROC.H_ROC_FORMAT;
				case NNClassifierMLP_CrossValidationPF_ROC.ROC
					prop_format = NNClassifierMLP_CrossValidationPF_ROC.ROC_FORMAT;
				case NNClassifierMLP_CrossValidationPF_ROC.ROC_DICT
					prop_format = NNClassifierMLP_CrossValidationPF_ROC.ROC_DICT_FORMAT;
				case NNClassifierMLP_CrossValidationPF_ROC.H_TITLE
					prop_format = NNClassifierMLP_CrossValidationPF_ROC.H_TITLE_FORMAT;
				case NNClassifierMLP_CrossValidationPF_ROC.ST_TITLE
					prop_format = NNClassifierMLP_CrossValidationPF_ROC.ST_TITLE_FORMAT;
				case NNClassifierMLP_CrossValidationPF_ROC.H_XLABEL
					prop_format = NNClassifierMLP_CrossValidationPF_ROC.H_XLABEL_FORMAT;
				case NNClassifierMLP_CrossValidationPF_ROC.ST_XLABEL
					prop_format = NNClassifierMLP_CrossValidationPF_ROC.ST_XLABEL_FORMAT;
				case NNClassifierMLP_CrossValidationPF_ROC.H_YLABEL
					prop_format = NNClassifierMLP_CrossValidationPF_ROC.H_YLABEL_FORMAT;
				case NNClassifierMLP_CrossValidationPF_ROC.ST_YLABEL
					prop_format = NNClassifierMLP_CrossValidationPF_ROC.ST_YLABEL_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(NNClassifierMLP_CrossValidationPF_ROC, POINTER) returns description of POINTER of NNClassifierMLP_CrossValidationPF_ROC.
			%  DESCRIPTION = PF.GETPROPDESCRIPTION(NNClassifierMLP_CrossValidationPF_ROC, POINTER) returns description of POINTER of NNClassifierMLP_CrossValidationPF_ROC.
			%
			% Note that the Element.GETPROPDESCRIPTION(PF) and Element.GETPROPDESCRIPTION('NNClassifierMLP_CrossValidationPF_ROC')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = NNClassifierMLP_CrossValidationPF_ROC.getPropProp(pointer);
			
			switch prop
				case NNClassifierMLP_CrossValidationPF_ROC.H_AXES
					prop_description = 'H_AXES (evanescent, handle) is the handle for the axes.';
				case NNClassifierMLP_CrossValidationPF_ROC.ST_AXIS
					prop_description = 'ST_AXIS (figure, item) determines the axis settings.';
				case NNClassifierMLP_CrossValidationPF_ROC.LISTENER_ST_AXIS
					prop_description = 'LISTENER_ST_AXIS (evanescent, handle) contains the listener to the axis settings to update the pushbuttons.';
				case NNClassifierMLP_CrossValidationPF_ROC.NNCV
					prop_description = 'NNCV (metadata, item) is the cross-validation.';
				case NNClassifierMLP_CrossValidationPF_ROC.CLASSNAMES
					prop_description = 'CLASSNAMES (metadata, stringlist) is the class names.';
				case NNClassifierMLP_CrossValidationPF_ROC.X_VALUES
					prop_description = 'X_VALUES (metadata, matrix) gets the x values for receiver operating characteristic curves.';
				case NNClassifierMLP_CrossValidationPF_ROC.Y_VALUES
					prop_description = 'Y_VALUES (metadata, matrix) gets the y values for receiver operating characteristic curves.';
				case NNClassifierMLP_CrossValidationPF_ROC.SETUP
					prop_description = 'SETUP (query, empty) initializes the receiver operating characteristic figure.';
				case NNClassifierMLP_CrossValidationPF_ROC.H_ROC
					prop_description = 'H_ROC (evanescent, handlelist) is the set of handles for the ROC plots.';
				case NNClassifierMLP_CrossValidationPF_ROC.ROC
					prop_description = 'ROC (figure, logical) determines whether the ROC plots are shown.';
				case NNClassifierMLP_CrossValidationPF_ROC.ROC_DICT
					prop_description = 'ROC_DICT (figure, idict) contains the ROC plots for each class.';
				case NNClassifierMLP_CrossValidationPF_ROC.H_TITLE
					prop_description = 'H_TITLE (evanescent, handle) is the axis title.';
				case NNClassifierMLP_CrossValidationPF_ROC.ST_TITLE
					prop_description = 'ST_TITLE (figure, item) determines the title settings.';
				case NNClassifierMLP_CrossValidationPF_ROC.H_XLABEL
					prop_description = 'H_XLABEL (evanescent, handle) is the axis x-label.';
				case NNClassifierMLP_CrossValidationPF_ROC.ST_XLABEL
					prop_description = 'ST_XLABEL (figure, item) determines the x-label settings.';
				case NNClassifierMLP_CrossValidationPF_ROC.H_YLABEL
					prop_description = 'H_YLABEL (evanescent, handle) is the axis y-label.';
				case NNClassifierMLP_CrossValidationPF_ROC.ST_YLABEL
					prop_description = 'ST_YLABEL (figure, item) determines the y-label settings.';
				case NNClassifierMLP_CrossValidationPF_ROC.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the panel for receiver operating characteristic figure.';
				case NNClassifierMLP_CrossValidationPF_ROC.NAME
					prop_description = 'NAME (constant, string) is the name of the panel for receiver operating characteristic figure.';
				case NNClassifierMLP_CrossValidationPF_ROC.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the panel for receiver operating characteristic figure.';
				case NNClassifierMLP_CrossValidationPF_ROC.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the panel for receiver operating characteristic figure.';
				case NNClassifierMLP_CrossValidationPF_ROC.ID
					prop_description = 'ID (data, string) is a few-letter code for the panel for receiver operating characteristic figure.';
				case NNClassifierMLP_CrossValidationPF_ROC.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the panel for receiver operating characteristic figure.';
				case NNClassifierMLP_CrossValidationPF_ROC.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the panel for receiver operating characteristic figure.';
				case NNClassifierMLP_CrossValidationPF_ROC.DRAW
					prop_description = 'DRAW (query, logical) draws the receiver operating characteristic figure.';
				case NNClassifierMLP_CrossValidationPF_ROC.DELETE
					prop_description = 'DELETE (query, logical) resets the handles when the panel figure graph is deleted.';
				case NNClassifierMLP_CrossValidationPF_ROC.H_TOOLS
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
			%  SETTINGS = Element.GETPROPSETTINGS(NNClassifierMLP_CrossValidationPF_ROC, POINTER) returns settings of POINTER of NNClassifierMLP_CrossValidationPF_ROC.
			%  SETTINGS = PF.GETPROPSETTINGS(NNClassifierMLP_CrossValidationPF_ROC, POINTER) returns settings of POINTER of NNClassifierMLP_CrossValidationPF_ROC.
			%
			% Note that the Element.GETPROPSETTINGS(PF) and Element.GETPROPSETTINGS('NNClassifierMLP_CrossValidationPF_ROC')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = NNClassifierMLP_CrossValidationPF_ROC.getPropProp(pointer);
			
			switch prop
				case NNClassifierMLP_CrossValidationPF_ROC.H_AXES
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case NNClassifierMLP_CrossValidationPF_ROC.ST_AXIS
					prop_settings = 'SettingsAxis';
				case NNClassifierMLP_CrossValidationPF_ROC.LISTENER_ST_AXIS
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case NNClassifierMLP_CrossValidationPF_ROC.NNCV
					prop_settings = 'NNClassifierMLP_CrossValidation';
				case NNClassifierMLP_CrossValidationPF_ROC.CLASSNAMES
					prop_settings = Format.getFormatSettings(Format.STRINGLIST);
				case NNClassifierMLP_CrossValidationPF_ROC.X_VALUES
					prop_settings = Format.getFormatSettings(Format.MATRIX);
				case NNClassifierMLP_CrossValidationPF_ROC.Y_VALUES
					prop_settings = Format.getFormatSettings(Format.MATRIX);
				case NNClassifierMLP_CrossValidationPF_ROC.SETUP
					prop_settings = Format.getFormatSettings(Format.EMPTY);
				case NNClassifierMLP_CrossValidationPF_ROC.H_ROC
					prop_settings = Format.getFormatSettings(Format.HANDLELIST);
				case NNClassifierMLP_CrossValidationPF_ROC.ROC
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case NNClassifierMLP_CrossValidationPF_ROC.ROC_DICT
					prop_settings = 'SettingsLine';
				case NNClassifierMLP_CrossValidationPF_ROC.H_TITLE
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case NNClassifierMLP_CrossValidationPF_ROC.ST_TITLE
					prop_settings = 'SettingsText';
				case NNClassifierMLP_CrossValidationPF_ROC.H_XLABEL
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case NNClassifierMLP_CrossValidationPF_ROC.ST_XLABEL
					prop_settings = 'SettingsText';
				case NNClassifierMLP_CrossValidationPF_ROC.H_YLABEL
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case NNClassifierMLP_CrossValidationPF_ROC.ST_YLABEL
					prop_settings = 'SettingsText';
				case NNClassifierMLP_CrossValidationPF_ROC.TEMPLATE
					prop_settings = 'NNClassifierMLP_CrossValidationPF_ROC';
				otherwise
					prop_settings = getPropSettings@PanelFig(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = NNClassifierMLP_CrossValidationPF_ROC.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = NNClassifierMLP_CrossValidationPF_ROC.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULT(NNClassifierMLP_CrossValidationPF_ROC, POINTER) returns the default value of POINTER of NNClassifierMLP_CrossValidationPF_ROC.
			%  DEFAULT = PF.GETPROPDEFAULT(NNClassifierMLP_CrossValidationPF_ROC, POINTER) returns the default value of POINTER of NNClassifierMLP_CrossValidationPF_ROC.
			%
			% Note that the Element.GETPROPDEFAULT(PF) and Element.GETPROPDEFAULT('NNClassifierMLP_CrossValidationPF_ROC')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNClassifierMLP_CrossValidationPF_ROC.getPropProp(pointer);
			
			switch prop
				case NNClassifierMLP_CrossValidationPF_ROC.H_AXES
					prop_default = Format.getFormatDefault(Format.HANDLE, NNClassifierMLP_CrossValidationPF_ROC.getPropSettings(prop));
				case NNClassifierMLP_CrossValidationPF_ROC.ST_AXIS
					prop_default = SettingsAxis('AXIS', true, 'GRID', false, 'EQUAL', false);
				case NNClassifierMLP_CrossValidationPF_ROC.LISTENER_ST_AXIS
					prop_default = Format.getFormatDefault(Format.HANDLE, NNClassifierMLP_CrossValidationPF_ROC.getPropSettings(prop));
				case NNClassifierMLP_CrossValidationPF_ROC.NNCV
					prop_default = Format.getFormatDefault(Format.ITEM, NNClassifierMLP_CrossValidationPF_ROC.getPropSettings(prop));
				case NNClassifierMLP_CrossValidationPF_ROC.CLASSNAMES
					prop_default = Format.getFormatDefault(Format.STRINGLIST, NNClassifierMLP_CrossValidationPF_ROC.getPropSettings(prop));
				case NNClassifierMLP_CrossValidationPF_ROC.X_VALUES
					prop_default = Format.getFormatDefault(Format.MATRIX, NNClassifierMLP_CrossValidationPF_ROC.getPropSettings(prop));
				case NNClassifierMLP_CrossValidationPF_ROC.Y_VALUES
					prop_default = Format.getFormatDefault(Format.MATRIX, NNClassifierMLP_CrossValidationPF_ROC.getPropSettings(prop));
				case NNClassifierMLP_CrossValidationPF_ROC.SETUP
					prop_default = Format.getFormatDefault(Format.EMPTY, NNClassifierMLP_CrossValidationPF_ROC.getPropSettings(prop));
				case NNClassifierMLP_CrossValidationPF_ROC.H_ROC
					prop_default = Format.getFormatDefault(Format.HANDLELIST, NNClassifierMLP_CrossValidationPF_ROC.getPropSettings(prop));
				case NNClassifierMLP_CrossValidationPF_ROC.ROC
					prop_default = true;
				case NNClassifierMLP_CrossValidationPF_ROC.ROC_DICT
					prop_default = Format.getFormatDefault(Format.IDICT, NNClassifierMLP_CrossValidationPF_ROC.getPropSettings(prop));
				case NNClassifierMLP_CrossValidationPF_ROC.H_TITLE
					prop_default = Format.getFormatDefault(Format.HANDLE, NNClassifierMLP_CrossValidationPF_ROC.getPropSettings(prop));
				case NNClassifierMLP_CrossValidationPF_ROC.ST_TITLE
					prop_default = SettingsText('VISIBLE', true, 'FONTSIZE', s(2), 'HALIGN', 'center', 'VALIGN', 'middle');
				case NNClassifierMLP_CrossValidationPF_ROC.H_XLABEL
					prop_default = Format.getFormatDefault(Format.HANDLE, NNClassifierMLP_CrossValidationPF_ROC.getPropSettings(prop));
				case NNClassifierMLP_CrossValidationPF_ROC.ST_XLABEL
					prop_default = SettingsText('VISIBLE', true, 'FONTSIZE', s(2), 'HALIGN', 'center', 'VALIGN', 'middle');
				case NNClassifierMLP_CrossValidationPF_ROC.H_YLABEL
					prop_default = Format.getFormatDefault(Format.HANDLE, NNClassifierMLP_CrossValidationPF_ROC.getPropSettings(prop));
				case NNClassifierMLP_CrossValidationPF_ROC.ST_YLABEL
					prop_default = SettingsText('VISIBLE', true, 'FONTSIZE', s(2), 'HALIGN', 'center', 'VALIGN', 'middle', 'ROTATION', 90);
				case NNClassifierMLP_CrossValidationPF_ROC.ELCLASS
					prop_default = 'NNClassifierMLP_CrossValidationPF_ROC';
				case NNClassifierMLP_CrossValidationPF_ROC.NAME
					prop_default = 'ROC Panel for Cross-Validation MLP Classifier';
				case NNClassifierMLP_CrossValidationPF_ROC.DESCRIPTION
					prop_default = 'The receiver operating characteristic panel for cross-validation MLP classifier (NNClassifierMLP_CrossValidationPF_ROC) manages the functionalities to plot a panel of the receiver operating characteristic curves.';
				case NNClassifierMLP_CrossValidationPF_ROC.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, NNClassifierMLP_CrossValidationPF_ROC.getPropSettings(prop));
				case NNClassifierMLP_CrossValidationPF_ROC.ID
					prop_default = 'NNClassifierMLP_CrossValidationPF_ROC ID';
				case NNClassifierMLP_CrossValidationPF_ROC.LABEL
					prop_default = 'NNClassifierMLP_CrossValidationPF_ROC label';
				case NNClassifierMLP_CrossValidationPF_ROC.NOTES
					prop_default = 'NNClassifierMLP_CrossValidationPF_ROC notes';
				otherwise
					prop_default = getPropDefault@PanelFig(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = NNClassifierMLP_CrossValidationPF_ROC.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = NNClassifierMLP_CrossValidationPF_ROC.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(NNClassifierMLP_CrossValidationPF_ROC, POINTER) returns the conditioned default value of POINTER of NNClassifierMLP_CrossValidationPF_ROC.
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(NNClassifierMLP_CrossValidationPF_ROC, POINTER) returns the conditioned default value of POINTER of NNClassifierMLP_CrossValidationPF_ROC.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PF) and Element.GETPROPDEFAULTCONDITIONED('NNClassifierMLP_CrossValidationPF_ROC')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = NNClassifierMLP_CrossValidationPF_ROC.getPropProp(pointer);
			
			prop_default = NNClassifierMLP_CrossValidationPF_ROC.conditioning(prop, NNClassifierMLP_CrossValidationPF_ROC.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(NNClassifierMLP_CrossValidationPF_ROC, PROP, VALUE) checks VALUE format for PROP of NNClassifierMLP_CrossValidationPF_ROC.
			%  CHECK = PF.CHECKPROP(NNClassifierMLP_CrossValidationPF_ROC, PROP, VALUE) checks VALUE format for PROP of NNClassifierMLP_CrossValidationPF_ROC.
			% 
			% PF.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:NNClassifierMLP_CrossValidationPF_ROC:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PF.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PF.
			%   Error id: €BRAPH2.STR€:NNClassifierMLP_CrossValidationPF_ROC:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(NNClassifierMLP_CrossValidationPF_ROC, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNClassifierMLP_CrossValidationPF_ROC.
			%   Error id: €BRAPH2.STR€:NNClassifierMLP_CrossValidationPF_ROC:€BRAPH2.WRONG_INPUT€
			%  PF.CHECKPROP(NNClassifierMLP_CrossValidationPF_ROC, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNClassifierMLP_CrossValidationPF_ROC.
			%   Error id: €BRAPH2.STR€:NNClassifierMLP_CrossValidationPF_ROC:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PF) and Element.CHECKPROP('NNClassifierMLP_CrossValidationPF_ROC')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = NNClassifierMLP_CrossValidationPF_ROC.getPropProp(pointer);
			
			switch prop
				case NNClassifierMLP_CrossValidationPF_ROC.H_AXES % __NNClassifierMLP_CrossValidationPF_ROC.H_AXES__
					check = Format.checkFormat(Format.HANDLE, value, NNClassifierMLP_CrossValidationPF_ROC.getPropSettings(prop));
				case NNClassifierMLP_CrossValidationPF_ROC.ST_AXIS % __NNClassifierMLP_CrossValidationPF_ROC.ST_AXIS__
					check = Format.checkFormat(Format.ITEM, value, NNClassifierMLP_CrossValidationPF_ROC.getPropSettings(prop));
				case NNClassifierMLP_CrossValidationPF_ROC.LISTENER_ST_AXIS % __NNClassifierMLP_CrossValidationPF_ROC.LISTENER_ST_AXIS__
					check = Format.checkFormat(Format.HANDLE, value, NNClassifierMLP_CrossValidationPF_ROC.getPropSettings(prop));
				case NNClassifierMLP_CrossValidationPF_ROC.NNCV % __NNClassifierMLP_CrossValidationPF_ROC.NNCV__
					check = Format.checkFormat(Format.ITEM, value, NNClassifierMLP_CrossValidationPF_ROC.getPropSettings(prop));
				case NNClassifierMLP_CrossValidationPF_ROC.CLASSNAMES % __NNClassifierMLP_CrossValidationPF_ROC.CLASSNAMES__
					check = Format.checkFormat(Format.STRINGLIST, value, NNClassifierMLP_CrossValidationPF_ROC.getPropSettings(prop));
				case NNClassifierMLP_CrossValidationPF_ROC.X_VALUES % __NNClassifierMLP_CrossValidationPF_ROC.X_VALUES__
					check = Format.checkFormat(Format.MATRIX, value, NNClassifierMLP_CrossValidationPF_ROC.getPropSettings(prop));
				case NNClassifierMLP_CrossValidationPF_ROC.Y_VALUES % __NNClassifierMLP_CrossValidationPF_ROC.Y_VALUES__
					check = Format.checkFormat(Format.MATRIX, value, NNClassifierMLP_CrossValidationPF_ROC.getPropSettings(prop));
				case NNClassifierMLP_CrossValidationPF_ROC.SETUP % __NNClassifierMLP_CrossValidationPF_ROC.SETUP__
					check = Format.checkFormat(Format.EMPTY, value, NNClassifierMLP_CrossValidationPF_ROC.getPropSettings(prop));
				case NNClassifierMLP_CrossValidationPF_ROC.H_ROC % __NNClassifierMLP_CrossValidationPF_ROC.H_ROC__
					check = Format.checkFormat(Format.HANDLELIST, value, NNClassifierMLP_CrossValidationPF_ROC.getPropSettings(prop));
				case NNClassifierMLP_CrossValidationPF_ROC.ROC % __NNClassifierMLP_CrossValidationPF_ROC.ROC__
					check = Format.checkFormat(Format.LOGICAL, value, NNClassifierMLP_CrossValidationPF_ROC.getPropSettings(prop));
				case NNClassifierMLP_CrossValidationPF_ROC.ROC_DICT % __NNClassifierMLP_CrossValidationPF_ROC.ROC_DICT__
					check = Format.checkFormat(Format.IDICT, value, NNClassifierMLP_CrossValidationPF_ROC.getPropSettings(prop));
				case NNClassifierMLP_CrossValidationPF_ROC.H_TITLE % __NNClassifierMLP_CrossValidationPF_ROC.H_TITLE__
					check = Format.checkFormat(Format.HANDLE, value, NNClassifierMLP_CrossValidationPF_ROC.getPropSettings(prop));
				case NNClassifierMLP_CrossValidationPF_ROC.ST_TITLE % __NNClassifierMLP_CrossValidationPF_ROC.ST_TITLE__
					check = Format.checkFormat(Format.ITEM, value, NNClassifierMLP_CrossValidationPF_ROC.getPropSettings(prop));
				case NNClassifierMLP_CrossValidationPF_ROC.H_XLABEL % __NNClassifierMLP_CrossValidationPF_ROC.H_XLABEL__
					check = Format.checkFormat(Format.HANDLE, value, NNClassifierMLP_CrossValidationPF_ROC.getPropSettings(prop));
				case NNClassifierMLP_CrossValidationPF_ROC.ST_XLABEL % __NNClassifierMLP_CrossValidationPF_ROC.ST_XLABEL__
					check = Format.checkFormat(Format.ITEM, value, NNClassifierMLP_CrossValidationPF_ROC.getPropSettings(prop));
				case NNClassifierMLP_CrossValidationPF_ROC.H_YLABEL % __NNClassifierMLP_CrossValidationPF_ROC.H_YLABEL__
					check = Format.checkFormat(Format.HANDLE, value, NNClassifierMLP_CrossValidationPF_ROC.getPropSettings(prop));
				case NNClassifierMLP_CrossValidationPF_ROC.ST_YLABEL % __NNClassifierMLP_CrossValidationPF_ROC.ST_YLABEL__
					check = Format.checkFormat(Format.ITEM, value, NNClassifierMLP_CrossValidationPF_ROC.getPropSettings(prop));
				case NNClassifierMLP_CrossValidationPF_ROC.TEMPLATE % __NNClassifierMLP_CrossValidationPF_ROC.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, NNClassifierMLP_CrossValidationPF_ROC.getPropSettings(prop));
				otherwise
					if prop <= PanelFig.getPropNumber()
						check = checkProp@PanelFig(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNClassifierMLP_CrossValidationPF_ROC:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNClassifierMLP_CrossValidationPF_ROC:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' NNClassifierMLP_CrossValidationPF_ROC.getPropTag(prop) ' (' NNClassifierMLP_CrossValidationPF_ROC.getFormatTag(NNClassifierMLP_CrossValidationPF_ROC.getPropFormat(prop)) ').'] ...
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
				case NNClassifierMLP_CrossValidationPF_ROC.ST_AXIS % __NNClassifierMLP_CrossValidationPF_ROC.ST_AXIS__
					if pf.get('DRAWN')
					    toolbar = pf.get('H_TOOLBAR');
					    if check_graphics(toolbar, 'uitoolbar')
					        set(findobj(toolbar, 'Tag', 'TOOL.Grid'), 'State', pf.get('ST_AXIS').get('GRID'))
					        set(findobj(toolbar, 'Tag', 'TOOL.Axis'), 'State', pf.get('ST_AXIS').get('AXIS'))
					    end
					end
					
				case NNClassifierMLP_CrossValidationPF_ROC.CLASSNAMES % __NNClassifierMLP_CrossValidationPF_ROC.CLASSNAMES__
					if isempty(pf.getr('CLASSNAMES')) && ~isa(pf.get('NNCV').getr('NN_LIST'), 'NoValue')
					    pf.set('CLASSNAMES', cellstr(pf.memorize('NNCV').get('NN_LIST_IT', 1).get('MODEL').Layers(end).Classes));
					end
					
				case NNClassifierMLP_CrossValidationPF_ROC.X_VALUES % __NNClassifierMLP_CrossValidationPF_ROC.X_VALUES__
					if isequal(pf.getr('X_VALUES'), []) && ~isa(pf.get('NNCV').getr('NN_LIST'), 'NoValue')
					    class_names = pf.get('CLASSNAMES');
					    kfolds = pf.get('NNCV').get('KFOLDS');
					    predictions_folds = cellfun(@(nn, nne) cell2mat(nn.get('PREDICT', nne.get('D'))), pf.get('NNCV').get('NN_LIST'), pf.get('NNCV').get('EVALUATOR_LIST'), 'UniformOutput', false);
					    ground_truth_folds = cellfun(@(nne) nne.get('GROUND_TRUTH'), pf.get('NNCV').get('EVALUATOR_LIST'), 'UniformOutput', false);
					    counter = 0;
					    for i = 1:1:kfolds
					        predictions_fold = predictions_folds{i};
					        ground_truth_fold = ground_truth_folds{i};
					        ground_truth_fold = categorical(ground_truth_fold);
					        rocNet = rocmetrics(ground_truth_fold, predictions_fold, class_names);
					        for j = 1:1:length(class_names)
					            counter = counter + 1;
					            idx_class = strcmp(rocNet.Metrics.ClassName, class_names{j});
					            values(counter, :) = rocNet.Metrics(idx_class,:).FalsePositiveRate;
					        end
					    end
					    pf.set('X_VALUES', values);
					end
					
				case NNClassifierMLP_CrossValidationPF_ROC.Y_VALUES % __NNClassifierMLP_CrossValidationPF_ROC.Y_VALUES__
					if isequal(pf.getr('Y_VALUES'), []) && ~isa(pf.get('NNCV').getr('NN_LIST'), 'NoValue')
					    class_names = pf.get('CLASSNAMES');
					    kfolds = pf.get('NNCV').get('KFOLDS');
					    predictions_folds = cellfun(@(nn, nne) cell2mat(nn.get('PREDICT', nne.get('D'))), pf.get('NNCV').get('NN_LIST'), pf.get('NNCV').get('EVALUATOR_LIST'), 'UniformOutput', false);
					    ground_truth_folds = cellfun(@(nne) nne.get('GROUND_TRUTH'), pf.get('NNCV').get('EVALUATOR_LIST'), 'UniformOutput', false);
					    counter = 0;
					    for i = 1:1:kfolds
					        predictions_fold = predictions_folds{i};
					        ground_truth_fold = ground_truth_folds{i};
					        ground_truth_fold = categorical(ground_truth_fold);
					        rocNet = rocmetrics(ground_truth_fold, predictions_fold, class_names);
					        for j = 1:1:length(class_names)
					            counter = counter + 1;
					            idx_class = strcmp(rocNet.Metrics.ClassName, class_names{j});
					            values(counter, :) = rocNet.Metrics(idx_class,:).TruePositiveRate;
					        end
					    end
					    pf.set('Y_VALUES', values);
					end
					
				case NNClassifierMLP_CrossValidationPF_ROC.ROC % __NNClassifierMLP_CrossValidationPF_ROC.ROC__
					if ~pf.get('ROC') % false
					    h_roc = pf.get('H_ROC');
					    for i = 1:1:length(h_roc)
					        set(h_roc{i}, 'Visible', false)
					    end
					else % true
					    % triggers the update of SPH_DICT
					    pf.set('ROC_DICT', pf.get('ROC_DICT'))
					end
					
					% update state of toggle tool
					toolbar = pf.get('H_TOOLBAR');
					if check_graphics(toolbar, 'uitoolbar')
					    set(findobj(toolbar, 'Tag', 'TOOL.ROC'), 'State', pf.get('ROC'))
					end
					
					pf.get('SETUP');
					
				case NNClassifierMLP_CrossValidationPF_ROC.ROC_DICT % __NNClassifierMLP_CrossValidationPF_ROC.ROC_DICT__
					if pf.get('ROC') && ~isa(pf.getr('NNCV'), 'NoValue')
					    classNames = pf.memorize('CLASSNAMES');
					    kfolds = pf.get('NNCV').get('KFOLDS');
					    x_values = pf.memorize('X_VALUES');
					    y_values = pf.memorize('Y_VALUES');
					
					    if pf.get('ROC_DICT').get('LENGTH') == 0 && ~isempty(classNames)
					        % Add mean ROC first
					        roc_st_lines{1} = SettingsLine( ...
					            'ID', 'Mean ROC Curve', ...
					            'X', mean(x_values, 1), ...
					            'Y', mean(y_values, 1), ...
					            'I', 1, ...
					            'PANEL', pf, ...
					            'PROP', NNClassifierMLP_CrossValidationPF_ROC.H_ROC, ...
					            'LINESTYLE', '-', ...
					            'LINEWIDTH', 3, ...
					            'SYMBOL', 'none', ...
					            'VISIBLE', false ...
					            );
					        counter = 1;
					        for f = 1:1:kfolds
					            for c = 1:1:length(classNames)
					                counter = counter + 1;
					                className = classNames{c};
					                roc_st_lines{counter} = SettingsLine( ...
					                    'ID', [className ' Fold ' num2str(f)], ...
					                    'X', x_values(counter-1, :), ...
					                    'Y', y_values(counter-1, :), ...
					                    'I', counter, ...
					                    'PANEL', pf, ...
					                    'PROP', NNClassifierMLP_CrossValidationPF_ROC.H_ROC, ...
					                    'LINESTYLE', '--', ...
					                    'LINEWIDTH', 1, ...
					                    'LINECOLOR', [0.8 0.8 0.8], ...
					                    'SYMBOL', 'none', ...
					                    'VISIBLE', false ...
					                    );
					            end
					        end
					        roc_st_lines{1}.set('VISIBLE', true);
					        pf.get('ROC_DICT').set('IT_LIST', roc_st_lines)
					    end
					    for i = 1:1:length(classNames)*kfolds + 1
					        pf.get('ROC_DICT').get('IT', i).get('SETUP')
					    end
					end
					
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
				case NNClassifierMLP_CrossValidationPF_ROC.H_AXES % __NNClassifierMLP_CrossValidationPF_ROC.H_AXES__
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
					
				case NNClassifierMLP_CrossValidationPF_ROC.LISTENER_ST_AXIS % __NNClassifierMLP_CrossValidationPF_ROC.LISTENER_ST_AXIS__
					value = listener(pf.get('ST_AXIS'), 'PropSet', @cb_listener_st_axis);
					
				case NNClassifierMLP_CrossValidationPF_ROC.SETUP % __NNClassifierMLP_CrossValidationPF_ROC.SETUP__
					xlim = pf.get('H_AXES').get('XLim');
					ylim = pf.get('H_AXES').get('YLim');
					
					nncv = pf.get('NNCV');
					plot_title = 'Mean ROC curve with variability';
					pf.get('ST_TITLE').set( ...
					    'TXT', plot_title, ...
					    'X', .5 * (xlim(2) + xlim(1)), ...
					    'Y', ylim(2) + .07 * (ylim(2) - ylim(1)), ...
					    'Z', 0 ...
					    )
					pf.get('ST_XLABEL').set( ...
					    'TXT', 'False Positive Rate', ...
					    'X', .5 * (xlim(2) + xlim(1)), ...
					    'Y', ylim(1) - .07 * (ylim(2) - ylim(1)), ...
					    'Z', 0 ...
					    )
					pf.get('ST_YLABEL').set( ...
						'TXT', 'True Positive Rate', ...
					    'X', xlim(1) - .14 * (xlim(2) - xlim(1)), ...
					    'Y', .5 * (ylim(2) + ylim(1)), ...
					    'Z', 0 ...
					    )
					
					value = [];
					
				case NNClassifierMLP_CrossValidationPF_ROC.H_ROC % __NNClassifierMLP_CrossValidationPF_ROC.H_ROC__
					if ~isempty(pf.get('CLASSNAMES')) && ~isa(pf.getr('NNCV'), 'NoValue')
					    class_names = pf.get('CLASSNAMES');
					    kfolds = pf.get('NNCV').get('KFOLDS');
					    L = length(class_names) * kfolds + 1; % accounting for mean roc curve
					    H_ROC = cell(1, L);
					    for i = 1:1:L
					        H_ROC{i} = plot(pf.get('H_AXES'), [0], [0], 'x');
					    end
					    value = H_ROC;
					else
					    value = {};
					end
					
				case NNClassifierMLP_CrossValidationPF_ROC.H_TITLE % __NNClassifierMLP_CrossValidationPF_ROC.H_TITLE__
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
					
				case NNClassifierMLP_CrossValidationPF_ROC.H_XLABEL % __NNClassifierMLP_CrossValidationPF_ROC.H_XLABEL__
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
					
				case NNClassifierMLP_CrossValidationPF_ROC.H_YLABEL % __NNClassifierMLP_CrossValidationPF_ROC.H_YLABEL__
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
					
				case NNClassifierMLP_CrossValidationPF_ROC.DRAW % __NNClassifierMLP_CrossValidationPF_ROC.DRAW__
					value = calculateValue@PanelFig(pf, PanelFig.DRAW, varargin{:}); % also warning
					if value
					    if isa(pf.get('NNCV').getr('NN_LIST'), 'NoValue')
					        pf.get('NNCV').memorize('D_LIST'); % trigger calculation in order to plot
					        pf.get('NNCV').memorize('NN_LIST'); % trigger calculation in order to plot
					    end
					    if isa(pf.get('NNCV').getr('EVALUATOR_LIST'), 'NoValue')
					        pf.get('NNCV').memorize('EVALUATOR_LIST'); % trigger calculation in order to plot
					    end
					
					    pf.memorize('CLASSNAMES');
					    pf.memorize('X_VALUES');
					    pf.memorize('Y_VALUES');
					
					    pf.memorize('H_AXES')
					    pf.memorize('H_ROC');
					    pf.memorize('ROC_DICT');
					    
					    pf.memorize('ST_AXIS').set('PANEL', pf, 'PROP', NNClassifierMLP_CrossValidationPF_ROC.H_AXES).get('SETUP')
					    pf.memorize('LISTENER_ST_AXIS');
					    
					    pf.memorize('H_TITLE')
					    pf.memorize('ST_TITLE').set('PANEL', pf, 'PROP', NNClassifierMLP_CrossValidationPF_ROC.H_TITLE).get('SETUP')
					
					    pf.memorize('H_XLABEL')
					    pf.memorize('ST_XLABEL').set('PANEL', pf, 'PROP', NNClassifierMLP_CrossValidationPF_ROC.H_XLABEL).get('SETUP')
					    
					    pf.memorize('H_YLABEL')
					    pf.memorize('ST_YLABEL').set('PANEL', pf, 'PROP', NNClassifierMLP_CrossValidationPF_ROC.H_YLABEL).get('SETUP')
					
					    pf.get('SETUP')
					end
					
				case NNClassifierMLP_CrossValidationPF_ROC.DELETE % __NNClassifierMLP_CrossValidationPF_ROC.DELETE__
					value = calculateValue@PanelFig(pf, PanelFig.DELETE, varargin{:}); % also warning
					if value
					    pf.set('H_AXES', Element.getNoValue())
					
					    pf.set('LISTENER_ST_AXIS', Element.getNoValue())
					 
					    pf.set('H_ROC', Element.getNoValue())
					
					    pf.set('H_TITLE', Element.getNoValue())
					
					    pf.set('H_XLABEL', Element.getNoValue())
					    
					    pf.set('H_YLABEL', Element.getNoValue())
					end
					
				case NNClassifierMLP_CrossValidationPF_ROC.H_TOOLS % __NNClassifierMLP_CrossValidationPF_ROC.H_TOOLS__
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
					    tool_roc = uitoggletool(toolbar, ...
					        'Tag', 'TOOL.ROC', ...
					        'State', pf.get('ROC'), ...
					        'Tooltip', 'Show ROC Curves', ...
					        'CData', imresize(imread('icon_line.png'), [24 24]), ... % % % make icon 16x16
					        'OnCallback', {@cb_roc, true}, ...
					        'OffCallback', {@cb_roc, false});
					
					    value = {value{:}, ...
					        tool_separator_1, ...
					        tool_axis, tool_grid, ... 
					        tool_separator_2, ... 
					        tool_roc ...
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
			function cb_roc(~, ~, visible) % (src, event)
				pf.set('ROC', visible)
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
				case NNClassifierMLP_CrossValidationPF_ROC.ST_AXIS % __NNClassifierMLP_CrossValidationPF_ROC.ST_AXIS__
					pr = SettingsAxisPP('EL', pf, 'PROP', NNClassifierMLP_CrossValidationPF_ROC.ST_AXIS, varargin{:});
					
				case NNClassifierMLP_CrossValidationPF_ROC.ROC_DICT % __NNClassifierMLP_CrossValidationPF_ROC.ROC_DICT__
					pr = PanelPropIDictTable('EL', pf, 'PROP', NNClassifierMLP_CrossValidationPF_ROC.ROC_DICT, ...
					    'COLS', [PanelPropIDictTable.SELECTOR SettingsLine.VISIBLE SettingsLine.LINESTYLE SettingsLine.LINECOLOR SettingsLine.LINEWIDTH SettingsLine.SYMBOL SettingsLine.SYMBOLSIZE SettingsLine.EDGECOLOR SettingsLine.FACECOLOR], ...
					    varargin{:});
					
				case NNClassifierMLP_CrossValidationPF_ROC.ST_TITLE % __NNClassifierMLP_CrossValidationPF_ROC.ST_TITLE__
					pr = SettingsTextPP('EL', pf, 'PROP', NNClassifierMLP_CrossValidationPF_ROC.ST_TITLE, varargin{:});
					
				case NNClassifierMLP_CrossValidationPF_ROC.ST_XLABEL % __NNClassifierMLP_CrossValidationPF_ROC.ST_XLABEL__
					pr = SettingsTextPP('EL', pf, 'PROP', NNClassifierMLP_CrossValidationPF_ROC.ST_XLABEL, varargin{:});
					
				case NNClassifierMLP_CrossValidationPF_ROC.ST_YLABEL % __NNClassifierMLP_CrossValidationPF_ROC.ST_YLABEL__
					pr = SettingsTextPP('EL', pf, 'PROP', NNClassifierMLP_CrossValidationPF_ROC.ST_YLABEL, varargin{:});
					
				otherwise
					pr = getPanelProp@PanelFig(pf, prop, varargin{:});
					
			end
		end
	end
end
