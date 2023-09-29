classdef MeasureEnsembleBrainPF < BrainAtlasPF
	%MeasureEnsembleBrainPF is a plot of a measure group brain.
	% It is a subclass of <a href="matlab:help BrainAtlasPF">BrainAtlasPF</a>.
	%
	% A Panel Figure for a Brain Measure of Analyze Group (MeasureEnsembleBrainPF) manages the plot of the measure
	%  ploted over the brain.  
	% MeasureEnsembleBrainPF utilizes the surface created from BrainAtlasPF to integrate 
	%  the meaure into the brain regions.
	%
	% MeasureEnsembleBrainPF methods (constructor):
	%  MeasureEnsembleBrainPF - constructor
	%
	% MeasureEnsembleBrainPF methods:
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
	% MeasureEnsembleBrainPF methods (display):
	%  tostring - string with information about the panel figure for measure group brain
	%  disp - displays information about the panel figure for measure group brain
	%  tree - displays the tree of the panel figure for measure group brain
	%
	% MeasureEnsembleBrainPF methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two panel figure for measure group brain are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the panel figure for measure group brain
	%
	% MeasureEnsembleBrainPF methods (save/load, Static):
	%  save - saves BRAPH2 panel figure for measure group brain as b2 file
	%  load - loads a BRAPH2 panel figure for measure group brain from a b2 file
	%
	% MeasureEnsembleBrainPF method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the panel figure for measure group brain
	%
	% MeasureEnsembleBrainPF method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the panel figure for measure group brain
	%
	% MeasureEnsembleBrainPF methods (inspection, Static):
	%  getClass - returns the class of the panel figure for measure group brain
	%  getSubclasses - returns all subclasses of MeasureEnsembleBrainPF
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
	% MeasureEnsembleBrainPF methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% MeasureEnsembleBrainPF methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% MeasureEnsembleBrainPF methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% MeasureEnsembleBrainPF methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?MeasureEnsembleBrainPF; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">MeasureEnsembleBrainPF constants</a>.
	%
	%
	% See also BrainAtlas, BrainSurface, BrainAtlasPF.
	
	properties (Constant) % properties
		ME = BrainAtlasPF.getPropNumber() + 1;
		ME_TAG = 'ME';
		ME_CATEGORY = Category.METADATA;
		ME_FORMAT = Format.ITEM;
		
		SETUP = BrainAtlasPF.getPropNumber() + 2;
		SETUP_TAG = 'SETUP';
		SETUP_CATEGORY = Category.QUERY;
		SETUP_FORMAT = Format.EMPTY;
	end
	methods % constructor
		function pf = MeasureEnsembleBrainPF(varargin)
			%MeasureEnsembleBrainPF() creates a panel figure for measure group brain.
			%
			% MeasureEnsembleBrainPF(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% MeasureEnsembleBrainPF(TAG, VALUE, ...) with property TAG set to VALUE.
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
			% CLASS = MeasureEnsembleBrainPF.GETCLASS() returns the class 'MeasureEnsembleBrainPF'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PF.GETCLASS() returns the class of the panel figure for measure group brain PF.
			%  CLASS = Element.GETCLASS(PF) returns the class of 'PF'.
			%  CLASS = Element.GETCLASS('MeasureEnsembleBrainPF') returns 'MeasureEnsembleBrainPF'.
			%
			% Note that the Element.GETCLASS(PF) and Element.GETCLASS('MeasureEnsembleBrainPF')
			%  are less computationally efficient.
			
			pf_class = 'MeasureEnsembleBrainPF';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the panel figure for measure group brain.
			%
			% LIST = MeasureEnsembleBrainPF.GETSUBCLASSES() returns all subclasses of 'MeasureEnsembleBrainPF'.
			%
			% Alternative forms to call this method are:
			%  LIST = PF.GETSUBCLASSES() returns all subclasses of the panel figure for measure group brain PF.
			%  LIST = Element.GETSUBCLASSES(PF) returns all subclasses of 'PF'.
			%  LIST = Element.GETSUBCLASSES('MeasureEnsembleBrainPF') returns all subclasses of 'MeasureEnsembleBrainPF'.
			%
			% Note that the Element.GETSUBCLASSES(PF) and Element.GETSUBCLASSES('MeasureEnsembleBrainPF')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('MeasureEnsembleBrainPF', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of panel figure for measure group brain.
			%
			% PROPS = MeasureEnsembleBrainPF.GETPROPS() returns the property list of panel figure for measure group brain
			%  as a row vector.
			%
			% PROPS = MeasureEnsembleBrainPF.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PF.GETPROPS([CATEGORY]) returns the property list of the panel figure for measure group brain PF.
			%  PROPS = Element.GETPROPS(PF[, CATEGORY]) returns the property list of 'PF'.
			%  PROPS = Element.GETPROPS('MeasureEnsembleBrainPF'[, CATEGORY]) returns the property list of 'MeasureEnsembleBrainPF'.
			%
			% Note that the Element.GETPROPS(PF) and Element.GETPROPS('MeasureEnsembleBrainPF')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					BrainAtlasPF.getProps() ...
						MeasureEnsembleBrainPF.ME ...
						MeasureEnsembleBrainPF.SETUP ...
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
						MeasureEnsembleBrainPF.ME ...
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
						MeasureEnsembleBrainPF.SETUP ...
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
			% N = MeasureEnsembleBrainPF.GETPROPNUMBER() returns the property number of panel figure for measure group brain.
			%
			% N = MeasureEnsembleBrainPF.GETPROPNUMBER(CATEGORY) returns the property number of panel figure for measure group brain
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PF.GETPROPNUMBER([CATEGORY]) returns the property number of the panel figure for measure group brain PF.
			%  N = Element.GETPROPNUMBER(PF) returns the property number of 'PF'.
			%  N = Element.GETPROPNUMBER('MeasureEnsembleBrainPF') returns the property number of 'MeasureEnsembleBrainPF'.
			%
			% Note that the Element.GETPROPNUMBER(PF) and Element.GETPROPNUMBER('MeasureEnsembleBrainPF')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(MeasureEnsembleBrainPF.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in panel figure for measure group brain/error.
			%
			% CHECK = MeasureEnsembleBrainPF.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSPROP(PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(PF, PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(MeasureEnsembleBrainPF, PROP) checks whether PROP exists for MeasureEnsembleBrainPF.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:MeasureEnsembleBrainPF:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSPROP(PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:MeasureEnsembleBrainPF:WrongInput]
			%  Element.EXISTSPROP(PF, PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:MeasureEnsembleBrainPF:WrongInput]
			%  Element.EXISTSPROP(MeasureEnsembleBrainPF, PROP) throws error if PROP does NOT exist for MeasureEnsembleBrainPF.
			%   Error id: [BRAPH2:MeasureEnsembleBrainPF:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PF) and Element.EXISTSPROP('MeasureEnsembleBrainPF')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == MeasureEnsembleBrainPF.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MeasureEnsembleBrainPF:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MeasureEnsembleBrainPF:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for MeasureEnsembleBrainPF.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in panel figure for measure group brain/error.
			%
			% CHECK = MeasureEnsembleBrainPF.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSTAG(TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(PF, TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(MeasureEnsembleBrainPF, TAG) checks whether TAG exists for MeasureEnsembleBrainPF.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:MeasureEnsembleBrainPF:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSTAG(TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:MeasureEnsembleBrainPF:WrongInput]
			%  Element.EXISTSTAG(PF, TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:MeasureEnsembleBrainPF:WrongInput]
			%  Element.EXISTSTAG(MeasureEnsembleBrainPF, TAG) throws error if TAG does NOT exist for MeasureEnsembleBrainPF.
			%   Error id: [BRAPH2:MeasureEnsembleBrainPF:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PF) and Element.EXISTSTAG('MeasureEnsembleBrainPF')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			measureensemblebrainpf_tag_list = cellfun(@(x) MeasureEnsembleBrainPF.getPropTag(x), num2cell(MeasureEnsembleBrainPF.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, measureensemblebrainpf_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MeasureEnsembleBrainPF:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MeasureEnsembleBrainPF:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for MeasureEnsembleBrainPF.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(MeasureEnsembleBrainPF, POINTER) returns property number of POINTER of MeasureEnsembleBrainPF.
			%  PROPERTY = PF.GETPROPPROP(MeasureEnsembleBrainPF, POINTER) returns property number of POINTER of MeasureEnsembleBrainPF.
			%
			% Note that the Element.GETPROPPROP(PF) and Element.GETPROPPROP('MeasureEnsembleBrainPF')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				measureensemblebrainpf_tag_list = cellfun(@(x) MeasureEnsembleBrainPF.getPropTag(x), num2cell(MeasureEnsembleBrainPF.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, measureensemblebrainpf_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(MeasureEnsembleBrainPF, POINTER) returns tag of POINTER of MeasureEnsembleBrainPF.
			%  TAG = PF.GETPROPTAG(MeasureEnsembleBrainPF, POINTER) returns tag of POINTER of MeasureEnsembleBrainPF.
			%
			% Note that the Element.GETPROPTAG(PF) and Element.GETPROPTAG('MeasureEnsembleBrainPF')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case MeasureEnsembleBrainPF.ME
						tag = MeasureEnsembleBrainPF.ME_TAG;
					case MeasureEnsembleBrainPF.SETUP
						tag = MeasureEnsembleBrainPF.SETUP_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(MeasureEnsembleBrainPF, POINTER) returns category of POINTER of MeasureEnsembleBrainPF.
			%  CATEGORY = PF.GETPROPCATEGORY(MeasureEnsembleBrainPF, POINTER) returns category of POINTER of MeasureEnsembleBrainPF.
			%
			% Note that the Element.GETPROPCATEGORY(PF) and Element.GETPROPCATEGORY('MeasureEnsembleBrainPF')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = MeasureEnsembleBrainPF.getPropProp(pointer);
			
			switch prop
				case MeasureEnsembleBrainPF.ME
					prop_category = MeasureEnsembleBrainPF.ME_CATEGORY;
				case MeasureEnsembleBrainPF.SETUP
					prop_category = MeasureEnsembleBrainPF.SETUP_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(MeasureEnsembleBrainPF, POINTER) returns format of POINTER of MeasureEnsembleBrainPF.
			%  FORMAT = PF.GETPROPFORMAT(MeasureEnsembleBrainPF, POINTER) returns format of POINTER of MeasureEnsembleBrainPF.
			%
			% Note that the Element.GETPROPFORMAT(PF) and Element.GETPROPFORMAT('MeasureEnsembleBrainPF')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = MeasureEnsembleBrainPF.getPropProp(pointer);
			
			switch prop
				case MeasureEnsembleBrainPF.ME
					prop_format = MeasureEnsembleBrainPF.ME_FORMAT;
				case MeasureEnsembleBrainPF.SETUP
					prop_format = MeasureEnsembleBrainPF.SETUP_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(MeasureEnsembleBrainPF, POINTER) returns description of POINTER of MeasureEnsembleBrainPF.
			%  DESCRIPTION = PF.GETPROPDESCRIPTION(MeasureEnsembleBrainPF, POINTER) returns description of POINTER of MeasureEnsembleBrainPF.
			%
			% Note that the Element.GETPROPDESCRIPTION(PF) and Element.GETPROPDESCRIPTION('MeasureEnsembleBrainPF')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = MeasureEnsembleBrainPF.getPropProp(pointer);
			
			switch prop
				case MeasureEnsembleBrainPF.ME
					prop_description = 'ME (metadata, item) is the measure ensemble.';
				case MeasureEnsembleBrainPF.SETUP
					prop_description = 'SETUP (query, empty) calculates the measure value and stores it to be implemented in the subelements.';
				case MeasureEnsembleBrainPF.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the % % %.';
				case MeasureEnsembleBrainPF.NAME
					prop_description = 'NAME (constant, string) is the name of the panel figure for measure group brain.';
				case MeasureEnsembleBrainPF.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the panel figure for measure group brain.';
				case MeasureEnsembleBrainPF.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the panel figure for measure group brain.';
				case MeasureEnsembleBrainPF.ID
					prop_description = 'ID (data, string) is a few-letter code for the panel figure for measure group brain.';
				case MeasureEnsembleBrainPF.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the panel figure for measure group brain.';
				case MeasureEnsembleBrainPF.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the panel figure for measure group brain.';
				case MeasureEnsembleBrainPF.DRAW
					prop_description = 'DRAW (query, logical) draws the figure brain atlas.';
				case MeasureEnsembleBrainPF.DELETE
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
			%  SETTINGS = Element.GETPROPSETTINGS(MeasureEnsembleBrainPF, POINTER) returns settings of POINTER of MeasureEnsembleBrainPF.
			%  SETTINGS = PF.GETPROPSETTINGS(MeasureEnsembleBrainPF, POINTER) returns settings of POINTER of MeasureEnsembleBrainPF.
			%
			% Note that the Element.GETPROPSETTINGS(PF) and Element.GETPROPSETTINGS('MeasureEnsembleBrainPF')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = MeasureEnsembleBrainPF.getPropProp(pointer);
			
			switch prop
				case MeasureEnsembleBrainPF.ME
					prop_settings = 'MeasureEnsemble';
				case MeasureEnsembleBrainPF.SETUP
					prop_settings = Format.getFormatSettings(Format.EMPTY);
				case MeasureEnsembleBrainPF.TEMPLATE
					prop_settings = 'MeasureEnsembleBrainPF';
				otherwise
					prop_settings = getPropSettings@BrainAtlasPF(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = MeasureEnsembleBrainPF.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = MeasureEnsembleBrainPF.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULT(MeasureEnsembleBrainPF, POINTER) returns the default value of POINTER of MeasureEnsembleBrainPF.
			%  DEFAULT = PF.GETPROPDEFAULT(MeasureEnsembleBrainPF, POINTER) returns the default value of POINTER of MeasureEnsembleBrainPF.
			%
			% Note that the Element.GETPROPDEFAULT(PF) and Element.GETPROPDEFAULT('MeasureEnsembleBrainPF')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = MeasureEnsembleBrainPF.getPropProp(pointer);
			
			switch prop
				case MeasureEnsembleBrainPF.ME
					prop_default = Format.getFormatDefault(Format.ITEM, MeasureEnsembleBrainPF.getPropSettings(prop));
				case MeasureEnsembleBrainPF.SETUP
					prop_default = Format.getFormatDefault(Format.EMPTY, MeasureEnsembleBrainPF.getPropSettings(prop));
				case MeasureEnsembleBrainPF.ELCLASS
					prop_default = 'MeasureEnsembleBrainPF';
				case MeasureEnsembleBrainPF.NAME
					prop_default = 'Panel Figure for Measure Group Brain';
				case MeasureEnsembleBrainPF.DESCRIPTION
					prop_default = 'A Panel Figure for a Brain Measure of Analyze Group (MeasureEnsembleBrainPF) manages the plot of the measure ploted over the brain. MeasureEnsembleBrainPF utilizes the surface created from BrainAtlasPF to integrate the meaure into the brain regions.';
				case MeasureEnsembleBrainPF.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, MeasureEnsembleBrainPF.getPropSettings(prop));
				case MeasureEnsembleBrainPF.ID
					prop_default = 'MeasureEnsembleBrainPF ID';
				case MeasureEnsembleBrainPF.LABEL
					prop_default = 'MeasureEnsembleBrainPF label';
				case MeasureEnsembleBrainPF.NOTES
					prop_default = 'MeasureEnsembleBrainPF notes';
				otherwise
					prop_default = getPropDefault@BrainAtlasPF(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = MeasureEnsembleBrainPF.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = MeasureEnsembleBrainPF.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(MeasureEnsembleBrainPF, POINTER) returns the conditioned default value of POINTER of MeasureEnsembleBrainPF.
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(MeasureEnsembleBrainPF, POINTER) returns the conditioned default value of POINTER of MeasureEnsembleBrainPF.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PF) and Element.GETPROPDEFAULTCONDITIONED('MeasureEnsembleBrainPF')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = MeasureEnsembleBrainPF.getPropProp(pointer);
			
			prop_default = MeasureEnsembleBrainPF.conditioning(prop, MeasureEnsembleBrainPF.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(MeasureEnsembleBrainPF, PROP, VALUE) checks VALUE format for PROP of MeasureEnsembleBrainPF.
			%  CHECK = PF.CHECKPROP(MeasureEnsembleBrainPF, PROP, VALUE) checks VALUE format for PROP of MeasureEnsembleBrainPF.
			% 
			% PF.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:MeasureEnsembleBrainPF:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PF.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PF.
			%   Error id: €BRAPH2.STR€:MeasureEnsembleBrainPF:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(MeasureEnsembleBrainPF, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MeasureEnsembleBrainPF.
			%   Error id: €BRAPH2.STR€:MeasureEnsembleBrainPF:€BRAPH2.WRONG_INPUT€
			%  PF.CHECKPROP(MeasureEnsembleBrainPF, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MeasureEnsembleBrainPF.
			%   Error id: €BRAPH2.STR€:MeasureEnsembleBrainPF:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PF) and Element.CHECKPROP('MeasureEnsembleBrainPF')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = MeasureEnsembleBrainPF.getPropProp(pointer);
			
			switch prop
				case MeasureEnsembleBrainPF.ME % __MeasureEnsembleBrainPF.ME__
					check = Format.checkFormat(Format.ITEM, value, MeasureEnsembleBrainPF.getPropSettings(prop));
				case MeasureEnsembleBrainPF.SETUP % __MeasureEnsembleBrainPF.SETUP__
					check = Format.checkFormat(Format.EMPTY, value, MeasureEnsembleBrainPF.getPropSettings(prop));
				case MeasureEnsembleBrainPF.TEMPLATE % __MeasureEnsembleBrainPF.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, MeasureEnsembleBrainPF.getPropSettings(prop));
				otherwise
					if prop <= BrainAtlasPF.getPropNumber()
						check = checkProp@BrainAtlasPF(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MeasureEnsembleBrainPF:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MeasureEnsembleBrainPF:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' MeasureEnsembleBrainPF.getPropTag(prop) ' (' MeasureEnsembleBrainPF.getFormatTag(MeasureEnsembleBrainPF.getPropFormat(prop)) ').'] ...
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
				case MeasureEnsembleBrainPF.SETUP % __MeasureEnsembleBrainPF.SETUP__
					value = [];
					
				case MeasureEnsembleBrainPF.DRAW % __MeasureEnsembleBrainPF.DRAW__
					value = calculateValue@BrainAtlasPF(pf, MeasureEnsembleBrainPF.DRAW, varargin{:}); % also warning
					if value    
					    % trigger setup
					    pf.get('SETUP');
					end
					
				case MeasureEnsembleBrainPF.DELETE % __MeasureEnsembleBrainPF.DELETE__
					value = calculateValue@BrainAtlasPF(pf, MeasureEnsembleBrainPF.DELETE, varargin{:}); % also warning
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
