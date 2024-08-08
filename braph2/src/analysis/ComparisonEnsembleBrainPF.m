classdef ComparisonEnsembleBrainPF < BrainAtlasPF
	%ComparisonEnsembleBrainPF is the base element to plot an ensemble-based comparison on brain surface figure.
	% It is a subclass of <a href="matlab:help BrainAtlasPF">BrainAtlasPF</a>.
	%
	% ComparisonEnsembleBrainPF manages the basic functionalities to plot of an ensemble-based comparison on brain surface figure.
	%
	% ComparisonEnsembleBrainPF methods (constructor):
	%  ComparisonEnsembleBrainPF - constructor
	%
	% ComparisonEnsembleBrainPF methods:
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
	% ComparisonEnsembleBrainPF methods (display):
	%  tostring - string with information about the panel ensemble-based comparison figure on brain surface figure
	%  disp - displays information about the panel ensemble-based comparison figure on brain surface figure
	%  tree - displays the tree of the panel ensemble-based comparison figure on brain surface figure
	%
	% ComparisonEnsembleBrainPF methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two panel ensemble-based comparison figure on brain surface figure are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the panel ensemble-based comparison figure on brain surface figure
	%
	% ComparisonEnsembleBrainPF methods (save/load, Static):
	%  save - saves BRAPH2 panel ensemble-based comparison figure on brain surface figure as b2 file
	%  load - loads a BRAPH2 panel ensemble-based comparison figure on brain surface figure from a b2 file
	%
	% ComparisonEnsembleBrainPF method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the panel ensemble-based comparison figure on brain surface figure
	%
	% ComparisonEnsembleBrainPF method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the panel ensemble-based comparison figure on brain surface figure
	%
	% ComparisonEnsembleBrainPF methods (inspection, Static):
	%  getClass - returns the class of the panel ensemble-based comparison figure on brain surface figure
	%  getSubclasses - returns all subclasses of ComparisonEnsembleBrainPF
	%  getProps - returns the property list of the panel ensemble-based comparison figure on brain surface figure
	%  getPropNumber - returns the property number of the panel ensemble-based comparison figure on brain surface figure
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
	% ComparisonEnsembleBrainPF methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% ComparisonEnsembleBrainPF methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% ComparisonEnsembleBrainPF methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% ComparisonEnsembleBrainPF methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?ComparisonEnsembleBrainPF; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">ComparisonEnsembleBrainPF constants</a>.
	%
	%
	% See also ComparisonEnsemble.
	
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
		function pf = ComparisonEnsembleBrainPF(varargin)
			%ComparisonEnsembleBrainPF() creates a panel ensemble-based comparison figure on brain surface figure.
			%
			% ComparisonEnsembleBrainPF(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% ComparisonEnsembleBrainPF(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the panel ensemble-based comparison figure on brain surface figure.
			%
			% CLASS = ComparisonEnsembleBrainPF.GETCLASS() returns the class 'ComparisonEnsembleBrainPF'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PF.GETCLASS() returns the class of the panel ensemble-based comparison figure on brain surface figure PF.
			%  CLASS = Element.GETCLASS(PF) returns the class of 'PF'.
			%  CLASS = Element.GETCLASS('ComparisonEnsembleBrainPF') returns 'ComparisonEnsembleBrainPF'.
			%
			% Note that the Element.GETCLASS(PF) and Element.GETCLASS('ComparisonEnsembleBrainPF')
			%  are less computationally efficient.
			
			pf_class = 'ComparisonEnsembleBrainPF';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the panel ensemble-based comparison figure on brain surface figure.
			%
			% LIST = ComparisonEnsembleBrainPF.GETSUBCLASSES() returns all subclasses of 'ComparisonEnsembleBrainPF'.
			%
			% Alternative forms to call this method are:
			%  LIST = PF.GETSUBCLASSES() returns all subclasses of the panel ensemble-based comparison figure on brain surface figure PF.
			%  LIST = Element.GETSUBCLASSES(PF) returns all subclasses of 'PF'.
			%  LIST = Element.GETSUBCLASSES('ComparisonEnsembleBrainPF') returns all subclasses of 'ComparisonEnsembleBrainPF'.
			%
			% Note that the Element.GETSUBCLASSES(PF) and Element.GETSUBCLASSES('ComparisonEnsembleBrainPF')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('ComparisonEnsembleBrainPF', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of panel ensemble-based comparison figure on brain surface figure.
			%
			% PROPS = ComparisonEnsembleBrainPF.GETPROPS() returns the property list of panel ensemble-based comparison figure on brain surface figure
			%  as a row vector.
			%
			% PROPS = ComparisonEnsembleBrainPF.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PF.GETPROPS([CATEGORY]) returns the property list of the panel ensemble-based comparison figure on brain surface figure PF.
			%  PROPS = Element.GETPROPS(PF[, CATEGORY]) returns the property list of 'PF'.
			%  PROPS = Element.GETPROPS('ComparisonEnsembleBrainPF'[, CATEGORY]) returns the property list of 'ComparisonEnsembleBrainPF'.
			%
			% Note that the Element.GETPROPS(PF) and Element.GETPROPS('ComparisonEnsembleBrainPF')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					BrainAtlasPF.getProps() ...
						ComparisonEnsembleBrainPF.CP ...
						ComparisonEnsembleBrainPF.SETUP ...
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
						ComparisonEnsembleBrainPF.CP ...
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
						ComparisonEnsembleBrainPF.SETUP ...
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
			%GETPROPNUMBER returns the property number of panel ensemble-based comparison figure on brain surface figure.
			%
			% N = ComparisonEnsembleBrainPF.GETPROPNUMBER() returns the property number of panel ensemble-based comparison figure on brain surface figure.
			%
			% N = ComparisonEnsembleBrainPF.GETPROPNUMBER(CATEGORY) returns the property number of panel ensemble-based comparison figure on brain surface figure
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PF.GETPROPNUMBER([CATEGORY]) returns the property number of the panel ensemble-based comparison figure on brain surface figure PF.
			%  N = Element.GETPROPNUMBER(PF) returns the property number of 'PF'.
			%  N = Element.GETPROPNUMBER('ComparisonEnsembleBrainPF') returns the property number of 'ComparisonEnsembleBrainPF'.
			%
			% Note that the Element.GETPROPNUMBER(PF) and Element.GETPROPNUMBER('ComparisonEnsembleBrainPF')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(ComparisonEnsembleBrainPF.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in panel ensemble-based comparison figure on brain surface figure/error.
			%
			% CHECK = ComparisonEnsembleBrainPF.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSPROP(PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(PF, PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(ComparisonEnsembleBrainPF, PROP) checks whether PROP exists for ComparisonEnsembleBrainPF.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:ComparisonEnsembleBrainPF:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSPROP(PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:ComparisonEnsembleBrainPF:WrongInput]
			%  Element.EXISTSPROP(PF, PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:ComparisonEnsembleBrainPF:WrongInput]
			%  Element.EXISTSPROP(ComparisonEnsembleBrainPF, PROP) throws error if PROP does NOT exist for ComparisonEnsembleBrainPF.
			%   Error id: [BRAPH2:ComparisonEnsembleBrainPF:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PF) and Element.EXISTSPROP('ComparisonEnsembleBrainPF')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == ComparisonEnsembleBrainPF.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ComparisonEnsembleBrainPF:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ComparisonEnsembleBrainPF:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for ComparisonEnsembleBrainPF.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in panel ensemble-based comparison figure on brain surface figure/error.
			%
			% CHECK = ComparisonEnsembleBrainPF.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSTAG(TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(PF, TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(ComparisonEnsembleBrainPF, TAG) checks whether TAG exists for ComparisonEnsembleBrainPF.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:ComparisonEnsembleBrainPF:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSTAG(TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:ComparisonEnsembleBrainPF:WrongInput]
			%  Element.EXISTSTAG(PF, TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:ComparisonEnsembleBrainPF:WrongInput]
			%  Element.EXISTSTAG(ComparisonEnsembleBrainPF, TAG) throws error if TAG does NOT exist for ComparisonEnsembleBrainPF.
			%   Error id: [BRAPH2:ComparisonEnsembleBrainPF:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PF) and Element.EXISTSTAG('ComparisonEnsembleBrainPF')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			comparisonensemblebrainpf_tag_list = cellfun(@(x) ComparisonEnsembleBrainPF.getPropTag(x), num2cell(ComparisonEnsembleBrainPF.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, comparisonensemblebrainpf_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ComparisonEnsembleBrainPF:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ComparisonEnsembleBrainPF:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for ComparisonEnsembleBrainPF.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(ComparisonEnsembleBrainPF, POINTER) returns property number of POINTER of ComparisonEnsembleBrainPF.
			%  PROPERTY = PF.GETPROPPROP(ComparisonEnsembleBrainPF, POINTER) returns property number of POINTER of ComparisonEnsembleBrainPF.
			%
			% Note that the Element.GETPROPPROP(PF) and Element.GETPROPPROP('ComparisonEnsembleBrainPF')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				comparisonensemblebrainpf_tag_list = cellfun(@(x) ComparisonEnsembleBrainPF.getPropTag(x), num2cell(ComparisonEnsembleBrainPF.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, comparisonensemblebrainpf_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(ComparisonEnsembleBrainPF, POINTER) returns tag of POINTER of ComparisonEnsembleBrainPF.
			%  TAG = PF.GETPROPTAG(ComparisonEnsembleBrainPF, POINTER) returns tag of POINTER of ComparisonEnsembleBrainPF.
			%
			% Note that the Element.GETPROPTAG(PF) and Element.GETPROPTAG('ComparisonEnsembleBrainPF')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case ComparisonEnsembleBrainPF.CP
						tag = ComparisonEnsembleBrainPF.CP_TAG;
					case ComparisonEnsembleBrainPF.SETUP
						tag = ComparisonEnsembleBrainPF.SETUP_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(ComparisonEnsembleBrainPF, POINTER) returns category of POINTER of ComparisonEnsembleBrainPF.
			%  CATEGORY = PF.GETPROPCATEGORY(ComparisonEnsembleBrainPF, POINTER) returns category of POINTER of ComparisonEnsembleBrainPF.
			%
			% Note that the Element.GETPROPCATEGORY(PF) and Element.GETPROPCATEGORY('ComparisonEnsembleBrainPF')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = ComparisonEnsembleBrainPF.getPropProp(pointer);
			
			switch prop
				case ComparisonEnsembleBrainPF.CP
					prop_category = ComparisonEnsembleBrainPF.CP_CATEGORY;
				case ComparisonEnsembleBrainPF.SETUP
					prop_category = ComparisonEnsembleBrainPF.SETUP_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(ComparisonEnsembleBrainPF, POINTER) returns format of POINTER of ComparisonEnsembleBrainPF.
			%  FORMAT = PF.GETPROPFORMAT(ComparisonEnsembleBrainPF, POINTER) returns format of POINTER of ComparisonEnsembleBrainPF.
			%
			% Note that the Element.GETPROPFORMAT(PF) and Element.GETPROPFORMAT('ComparisonEnsembleBrainPF')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = ComparisonEnsembleBrainPF.getPropProp(pointer);
			
			switch prop
				case ComparisonEnsembleBrainPF.CP
					prop_format = ComparisonEnsembleBrainPF.CP_FORMAT;
				case ComparisonEnsembleBrainPF.SETUP
					prop_format = ComparisonEnsembleBrainPF.SETUP_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(ComparisonEnsembleBrainPF, POINTER) returns description of POINTER of ComparisonEnsembleBrainPF.
			%  DESCRIPTION = PF.GETPROPDESCRIPTION(ComparisonEnsembleBrainPF, POINTER) returns description of POINTER of ComparisonEnsembleBrainPF.
			%
			% Note that the Element.GETPROPDESCRIPTION(PF) and Element.GETPROPDESCRIPTION('ComparisonEnsembleBrainPF')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = ComparisonEnsembleBrainPF.getPropProp(pointer);
			
			switch prop
				case ComparisonEnsembleBrainPF.CP
					prop_description = 'CP (metadata, item) is the measure.';
				case ComparisonEnsembleBrainPF.SETUP
					prop_description = 'SETUP (query, empty) calculates the diff value and stores it to be implemented in the subelements.';
				case ComparisonEnsembleBrainPF.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of % % % .';
				case ComparisonEnsembleBrainPF.NAME
					prop_description = 'NAME (constant, string) is the name of the panel ensemble-based comparison figure on brain surface.';
				case ComparisonEnsembleBrainPF.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the panel ensemble-based comparison figure on brain surface.';
				case ComparisonEnsembleBrainPF.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the panel ensemble-based comparison figure on brain surface.';
				case ComparisonEnsembleBrainPF.ID
					prop_description = 'ID (data, string) is a few-letter code for the panel ensemble-based comparison figure on brain surface.';
				case ComparisonEnsembleBrainPF.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the panel ensemble-based comparison figure on brain surface.';
				case ComparisonEnsembleBrainPF.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the panel ensemble-based comparison figure on brain surface.';
				case ComparisonEnsembleBrainPF.DRAW
					prop_description = 'DRAW (query, logical) draws the figure brain atlas.';
				case ComparisonEnsembleBrainPF.DELETE
					prop_description = 'DELETE (query, logical) resets the handles when the panel figure brain surface is deleted.';
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
			%  SETTINGS = Element.GETPROPSETTINGS(ComparisonEnsembleBrainPF, POINTER) returns settings of POINTER of ComparisonEnsembleBrainPF.
			%  SETTINGS = PF.GETPROPSETTINGS(ComparisonEnsembleBrainPF, POINTER) returns settings of POINTER of ComparisonEnsembleBrainPF.
			%
			% Note that the Element.GETPROPSETTINGS(PF) and Element.GETPROPSETTINGS('ComparisonEnsembleBrainPF')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = ComparisonEnsembleBrainPF.getPropProp(pointer);
			
			switch prop
				case ComparisonEnsembleBrainPF.CP
					prop_settings = 'ComparisonEnsemble';
				case ComparisonEnsembleBrainPF.SETUP
					prop_settings = Format.getFormatSettings(Format.EMPTY);
				case ComparisonEnsembleBrainPF.TEMPLATE
					prop_settings = 'ComparisonEnsembleBrainPF';
				otherwise
					prop_settings = getPropSettings@BrainAtlasPF(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = ComparisonEnsembleBrainPF.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = ComparisonEnsembleBrainPF.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULT(ComparisonEnsembleBrainPF, POINTER) returns the default value of POINTER of ComparisonEnsembleBrainPF.
			%  DEFAULT = PF.GETPROPDEFAULT(ComparisonEnsembleBrainPF, POINTER) returns the default value of POINTER of ComparisonEnsembleBrainPF.
			%
			% Note that the Element.GETPROPDEFAULT(PF) and Element.GETPROPDEFAULT('ComparisonEnsembleBrainPF')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = ComparisonEnsembleBrainPF.getPropProp(pointer);
			
			switch prop
				case ComparisonEnsembleBrainPF.CP
					prop_default = Format.getFormatDefault(Format.ITEM, ComparisonEnsembleBrainPF.getPropSettings(prop));
				case ComparisonEnsembleBrainPF.SETUP
					prop_default = Format.getFormatDefault(Format.EMPTY, ComparisonEnsembleBrainPF.getPropSettings(prop));
				case ComparisonEnsembleBrainPF.ELCLASS
					prop_default = 'ComparisonEnsembleBrainPF';
				case ComparisonEnsembleBrainPF.NAME
					prop_default = 'ComparisonEnsembleBrainPF';
				case ComparisonEnsembleBrainPF.DESCRIPTION
					prop_default = 'ComparisonEnsembleBrainPF manages the basic functionalities to plot of an ensemble-based comparison on brain surface.';
				case ComparisonEnsembleBrainPF.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, ComparisonEnsembleBrainPF.getPropSettings(prop));
				case ComparisonEnsembleBrainPF.ID
					prop_default = 'ComparisonEnsembleBrainPF ID';
				case ComparisonEnsembleBrainPF.LABEL
					prop_default = 'ComparisonEnsembleBrainPF label';
				case ComparisonEnsembleBrainPF.NOTES
					prop_default = 'ComparisonEnsembleBrainPF notes';
				otherwise
					prop_default = getPropDefault@BrainAtlasPF(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = ComparisonEnsembleBrainPF.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = ComparisonEnsembleBrainPF.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(ComparisonEnsembleBrainPF, POINTER) returns the conditioned default value of POINTER of ComparisonEnsembleBrainPF.
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(ComparisonEnsembleBrainPF, POINTER) returns the conditioned default value of POINTER of ComparisonEnsembleBrainPF.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PF) and Element.GETPROPDEFAULTCONDITIONED('ComparisonEnsembleBrainPF')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = ComparisonEnsembleBrainPF.getPropProp(pointer);
			
			prop_default = ComparisonEnsembleBrainPF.conditioning(prop, ComparisonEnsembleBrainPF.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(ComparisonEnsembleBrainPF, PROP, VALUE) checks VALUE format for PROP of ComparisonEnsembleBrainPF.
			%  CHECK = PF.CHECKPROP(ComparisonEnsembleBrainPF, PROP, VALUE) checks VALUE format for PROP of ComparisonEnsembleBrainPF.
			% 
			% PF.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:ComparisonEnsembleBrainPF:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PF.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PF.
			%   Error id: €BRAPH2.STR€:ComparisonEnsembleBrainPF:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(ComparisonEnsembleBrainPF, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ComparisonEnsembleBrainPF.
			%   Error id: €BRAPH2.STR€:ComparisonEnsembleBrainPF:€BRAPH2.WRONG_INPUT€
			%  PF.CHECKPROP(ComparisonEnsembleBrainPF, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ComparisonEnsembleBrainPF.
			%   Error id: €BRAPH2.STR€:ComparisonEnsembleBrainPF:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PF) and Element.CHECKPROP('ComparisonEnsembleBrainPF')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = ComparisonEnsembleBrainPF.getPropProp(pointer);
			
			switch prop
				case ComparisonEnsembleBrainPF.CP % __ComparisonEnsembleBrainPF.CP__
					check = Format.checkFormat(Format.ITEM, value, ComparisonEnsembleBrainPF.getPropSettings(prop));
				case ComparisonEnsembleBrainPF.SETUP % __ComparisonEnsembleBrainPF.SETUP__
					check = Format.checkFormat(Format.EMPTY, value, ComparisonEnsembleBrainPF.getPropSettings(prop));
				case ComparisonEnsembleBrainPF.TEMPLATE % __ComparisonEnsembleBrainPF.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, ComparisonEnsembleBrainPF.getPropSettings(prop));
				otherwise
					if prop <= BrainAtlasPF.getPropNumber()
						check = checkProp@BrainAtlasPF(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ComparisonEnsembleBrainPF:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ComparisonEnsembleBrainPF:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' ComparisonEnsembleBrainPF.getPropTag(prop) ' (' ComparisonEnsembleBrainPF.getFormatTag(ComparisonEnsembleBrainPF.getPropFormat(prop)) ').'] ...
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
				case ComparisonEnsembleBrainPF.SETUP % __ComparisonEnsembleBrainPF.SETUP__
					value = [];
					
				case ComparisonEnsembleBrainPF.DRAW % __ComparisonEnsembleBrainPF.DRAW__
					value = calculateValue@BrainAtlasPF(pf, ComparisonEnsembleBrainPF.DRAW, varargin{:}); % also warning
					if value
					    pf.get('SETUP')
					end
					
				case ComparisonEnsembleBrainPF.DELETE % __ComparisonEnsembleBrainPF.DELETE__
					value = calculateValue@BrainAtlasPF(pf, ComparisonEnsembleBrainPF.DELETE, varargin{:}); % also warning
					if value
					    pf.set('H_SPHS', Element.getNoValue())
					    pf.set('H_SYMS', Element.getNoValue())
					    pf.set('H_IDS', Element.getNoValue())
					    pf.set('H_LABS', Element.getNoValue())
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
