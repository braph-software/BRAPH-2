classdef PipelineSection < ConcreteElement
	%PipelineSection is a pipeline code section.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% A Pipeline Section (PipelineSection) represents a section of executable code in a pipeline.
	%
	% PipelineSection methods (constructor):
	%  PipelineSection - constructor
	%
	% PipelineSection methods:
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
	% PipelineSection methods (display):
	%  tostring - string with information about the pipeline section
	%  disp - displays information about the pipeline section
	%  tree - displays the tree of the pipeline section
	%
	% PipelineSection methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two pipeline section are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the pipeline section
	%
	% PipelineSection methods (save/load, Static):
	%  save - saves BRAPH2 pipeline section as b2 file
	%  load - loads a BRAPH2 pipeline section from a b2 file
	%
	% PipelineSection method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the pipeline section
	%
	% PipelineSection method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the pipeline section
	%
	% PipelineSection methods (inspection, Static):
	%  getClass - returns the class of the pipeline section
	%  getSubclasses - returns all subclasses of PipelineSection
	%  getProps - returns the property list of the pipeline section
	%  getPropNumber - returns the property number of the pipeline section
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
	% PipelineSection methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% PipelineSection methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% PipelineSection methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% PipelineSection methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?PipelineSection; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">PipelineSection constants</a>.
	%
	%
	% See also PipelinePP_PSDict, Pipeline, PipelineSection.
	
	properties (Constant) % properties
		PC_DICT = ConcreteElement.getPropNumber() + 1;
		PC_DICT_TAG = 'PC_DICT';
		PC_DICT_CATEGORY = Category.DATA;
		PC_DICT_FORMAT = Format.IDICT;
	end
	methods % constructor
		function ps = PipelineSection(varargin)
			%PipelineSection() creates a pipeline section.
			%
			% PipelineSection(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% PipelineSection(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			ps = ps@ConcreteElement(varargin{:});
		end
	end
	methods (Static) % inspection
		function ps_class = getClass()
			%GETCLASS returns the class of the pipeline section.
			%
			% CLASS = PipelineSection.GETCLASS() returns the class 'PipelineSection'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PS.GETCLASS() returns the class of the pipeline section PS.
			%  CLASS = Element.GETCLASS(PS) returns the class of 'PS'.
			%  CLASS = Element.GETCLASS('PipelineSection') returns 'PipelineSection'.
			%
			% Note that the Element.GETCLASS(PS) and Element.GETCLASS('PipelineSection')
			%  are less computationally efficient.
			
			ps_class = 'PipelineSection';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the pipeline section.
			%
			% LIST = PipelineSection.GETSUBCLASSES() returns all subclasses of 'PipelineSection'.
			%
			% Alternative forms to call this method are:
			%  LIST = PS.GETSUBCLASSES() returns all subclasses of the pipeline section PS.
			%  LIST = Element.GETSUBCLASSES(PS) returns all subclasses of 'PS'.
			%  LIST = Element.GETSUBCLASSES('PipelineSection') returns all subclasses of 'PipelineSection'.
			%
			% Note that the Element.GETSUBCLASSES(PS) and Element.GETSUBCLASSES('PipelineSection')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('PipelineSection', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of pipeline section.
			%
			% PROPS = PipelineSection.GETPROPS() returns the property list of pipeline section
			%  as a row vector.
			%
			% PROPS = PipelineSection.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PS.GETPROPS([CATEGORY]) returns the property list of the pipeline section PS.
			%  PROPS = Element.GETPROPS(PS[, CATEGORY]) returns the property list of 'PS'.
			%  PROPS = Element.GETPROPS('PipelineSection'[, CATEGORY]) returns the property list of 'PipelineSection'.
			%
			% Note that the Element.GETPROPS(PS) and Element.GETPROPS('PipelineSection')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					ConcreteElement.getProps() ...
						PipelineSection.PC_DICT ...
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
						PipelineSection.PC_DICT ...
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
			%GETPROPNUMBER returns the property number of pipeline section.
			%
			% N = PipelineSection.GETPROPNUMBER() returns the property number of pipeline section.
			%
			% N = PipelineSection.GETPROPNUMBER(CATEGORY) returns the property number of pipeline section
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PS.GETPROPNUMBER([CATEGORY]) returns the property number of the pipeline section PS.
			%  N = Element.GETPROPNUMBER(PS) returns the property number of 'PS'.
			%  N = Element.GETPROPNUMBER('PipelineSection') returns the property number of 'PipelineSection'.
			%
			% Note that the Element.GETPROPNUMBER(PS) and Element.GETPROPNUMBER('PipelineSection')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(PipelineSection.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in pipeline section/error.
			%
			% CHECK = PipelineSection.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PS.EXISTSPROP(PROP) checks whether PROP exists for PS.
			%  CHECK = Element.EXISTSPROP(PS, PROP) checks whether PROP exists for PS.
			%  CHECK = Element.EXISTSPROP(PipelineSection, PROP) checks whether PROP exists for PipelineSection.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:PipelineSection:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PS.EXISTSPROP(PROP) throws error if PROP does NOT exist for PS.
			%   Error id: [BRAPH2:PipelineSection:WrongInput]
			%  Element.EXISTSPROP(PS, PROP) throws error if PROP does NOT exist for PS.
			%   Error id: [BRAPH2:PipelineSection:WrongInput]
			%  Element.EXISTSPROP(PipelineSection, PROP) throws error if PROP does NOT exist for PipelineSection.
			%   Error id: [BRAPH2:PipelineSection:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PS) and Element.EXISTSPROP('PipelineSection')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == PipelineSection.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PipelineSection:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PipelineSection:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for PipelineSection.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in pipeline section/error.
			%
			% CHECK = PipelineSection.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PS.EXISTSTAG(TAG) checks whether TAG exists for PS.
			%  CHECK = Element.EXISTSTAG(PS, TAG) checks whether TAG exists for PS.
			%  CHECK = Element.EXISTSTAG(PipelineSection, TAG) checks whether TAG exists for PipelineSection.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:PipelineSection:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PS.EXISTSTAG(TAG) throws error if TAG does NOT exist for PS.
			%   Error id: [BRAPH2:PipelineSection:WrongInput]
			%  Element.EXISTSTAG(PS, TAG) throws error if TAG does NOT exist for PS.
			%   Error id: [BRAPH2:PipelineSection:WrongInput]
			%  Element.EXISTSTAG(PipelineSection, TAG) throws error if TAG does NOT exist for PipelineSection.
			%   Error id: [BRAPH2:PipelineSection:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PS) and Element.EXISTSTAG('PipelineSection')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			pipelinesection_tag_list = cellfun(@(x) PipelineSection.getPropTag(x), num2cell(PipelineSection.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, pipelinesection_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PipelineSection:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PipelineSection:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for PipelineSection.'] ...
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
			%  PROPERTY = PS.GETPROPPROP(POINTER) returns property number of POINTER of PS.
			%  PROPERTY = Element.GETPROPPROP(PipelineSection, POINTER) returns property number of POINTER of PipelineSection.
			%  PROPERTY = PS.GETPROPPROP(PipelineSection, POINTER) returns property number of POINTER of PipelineSection.
			%
			% Note that the Element.GETPROPPROP(PS) and Element.GETPROPPROP('PipelineSection')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				pipelinesection_tag_list = cellfun(@(x) PipelineSection.getPropTag(x), num2cell(PipelineSection.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, pipelinesection_tag_list)); % tag = pointer
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
			%  TAG = PS.GETPROPTAG(POINTER) returns tag of POINTER of PS.
			%  TAG = Element.GETPROPTAG(PipelineSection, POINTER) returns tag of POINTER of PipelineSection.
			%  TAG = PS.GETPROPTAG(PipelineSection, POINTER) returns tag of POINTER of PipelineSection.
			%
			% Note that the Element.GETPROPTAG(PS) and Element.GETPROPTAG('PipelineSection')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case PipelineSection.PC_DICT
						tag = PipelineSection.PC_DICT_TAG;
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
			%  CATEGORY = PS.GETPROPCATEGORY(POINTER) returns category of POINTER of PS.
			%  CATEGORY = Element.GETPROPCATEGORY(PipelineSection, POINTER) returns category of POINTER of PipelineSection.
			%  CATEGORY = PS.GETPROPCATEGORY(PipelineSection, POINTER) returns category of POINTER of PipelineSection.
			%
			% Note that the Element.GETPROPCATEGORY(PS) and Element.GETPROPCATEGORY('PipelineSection')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = PipelineSection.getPropProp(pointer);
			
			switch prop
				case PipelineSection.PC_DICT
					prop_category = PipelineSection.PC_DICT_CATEGORY;
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
			%  FORMAT = PS.GETPROPFORMAT(POINTER) returns format of POINTER of PS.
			%  FORMAT = Element.GETPROPFORMAT(PipelineSection, POINTER) returns format of POINTER of PipelineSection.
			%  FORMAT = PS.GETPROPFORMAT(PipelineSection, POINTER) returns format of POINTER of PipelineSection.
			%
			% Note that the Element.GETPROPFORMAT(PS) and Element.GETPROPFORMAT('PipelineSection')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = PipelineSection.getPropProp(pointer);
			
			switch prop
				case PipelineSection.PC_DICT
					prop_format = PipelineSection.PC_DICT_FORMAT;
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
			%  DESCRIPTION = PS.GETPROPDESCRIPTION(POINTER) returns description of POINTER of PS.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(PipelineSection, POINTER) returns description of POINTER of PipelineSection.
			%  DESCRIPTION = PS.GETPROPDESCRIPTION(PipelineSection, POINTER) returns description of POINTER of PipelineSection.
			%
			% Note that the Element.GETPROPDESCRIPTION(PS) and Element.GETPROPDESCRIPTION('PipelineSection')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = PipelineSection.getPropProp(pointer);
			
			switch prop
				case PipelineSection.PC_DICT
					prop_description = 'PC_DICT (data, idict) is an indexed dictionary with the executable code lines.';
				case PipelineSection.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the pipeline section.';
				case PipelineSection.NAME
					prop_description = 'NAME (constant, string) is the name of the pipeline section.';
				case PipelineSection.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the pipeline section.';
				case PipelineSection.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the pipeline section.';
				case PipelineSection.ID
					prop_description = 'ID (data, string) is a few-letter code for the pipeline section.';
				case PipelineSection.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the pipeline section.';
				case PipelineSection.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the pipeline section.';
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
			%  SETTINGS = PS.GETPROPSETTINGS(POINTER) returns settings of POINTER of PS.
			%  SETTINGS = Element.GETPROPSETTINGS(PipelineSection, POINTER) returns settings of POINTER of PipelineSection.
			%  SETTINGS = PS.GETPROPSETTINGS(PipelineSection, POINTER) returns settings of POINTER of PipelineSection.
			%
			% Note that the Element.GETPROPSETTINGS(PS) and Element.GETPROPSETTINGS('PipelineSection')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = PipelineSection.getPropProp(pointer);
			
			switch prop
				case PipelineSection.PC_DICT
					prop_settings = 'PipelineCode';
				case PipelineSection.TEMPLATE
					prop_settings = 'PipelineSection';
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = PipelineSection.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = PipelineSection.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PS.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PS.
			%  DEFAULT = Element.GETPROPDEFAULT(PipelineSection, POINTER) returns the default value of POINTER of PipelineSection.
			%  DEFAULT = PS.GETPROPDEFAULT(PipelineSection, POINTER) returns the default value of POINTER of PipelineSection.
			%
			% Note that the Element.GETPROPDEFAULT(PS) and Element.GETPROPDEFAULT('PipelineSection')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PipelineSection.getPropProp(pointer);
			
			switch prop
				case PipelineSection.PC_DICT
					prop_default = Format.getFormatDefault(Format.IDICT, PipelineSection.getPropSettings(prop));
				case PipelineSection.ELCLASS
					prop_default = 'PipelineSection';
				case PipelineSection.NAME
					prop_default = 'Pipeline Section';
				case PipelineSection.DESCRIPTION
					prop_default = 'A Pipeline Section (PipelineSection) represents a section of executable code in a pipeline.';
				case PipelineSection.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, PipelineSection.getPropSettings(prop));
				case PipelineSection.ID
					prop_default = 'PipelineSection ID';
				case PipelineSection.LABEL
					prop_default = 'PipelineSection label';
				case PipelineSection.NOTES
					prop_default = 'PipelineSection notes';
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = PipelineSection.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = PipelineSection.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PS.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PS.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(PipelineSection, POINTER) returns the conditioned default value of POINTER of PipelineSection.
			%  DEFAULT = PS.GETPROPDEFAULTCONDITIONED(PipelineSection, POINTER) returns the conditioned default value of POINTER of PipelineSection.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PS) and Element.GETPROPDEFAULTCONDITIONED('PipelineSection')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = PipelineSection.getPropProp(pointer);
			
			prop_default = PipelineSection.conditioning(prop, PipelineSection.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = PS.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = PS.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of PS.
			%  CHECK = Element.CHECKPROP(PipelineSection, PROP, VALUE) checks VALUE format for PROP of PipelineSection.
			%  CHECK = PS.CHECKPROP(PipelineSection, PROP, VALUE) checks VALUE format for PROP of PipelineSection.
			% 
			% PS.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:PipelineSection:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PS.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PS.
			%   Error id: €BRAPH2.STR€:PipelineSection:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(PipelineSection, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PipelineSection.
			%   Error id: €BRAPH2.STR€:PipelineSection:€BRAPH2.WRONG_INPUT€
			%  PS.CHECKPROP(PipelineSection, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PipelineSection.
			%   Error id: €BRAPH2.STR€:PipelineSection:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PS) and Element.CHECKPROP('PipelineSection')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = PipelineSection.getPropProp(pointer);
			
			switch prop
				case PipelineSection.PC_DICT % __PipelineSection.PC_DICT__
					check = Format.checkFormat(Format.IDICT, value, PipelineSection.getPropSettings(prop));
				case PipelineSection.TEMPLATE % __PipelineSection.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, PipelineSection.getPropSettings(prop));
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PipelineSection:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PipelineSection:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' PipelineSection.getPropTag(prop) ' (' PipelineSection.getFormatTag(PipelineSection.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
end
