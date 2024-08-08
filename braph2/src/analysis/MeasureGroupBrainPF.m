classdef MeasureGroupBrainPF < BrainAtlasPF
	%MeasureGroupBrainPF is a plot of a measure group brain.
	% It is a subclass of <a href="matlab:help BrainAtlasPF">BrainAtlasPF</a>.
	%
	% A Panel Figure for a Brain Measure of Analyze Group (MeasureGroupBrainPF) manages the plot of the measure
	%  ploted over the brain.  
	% MeasureGroupBrainPF utilizes the surface created from BrainAtlasPF to integrate 
	%  the meaure into the brain regions.
	%
	% MeasureGroupBrainPF methods (constructor):
	%  MeasureGroupBrainPF - constructor
	%
	% MeasureGroupBrainPF methods:
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
	% MeasureGroupBrainPF methods (display):
	%  tostring - string with information about the panel figure for measure group brain
	%  disp - displays information about the panel figure for measure group brain
	%  tree - displays the tree of the panel figure for measure group brain
	%
	% MeasureGroupBrainPF methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two panel figure for measure group brain are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the panel figure for measure group brain
	%
	% MeasureGroupBrainPF methods (save/load, Static):
	%  save - saves BRAPH2 panel figure for measure group brain as b2 file
	%  load - loads a BRAPH2 panel figure for measure group brain from a b2 file
	%
	% MeasureGroupBrainPF method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the panel figure for measure group brain
	%
	% MeasureGroupBrainPF method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the panel figure for measure group brain
	%
	% MeasureGroupBrainPF methods (inspection, Static):
	%  getClass - returns the class of the panel figure for measure group brain
	%  getSubclasses - returns all subclasses of MeasureGroupBrainPF
	%  getProps - returns the property list of the panel figure for measure group brain
	%  getPropNumber - returns the property number of the panel figure for measure group brain
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
	% MeasureGroupBrainPF methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% MeasureGroupBrainPF methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% MeasureGroupBrainPF methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% MeasureGroupBrainPF methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?MeasureGroupBrainPF; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">MeasureGroupBrainPF constants</a>.
	%
	%
	% See also BrainAtlas, BrainSurface, BrainAtlasPF.
	
	properties (Constant) % properties
		M = BrainAtlasPF.getPropNumber() + 1;
		M_TAG = 'M';
		M_CATEGORY = Category.METADATA;
		M_FORMAT = Format.ITEM;
		
		SETUP = BrainAtlasPF.getPropNumber() + 2;
		SETUP_TAG = 'SETUP';
		SETUP_CATEGORY = Category.QUERY;
		SETUP_FORMAT = Format.EMPTY;
	end
	methods % constructor
		function pf = MeasureGroupBrainPF(varargin)
			%MeasureGroupBrainPF() creates a panel figure for measure group brain.
			%
			% MeasureGroupBrainPF(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% MeasureGroupBrainPF(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the panel figure for measure group brain.
			%
			% CLASS = MeasureGroupBrainPF.GETCLASS() returns the class 'MeasureGroupBrainPF'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PF.GETCLASS() returns the class of the panel figure for measure group brain PF.
			%  CLASS = Element.GETCLASS(PF) returns the class of 'PF'.
			%  CLASS = Element.GETCLASS('MeasureGroupBrainPF') returns 'MeasureGroupBrainPF'.
			%
			% Note that the Element.GETCLASS(PF) and Element.GETCLASS('MeasureGroupBrainPF')
			%  are less computationally efficient.
			
			pf_class = 'MeasureGroupBrainPF';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the panel figure for measure group brain.
			%
			% LIST = MeasureGroupBrainPF.GETSUBCLASSES() returns all subclasses of 'MeasureGroupBrainPF'.
			%
			% Alternative forms to call this method are:
			%  LIST = PF.GETSUBCLASSES() returns all subclasses of the panel figure for measure group brain PF.
			%  LIST = Element.GETSUBCLASSES(PF) returns all subclasses of 'PF'.
			%  LIST = Element.GETSUBCLASSES('MeasureGroupBrainPF') returns all subclasses of 'MeasureGroupBrainPF'.
			%
			% Note that the Element.GETSUBCLASSES(PF) and Element.GETSUBCLASSES('MeasureGroupBrainPF')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('MeasureGroupBrainPF', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of panel figure for measure group brain.
			%
			% PROPS = MeasureGroupBrainPF.GETPROPS() returns the property list of panel figure for measure group brain
			%  as a row vector.
			%
			% PROPS = MeasureGroupBrainPF.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PF.GETPROPS([CATEGORY]) returns the property list of the panel figure for measure group brain PF.
			%  PROPS = Element.GETPROPS(PF[, CATEGORY]) returns the property list of 'PF'.
			%  PROPS = Element.GETPROPS('MeasureGroupBrainPF'[, CATEGORY]) returns the property list of 'MeasureGroupBrainPF'.
			%
			% Note that the Element.GETPROPS(PF) and Element.GETPROPS('MeasureGroupBrainPF')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					BrainAtlasPF.getProps() ...
						MeasureGroupBrainPF.M ...
						MeasureGroupBrainPF.SETUP ...
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
						MeasureGroupBrainPF.M ...
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
						MeasureGroupBrainPF.SETUP ...
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
			%GETPROPNUMBER returns the property number of panel figure for measure group brain.
			%
			% N = MeasureGroupBrainPF.GETPROPNUMBER() returns the property number of panel figure for measure group brain.
			%
			% N = MeasureGroupBrainPF.GETPROPNUMBER(CATEGORY) returns the property number of panel figure for measure group brain
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PF.GETPROPNUMBER([CATEGORY]) returns the property number of the panel figure for measure group brain PF.
			%  N = Element.GETPROPNUMBER(PF) returns the property number of 'PF'.
			%  N = Element.GETPROPNUMBER('MeasureGroupBrainPF') returns the property number of 'MeasureGroupBrainPF'.
			%
			% Note that the Element.GETPROPNUMBER(PF) and Element.GETPROPNUMBER('MeasureGroupBrainPF')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(MeasureGroupBrainPF.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in panel figure for measure group brain/error.
			%
			% CHECK = MeasureGroupBrainPF.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSPROP(PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(PF, PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(MeasureGroupBrainPF, PROP) checks whether PROP exists for MeasureGroupBrainPF.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:MeasureGroupBrainPF:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSPROP(PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:MeasureGroupBrainPF:WrongInput]
			%  Element.EXISTSPROP(PF, PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:MeasureGroupBrainPF:WrongInput]
			%  Element.EXISTSPROP(MeasureGroupBrainPF, PROP) throws error if PROP does NOT exist for MeasureGroupBrainPF.
			%   Error id: [BRAPH2:MeasureGroupBrainPF:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PF) and Element.EXISTSPROP('MeasureGroupBrainPF')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == MeasureGroupBrainPF.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MeasureGroupBrainPF:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MeasureGroupBrainPF:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for MeasureGroupBrainPF.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in panel figure for measure group brain/error.
			%
			% CHECK = MeasureGroupBrainPF.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSTAG(TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(PF, TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(MeasureGroupBrainPF, TAG) checks whether TAG exists for MeasureGroupBrainPF.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:MeasureGroupBrainPF:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSTAG(TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:MeasureGroupBrainPF:WrongInput]
			%  Element.EXISTSTAG(PF, TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:MeasureGroupBrainPF:WrongInput]
			%  Element.EXISTSTAG(MeasureGroupBrainPF, TAG) throws error if TAG does NOT exist for MeasureGroupBrainPF.
			%   Error id: [BRAPH2:MeasureGroupBrainPF:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PF) and Element.EXISTSTAG('MeasureGroupBrainPF')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			measuregroupbrainpf_tag_list = cellfun(@(x) MeasureGroupBrainPF.getPropTag(x), num2cell(MeasureGroupBrainPF.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, measuregroupbrainpf_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MeasureGroupBrainPF:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MeasureGroupBrainPF:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for MeasureGroupBrainPF.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(MeasureGroupBrainPF, POINTER) returns property number of POINTER of MeasureGroupBrainPF.
			%  PROPERTY = PF.GETPROPPROP(MeasureGroupBrainPF, POINTER) returns property number of POINTER of MeasureGroupBrainPF.
			%
			% Note that the Element.GETPROPPROP(PF) and Element.GETPROPPROP('MeasureGroupBrainPF')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				measuregroupbrainpf_tag_list = cellfun(@(x) MeasureGroupBrainPF.getPropTag(x), num2cell(MeasureGroupBrainPF.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, measuregroupbrainpf_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(MeasureGroupBrainPF, POINTER) returns tag of POINTER of MeasureGroupBrainPF.
			%  TAG = PF.GETPROPTAG(MeasureGroupBrainPF, POINTER) returns tag of POINTER of MeasureGroupBrainPF.
			%
			% Note that the Element.GETPROPTAG(PF) and Element.GETPROPTAG('MeasureGroupBrainPF')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case MeasureGroupBrainPF.M
						tag = MeasureGroupBrainPF.M_TAG;
					case MeasureGroupBrainPF.SETUP
						tag = MeasureGroupBrainPF.SETUP_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(MeasureGroupBrainPF, POINTER) returns category of POINTER of MeasureGroupBrainPF.
			%  CATEGORY = PF.GETPROPCATEGORY(MeasureGroupBrainPF, POINTER) returns category of POINTER of MeasureGroupBrainPF.
			%
			% Note that the Element.GETPROPCATEGORY(PF) and Element.GETPROPCATEGORY('MeasureGroupBrainPF')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = MeasureGroupBrainPF.getPropProp(pointer);
			
			switch prop
				case MeasureGroupBrainPF.M
					prop_category = MeasureGroupBrainPF.M_CATEGORY;
				case MeasureGroupBrainPF.SETUP
					prop_category = MeasureGroupBrainPF.SETUP_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(MeasureGroupBrainPF, POINTER) returns format of POINTER of MeasureGroupBrainPF.
			%  FORMAT = PF.GETPROPFORMAT(MeasureGroupBrainPF, POINTER) returns format of POINTER of MeasureGroupBrainPF.
			%
			% Note that the Element.GETPROPFORMAT(PF) and Element.GETPROPFORMAT('MeasureGroupBrainPF')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = MeasureGroupBrainPF.getPropProp(pointer);
			
			switch prop
				case MeasureGroupBrainPF.M
					prop_format = MeasureGroupBrainPF.M_FORMAT;
				case MeasureGroupBrainPF.SETUP
					prop_format = MeasureGroupBrainPF.SETUP_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(MeasureGroupBrainPF, POINTER) returns description of POINTER of MeasureGroupBrainPF.
			%  DESCRIPTION = PF.GETPROPDESCRIPTION(MeasureGroupBrainPF, POINTER) returns description of POINTER of MeasureGroupBrainPF.
			%
			% Note that the Element.GETPROPDESCRIPTION(PF) and Element.GETPROPDESCRIPTION('MeasureGroupBrainPF')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = MeasureGroupBrainPF.getPropProp(pointer);
			
			switch prop
				case MeasureGroupBrainPF.M
					prop_description = 'M (metadata, item) is the measure.';
				case MeasureGroupBrainPF.SETUP
					prop_description = 'SETUP (query, empty) calculates the measure value and stores it to be implemented in the subelements.';
				case MeasureGroupBrainPF.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the % % %.';
				case MeasureGroupBrainPF.NAME
					prop_description = 'NAME (constant, string) is the name of the panel figure for measure group brain.';
				case MeasureGroupBrainPF.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the panel figure for measure group brain.';
				case MeasureGroupBrainPF.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the panel figure for measure group brain.';
				case MeasureGroupBrainPF.ID
					prop_description = 'ID (data, string) is a few-letter code for the panel figure for measure group brain.';
				case MeasureGroupBrainPF.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the panel figure for measure group brain.';
				case MeasureGroupBrainPF.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the panel figure for measure group brain.';
				case MeasureGroupBrainPF.DRAW
					prop_description = 'DRAW (query, logical) draws the figure brain atlas.';
				case MeasureGroupBrainPF.DELETE
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
			%  SETTINGS = Element.GETPROPSETTINGS(MeasureGroupBrainPF, POINTER) returns settings of POINTER of MeasureGroupBrainPF.
			%  SETTINGS = PF.GETPROPSETTINGS(MeasureGroupBrainPF, POINTER) returns settings of POINTER of MeasureGroupBrainPF.
			%
			% Note that the Element.GETPROPSETTINGS(PF) and Element.GETPROPSETTINGS('MeasureGroupBrainPF')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = MeasureGroupBrainPF.getPropProp(pointer);
			
			switch prop
				case MeasureGroupBrainPF.M
					prop_settings = 'Measure';
				case MeasureGroupBrainPF.SETUP
					prop_settings = Format.getFormatSettings(Format.EMPTY);
				case MeasureGroupBrainPF.TEMPLATE
					prop_settings = 'MeasureGroupBrainPF';
				otherwise
					prop_settings = getPropSettings@BrainAtlasPF(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = MeasureGroupBrainPF.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = MeasureGroupBrainPF.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULT(MeasureGroupBrainPF, POINTER) returns the default value of POINTER of MeasureGroupBrainPF.
			%  DEFAULT = PF.GETPROPDEFAULT(MeasureGroupBrainPF, POINTER) returns the default value of POINTER of MeasureGroupBrainPF.
			%
			% Note that the Element.GETPROPDEFAULT(PF) and Element.GETPROPDEFAULT('MeasureGroupBrainPF')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = MeasureGroupBrainPF.getPropProp(pointer);
			
			switch prop
				case MeasureGroupBrainPF.M
					prop_default = Format.getFormatDefault(Format.ITEM, MeasureGroupBrainPF.getPropSettings(prop));
				case MeasureGroupBrainPF.SETUP
					prop_default = Format.getFormatDefault(Format.EMPTY, MeasureGroupBrainPF.getPropSettings(prop));
				case MeasureGroupBrainPF.ELCLASS
					prop_default = 'MeasureGroupBrainPF';
				case MeasureGroupBrainPF.NAME
					prop_default = 'Panel Figure for Measure Group Brain';
				case MeasureGroupBrainPF.DESCRIPTION
					prop_default = 'A Panel Figure for a Brain Measure of Analyze Group (MeasureGroupBrainPF) manages the plot of the measure ploted over the brain. MeasureGroupBrainPF utilizes the surface created from BrainAtlasPF to integrate the meaure into the brain regions.';
				case MeasureGroupBrainPF.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, MeasureGroupBrainPF.getPropSettings(prop));
				case MeasureGroupBrainPF.ID
					prop_default = 'MeasureGroupBrainPF ID';
				case MeasureGroupBrainPF.LABEL
					prop_default = 'MeasureGroupBrainPF label';
				case MeasureGroupBrainPF.NOTES
					prop_default = 'MeasureGroupBrainPF notes';
				otherwise
					prop_default = getPropDefault@BrainAtlasPF(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = MeasureGroupBrainPF.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = MeasureGroupBrainPF.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(MeasureGroupBrainPF, POINTER) returns the conditioned default value of POINTER of MeasureGroupBrainPF.
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(MeasureGroupBrainPF, POINTER) returns the conditioned default value of POINTER of MeasureGroupBrainPF.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PF) and Element.GETPROPDEFAULTCONDITIONED('MeasureGroupBrainPF')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = MeasureGroupBrainPF.getPropProp(pointer);
			
			prop_default = MeasureGroupBrainPF.conditioning(prop, MeasureGroupBrainPF.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(MeasureGroupBrainPF, PROP, VALUE) checks VALUE format for PROP of MeasureGroupBrainPF.
			%  CHECK = PF.CHECKPROP(MeasureGroupBrainPF, PROP, VALUE) checks VALUE format for PROP of MeasureGroupBrainPF.
			% 
			% PF.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:MeasureGroupBrainPF:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PF.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PF.
			%   Error id: €BRAPH2.STR€:MeasureGroupBrainPF:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(MeasureGroupBrainPF, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MeasureGroupBrainPF.
			%   Error id: €BRAPH2.STR€:MeasureGroupBrainPF:€BRAPH2.WRONG_INPUT€
			%  PF.CHECKPROP(MeasureGroupBrainPF, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MeasureGroupBrainPF.
			%   Error id: €BRAPH2.STR€:MeasureGroupBrainPF:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PF) and Element.CHECKPROP('MeasureGroupBrainPF')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = MeasureGroupBrainPF.getPropProp(pointer);
			
			switch prop
				case MeasureGroupBrainPF.M % __MeasureGroupBrainPF.M__
					check = Format.checkFormat(Format.ITEM, value, MeasureGroupBrainPF.getPropSettings(prop));
				case MeasureGroupBrainPF.SETUP % __MeasureGroupBrainPF.SETUP__
					check = Format.checkFormat(Format.EMPTY, value, MeasureGroupBrainPF.getPropSettings(prop));
				case MeasureGroupBrainPF.TEMPLATE % __MeasureGroupBrainPF.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, MeasureGroupBrainPF.getPropSettings(prop));
				otherwise
					if prop <= BrainAtlasPF.getPropNumber()
						check = checkProp@BrainAtlasPF(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MeasureGroupBrainPF:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MeasureGroupBrainPF:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' MeasureGroupBrainPF.getPropTag(prop) ' (' MeasureGroupBrainPF.getFormatTag(MeasureGroupBrainPF.getPropFormat(prop)) ').'] ...
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
				case MeasureGroupBrainPF.SETUP % __MeasureGroupBrainPF.SETUP__
					value = [];
					
				case MeasureGroupBrainPF.DRAW % __MeasureGroupBrainPF.DRAW__
					value = calculateValue@BrainAtlasPF(pf, MeasureGroupBrainPF.DRAW, varargin{:}); % also warning
					if value    
					    % trigger setup
					    pf.get('SETUP');
					end
					
				case MeasureGroupBrainPF.DELETE % __MeasureGroupBrainPF.DELETE__
					value = calculateValue@BrainAtlasPF(pf, MeasureGroupBrainPF.DELETE, varargin{:}); % also warning
					if value
					    % do nothing
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
