classdef ComparisonGroupBrainPF < BrainAtlasPF
	%ComparisonGroupBrainPF is the base element to plot a group comparison on brain surface.
	% It is a subclass of <a href="matlab:help BrainAtlasPF">BrainAtlasPF</a>.
	%
	% ComparisonGroupBrainPF manages the basic functionalities to plot of a group comparison on brain surface.
	%
	% ComparisonGroupBrainPF methods (constructor):
	%  ComparisonGroupBrainPF - constructor
	%
	% ComparisonGroupBrainPF methods:
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
	% ComparisonGroupBrainPF methods (display):
	%  tostring - string with information about the brain panel group comparison on brain surface figure
	%  disp - displays information about the brain panel group comparison on brain surface figure
	%  tree - displays the tree of the brain panel group comparison on brain surface figure
	%
	% ComparisonGroupBrainPF methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two brain panel group comparison on brain surface figure are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the brain panel group comparison on brain surface figure
	%
	% ComparisonGroupBrainPF methods (save/load, Static):
	%  save - saves BRAPH2 brain panel group comparison on brain surface figure as b2 file
	%  load - loads a BRAPH2 brain panel group comparison on brain surface figure from a b2 file
	%
	% ComparisonGroupBrainPF method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the brain panel group comparison on brain surface figure
	%
	% ComparisonGroupBrainPF method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the brain panel group comparison on brain surface figure
	%
	% ComparisonGroupBrainPF methods (inspection, Static):
	%  getClass - returns the class of the brain panel group comparison on brain surface figure
	%  getSubclasses - returns all subclasses of ComparisonGroupBrainPF
	%  getProps - returns the property list of the brain panel group comparison on brain surface figure
	%  getPropNumber - returns the property number of the brain panel group comparison on brain surface figure
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
	% ComparisonGroupBrainPF methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% ComparisonGroupBrainPF methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% ComparisonGroupBrainPF methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% ComparisonGroupBrainPF methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?ComparisonGroupBrainPF; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">ComparisonGroupBrainPF constants</a>.
	%
	%
	% See also ComparisonGroup, BrainAtlasPF.
	
	properties (Constant) % properties
		CP = BrainAtlasPF.getPropNumber() + 1;
		CP_TAG = 'CP';
		CP_CATEGORY = Category.METADATA;
		CP_FORMAT = Format.ITEM;
		
		SETUP = BrainAtlasPF.getPropNumber() + 2;
		SETUP_TAG = 'SETUP';
		SETUP_CATEGORY = Category.QUERY;
		SETUP_FORMAT = Format.EMPTY;
	end
	methods % constructor
		function pf = ComparisonGroupBrainPF(varargin)
			%ComparisonGroupBrainPF() creates a brain panel group comparison on brain surface figure.
			%
			% ComparisonGroupBrainPF(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% ComparisonGroupBrainPF(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			pf = pf@BrainAtlasPF(varargin{:});
		end
	end
	methods (Static) % inspection
		function pf_class = getClass()
			%GETCLASS returns the class of the brain panel group comparison on brain surface figure.
			%
			% CLASS = ComparisonGroupBrainPF.GETCLASS() returns the class 'ComparisonGroupBrainPF'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PF.GETCLASS() returns the class of the brain panel group comparison on brain surface figure PF.
			%  CLASS = Element.GETCLASS(PF) returns the class of 'PF'.
			%  CLASS = Element.GETCLASS('ComparisonGroupBrainPF') returns 'ComparisonGroupBrainPF'.
			%
			% Note that the Element.GETCLASS(PF) and Element.GETCLASS('ComparisonGroupBrainPF')
			%  are less computationally efficient.
			
			pf_class = 'ComparisonGroupBrainPF';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the brain panel group comparison on brain surface figure.
			%
			% LIST = ComparisonGroupBrainPF.GETSUBCLASSES() returns all subclasses of 'ComparisonGroupBrainPF'.
			%
			% Alternative forms to call this method are:
			%  LIST = PF.GETSUBCLASSES() returns all subclasses of the brain panel group comparison on brain surface figure PF.
			%  LIST = Element.GETSUBCLASSES(PF) returns all subclasses of 'PF'.
			%  LIST = Element.GETSUBCLASSES('ComparisonGroupBrainPF') returns all subclasses of 'ComparisonGroupBrainPF'.
			%
			% Note that the Element.GETSUBCLASSES(PF) and Element.GETSUBCLASSES('ComparisonGroupBrainPF')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('ComparisonGroupBrainPF', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of brain panel group comparison on brain surface figure.
			%
			% PROPS = ComparisonGroupBrainPF.GETPROPS() returns the property list of brain panel group comparison on brain surface figure
			%  as a row vector.
			%
			% PROPS = ComparisonGroupBrainPF.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PF.GETPROPS([CATEGORY]) returns the property list of the brain panel group comparison on brain surface figure PF.
			%  PROPS = Element.GETPROPS(PF[, CATEGORY]) returns the property list of 'PF'.
			%  PROPS = Element.GETPROPS('ComparisonGroupBrainPF'[, CATEGORY]) returns the property list of 'ComparisonGroupBrainPF'.
			%
			% Note that the Element.GETPROPS(PF) and Element.GETPROPS('ComparisonGroupBrainPF')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					BrainAtlasPF.getProps() ...
						ComparisonGroupBrainPF.CP ...
						ComparisonGroupBrainPF.SETUP ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						BrainAtlasPF.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						BrainAtlasPF.getProps(Category.METADATA) ...
						ComparisonGroupBrainPF.CP ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						BrainAtlasPF.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						BrainAtlasPF.getProps(Category.DATA) ...
						];
				case Category.RESULT
					prop_list = [
						BrainAtlasPF.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						BrainAtlasPF.getProps(Category.QUERY) ...
						ComparisonGroupBrainPF.SETUP ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						BrainAtlasPF.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						BrainAtlasPF.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						BrainAtlasPF.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of brain panel group comparison on brain surface figure.
			%
			% N = ComparisonGroupBrainPF.GETPROPNUMBER() returns the property number of brain panel group comparison on brain surface figure.
			%
			% N = ComparisonGroupBrainPF.GETPROPNUMBER(CATEGORY) returns the property number of brain panel group comparison on brain surface figure
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PF.GETPROPNUMBER([CATEGORY]) returns the property number of the brain panel group comparison on brain surface figure PF.
			%  N = Element.GETPROPNUMBER(PF) returns the property number of 'PF'.
			%  N = Element.GETPROPNUMBER('ComparisonGroupBrainPF') returns the property number of 'ComparisonGroupBrainPF'.
			%
			% Note that the Element.GETPROPNUMBER(PF) and Element.GETPROPNUMBER('ComparisonGroupBrainPF')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(ComparisonGroupBrainPF.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in brain panel group comparison on brain surface figure/error.
			%
			% CHECK = ComparisonGroupBrainPF.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSPROP(PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(PF, PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(ComparisonGroupBrainPF, PROP) checks whether PROP exists for ComparisonGroupBrainPF.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:ComparisonGroupBrainPF:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSPROP(PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:ComparisonGroupBrainPF:WrongInput]
			%  Element.EXISTSPROP(PF, PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:ComparisonGroupBrainPF:WrongInput]
			%  Element.EXISTSPROP(ComparisonGroupBrainPF, PROP) throws error if PROP does NOT exist for ComparisonGroupBrainPF.
			%   Error id: [BRAPH2:ComparisonGroupBrainPF:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PF) and Element.EXISTSPROP('ComparisonGroupBrainPF')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == ComparisonGroupBrainPF.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ComparisonGroupBrainPF:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ComparisonGroupBrainPF:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for ComparisonGroupBrainPF.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in brain panel group comparison on brain surface figure/error.
			%
			% CHECK = ComparisonGroupBrainPF.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSTAG(TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(PF, TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(ComparisonGroupBrainPF, TAG) checks whether TAG exists for ComparisonGroupBrainPF.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:ComparisonGroupBrainPF:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSTAG(TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:ComparisonGroupBrainPF:WrongInput]
			%  Element.EXISTSTAG(PF, TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:ComparisonGroupBrainPF:WrongInput]
			%  Element.EXISTSTAG(ComparisonGroupBrainPF, TAG) throws error if TAG does NOT exist for ComparisonGroupBrainPF.
			%   Error id: [BRAPH2:ComparisonGroupBrainPF:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PF) and Element.EXISTSTAG('ComparisonGroupBrainPF')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			comparisongroupbrainpf_tag_list = cellfun(@(x) ComparisonGroupBrainPF.getPropTag(x), num2cell(ComparisonGroupBrainPF.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, comparisongroupbrainpf_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ComparisonGroupBrainPF:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ComparisonGroupBrainPF:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for ComparisonGroupBrainPF.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(ComparisonGroupBrainPF, POINTER) returns property number of POINTER of ComparisonGroupBrainPF.
			%  PROPERTY = PF.GETPROPPROP(ComparisonGroupBrainPF, POINTER) returns property number of POINTER of ComparisonGroupBrainPF.
			%
			% Note that the Element.GETPROPPROP(PF) and Element.GETPROPPROP('ComparisonGroupBrainPF')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				comparisongroupbrainpf_tag_list = cellfun(@(x) ComparisonGroupBrainPF.getPropTag(x), num2cell(ComparisonGroupBrainPF.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, comparisongroupbrainpf_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(ComparisonGroupBrainPF, POINTER) returns tag of POINTER of ComparisonGroupBrainPF.
			%  TAG = PF.GETPROPTAG(ComparisonGroupBrainPF, POINTER) returns tag of POINTER of ComparisonGroupBrainPF.
			%
			% Note that the Element.GETPROPTAG(PF) and Element.GETPROPTAG('ComparisonGroupBrainPF')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case ComparisonGroupBrainPF.CP
						tag = ComparisonGroupBrainPF.CP_TAG;
					case ComparisonGroupBrainPF.SETUP
						tag = ComparisonGroupBrainPF.SETUP_TAG;
					otherwise
						tag = getPropTag@BrainAtlasPF(prop);
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
			%  CATEGORY = Element.GETPROPCATEGORY(ComparisonGroupBrainPF, POINTER) returns category of POINTER of ComparisonGroupBrainPF.
			%  CATEGORY = PF.GETPROPCATEGORY(ComparisonGroupBrainPF, POINTER) returns category of POINTER of ComparisonGroupBrainPF.
			%
			% Note that the Element.GETPROPCATEGORY(PF) and Element.GETPROPCATEGORY('ComparisonGroupBrainPF')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = ComparisonGroupBrainPF.getPropProp(pointer);
			
			switch prop
				case ComparisonGroupBrainPF.CP
					prop_category = ComparisonGroupBrainPF.CP_CATEGORY;
				case ComparisonGroupBrainPF.SETUP
					prop_category = ComparisonGroupBrainPF.SETUP_CATEGORY;
				otherwise
					prop_category = getPropCategory@BrainAtlasPF(prop);
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
			%  FORMAT = Element.GETPROPFORMAT(ComparisonGroupBrainPF, POINTER) returns format of POINTER of ComparisonGroupBrainPF.
			%  FORMAT = PF.GETPROPFORMAT(ComparisonGroupBrainPF, POINTER) returns format of POINTER of ComparisonGroupBrainPF.
			%
			% Note that the Element.GETPROPFORMAT(PF) and Element.GETPROPFORMAT('ComparisonGroupBrainPF')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = ComparisonGroupBrainPF.getPropProp(pointer);
			
			switch prop
				case ComparisonGroupBrainPF.CP
					prop_format = ComparisonGroupBrainPF.CP_FORMAT;
				case ComparisonGroupBrainPF.SETUP
					prop_format = ComparisonGroupBrainPF.SETUP_FORMAT;
				otherwise
					prop_format = getPropFormat@BrainAtlasPF(prop);
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(ComparisonGroupBrainPF, POINTER) returns description of POINTER of ComparisonGroupBrainPF.
			%  DESCRIPTION = PF.GETPROPDESCRIPTION(ComparisonGroupBrainPF, POINTER) returns description of POINTER of ComparisonGroupBrainPF.
			%
			% Note that the Element.GETPROPDESCRIPTION(PF) and Element.GETPROPDESCRIPTION('ComparisonGroupBrainPF')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = ComparisonGroupBrainPF.getPropProp(pointer);
			
			switch prop
				case ComparisonGroupBrainPF.CP
					prop_description = 'CP (metadata, item) is the group comparison on brain surface.';
				case ComparisonGroupBrainPF.SETUP
					prop_description = 'SETUP (query, empty) calculates the group comparison on brain surface value and stores it to be implemented in the subelements.';
				case ComparisonGroupBrainPF.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the  % % % .';
				case ComparisonGroupBrainPF.NAME
					prop_description = 'NAME (constant, string) is the name of the brain panel group comparison on brain surface figure.';
				case ComparisonGroupBrainPF.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the brain panel group comparison on brain surface figure.';
				case ComparisonGroupBrainPF.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the brain panel group comparison on brain surface figure.';
				case ComparisonGroupBrainPF.ID
					prop_description = 'ID (data, string) is a few-letter code for the brain panel group comparison on brain surface figure.';
				case ComparisonGroupBrainPF.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the brain panel group comparison on brain surface figure.';
				case ComparisonGroupBrainPF.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the brain panel group comparison on brain surface figure.';
				case ComparisonGroupBrainPF.DRAW
					prop_description = 'DRAW (query, logical) draws the figure comparison figure.';
				case ComparisonGroupBrainPF.DELETE
					prop_description = 'DELETE (query, logical) resets the handles when the brain panel figure graph is deleted.';
				case ComparisonGroupBrainPF.H_TOOLS
					prop_description = 'H_TOOLS (evanescent, handlelist) is the list of panel-specific tools from the first.';
				otherwise
					prop_description = getPropDescription@BrainAtlasPF(prop);
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
			%  SETTINGS = Element.GETPROPSETTINGS(ComparisonGroupBrainPF, POINTER) returns settings of POINTER of ComparisonGroupBrainPF.
			%  SETTINGS = PF.GETPROPSETTINGS(ComparisonGroupBrainPF, POINTER) returns settings of POINTER of ComparisonGroupBrainPF.
			%
			% Note that the Element.GETPROPSETTINGS(PF) and Element.GETPROPSETTINGS('ComparisonGroupBrainPF')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = ComparisonGroupBrainPF.getPropProp(pointer);
			
			switch prop
				case ComparisonGroupBrainPF.CP
					prop_settings = 'ComparisonGroup';
				case ComparisonGroupBrainPF.SETUP
					prop_settings = Format.getFormatSettings(Format.EMPTY);
				case ComparisonGroupBrainPF.TEMPLATE
					prop_settings = 'ComparisonGroupBrainPF';
				otherwise
					prop_settings = getPropSettings@BrainAtlasPF(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = ComparisonGroupBrainPF.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = ComparisonGroupBrainPF.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULT(ComparisonGroupBrainPF, POINTER) returns the default value of POINTER of ComparisonGroupBrainPF.
			%  DEFAULT = PF.GETPROPDEFAULT(ComparisonGroupBrainPF, POINTER) returns the default value of POINTER of ComparisonGroupBrainPF.
			%
			% Note that the Element.GETPROPDEFAULT(PF) and Element.GETPROPDEFAULT('ComparisonGroupBrainPF')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = ComparisonGroupBrainPF.getPropProp(pointer);
			
			switch prop
				case ComparisonGroupBrainPF.CP
					prop_default = Format.getFormatDefault(Format.ITEM, ComparisonGroupBrainPF.getPropSettings(prop));
				case ComparisonGroupBrainPF.SETUP
					prop_default = Format.getFormatDefault(Format.EMPTY, ComparisonGroupBrainPF.getPropSettings(prop));
				case ComparisonGroupBrainPF.ELCLASS
					prop_default = 'ComparisonGroupBrainPF';
				case ComparisonGroupBrainPF.NAME
					prop_default = 'ComparisonGroupBrainPF';
				case ComparisonGroupBrainPF.DESCRIPTION
					prop_default = 'ComparisonGroupBrainPF manages the basic functionalities to plot of a group comparison on brain surface.';
				case ComparisonGroupBrainPF.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, ComparisonGroupBrainPF.getPropSettings(prop));
				case ComparisonGroupBrainPF.ID
					prop_default = 'ComparisonGroupBrainPF ID';
				case ComparisonGroupBrainPF.LABEL
					prop_default = 'ComparisonGroupBrainPF label';
				case ComparisonGroupBrainPF.NOTES
					prop_default = 'ComparisonGroupBrainPF notes';
				otherwise
					prop_default = getPropDefault@BrainAtlasPF(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = ComparisonGroupBrainPF.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = ComparisonGroupBrainPF.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(ComparisonGroupBrainPF, POINTER) returns the conditioned default value of POINTER of ComparisonGroupBrainPF.
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(ComparisonGroupBrainPF, POINTER) returns the conditioned default value of POINTER of ComparisonGroupBrainPF.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PF) and Element.GETPROPDEFAULTCONDITIONED('ComparisonGroupBrainPF')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = ComparisonGroupBrainPF.getPropProp(pointer);
			
			prop_default = ComparisonGroupBrainPF.conditioning(prop, ComparisonGroupBrainPF.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(ComparisonGroupBrainPF, PROP, VALUE) checks VALUE format for PROP of ComparisonGroupBrainPF.
			%  CHECK = PF.CHECKPROP(ComparisonGroupBrainPF, PROP, VALUE) checks VALUE format for PROP of ComparisonGroupBrainPF.
			% 
			% PF.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:ComparisonGroupBrainPF:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PF.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PF.
			%   Error id: €BRAPH2.STR€:ComparisonGroupBrainPF:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(ComparisonGroupBrainPF, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ComparisonGroupBrainPF.
			%   Error id: €BRAPH2.STR€:ComparisonGroupBrainPF:€BRAPH2.WRONG_INPUT€
			%  PF.CHECKPROP(ComparisonGroupBrainPF, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ComparisonGroupBrainPF.
			%   Error id: €BRAPH2.STR€:ComparisonGroupBrainPF:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PF) and Element.CHECKPROP('ComparisonGroupBrainPF')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = ComparisonGroupBrainPF.getPropProp(pointer);
			
			switch prop
				case ComparisonGroupBrainPF.CP % __ComparisonGroupBrainPF.CP__
					check = Format.checkFormat(Format.ITEM, value, ComparisonGroupBrainPF.getPropSettings(prop));
				case ComparisonGroupBrainPF.SETUP % __ComparisonGroupBrainPF.SETUP__
					check = Format.checkFormat(Format.EMPTY, value, ComparisonGroupBrainPF.getPropSettings(prop));
				case ComparisonGroupBrainPF.TEMPLATE % __ComparisonGroupBrainPF.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, ComparisonGroupBrainPF.getPropSettings(prop));
				otherwise
					if prop <= BrainAtlasPF.getPropNumber()
						check = checkProp@BrainAtlasPF(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ComparisonGroupBrainPF:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ComparisonGroupBrainPF:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' ComparisonGroupBrainPF.getPropTag(prop) ' (' ComparisonGroupBrainPF.getFormatTag(ComparisonGroupBrainPF.getPropFormat(prop)) ').'] ...
					)
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
				case ComparisonGroupBrainPF.SETUP % __ComparisonGroupBrainPF.SETUP__
					value = [];
					
				case ComparisonGroupBrainPF.DRAW % __ComparisonGroupBrainPF.DRAW__
					value = calculateValue@BrainAtlasPF(pf, BrainAtlasPF.DRAW, varargin{:}); % also warning
					if value
					    pf.get('SETUP')
					end
					
				case ComparisonGroupBrainPF.DELETE % __ComparisonGroupBrainPF.DELETE__
					value = calculateValue@BrainAtlasPF(pf, BrainAtlasPF.DELETE, varargin{:}); % also warning
					if value
					    % do nothing
					
					end
					
				case ComparisonGroupBrainPF.H_TOOLS % __ComparisonGroupBrainPF.H_TOOLS__
					toolbar = pf.memorize('H_TOOLBAR');
					if check_graphics(toolbar, 'uitoolbar')
					    value = calculateValue@BrainAtlasPF(pf, BrainAtlasPF.H_TOOLS, varargin{:});
					    
					    % tool_separator_1 = uipushtool(toolbar, 'Separator', 'on', 'Visible', 'off');
					    % 
					    % value = {value{:}, ...
					    %     tool_separator_1,  ...
					    %     };
					else
					    value = {};
					end
					
				otherwise
					if prop <= BrainAtlasPF.getPropNumber()
						value = calculateValue@BrainAtlasPF(pf, prop, varargin{:});
					else
						value = calculateValue@Element(pf, prop, varargin{:});
					end
			end
			
		end
	end
end
