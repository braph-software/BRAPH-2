classdef ComparisonEnsemblePF < PanelFig
	%ComparisonEnsemblePF is the base element to plot an ensemble-based comparison.
	% It is a subclass of <a href="matlab:help PanelFig">PanelFig</a>.
	%
	% ComparisonEnsemblePF manages the basic functionalities to plot of an ensemble-based comparison.
	%
	% ComparisonEnsemblePF methods (constructor):
	%  ComparisonEnsemblePF - constructor
	%
	% ComparisonEnsemblePF methods:
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
	% ComparisonEnsemblePF methods (display):
	%  tostring - string with information about the panel ensemble-based comparison figure
	%  disp - displays information about the panel ensemble-based comparison figure
	%  tree - displays the tree of the panel ensemble-based comparison figure
	%
	% ComparisonEnsemblePF methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two panel ensemble-based comparison figure are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the panel ensemble-based comparison figure
	%
	% ComparisonEnsemblePF methods (save/load, Static):
	%  save - saves BRAPH2 panel ensemble-based comparison figure as b2 file
	%  load - loads a BRAPH2 panel ensemble-based comparison figure from a b2 file
	%
	% ComparisonEnsemblePF method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the panel ensemble-based comparison figure
	%
	% ComparisonEnsemblePF method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the panel ensemble-based comparison figure
	%
	% ComparisonEnsemblePF methods (inspection, Static):
	%  getClass - returns the class of the panel ensemble-based comparison figure
	%  getSubclasses - returns all subclasses of ComparisonEnsemblePF
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
	% ComparisonEnsemblePF methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% ComparisonEnsemblePF methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% ComparisonEnsemblePF methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% ComparisonEnsemblePF methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?ComparisonEnsemblePF; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">ComparisonEnsemblePF constants</a>.
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
		
		CP = PanelFig.getPropNumber() + 4;
		CP_TAG = 'CP';
		CP_CATEGORY = Category.METADATA;
		CP_FORMAT = Format.ITEM;
		
		SETUP = PanelFig.getPropNumber() + 5;
		SETUP_TAG = 'SETUP';
		SETUP_CATEGORY = Category.QUERY;
		SETUP_FORMAT = Format.EMPTY;
		
		H_AREA = PanelFig.getPropNumber() + 6;
		H_AREA_TAG = 'H_AREA';
		H_AREA_CATEGORY = Category.EVANESCENT;
		H_AREA_FORMAT = Format.HANDLE;
		
		ST_AREA = PanelFig.getPropNumber() + 7;
		ST_AREA_TAG = 'ST_AREA';
		ST_AREA_CATEGORY = Category.FIGURE;
		ST_AREA_FORMAT = Format.ITEM;
		
		LISTENER_ST_AREA = PanelFig.getPropNumber() + 8;
		LISTENER_ST_AREA_TAG = 'LISTENER_ST_AREA';
		LISTENER_ST_AREA_CATEGORY = Category.EVANESCENT;
		LISTENER_ST_AREA_FORMAT = Format.HANDLE;
		
		H_LINE_DIFF = PanelFig.getPropNumber() + 9;
		H_LINE_DIFF_TAG = 'H_LINE_DIFF';
		H_LINE_DIFF_CATEGORY = Category.EVANESCENT;
		H_LINE_DIFF_FORMAT = Format.HANDLE;
		
		ST_LINE_DIFF = PanelFig.getPropNumber() + 10;
		ST_LINE_DIFF_TAG = 'ST_LINE_DIFF';
		ST_LINE_DIFF_CATEGORY = Category.FIGURE;
		ST_LINE_DIFF_FORMAT = Format.ITEM;
		
		LISTENER_ST_LINE_DIFF = PanelFig.getPropNumber() + 11;
		LISTENER_ST_LINE_DIFF_TAG = 'LISTENER_ST_LINE_DIFF';
		LISTENER_ST_LINE_DIFF_CATEGORY = Category.EVANESCENT;
		LISTENER_ST_LINE_DIFF_FORMAT = Format.HANDLE;
		
		H_LINE_CIL = PanelFig.getPropNumber() + 12;
		H_LINE_CIL_TAG = 'H_LINE_CIL';
		H_LINE_CIL_CATEGORY = Category.EVANESCENT;
		H_LINE_CIL_FORMAT = Format.HANDLE;
		
		ST_LINE_CIL = PanelFig.getPropNumber() + 13;
		ST_LINE_CIL_TAG = 'ST_LINE_CIL';
		ST_LINE_CIL_CATEGORY = Category.FIGURE;
		ST_LINE_CIL_FORMAT = Format.ITEM;
		
		LISTENER_ST_LINE_CIL = PanelFig.getPropNumber() + 14;
		LISTENER_ST_LINE_CIL_TAG = 'LISTENER_ST_LINE_CIL';
		LISTENER_ST_LINE_CIL_CATEGORY = Category.EVANESCENT;
		LISTENER_ST_LINE_CIL_FORMAT = Format.HANDLE;
		
		H_LINE_CIU = PanelFig.getPropNumber() + 15;
		H_LINE_CIU_TAG = 'H_LINE_CIU';
		H_LINE_CIU_CATEGORY = Category.EVANESCENT;
		H_LINE_CIU_FORMAT = Format.HANDLE;
		
		ST_LINE_CIU = PanelFig.getPropNumber() + 16;
		ST_LINE_CIU_TAG = 'ST_LINE_CIU';
		ST_LINE_CIU_CATEGORY = Category.FIGURE;
		ST_LINE_CIU_FORMAT = Format.ITEM;
		
		LISTENER_ST_LINE_CIU = PanelFig.getPropNumber() + 17;
		LISTENER_ST_LINE_CIU_TAG = 'LISTENER_ST_LINE_CIU';
		LISTENER_ST_LINE_CIU_CATEGORY = Category.EVANESCENT;
		LISTENER_ST_LINE_CIU_FORMAT = Format.HANDLE;
		
		H_TITLE = PanelFig.getPropNumber() + 18;
		H_TITLE_TAG = 'H_TITLE';
		H_TITLE_CATEGORY = Category.EVANESCENT;
		H_TITLE_FORMAT = Format.HANDLE;
		
		ST_TITLE = PanelFig.getPropNumber() + 19;
		ST_TITLE_TAG = 'ST_TITLE';
		ST_TITLE_CATEGORY = Category.FIGURE;
		ST_TITLE_FORMAT = Format.ITEM;
		
		H_XLABEL = PanelFig.getPropNumber() + 20;
		H_XLABEL_TAG = 'H_XLABEL';
		H_XLABEL_CATEGORY = Category.EVANESCENT;
		H_XLABEL_FORMAT = Format.HANDLE;
		
		ST_XLABEL = PanelFig.getPropNumber() + 21;
		ST_XLABEL_TAG = 'ST_XLABEL';
		ST_XLABEL_CATEGORY = Category.FIGURE;
		ST_XLABEL_FORMAT = Format.ITEM;
		
		H_YLABEL = PanelFig.getPropNumber() + 22;
		H_YLABEL_TAG = 'H_YLABEL';
		H_YLABEL_CATEGORY = Category.EVANESCENT;
		H_YLABEL_FORMAT = Format.HANDLE;
		
		ST_YLABEL = PanelFig.getPropNumber() + 23;
		ST_YLABEL_TAG = 'ST_YLABEL';
		ST_YLABEL_CATEGORY = Category.FIGURE;
		ST_YLABEL_FORMAT = Format.ITEM;
	end
	methods % constructor
		function pf = ComparisonEnsemblePF(varargin)
			%ComparisonEnsemblePF() creates a panel ensemble-based comparison figure.
			%
			% ComparisonEnsemblePF(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% ComparisonEnsemblePF(TAG, VALUE, ...) with property TAG set to VALUE.
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
			% CLASS = ComparisonEnsemblePF.GETCLASS() returns the class 'ComparisonEnsemblePF'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PF.GETCLASS() returns the class of the panel ensemble-based comparison figure PF.
			%  CLASS = Element.GETCLASS(PF) returns the class of 'PF'.
			%  CLASS = Element.GETCLASS('ComparisonEnsemblePF') returns 'ComparisonEnsemblePF'.
			%
			% Note that the Element.GETCLASS(PF) and Element.GETCLASS('ComparisonEnsemblePF')
			%  are less computationally efficient.
			
			pf_class = 'ComparisonEnsemblePF';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the panel ensemble-based comparison figure.
			%
			% LIST = ComparisonEnsemblePF.GETSUBCLASSES() returns all subclasses of 'ComparisonEnsemblePF'.
			%
			% Alternative forms to call this method are:
			%  LIST = PF.GETSUBCLASSES() returns all subclasses of the panel ensemble-based comparison figure PF.
			%  LIST = Element.GETSUBCLASSES(PF) returns all subclasses of 'PF'.
			%  LIST = Element.GETSUBCLASSES('ComparisonEnsemblePF') returns all subclasses of 'ComparisonEnsemblePF'.
			%
			% Note that the Element.GETSUBCLASSES(PF) and Element.GETSUBCLASSES('ComparisonEnsemblePF')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('ComparisonEnsemblePF', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of panel ensemble-based comparison figure.
			%
			% PROPS = ComparisonEnsemblePF.GETPROPS() returns the property list of panel ensemble-based comparison figure
			%  as a row vector.
			%
			% PROPS = ComparisonEnsemblePF.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PF.GETPROPS([CATEGORY]) returns the property list of the panel ensemble-based comparison figure PF.
			%  PROPS = Element.GETPROPS(PF[, CATEGORY]) returns the property list of 'PF'.
			%  PROPS = Element.GETPROPS('ComparisonEnsemblePF'[, CATEGORY]) returns the property list of 'ComparisonEnsemblePF'.
			%
			% Note that the Element.GETPROPS(PF) and Element.GETPROPS('ComparisonEnsemblePF')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					PanelFig.getProps() ...
						ComparisonEnsemblePF.H_AXES ...
						ComparisonEnsemblePF.ST_AXIS ...
						ComparisonEnsemblePF.LISTENER_ST_AXIS ...
						ComparisonEnsemblePF.CP ...
						ComparisonEnsemblePF.SETUP ...
						ComparisonEnsemblePF.H_AREA ...
						ComparisonEnsemblePF.ST_AREA ...
						ComparisonEnsemblePF.LISTENER_ST_AREA ...
						ComparisonEnsemblePF.H_LINE_DIFF ...
						ComparisonEnsemblePF.ST_LINE_DIFF ...
						ComparisonEnsemblePF.LISTENER_ST_LINE_DIFF ...
						ComparisonEnsemblePF.H_LINE_CIL ...
						ComparisonEnsemblePF.ST_LINE_CIL ...
						ComparisonEnsemblePF.LISTENER_ST_LINE_CIL ...
						ComparisonEnsemblePF.H_LINE_CIU ...
						ComparisonEnsemblePF.ST_LINE_CIU ...
						ComparisonEnsemblePF.LISTENER_ST_LINE_CIU ...
						ComparisonEnsemblePF.H_TITLE ...
						ComparisonEnsemblePF.ST_TITLE ...
						ComparisonEnsemblePF.H_XLABEL ...
						ComparisonEnsemblePF.ST_XLABEL ...
						ComparisonEnsemblePF.H_YLABEL ...
						ComparisonEnsemblePF.ST_YLABEL ...
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
						ComparisonEnsemblePF.CP ...
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
						ComparisonEnsemblePF.SETUP ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						PanelFig.getProps(Category.EVANESCENT) ...
						ComparisonEnsemblePF.H_AXES ...
						ComparisonEnsemblePF.LISTENER_ST_AXIS ...
						ComparisonEnsemblePF.H_AREA ...
						ComparisonEnsemblePF.LISTENER_ST_AREA ...
						ComparisonEnsemblePF.H_LINE_DIFF ...
						ComparisonEnsemblePF.LISTENER_ST_LINE_DIFF ...
						ComparisonEnsemblePF.H_LINE_CIL ...
						ComparisonEnsemblePF.LISTENER_ST_LINE_CIL ...
						ComparisonEnsemblePF.H_LINE_CIU ...
						ComparisonEnsemblePF.LISTENER_ST_LINE_CIU ...
						ComparisonEnsemblePF.H_TITLE ...
						ComparisonEnsemblePF.H_XLABEL ...
						ComparisonEnsemblePF.H_YLABEL ...
						];
				case Category.FIGURE
					prop_list = [ ...
						PanelFig.getProps(Category.FIGURE) ...
						ComparisonEnsemblePF.ST_AXIS ...
						ComparisonEnsemblePF.ST_AREA ...
						ComparisonEnsemblePF.ST_LINE_DIFF ...
						ComparisonEnsemblePF.ST_LINE_CIL ...
						ComparisonEnsemblePF.ST_LINE_CIU ...
						ComparisonEnsemblePF.ST_TITLE ...
						ComparisonEnsemblePF.ST_XLABEL ...
						ComparisonEnsemblePF.ST_YLABEL ...
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
			% N = ComparisonEnsemblePF.GETPROPNUMBER() returns the property number of panel ensemble-based comparison figure.
			%
			% N = ComparisonEnsemblePF.GETPROPNUMBER(CATEGORY) returns the property number of panel ensemble-based comparison figure
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PF.GETPROPNUMBER([CATEGORY]) returns the property number of the panel ensemble-based comparison figure PF.
			%  N = Element.GETPROPNUMBER(PF) returns the property number of 'PF'.
			%  N = Element.GETPROPNUMBER('ComparisonEnsemblePF') returns the property number of 'ComparisonEnsemblePF'.
			%
			% Note that the Element.GETPROPNUMBER(PF) and Element.GETPROPNUMBER('ComparisonEnsemblePF')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(ComparisonEnsemblePF.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in panel ensemble-based comparison figure/error.
			%
			% CHECK = ComparisonEnsemblePF.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSPROP(PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(PF, PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(ComparisonEnsemblePF, PROP) checks whether PROP exists for ComparisonEnsemblePF.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:ComparisonEnsemblePF:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSPROP(PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:ComparisonEnsemblePF:WrongInput]
			%  Element.EXISTSPROP(PF, PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:ComparisonEnsemblePF:WrongInput]
			%  Element.EXISTSPROP(ComparisonEnsemblePF, PROP) throws error if PROP does NOT exist for ComparisonEnsemblePF.
			%   Error id: [BRAPH2:ComparisonEnsemblePF:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PF) and Element.EXISTSPROP('ComparisonEnsemblePF')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == ComparisonEnsemblePF.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ComparisonEnsemblePF:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ComparisonEnsemblePF:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for ComparisonEnsemblePF.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in panel ensemble-based comparison figure/error.
			%
			% CHECK = ComparisonEnsemblePF.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSTAG(TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(PF, TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(ComparisonEnsemblePF, TAG) checks whether TAG exists for ComparisonEnsemblePF.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:ComparisonEnsemblePF:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSTAG(TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:ComparisonEnsemblePF:WrongInput]
			%  Element.EXISTSTAG(PF, TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:ComparisonEnsemblePF:WrongInput]
			%  Element.EXISTSTAG(ComparisonEnsemblePF, TAG) throws error if TAG does NOT exist for ComparisonEnsemblePF.
			%   Error id: [BRAPH2:ComparisonEnsemblePF:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PF) and Element.EXISTSTAG('ComparisonEnsemblePF')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			comparisonensemblepf_tag_list = cellfun(@(x) ComparisonEnsemblePF.getPropTag(x), num2cell(ComparisonEnsemblePF.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, comparisonensemblepf_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ComparisonEnsemblePF:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ComparisonEnsemblePF:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for ComparisonEnsemblePF.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(ComparisonEnsemblePF, POINTER) returns property number of POINTER of ComparisonEnsemblePF.
			%  PROPERTY = PF.GETPROPPROP(ComparisonEnsemblePF, POINTER) returns property number of POINTER of ComparisonEnsemblePF.
			%
			% Note that the Element.GETPROPPROP(PF) and Element.GETPROPPROP('ComparisonEnsemblePF')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				comparisonensemblepf_tag_list = cellfun(@(x) ComparisonEnsemblePF.getPropTag(x), num2cell(ComparisonEnsemblePF.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, comparisonensemblepf_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(ComparisonEnsemblePF, POINTER) returns tag of POINTER of ComparisonEnsemblePF.
			%  TAG = PF.GETPROPTAG(ComparisonEnsemblePF, POINTER) returns tag of POINTER of ComparisonEnsemblePF.
			%
			% Note that the Element.GETPROPTAG(PF) and Element.GETPROPTAG('ComparisonEnsemblePF')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case ComparisonEnsemblePF.H_AXES
						tag = ComparisonEnsemblePF.H_AXES_TAG;
					case ComparisonEnsemblePF.ST_AXIS
						tag = ComparisonEnsemblePF.ST_AXIS_TAG;
					case ComparisonEnsemblePF.LISTENER_ST_AXIS
						tag = ComparisonEnsemblePF.LISTENER_ST_AXIS_TAG;
					case ComparisonEnsemblePF.CP
						tag = ComparisonEnsemblePF.CP_TAG;
					case ComparisonEnsemblePF.SETUP
						tag = ComparisonEnsemblePF.SETUP_TAG;
					case ComparisonEnsemblePF.H_AREA
						tag = ComparisonEnsemblePF.H_AREA_TAG;
					case ComparisonEnsemblePF.ST_AREA
						tag = ComparisonEnsemblePF.ST_AREA_TAG;
					case ComparisonEnsemblePF.LISTENER_ST_AREA
						tag = ComparisonEnsemblePF.LISTENER_ST_AREA_TAG;
					case ComparisonEnsemblePF.H_LINE_DIFF
						tag = ComparisonEnsemblePF.H_LINE_DIFF_TAG;
					case ComparisonEnsemblePF.ST_LINE_DIFF
						tag = ComparisonEnsemblePF.ST_LINE_DIFF_TAG;
					case ComparisonEnsemblePF.LISTENER_ST_LINE_DIFF
						tag = ComparisonEnsemblePF.LISTENER_ST_LINE_DIFF_TAG;
					case ComparisonEnsemblePF.H_LINE_CIL
						tag = ComparisonEnsemblePF.H_LINE_CIL_TAG;
					case ComparisonEnsemblePF.ST_LINE_CIL
						tag = ComparisonEnsemblePF.ST_LINE_CIL_TAG;
					case ComparisonEnsemblePF.LISTENER_ST_LINE_CIL
						tag = ComparisonEnsemblePF.LISTENER_ST_LINE_CIL_TAG;
					case ComparisonEnsemblePF.H_LINE_CIU
						tag = ComparisonEnsemblePF.H_LINE_CIU_TAG;
					case ComparisonEnsemblePF.ST_LINE_CIU
						tag = ComparisonEnsemblePF.ST_LINE_CIU_TAG;
					case ComparisonEnsemblePF.LISTENER_ST_LINE_CIU
						tag = ComparisonEnsemblePF.LISTENER_ST_LINE_CIU_TAG;
					case ComparisonEnsemblePF.H_TITLE
						tag = ComparisonEnsemblePF.H_TITLE_TAG;
					case ComparisonEnsemblePF.ST_TITLE
						tag = ComparisonEnsemblePF.ST_TITLE_TAG;
					case ComparisonEnsemblePF.H_XLABEL
						tag = ComparisonEnsemblePF.H_XLABEL_TAG;
					case ComparisonEnsemblePF.ST_XLABEL
						tag = ComparisonEnsemblePF.ST_XLABEL_TAG;
					case ComparisonEnsemblePF.H_YLABEL
						tag = ComparisonEnsemblePF.H_YLABEL_TAG;
					case ComparisonEnsemblePF.ST_YLABEL
						tag = ComparisonEnsemblePF.ST_YLABEL_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(ComparisonEnsemblePF, POINTER) returns category of POINTER of ComparisonEnsemblePF.
			%  CATEGORY = PF.GETPROPCATEGORY(ComparisonEnsemblePF, POINTER) returns category of POINTER of ComparisonEnsemblePF.
			%
			% Note that the Element.GETPROPCATEGORY(PF) and Element.GETPROPCATEGORY('ComparisonEnsemblePF')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = ComparisonEnsemblePF.getPropProp(pointer);
			
			switch prop
				case ComparisonEnsemblePF.H_AXES
					prop_category = ComparisonEnsemblePF.H_AXES_CATEGORY;
				case ComparisonEnsemblePF.ST_AXIS
					prop_category = ComparisonEnsemblePF.ST_AXIS_CATEGORY;
				case ComparisonEnsemblePF.LISTENER_ST_AXIS
					prop_category = ComparisonEnsemblePF.LISTENER_ST_AXIS_CATEGORY;
				case ComparisonEnsemblePF.CP
					prop_category = ComparisonEnsemblePF.CP_CATEGORY;
				case ComparisonEnsemblePF.SETUP
					prop_category = ComparisonEnsemblePF.SETUP_CATEGORY;
				case ComparisonEnsemblePF.H_AREA
					prop_category = ComparisonEnsemblePF.H_AREA_CATEGORY;
				case ComparisonEnsemblePF.ST_AREA
					prop_category = ComparisonEnsemblePF.ST_AREA_CATEGORY;
				case ComparisonEnsemblePF.LISTENER_ST_AREA
					prop_category = ComparisonEnsemblePF.LISTENER_ST_AREA_CATEGORY;
				case ComparisonEnsemblePF.H_LINE_DIFF
					prop_category = ComparisonEnsemblePF.H_LINE_DIFF_CATEGORY;
				case ComparisonEnsemblePF.ST_LINE_DIFF
					prop_category = ComparisonEnsemblePF.ST_LINE_DIFF_CATEGORY;
				case ComparisonEnsemblePF.LISTENER_ST_LINE_DIFF
					prop_category = ComparisonEnsemblePF.LISTENER_ST_LINE_DIFF_CATEGORY;
				case ComparisonEnsemblePF.H_LINE_CIL
					prop_category = ComparisonEnsemblePF.H_LINE_CIL_CATEGORY;
				case ComparisonEnsemblePF.ST_LINE_CIL
					prop_category = ComparisonEnsemblePF.ST_LINE_CIL_CATEGORY;
				case ComparisonEnsemblePF.LISTENER_ST_LINE_CIL
					prop_category = ComparisonEnsemblePF.LISTENER_ST_LINE_CIL_CATEGORY;
				case ComparisonEnsemblePF.H_LINE_CIU
					prop_category = ComparisonEnsemblePF.H_LINE_CIU_CATEGORY;
				case ComparisonEnsemblePF.ST_LINE_CIU
					prop_category = ComparisonEnsemblePF.ST_LINE_CIU_CATEGORY;
				case ComparisonEnsemblePF.LISTENER_ST_LINE_CIU
					prop_category = ComparisonEnsemblePF.LISTENER_ST_LINE_CIU_CATEGORY;
				case ComparisonEnsemblePF.H_TITLE
					prop_category = ComparisonEnsemblePF.H_TITLE_CATEGORY;
				case ComparisonEnsemblePF.ST_TITLE
					prop_category = ComparisonEnsemblePF.ST_TITLE_CATEGORY;
				case ComparisonEnsemblePF.H_XLABEL
					prop_category = ComparisonEnsemblePF.H_XLABEL_CATEGORY;
				case ComparisonEnsemblePF.ST_XLABEL
					prop_category = ComparisonEnsemblePF.ST_XLABEL_CATEGORY;
				case ComparisonEnsemblePF.H_YLABEL
					prop_category = ComparisonEnsemblePF.H_YLABEL_CATEGORY;
				case ComparisonEnsemblePF.ST_YLABEL
					prop_category = ComparisonEnsemblePF.ST_YLABEL_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(ComparisonEnsemblePF, POINTER) returns format of POINTER of ComparisonEnsemblePF.
			%  FORMAT = PF.GETPROPFORMAT(ComparisonEnsemblePF, POINTER) returns format of POINTER of ComparisonEnsemblePF.
			%
			% Note that the Element.GETPROPFORMAT(PF) and Element.GETPROPFORMAT('ComparisonEnsemblePF')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = ComparisonEnsemblePF.getPropProp(pointer);
			
			switch prop
				case ComparisonEnsemblePF.H_AXES
					prop_format = ComparisonEnsemblePF.H_AXES_FORMAT;
				case ComparisonEnsemblePF.ST_AXIS
					prop_format = ComparisonEnsemblePF.ST_AXIS_FORMAT;
				case ComparisonEnsemblePF.LISTENER_ST_AXIS
					prop_format = ComparisonEnsemblePF.LISTENER_ST_AXIS_FORMAT;
				case ComparisonEnsemblePF.CP
					prop_format = ComparisonEnsemblePF.CP_FORMAT;
				case ComparisonEnsemblePF.SETUP
					prop_format = ComparisonEnsemblePF.SETUP_FORMAT;
				case ComparisonEnsemblePF.H_AREA
					prop_format = ComparisonEnsemblePF.H_AREA_FORMAT;
				case ComparisonEnsemblePF.ST_AREA
					prop_format = ComparisonEnsemblePF.ST_AREA_FORMAT;
				case ComparisonEnsemblePF.LISTENER_ST_AREA
					prop_format = ComparisonEnsemblePF.LISTENER_ST_AREA_FORMAT;
				case ComparisonEnsemblePF.H_LINE_DIFF
					prop_format = ComparisonEnsemblePF.H_LINE_DIFF_FORMAT;
				case ComparisonEnsemblePF.ST_LINE_DIFF
					prop_format = ComparisonEnsemblePF.ST_LINE_DIFF_FORMAT;
				case ComparisonEnsemblePF.LISTENER_ST_LINE_DIFF
					prop_format = ComparisonEnsemblePF.LISTENER_ST_LINE_DIFF_FORMAT;
				case ComparisonEnsemblePF.H_LINE_CIL
					prop_format = ComparisonEnsemblePF.H_LINE_CIL_FORMAT;
				case ComparisonEnsemblePF.ST_LINE_CIL
					prop_format = ComparisonEnsemblePF.ST_LINE_CIL_FORMAT;
				case ComparisonEnsemblePF.LISTENER_ST_LINE_CIL
					prop_format = ComparisonEnsemblePF.LISTENER_ST_LINE_CIL_FORMAT;
				case ComparisonEnsemblePF.H_LINE_CIU
					prop_format = ComparisonEnsemblePF.H_LINE_CIU_FORMAT;
				case ComparisonEnsemblePF.ST_LINE_CIU
					prop_format = ComparisonEnsemblePF.ST_LINE_CIU_FORMAT;
				case ComparisonEnsemblePF.LISTENER_ST_LINE_CIU
					prop_format = ComparisonEnsemblePF.LISTENER_ST_LINE_CIU_FORMAT;
				case ComparisonEnsemblePF.H_TITLE
					prop_format = ComparisonEnsemblePF.H_TITLE_FORMAT;
				case ComparisonEnsemblePF.ST_TITLE
					prop_format = ComparisonEnsemblePF.ST_TITLE_FORMAT;
				case ComparisonEnsemblePF.H_XLABEL
					prop_format = ComparisonEnsemblePF.H_XLABEL_FORMAT;
				case ComparisonEnsemblePF.ST_XLABEL
					prop_format = ComparisonEnsemblePF.ST_XLABEL_FORMAT;
				case ComparisonEnsemblePF.H_YLABEL
					prop_format = ComparisonEnsemblePF.H_YLABEL_FORMAT;
				case ComparisonEnsemblePF.ST_YLABEL
					prop_format = ComparisonEnsemblePF.ST_YLABEL_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(ComparisonEnsemblePF, POINTER) returns description of POINTER of ComparisonEnsemblePF.
			%  DESCRIPTION = PF.GETPROPDESCRIPTION(ComparisonEnsemblePF, POINTER) returns description of POINTER of ComparisonEnsemblePF.
			%
			% Note that the Element.GETPROPDESCRIPTION(PF) and Element.GETPROPDESCRIPTION('ComparisonEnsemblePF')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = ComparisonEnsemblePF.getPropProp(pointer);
			
			switch prop
				case ComparisonEnsemblePF.H_AXES
					prop_description = 'H_AXES (evanescent, handle) is the handle for the axes.';
				case ComparisonEnsemblePF.ST_AXIS
					prop_description = 'ST_AXIS (figure, item) determines the axis settings.';
				case ComparisonEnsemblePF.LISTENER_ST_AXIS
					prop_description = 'LISTENER_ST_AXIS (evanescent, handle) contains the listener to the axis settings to update the pushbuttons.';
				case ComparisonEnsemblePF.CP
					prop_description = 'CP (metadata, item) is the ensemble-based comparison.';
				case ComparisonEnsemblePF.SETUP
					prop_description = 'SETUP (query, empty) calculates the ensemble-based comparison value and stores it to be implemented in the subelements.';
				case ComparisonEnsemblePF.H_AREA
					prop_description = 'H_AREA (evanescent, handle) is the handle for the ensemble-based comparison confidence area.';
				case ComparisonEnsemblePF.ST_AREA
					prop_description = 'ST_AREA (figure, item) determines the area settings.';
				case ComparisonEnsemblePF.LISTENER_ST_AREA
					prop_description = 'LISTENER_ST_AREA (evanescent, handle) contains the listener to the measure area settings to update the pushbutton.';
				case ComparisonEnsemblePF.H_LINE_DIFF
					prop_description = 'H_LINE_DIFF (evanescent, handle) is the handle for the ensemble-based comparison line.';
				case ComparisonEnsemblePF.ST_LINE_DIFF
					prop_description = 'ST_LINE_DIFF (figure, item) determines the line settings.';
				case ComparisonEnsemblePF.LISTENER_ST_LINE_DIFF
					prop_description = 'LISTENER_ST_LINE_DIFF (evanescent, handle) contains the listener to the measure line settings to update the pushbutton.';
				case ComparisonEnsemblePF.H_LINE_CIL
					prop_description = 'H_LINE_CIL (evanescent, handle) is the handle for the lower confidence interval of the ensemble-based comparison line.';
				case ComparisonEnsemblePF.ST_LINE_CIL
					prop_description = 'ST_LINE_CIL (figure, item) determines the line settings.';
				case ComparisonEnsemblePF.LISTENER_ST_LINE_CIL
					prop_description = 'LISTENER_ST_LINE_CIL (evanescent, handle) contains the listener to the measure line settings to update the pushbutton.';
				case ComparisonEnsemblePF.H_LINE_CIU
					prop_description = 'H_LINE_CIU (evanescent, handle) is the handle for the upper confidence interval of the ensemble-based comparison line.';
				case ComparisonEnsemblePF.ST_LINE_CIU
					prop_description = 'ST_LINE_CIU (figure, item) determines the line settings.';
				case ComparisonEnsemblePF.LISTENER_ST_LINE_CIU
					prop_description = 'LISTENER_ST_LINE_CIU (evanescent, handle) contains the listener to the measure line settings to update the pushbutton.';
				case ComparisonEnsemblePF.H_TITLE
					prop_description = 'H_TITLE (evanescent, handle) is the axis title.';
				case ComparisonEnsemblePF.ST_TITLE
					prop_description = 'ST_TITLE (figure, item) determines the title settings.';
				case ComparisonEnsemblePF.H_XLABEL
					prop_description = 'H_XLABEL (evanescent, handle) is the axis x-label.';
				case ComparisonEnsemblePF.ST_XLABEL
					prop_description = 'ST_XLABEL (figure, item) determines the x-label settings.';
				case ComparisonEnsemblePF.H_YLABEL
					prop_description = 'H_YLABEL (evanescent, handle) is the axis y-label.';
				case ComparisonEnsemblePF.ST_YLABEL
					prop_description = 'ST_YLABEL (figure, item) determines the y-label settings.';
				case ComparisonEnsemblePF.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the % % % .';
				case ComparisonEnsemblePF.NAME
					prop_description = 'NAME (constant, string) is the name of the panel ensemble-based comparison figure.';
				case ComparisonEnsemblePF.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the panel ensemble-based comparison figure.';
				case ComparisonEnsemblePF.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the panel ensemble-based comparison figure.';
				case ComparisonEnsemblePF.ID
					prop_description = 'ID (data, string) is a few-letter code for the panel ensemble-based comparison figure.';
				case ComparisonEnsemblePF.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the panel ensemble-based comparison figure.';
				case ComparisonEnsemblePF.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the panel ensemble-based comparison figure.';
				case ComparisonEnsemblePF.DRAW
					prop_description = 'DRAW (query, logical) draws the figure comparison figure.';
				case ComparisonEnsemblePF.DELETE
					prop_description = 'DELETE (query, logical) resets the handles when the panel figure graph is deleted.';
				case ComparisonEnsemblePF.H_TOOLS
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
			%  SETTINGS = Element.GETPROPSETTINGS(ComparisonEnsemblePF, POINTER) returns settings of POINTER of ComparisonEnsemblePF.
			%  SETTINGS = PF.GETPROPSETTINGS(ComparisonEnsemblePF, POINTER) returns settings of POINTER of ComparisonEnsemblePF.
			%
			% Note that the Element.GETPROPSETTINGS(PF) and Element.GETPROPSETTINGS('ComparisonEnsemblePF')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = ComparisonEnsemblePF.getPropProp(pointer);
			
			switch prop
				case ComparisonEnsemblePF.H_AXES
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case ComparisonEnsemblePF.ST_AXIS
					prop_settings = 'SettingsAxis';
				case ComparisonEnsemblePF.LISTENER_ST_AXIS
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case ComparisonEnsemblePF.CP
					prop_settings = 'ComparisonEnsemble';
				case ComparisonEnsemblePF.SETUP
					prop_settings = Format.getFormatSettings(Format.EMPTY);
				case ComparisonEnsemblePF.H_AREA
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case ComparisonEnsemblePF.ST_AREA
					prop_settings = 'SettingsArea';
				case ComparisonEnsemblePF.LISTENER_ST_AREA
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case ComparisonEnsemblePF.H_LINE_DIFF
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case ComparisonEnsemblePF.ST_LINE_DIFF
					prop_settings = 'SettingsLine';
				case ComparisonEnsemblePF.LISTENER_ST_LINE_DIFF
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case ComparisonEnsemblePF.H_LINE_CIL
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case ComparisonEnsemblePF.ST_LINE_CIL
					prop_settings = 'SettingsLine';
				case ComparisonEnsemblePF.LISTENER_ST_LINE_CIL
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case ComparisonEnsemblePF.H_LINE_CIU
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case ComparisonEnsemblePF.ST_LINE_CIU
					prop_settings = 'SettingsLine';
				case ComparisonEnsemblePF.LISTENER_ST_LINE_CIU
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case ComparisonEnsemblePF.H_TITLE
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case ComparisonEnsemblePF.ST_TITLE
					prop_settings = 'SettingsText';
				case ComparisonEnsemblePF.H_XLABEL
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case ComparisonEnsemblePF.ST_XLABEL
					prop_settings = 'SettingsText';
				case ComparisonEnsemblePF.H_YLABEL
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case ComparisonEnsemblePF.ST_YLABEL
					prop_settings = 'SettingsText';
				case ComparisonEnsemblePF.TEMPLATE
					prop_settings = 'ComparisonEnsemblePF';
				otherwise
					prop_settings = getPropSettings@PanelFig(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = ComparisonEnsemblePF.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = ComparisonEnsemblePF.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULT(ComparisonEnsemblePF, POINTER) returns the default value of POINTER of ComparisonEnsemblePF.
			%  DEFAULT = PF.GETPROPDEFAULT(ComparisonEnsemblePF, POINTER) returns the default value of POINTER of ComparisonEnsemblePF.
			%
			% Note that the Element.GETPROPDEFAULT(PF) and Element.GETPROPDEFAULT('ComparisonEnsemblePF')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = ComparisonEnsemblePF.getPropProp(pointer);
			
			switch prop
				case ComparisonEnsemblePF.H_AXES
					prop_default = Format.getFormatDefault(Format.HANDLE, ComparisonEnsemblePF.getPropSettings(prop));
				case ComparisonEnsemblePF.ST_AXIS
					prop_default = SettingsAxis('AXIS', true, 'GRID', false, 'EQUAL', false);
				case ComparisonEnsemblePF.LISTENER_ST_AXIS
					prop_default = Format.getFormatDefault(Format.HANDLE, ComparisonEnsemblePF.getPropSettings(prop));
				case ComparisonEnsemblePF.CP
					prop_default = Format.getFormatDefault(Format.ITEM, ComparisonEnsemblePF.getPropSettings(prop));
				case ComparisonEnsemblePF.SETUP
					prop_default = Format.getFormatDefault(Format.EMPTY, ComparisonEnsemblePF.getPropSettings(prop));
				case ComparisonEnsemblePF.H_AREA
					prop_default = Format.getFormatDefault(Format.HANDLE, ComparisonEnsemblePF.getPropSettings(prop));
				case ComparisonEnsemblePF.ST_AREA
					prop_default = Format.getFormatDefault(Format.ITEM, ComparisonEnsemblePF.getPropSettings(prop));
				case ComparisonEnsemblePF.LISTENER_ST_AREA
					prop_default = Format.getFormatDefault(Format.HANDLE, ComparisonEnsemblePF.getPropSettings(prop));
				case ComparisonEnsemblePF.H_LINE_DIFF
					prop_default = Format.getFormatDefault(Format.HANDLE, ComparisonEnsemblePF.getPropSettings(prop));
				case ComparisonEnsemblePF.ST_LINE_DIFF
					prop_default = Format.getFormatDefault(Format.ITEM, ComparisonEnsemblePF.getPropSettings(prop));
				case ComparisonEnsemblePF.LISTENER_ST_LINE_DIFF
					prop_default = Format.getFormatDefault(Format.HANDLE, ComparisonEnsemblePF.getPropSettings(prop));
				case ComparisonEnsemblePF.H_LINE_CIL
					prop_default = Format.getFormatDefault(Format.HANDLE, ComparisonEnsemblePF.getPropSettings(prop));
				case ComparisonEnsemblePF.ST_LINE_CIL
					prop_default = SettingsLine('SYMBOLSIZE', 6, 'FACECOLOR', [.5 .5 .5]);
				case ComparisonEnsemblePF.LISTENER_ST_LINE_CIL
					prop_default = Format.getFormatDefault(Format.HANDLE, ComparisonEnsemblePF.getPropSettings(prop));
				case ComparisonEnsemblePF.H_LINE_CIU
					prop_default = Format.getFormatDefault(Format.HANDLE, ComparisonEnsemblePF.getPropSettings(prop));
				case ComparisonEnsemblePF.ST_LINE_CIU
					prop_default = SettingsLine('SYMBOLSIZE', 6, 'FACECOLOR', [.5 .5 .5]);
				case ComparisonEnsemblePF.LISTENER_ST_LINE_CIU
					prop_default = Format.getFormatDefault(Format.HANDLE, ComparisonEnsemblePF.getPropSettings(prop));
				case ComparisonEnsemblePF.H_TITLE
					prop_default = Format.getFormatDefault(Format.HANDLE, ComparisonEnsemblePF.getPropSettings(prop));
				case ComparisonEnsemblePF.ST_TITLE
					prop_default = SettingsText('VISIBLE', true, 'FONTSIZE', s(2), 'HALIGN', 'center', 'VALIGN', 'middle');
				case ComparisonEnsemblePF.H_XLABEL
					prop_default = Format.getFormatDefault(Format.HANDLE, ComparisonEnsemblePF.getPropSettings(prop));
				case ComparisonEnsemblePF.ST_XLABEL
					prop_default = SettingsText('VISIBLE', true, 'FONTSIZE', s(2), 'HALIGN', 'center', 'VALIGN', 'middle');
				case ComparisonEnsemblePF.H_YLABEL
					prop_default = Format.getFormatDefault(Format.HANDLE, ComparisonEnsemblePF.getPropSettings(prop));
				case ComparisonEnsemblePF.ST_YLABEL
					prop_default = SettingsText('VISIBLE', true, 'FONTSIZE', s(2), 'HALIGN', 'center', 'VALIGN', 'middle', 'ROTATION', 90);
				case ComparisonEnsemblePF.ELCLASS
					prop_default = 'ComparisonEnsemblePF';
				case ComparisonEnsemblePF.NAME
					prop_default = 'ComparisonEnsemblePF';
				case ComparisonEnsemblePF.DESCRIPTION
					prop_default = 'ComparisonEnsemblePF manages the basic functionalities to plot of an ensemble-based comparison.';
				case ComparisonEnsemblePF.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, ComparisonEnsemblePF.getPropSettings(prop));
				case ComparisonEnsemblePF.ID
					prop_default = 'ComparisonEnsemblePF ID';
				case ComparisonEnsemblePF.LABEL
					prop_default = 'ComparisonEnsemblePF label';
				case ComparisonEnsemblePF.NOTES
					prop_default = 'ComparisonEnsemblePF notes';
				otherwise
					prop_default = getPropDefault@PanelFig(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = ComparisonEnsemblePF.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = ComparisonEnsemblePF.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(ComparisonEnsemblePF, POINTER) returns the conditioned default value of POINTER of ComparisonEnsemblePF.
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(ComparisonEnsemblePF, POINTER) returns the conditioned default value of POINTER of ComparisonEnsemblePF.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PF) and Element.GETPROPDEFAULTCONDITIONED('ComparisonEnsemblePF')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = ComparisonEnsemblePF.getPropProp(pointer);
			
			prop_default = ComparisonEnsemblePF.conditioning(prop, ComparisonEnsemblePF.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(ComparisonEnsemblePF, PROP, VALUE) checks VALUE format for PROP of ComparisonEnsemblePF.
			%  CHECK = PF.CHECKPROP(ComparisonEnsemblePF, PROP, VALUE) checks VALUE format for PROP of ComparisonEnsemblePF.
			% 
			% PF.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:ComparisonEnsemblePF:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PF.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PF.
			%   Error id: €BRAPH2.STR€:ComparisonEnsemblePF:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(ComparisonEnsemblePF, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ComparisonEnsemblePF.
			%   Error id: €BRAPH2.STR€:ComparisonEnsemblePF:€BRAPH2.WRONG_INPUT€
			%  PF.CHECKPROP(ComparisonEnsemblePF, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ComparisonEnsemblePF.
			%   Error id: €BRAPH2.STR€:ComparisonEnsemblePF:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PF) and Element.CHECKPROP('ComparisonEnsemblePF')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = ComparisonEnsemblePF.getPropProp(pointer);
			
			switch prop
				case ComparisonEnsemblePF.H_AXES % __ComparisonEnsemblePF.H_AXES__
					check = Format.checkFormat(Format.HANDLE, value, ComparisonEnsemblePF.getPropSettings(prop));
				case ComparisonEnsemblePF.ST_AXIS % __ComparisonEnsemblePF.ST_AXIS__
					check = Format.checkFormat(Format.ITEM, value, ComparisonEnsemblePF.getPropSettings(prop));
				case ComparisonEnsemblePF.LISTENER_ST_AXIS % __ComparisonEnsemblePF.LISTENER_ST_AXIS__
					check = Format.checkFormat(Format.HANDLE, value, ComparisonEnsemblePF.getPropSettings(prop));
				case ComparisonEnsemblePF.CP % __ComparisonEnsemblePF.CP__
					check = Format.checkFormat(Format.ITEM, value, ComparisonEnsemblePF.getPropSettings(prop));
				case ComparisonEnsemblePF.SETUP % __ComparisonEnsemblePF.SETUP__
					check = Format.checkFormat(Format.EMPTY, value, ComparisonEnsemblePF.getPropSettings(prop));
				case ComparisonEnsemblePF.H_AREA % __ComparisonEnsemblePF.H_AREA__
					check = Format.checkFormat(Format.HANDLE, value, ComparisonEnsemblePF.getPropSettings(prop));
				case ComparisonEnsemblePF.ST_AREA % __ComparisonEnsemblePF.ST_AREA__
					check = Format.checkFormat(Format.ITEM, value, ComparisonEnsemblePF.getPropSettings(prop));
				case ComparisonEnsemblePF.LISTENER_ST_AREA % __ComparisonEnsemblePF.LISTENER_ST_AREA__
					check = Format.checkFormat(Format.HANDLE, value, ComparisonEnsemblePF.getPropSettings(prop));
				case ComparisonEnsemblePF.H_LINE_DIFF % __ComparisonEnsemblePF.H_LINE_DIFF__
					check = Format.checkFormat(Format.HANDLE, value, ComparisonEnsemblePF.getPropSettings(prop));
				case ComparisonEnsemblePF.ST_LINE_DIFF % __ComparisonEnsemblePF.ST_LINE_DIFF__
					check = Format.checkFormat(Format.ITEM, value, ComparisonEnsemblePF.getPropSettings(prop));
				case ComparisonEnsemblePF.LISTENER_ST_LINE_DIFF % __ComparisonEnsemblePF.LISTENER_ST_LINE_DIFF__
					check = Format.checkFormat(Format.HANDLE, value, ComparisonEnsemblePF.getPropSettings(prop));
				case ComparisonEnsemblePF.H_LINE_CIL % __ComparisonEnsemblePF.H_LINE_CIL__
					check = Format.checkFormat(Format.HANDLE, value, ComparisonEnsemblePF.getPropSettings(prop));
				case ComparisonEnsemblePF.ST_LINE_CIL % __ComparisonEnsemblePF.ST_LINE_CIL__
					check = Format.checkFormat(Format.ITEM, value, ComparisonEnsemblePF.getPropSettings(prop));
				case ComparisonEnsemblePF.LISTENER_ST_LINE_CIL % __ComparisonEnsemblePF.LISTENER_ST_LINE_CIL__
					check = Format.checkFormat(Format.HANDLE, value, ComparisonEnsemblePF.getPropSettings(prop));
				case ComparisonEnsemblePF.H_LINE_CIU % __ComparisonEnsemblePF.H_LINE_CIU__
					check = Format.checkFormat(Format.HANDLE, value, ComparisonEnsemblePF.getPropSettings(prop));
				case ComparisonEnsemblePF.ST_LINE_CIU % __ComparisonEnsemblePF.ST_LINE_CIU__
					check = Format.checkFormat(Format.ITEM, value, ComparisonEnsemblePF.getPropSettings(prop));
				case ComparisonEnsemblePF.LISTENER_ST_LINE_CIU % __ComparisonEnsemblePF.LISTENER_ST_LINE_CIU__
					check = Format.checkFormat(Format.HANDLE, value, ComparisonEnsemblePF.getPropSettings(prop));
				case ComparisonEnsemblePF.H_TITLE % __ComparisonEnsemblePF.H_TITLE__
					check = Format.checkFormat(Format.HANDLE, value, ComparisonEnsemblePF.getPropSettings(prop));
				case ComparisonEnsemblePF.ST_TITLE % __ComparisonEnsemblePF.ST_TITLE__
					check = Format.checkFormat(Format.ITEM, value, ComparisonEnsemblePF.getPropSettings(prop));
				case ComparisonEnsemblePF.H_XLABEL % __ComparisonEnsemblePF.H_XLABEL__
					check = Format.checkFormat(Format.HANDLE, value, ComparisonEnsemblePF.getPropSettings(prop));
				case ComparisonEnsemblePF.ST_XLABEL % __ComparisonEnsemblePF.ST_XLABEL__
					check = Format.checkFormat(Format.ITEM, value, ComparisonEnsemblePF.getPropSettings(prop));
				case ComparisonEnsemblePF.H_YLABEL % __ComparisonEnsemblePF.H_YLABEL__
					check = Format.checkFormat(Format.HANDLE, value, ComparisonEnsemblePF.getPropSettings(prop));
				case ComparisonEnsemblePF.ST_YLABEL % __ComparisonEnsemblePF.ST_YLABEL__
					check = Format.checkFormat(Format.ITEM, value, ComparisonEnsemblePF.getPropSettings(prop));
				case ComparisonEnsemblePF.TEMPLATE % __ComparisonEnsemblePF.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, ComparisonEnsemblePF.getPropSettings(prop));
				otherwise
					if prop <= PanelFig.getPropNumber()
						check = checkProp@PanelFig(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ComparisonEnsemblePF:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ComparisonEnsemblePF:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' ComparisonEnsemblePF.getPropTag(prop) ' (' ComparisonEnsemblePF.getFormatTag(ComparisonEnsemblePF.getPropFormat(prop)) ').'] ...
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
				case ComparisonEnsemblePF.ST_AXIS % __ComparisonEnsemblePF.ST_AXIS__
					if pf.get('DRAWN')
					    toolbar = pf.get('H_TOOLBAR');
					    if check_graphics(toolbar, 'uitoolbar')
					        set(findobj(toolbar, 'Tag', 'TOOL.Grid'), 'State', pf.get('ST_AXIS').get('GRID'))
					        set(findobj(toolbar, 'Tag', 'TOOL.Axis'), 'State', pf.get('ST_AXIS').get('AXIS'))
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
				case ComparisonEnsemblePF.H_AXES % __ComparisonEnsemblePF.H_AXES__
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
					
				case ComparisonEnsemblePF.LISTENER_ST_AXIS % __ComparisonEnsemblePF.LISTENER_ST_AXIS__
					value = listener(pf.get('ST_AXIS'), 'PropSet', @cb_listener_st_axis);
					
				case ComparisonEnsemblePF.SETUP % __ComparisonEnsemblePF.SETUP__
					value = [];
					
				case ComparisonEnsemblePF.H_AREA % __ComparisonEnsemblePF.H_AREA__
					value = fill(pf.get('H_AXES'), [0], [0], 'k');
					
				case ComparisonEnsemblePF.LISTENER_ST_AREA % __ComparisonEnsemblePF.LISTENER_ST_AREA__
					value = listener(pf.get('ST_AREA'), 'PropSet', @cb_listener_st_area);
					
				case ComparisonEnsemblePF.H_LINE_DIFF % __ComparisonEnsemblePF.H_LINE_DIFF__
					value = plot(pf.get('H_AXES'), [0], [0], 'b', 'LineWidth', 2);
					
				case ComparisonEnsemblePF.LISTENER_ST_LINE_DIFF % __ComparisonEnsemblePF.LISTENER_ST_LINE_DIFF__
					value = listener(pf.get('ST_LINE_DIFF'), 'PropSet', @cb_listener_st_line_diff);
					
				case ComparisonEnsemblePF.H_LINE_CIL % __ComparisonEnsemblePF.H_LINE_CIL__
					value = plot(pf.get('H_AXES'), [0], [0], 'b', 'LineWidth', 2);
					
				case ComparisonEnsemblePF.LISTENER_ST_LINE_CIL % __ComparisonEnsemblePF.LISTENER_ST_LINE_CIL__
					value = listener(pf.get('ST_LINE_DIFF'), 'PropSet', @cb_listener_st_line_cil);
					
				case ComparisonEnsemblePF.H_LINE_CIU % __ComparisonEnsemblePF.H_LINE_CIU__
					value = plot(pf.get('H_AXES'), [0], [0], 'b', 'LineWidth', 2);
					
				case ComparisonEnsemblePF.LISTENER_ST_LINE_CIU % __ComparisonEnsemblePF.LISTENER_ST_LINE_CIU__
					value = listener(pf.get('ST_LINE_CIU'), 'PropSet', @cb_listener_st_line_ciu);
					
				case ComparisonEnsemblePF.H_TITLE % __ComparisonEnsemblePF.H_TITLE__
					value = title(pf.get('H_AXES'), '');
					
					if isa(pf.getr('ST_TITLE'), 'NoValue')
					    st = pf.memorize('ST_TITLE');
					    
					    position = get(value, 'Position');
					    st.set( ...
					        'TXT', pf.get('CP').get('LABEL'), ...
					        'X', position(1), ...
					        'Y', position(2), ...
					        'Z', position(3) ...
					        )
					end
					
				case ComparisonEnsemblePF.H_XLABEL % __ComparisonEnsemblePF.H_XLABEL__
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
					
				case ComparisonEnsemblePF.H_YLABEL % __ComparisonEnsemblePF.H_YLABEL__
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
					
				case ComparisonEnsemblePF.DRAW % __ComparisonEnsemblePF.DRAW__
					value = calculateValue@PanelFig(pf, PanelFig.DRAW, varargin{:}); % also warning
					if value
					    pf.memorize('H_AXES')
					    
					    pf.memorize('ST_AXIS').set('PANEL', pf, 'PROP', ComparisonEnsemblePF.H_AXES).get('SETUP')
					    pf.memorize('LISTENER_ST_AXIS');
					    
					    pf.memorize('H_AREA')
					    pf.memorize('ST_AREA').set('PANEL', pf, 'PROP', ComparisonEnsemblePF.H_AREA).get('SETUP')
					    pf.memorize('LISTENER_ST_AREA');
					
					    pf.memorize('H_LINE_DIFF')
					    pf.memorize('ST_LINE_DIFF').set('PANEL', pf, 'PROP', ComparisonEnsemblePF.H_LINE_DIFF).get('SETUP')
						pf.memorize('LISTENER_ST_LINE_DIFF');
					    
					    pf.memorize('H_LINE_CIL')
					    pf.memorize('ST_LINE_CIL').set('PANEL', pf, 'PROP', ComparisonEnsemblePF.H_LINE_CIL).get('SETUP')
						pf.memorize('LISTENER_ST_LINE_CIL');
					
					    pf.memorize('H_LINE_CIU')
					    pf.memorize('ST_LINE_CIU').set('PANEL', pf, 'PROP', ComparisonEnsemblePF.H_LINE_CIU).get('SETUP')
						pf.memorize('LISTENER_ST_LINE_CIU');
					
					    pf.memorize('H_TITLE')
					    pf.memorize('ST_TITLE').set('PANEL', pf, 'PROP', ComparisonEnsemblePF.H_TITLE).get('SETUP')
					
					    pf.memorize('H_XLABEL')
					    pf.memorize('ST_XLABEL').set('PANEL', pf, 'PROP', ComparisonEnsemblePF.H_XLABEL).get('SETUP')
					    
					    pf.memorize('H_YLABEL')
					    pf.memorize('ST_YLABEL').set('PANEL', pf, 'PROP', ComparisonEnsemblePF.H_YLABEL).get('SETUP')
					
					    pf.get('SETUP')
					end
					
				case ComparisonEnsemblePF.DELETE % __ComparisonEnsemblePF.DELETE__
					value = calculateValue@PanelFig(pf, PanelFig.DELETE, varargin{:}); % also warning
					if value
					    pf.set('H_AXES', Element.getNoValue())
					
					    pf.set('LISTENER_ST_AXIS', Element.getNoValue())
					    
					    pf.set('H_AREA', Element.getNoValue())
					    pf.set('LISTENER_ST_AREA', Element.getNoValue())
					 
					    pf.set('H_LINE_DIFF', Element.getNoValue())
					    pf.set('LISTENER_ST_LINE_DIFF', Element.getNoValue())
					
					    pf.set('H_LINE_CIL', Element.getNoValue())
					    pf.set('LISTENER_ST_LINE_CIL', Element.getNoValue())
					
					    pf.set('H_LINE_CIU', Element.getNoValue())
					    pf.set('LISTENER_ST_LINE_CIU', Element.getNoValue())
					
					    pf.set('H_TITLE', Element.getNoValue())
					
					    pf.set('H_XLABEL', Element.getNoValue())
					    
					    pf.set('H_YLABEL', Element.getNoValue())
					end
					
				case ComparisonEnsemblePF.H_TOOLS % __ComparisonEnsemblePF.H_TOOLS__
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
					    
					    % Difference Line
					    tool_line_diff = uitoggletool(toolbar, ...
					        'Tag', 'TOOL.Line_Diff', ...
					        'State', pf.get('ST_LINE_DIFF').get('VISIBLE'), ...
					        'Tooltip', 'Show difference line', ...
					        'CData', imresize(imread('icon_line.png'), [24 24]), ... % % % make icon 16x16
					        'OnCallback', {@cb_line_diff, true}, ...
					        'OffCallback', {@cb_line_diff, false});
					
					    % Difference Line
					    tool_line_ci = uitoggletool(toolbar, ...
					        'Tag', 'TOOL.Line_CI', ...
					        'State', pf.get('ST_LINE_DIFF').get('VISIBLE'), ...
					        'Tooltip', 'Show confidence lines (95%)', ...
					        'CData', imresize(imread('icon_line.png'), [24 24]), ... % % % imread('icon_lines_two.png'), ...
					        'OnCallback', {@cb_line_ci, true}, ...
					        'OffCallback', {@cb_line_ci, false});
					    
					    % Confidence Area
					    tool_area = uitoggletool(toolbar, ...
					        'Tag', 'TOOL.Area', ...
					        'State', pf.get('ST_AREA').get('VISIBLE'), ...
					        'Tooltip', 'Show confidence area (95%)', ...
					        'CData', imresize(imread('icon_area.png'), [24 24]), ... % % % make icon 16x16
					        'OnCallback', {@cb_area, true}, ...
					        'OffCallback', {@cb_area, false});
					
					    value = {value{:}, ...
					        tool_separator_1, ...
					        tool_axis, tool_grid, ... 
					        tool_separator_2, ... 
					        tool_line_diff, tool_line_ci, tool_area ...
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
			function cb_listener_st_area(~, ~)
			    if pf.get('DRAWN')
			        toolbar = pf.get('H_TOOLBAR');
			        if check_graphics(toolbar, 'uitoolbar')
			            set(findobj(toolbar, 'Tag', 'TOOL.Area'), 'State', pf.get('ST_AREA').get('VISIBLE'))
			        end
			    end
			end
			function cb_listener_st_line_diff(~, ~)
			    if pf.get('DRAWN')
			        toolbar = pf.get('H_TOOLBAR');
			        if check_graphics(toolbar, 'uitoolbar')
			            set(findobj(toolbar, 'Tag', 'TOOL.Line_DIff'), 'State', pf.get('ST_LINE_DIFF').get('VISIBLE'))
			        end
			    end
			end
			function cb_listener_st_line_cil(~, ~)
			    if pf.get('DRAWN')
			        toolbar = pf.get('H_TOOLBAR');
			        if check_graphics(toolbar, 'uitoolbar')
			            set(findobj(toolbar, 'Tag', 'TOOL.Line_CI'), 'State', pf.get('ST_LINE_CIL').get('VISIBLE'))
			        end
			    end
			end
			function cb_listener_st_line_ciu(~, ~)
			    if pf.get('DRAWN')
			        toolbar = pf.get('H_TOOLBAR');
			        if check_graphics(toolbar, 'uitoolbar')
			            set(findobj(toolbar, 'Tag', 'TOOL.Line_CI'), 'State', pf.get('ST_LINE_CIU').get('VISIBLE'))
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
			function cb_line_diff(~, ~, visible) % (src, event)
				pf.get('ST_LINE_DIFF').set('VISIBLE', visible)
			
			    % triggers the update of ST_LINE_DIFF
			    pf.set('ST_LINE_DIFF', pf.get('ST_LINE_DIFF'))
			end
			function cb_line_ci(~, ~, visible) % (src, event)
				pf.get('ST_LINE_CIL').set('VISIBLE', visible)
				pf.get('ST_LINE_CIU').set('VISIBLE', visible)
			
			    % triggers the update of ST_LINE_CIL and ST_LINE_CIU
			    pf.set('ST_LINE_CIL', pf.get('ST_LINE_CIL'))
			    pf.set('ST_LINE_CIU', pf.get('ST_LINE_CIU'))
			end
			function cb_area(~, ~, visible) % (src, event)
			    pf.get('ST_AREA').set('VISIBLE', visible)
			
			    % triggers the update of ST_AREA
			    pf.set('ST_AREA', pf.get('ST_AREA'))
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
				case ComparisonEnsemblePF.ST_AXIS % __ComparisonEnsemblePF.ST_AXIS__
					pr = SettingsAxisPP('EL', pf, 'PROP', ComparisonEnsemblePF.ST_AXIS, varargin{:});
					
				case ComparisonEnsemblePF.ST_AREA % __ComparisonEnsemblePF.ST_AREA__
					pr = SettingsAreaPP('EL', pf, 'PROP', ComparisonEnsemblePF.ST_AREA, varargin{:});
					
				case ComparisonEnsemblePF.ST_LINE_DIFF % __ComparisonEnsemblePF.ST_LINE_DIFF__
					pr = SettingsLinePP('EL', pf, 'PROP', ComparisonEnsemblePF.ST_LINE_DIFF, varargin{:});
					
				case ComparisonEnsemblePF.ST_LINE_CIL % __ComparisonEnsemblePF.ST_LINE_CIL__
					pr = SettingsLinePP('EL', pf, 'PROP', ComparisonEnsemblePF.ST_LINE_CIL, varargin{:});
					
				case ComparisonEnsemblePF.ST_LINE_CIU % __ComparisonEnsemblePF.ST_LINE_CIU__
					pr = SettingsLinePP('EL', pf, 'PROP', ComparisonEnsemblePF.ST_LINE_CIU, varargin{:});
					
				case ComparisonEnsemblePF.ST_TITLE % __ComparisonEnsemblePF.ST_TITLE__
					pr = SettingsTextPP('EL', pf, 'PROP', ComparisonEnsemblePF.ST_TITLE, varargin{:});
					
				case ComparisonEnsemblePF.ST_XLABEL % __ComparisonEnsemblePF.ST_XLABEL__
					pr = SettingsTextPP('EL', pf, 'PROP', ComparisonEnsemblePF.ST_XLABEL, varargin{:});
					
				case ComparisonEnsemblePF.ST_YLABEL % __ComparisonEnsemblePF.ST_YLABEL__
					pr = SettingsTextPP('EL', pf, 'PROP', ComparisonEnsemblePF.ST_YLABEL, varargin{:});
					
				otherwise
					pr = getPanelProp@PanelFig(pf, prop, varargin{:});
					
			end
		end
	end
end
