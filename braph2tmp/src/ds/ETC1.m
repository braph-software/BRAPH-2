classdef ETC1 < Element
	% ETC1 tests conditioning.
	% It is a subclass of <a href="matlab:help Element">Element</a>.
	%
	% ETC1 tests conditioning.
	%
	% The list of ETC1 properties is:
	%  <strong>1</strong> <strong>nm</strong> 	NM (metadata, scalar) is a scalar, metadata.
	%  <strong>2</strong> <strong>np</strong> 	NP (parameter, scalar) is a scalar, parameter.
	%  <strong>3</strong> <strong>nd</strong> 	ND (data, scalar) is a scalar, data.
	%  <strong>4</strong> <strong>ng</strong> 	NG (gui, scalar) is a scalar, gui.
	%  <strong>5</strong> <strong>nf</strong> 	NF (figure, scalar) is a scalar, figure.
	%  <strong>6</strong> <strong>nr</strong> 	NR (result, scalar) is a scalar, result.
	%  <strong>7</strong> <strong>sm</strong> 	SM (metadata, string) is a scalar, metadata.
	%  <strong>8</strong> <strong>sp</strong> 	SP (parameter, string) is a scalar, parameter.
	%  <strong>9</strong> <strong>sd</strong> 	SD (data, string) is a scalar, data.
	%  <strong>10</strong> <strong>sg</strong> 	SG (gui, string) is a scalar, gui.
	%  <strong>11</strong> <strong>sf</strong> 	SF (figure, string) is a scalar, figure.
	%  <strong>12</strong> <strong>sr</strong> 	SR (result, string) is a scalar, result.
	%  <strong>13</strong> <strong>cm</strong> 	CM (metadata, cvector) is a cvector, metadata.
	%  <strong>14</strong> <strong>cp</strong> 	CP (parameter, cvector) is a cvector, parameter.
	%  <strong>15</strong> <strong>cd</strong> 	CD (data, cvector) is a cvector, data.
	%  <strong>16</strong> <strong>cg</strong> 	CG (gui, cvector) is a cvector, gui.
	%  <strong>17</strong> <strong>cf</strong> 	CF (figure, cvector) is a cvector, figure.
	%  <strong>18</strong> <strong>cr</strong> 	CR (result, cvector) is a cvector, result.
	%
	% ETC1 methods (constructor):
	% ETC1 - constructor
	%
	% ETC1 methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in test Element C/error.
	%  existsProp - checks whether property exists in test Element C/error.
	%  getPropNumber - returns the property number of test Element C.
	%  getProps - returns the property list of test Element C.
	%  getDescription - returns the description of the test Element C.
	%  getName - returns the name of the test Element C.
	%  getClass - returns the class of the test Element C.
	%
	% ETC1 methods:
	%  set - sets the value of a property
	%  check - checks the values of all properties
	%  getr - returns the raw value of a property
	%  get - returns the value of a property
	%  memorize - returns and memorizes the value of a property
	%  getPropSeed - returns the seed of a property
	%  isLocked - returns whether a property is locked
	%  lock - locks unreversibly a property
	%  isChecked - returns whether a property is checked
	%  checked - sets a property to checked
	%  unchecked - sets a property to NOT checked
	%
	% ETC1 methods (operators):
	%  isequal - determines whether two ETC1 are equal (values, locked)
	%
	% ETC1 methods (display):
	%  tostring - string with information about the ETC1
	%  disp - displays information about the ETC1
	%  tree - displays the element of ETC1
	%
	% ETC1 method (element list):
	%  getElementList - returns a list with all subelements of ETC1
	%
	% ETC1 method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the ETC1
	%
	% ETC1 method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the ETC1
	%
	% ETC1 methods (copy):
	%  copy - copies the ETC1
	%  deepclone - deep-clones the ETC1
	%  clone - clones the ETC1
	%
	% ETC1 methods (inspection, Static):
	%  getClass - returns ETC1
	%  getName - returns the name of ETC1
	%  getDescription - returns the description of ETC1
	%  getProps - returns the property list of ETC1
	%  getPropNumber - returns the property number of ETC1
	%  existsProp - checks whether property exists/error
	%  existsTag - checks whether tag exists/error
	%  getPropProp - returns the property number of a property
	%  getPropTag - returns the tag of a property
	%  getPropCategory - returns the category of a property
	%  getPropFormat - returns the format of a property
	%  getPropDescription - returns the description of a property
	%  getPropSettings - returns the settings of a property
	%  getPropDefault - returns the default value of a property
	%  getPropDefaultConditioned - returns the conditione default value of a property
	%  checkProp - checks whether a value has the correct format/error
	%
	% ETC1 methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% ETC1 methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% ETC1 methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% ETC1 methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% ETC1 properties (Constant).
	%  NM - 1
	%  NM_TAG - 'nm'
	%  NM_CATEGORY - 'm'
	%  NM_FORMAT - 'nn'
	%  NP - 2
	%  NP_TAG - 'np'
	%  NP_CATEGORY - 'p'
	%  NP_FORMAT - 'nn'
	%  ND - 3
	%  ND_TAG - 'nd'
	%  ND_CATEGORY - 'd'
	%  ND_FORMAT - 'nn'
	%  NG - 4
	%  NG_TAG - 'ng'
	%  NG_CATEGORY - 'g'
	%  NG_FORMAT - 'nn'
	%  NF - 5
	%  NF_TAG - 'nf'
	%  NF_CATEGORY - 'f'
	%  NF_FORMAT - 'nn'
	%  NR - 6
	%  NR_TAG - 'nr'
	%  NR_CATEGORY - 'r'
	%  NR_FORMAT - 'nn'
	%  SM - 7
	%  SM_TAG - 'sm'
	%  SM_CATEGORY - 'm'
	%  SM_FORMAT - 'st'
	%  SP - 8
	%  SP_TAG - 'sp'
	%  SP_CATEGORY - 'p'
	%  SP_FORMAT - 'st'
	%  SD - 9
	%  SD_TAG - 'sd'
	%  SD_CATEGORY - 'd'
	%  SD_FORMAT - 'st'
	%  SG - 10
	%  SG_TAG - 'sg'
	%  SG_CATEGORY - 'g'
	%  SG_FORMAT - 'st'
	%  SF - 11
	%  SF_TAG - 'sf'
	%  SF_CATEGORY - 'f'
	%  SF_FORMAT - 'st'
	%  SR - 12
	%  SR_TAG - 'sr'
	%  SR_CATEGORY - 'r'
	%  SR_FORMAT - 'st'
	%  CM - 13
	%  CM_TAG - 'cm'
	%  CM_CATEGORY - 'm'
	%  CM_FORMAT - 'nc'
	%  CP - 14
	%  CP_TAG - 'cp'
	%  CP_CATEGORY - 'p'
	%  CP_FORMAT - 'nc'
	%  CD - 15
	%  CD_TAG - 'cd'
	%  CD_CATEGORY - 'd'
	%  CD_FORMAT - 'nc'
	%  CG - 16
	%  CG_TAG - 'cg'
	%  CG_CATEGORY - 'g'
	%  CG_FORMAT - 'nc'
	%  CF - 17
	%  CF_TAG - 'cf'
	%  CF_CATEGORY - 'f'
	%  CF_FORMAT - 'nc'
	%  CR - 18
	%  CR_TAG - 'cr'
	%  CR_CATEGORY - 'r'
	%  CR_FORMAT - 'nc'
	%  METADATA - 'm'
	%  METADATA_NAME - 'metadata'
	%  METADATA_DESCRIPTION - 'Metadata NOT used in the calculation of the results (does not allow callbacks, not cloned).'
	%  PARAMETER - 'p'
	%  PARAMETER_NAME - 'parameter'
	%  PARAMETER_DESCRIPTION - 'Parameter used to calculate the results of the element (allows incoming and outgoing callbacks, cloned).'
	%  DATA - 'd'
	%  DATA_NAME - 'data'
	%  DATA_DESCRIPTION - 'Data used to calculate the results of the element (can be NoResult when not set, allows incoming and outgoing callbacks, not cloned).'
	%  RESULT - 'r'
	%  RESULT_NAME - 'result'
	%  RESULT_DESCRIPTION - 'Result calculated by the element using parameters and data (can be NoResult when not calculated, allows incoming callbacks).'
	%  FIGURE - 'f'
	%  FIGURE_NAME - 'figure'
	%  FIGURE_DESCRIPTION - 'Parameter used to plot the results in a figure (allows incoming and outgoing callbacks, not cloned).'
	%  GUI - 'g'
	%  GUI_NAME - 'gui'
	%  GUI_DESCRIPTION - 'Parameter used by the graphical user interface (allows incoming and outgoing callbacks, not cloned).'
	%  EMPTY - 'em'
	%  EMPTY_NAME - 'empty'
	%  EMPTY_DESCRIPTION - 'Empty has an empty value and is typically used as a result to execute some code.'
	%  STRING - 'st'
	%  STRING_NAME - 'string'
	%  STRING_DESCRIPTION - 'String is a char array.'
	%  LOGICAL - 'lo'
	%  LOGICAL_NAME - 'logical'
	%  LOGICAL_DESCRIPTION - 'Logical is a boolean value.'
	%  OPTION - 'op'
	%  OPTION_NAME - 'option'
	%  OPTION_DESCRIPTION - 'Option is a char array representing an option within a set defined in the element.'
	%  CLASS - 'ca'
	%  CLASS_NAME - 'class'
	%  CLASS_DESCRIPTION - 'Class is a char array corresponding to an element class.'
	%  CLASSLIST - 'cl'
	%  CLASSLIST_NAME - 'classlist'
	%  CLASSLIST_DESCRIPTION - 'ClassList is a cell array with char arrays corresponding to element classes.'
	%  ITEM - 'it'
	%  ITEM_NAME - 'item'
	%  ITEM_DESCRIPTION - 'Item is a pointer to an element of a class defined in the element.'
	%  ITEMLIST - 'il'
	%  ITEMLIST_NAME - 'itemlist'
	%  ITEMLIST_DESCRIPTION - 'ItemList is a cell array with pointers to elements of a class defined in the element.'
	%  IDICT - 'di'
	%  IDICT_NAME - 'idict'
	%  IDICT_DESCRIPTION - 'Idict is an indexed dictionary of elements of a class defined in the element.'
	%  SCALAR - 'nn'
	%  SCALAR_NAME - 'scalar'
	%  SCALAR_DESCRIPTION - 'Scalar is a scalar numerical value.'
	%  RVECTOR - 'nr'
	%  RVECTOR_NAME - 'rvector'
	%  RVECTOR_DESCRIPTION - 'Rvector is a numerical row vector.'
	%  CVECTOR - 'nc'
	%  CVECTOR_NAME - 'cvector'
	%  CVECTOR_DESCRIPTION - 'Cvector is a numerical column vector.'
	%  MATRIX - 'nm'
	%  MATRIX_NAME - 'matrix'
	%  MATRIX_DESCRIPTION - 'Matrix is a numerical matrix.'
	%  SMATRIX - 'ns'
	%  SMATRIX_NAME - 'smatrix'
	%  SMATRIX_DESCRIPTION - 'Smatrix is a numerical square matrix.'
	%  CELL - 'll'
	%  CELL_NAME - 'cell'
	%  CELL_DESCRIPTION - 'Cell is a 2D cell array of numeric data, typically used for adjaciency matrices and measures.'
	%  NET - 'ml'
	%  NET_NAME - 'net'
	%  NET_DESCRIPTION - 'Net is a MatLab neural network object.'
	%
	% See also Element, Category, Format, ETC2, ETC3.
	
	properties (Constant) % properties
		NM = 1;
		NM_TAG = 'nm';
		NM_CATEGORY = Category.METADATA;
		NM_FORMAT = Format.SCALAR;
		
		NP = 2;
		NP_TAG = 'np';
		NP_CATEGORY = Category.PARAMETER;
		NP_FORMAT = Format.SCALAR;
		
		ND = 3;
		ND_TAG = 'nd';
		ND_CATEGORY = Category.DATA;
		ND_FORMAT = Format.SCALAR;
		
		NG = 4;
		NG_TAG = 'ng';
		NG_CATEGORY = Category.GUI;
		NG_FORMAT = Format.SCALAR;
		
		NF = 5;
		NF_TAG = 'nf';
		NF_CATEGORY = Category.FIGURE;
		NF_FORMAT = Format.SCALAR;
		
		NR = 6;
		NR_TAG = 'nr';
		NR_CATEGORY = Category.RESULT;
		NR_FORMAT = Format.SCALAR;
		
		SM = 7;
		SM_TAG = 'sm';
		SM_CATEGORY = Category.METADATA;
		SM_FORMAT = Format.STRING;
		
		SP = 8;
		SP_TAG = 'sp';
		SP_CATEGORY = Category.PARAMETER;
		SP_FORMAT = Format.STRING;
		
		SD = 9;
		SD_TAG = 'sd';
		SD_CATEGORY = Category.DATA;
		SD_FORMAT = Format.STRING;
		
		SG = 10;
		SG_TAG = 'sg';
		SG_CATEGORY = Category.GUI;
		SG_FORMAT = Format.STRING;
		
		SF = 11;
		SF_TAG = 'sf';
		SF_CATEGORY = Category.FIGURE;
		SF_FORMAT = Format.STRING;
		
		SR = 12;
		SR_TAG = 'sr';
		SR_CATEGORY = Category.RESULT;
		SR_FORMAT = Format.STRING;
		
		CM = 13;
		CM_TAG = 'cm';
		CM_CATEGORY = Category.METADATA;
		CM_FORMAT = Format.CVECTOR;
		
		CP = 14;
		CP_TAG = 'cp';
		CP_CATEGORY = Category.PARAMETER;
		CP_FORMAT = Format.CVECTOR;
		
		CD = 15;
		CD_TAG = 'cd';
		CD_CATEGORY = Category.DATA;
		CD_FORMAT = Format.CVECTOR;
		
		CG = 16;
		CG_TAG = 'cg';
		CG_CATEGORY = Category.GUI;
		CG_FORMAT = Format.CVECTOR;
		
		CF = 17;
		CF_TAG = 'cf';
		CF_CATEGORY = Category.FIGURE;
		CF_FORMAT = Format.CVECTOR;
		
		CR = 18;
		CR_TAG = 'cr';
		CR_CATEGORY = Category.RESULT;
		CR_FORMAT = Format.CVECTOR;
	end
	methods (Static) % inspection methods
		function et_class = getClass()
			%GETCLASS returns the class of the test Element C.
			%
			% CLASS = ETC1.GETCLASS() returns the class 'ETC1'.
			%
			% Alternative forms to call this method are:
			%  CLASS = ET.GETCLASS() returns the class of the test Element C ET.
			%  CLASS = Element.GETCLASS(ET) returns the class of 'ET'.
			%  CLASS = Element.GETCLASS('ETC1') returns 'ETC1'.
			%
			% See also getName, getDescription.
			
			et_class = 'ETC1';
		end
		function et_name = getName()
			%GETNAME returns the name of the test Element C.
			%
			% NAME = ETC1.GETNAME() returns the name of the 'test Element C'.
			%  Test Element C.
			%
			% Alternative forms to call this method are:
			%  NAME = ET.GETNAME() returns the name of the test Element C ET.
			%  NAME = Element.GETNAME(ET) returns the name of 'ET'.
			%  NAME = Element.GETNAME('ETC1') returns the name of 'ETC1'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			et_name = 'Test Element C';
		end
		function et_description = getDescription()
			%GETDESCRIPTION returns the description of the test Element C.
			%
			% STR = ETC1.GETDESCRIPTION() returns the description of the 'test Element C'.
			%  which is:
			%
			%  ETC1 tests conditioning.
			%
			% Alternative forms to call this method are:
			%  STR = ET.GETDESCRIPTION() returns the description of the test Element C ET.
			%  STR = Element.GETDESCRIPTION(ET) returns the description of 'ET'.
			%  STR = Element.GETDESCRIPTION('ETC1') returns the description of 'ETC1'.
			%
			% See also getClass, getName.
			
			et_description = [
				'ETC1 tests conditioning.' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of test Element C.
			%
			% PROPS = ETC1.GETPROPS() returns the property list of test Element C.
			%
			% PROPS = ETC1.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = ET.GETPROPS([CATEGORY]) returns the property list of the test Element C ET.
			%  PROPS = Element.GETPROPS(ET[, CATEGORY]) returns the property list of 'ET'.
			%  PROPS = Element.GETPROPS('ETC1'[, CATEGORY]) returns the property list of 'ETC1'.
			%
			% See also getPropNumber.
			
			if nargin < 1
				category = 'all';
			end
			
			switch category
				case Category.METADATA
					prop_list = [
						ETC1.NM
						ETC1.SM
						ETC1.CM
						];
				case Category.PARAMETER
					prop_list = [
						ETC1.NP
						ETC1.SP
						ETC1.CP
						];
				case Category.DATA
					prop_list = [
						ETC1.ND
						ETC1.SD
						ETC1.CD
						];
				case Category.RESULT
					prop_list = [
						ETC1.NR
						ETC1.SR
						ETC1.CR
						];
				case Category.FIGURE
					prop_list = [
						ETC1.NF
						ETC1.SF
						ETC1.CF
						];
				case Category.GUI
					prop_list = [
						ETC1.NG
						ETC1.SG
						ETC1.CG
						];
				otherwise
					prop_list = [
						ETC1.NM
						ETC1.NP
						ETC1.ND
						ETC1.NG
						ETC1.NF
						ETC1.NR
						ETC1.SM
						ETC1.SP
						ETC1.SD
						ETC1.SG
						ETC1.SF
						ETC1.SR
						ETC1.CM
						ETC1.CP
						ETC1.CD
						ETC1.CG
						ETC1.CF
						ETC1.CR
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of test Element C.
			%
			% N = ETC1.GETPROPNUMBER() returns the property number of test Element C.
			%
			% Alternative forms to call this method are:
			%  N = ET.GETPROPNUMBER() returns the property number of the test Element C ET.
			%  N = Element.GETPROPNUMBER(ET) returns the property number of 'ET'.
			%  N = Element.GETPROPNUMBER('ETC1') returns the property number of 'ETC1'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 18;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in test Element C/error.
			%
			% CHECK = ETC1.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = ET.EXISTSPROP(PROP) checks whether PROP exists for ET.
			%  CHECK = Element.EXISTSPROP(ET, PROP) checks whether PROP exists for ET.
			%  CHECK = Element.EXISTSPROP(ETC1, PROP) checks whether PROP exists for ETC1.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:ETC1:WrongInput]
			%
			% Alternative forms to call this method are:
			%  ET.EXISTSPROP(PROP) throws error if PROP does NOT exist for ET.
			%   Error id: [BRAPH2:ETC1:WrongInput]
			%  Element.EXISTSPROP(ET, PROP) throws error if PROP does NOT exist for ET.
			%   Error id: [BRAPH2:ETC1:WrongInput]
			%  Element.EXISTSPROP(ETC1, PROP) throws error if PROP does NOT exist for ETC1.
			%   Error id: [BRAPH2:ETC1:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18 ]);
			else
				assert( ...
					ETC1.existsProp(prop), ...
					[BRAPH2.STR ':ETC1:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ETC1:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for ETC1.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in test Element C/error.
			%
			% CHECK = ETC1.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = ET.EXISTSTAG(TAG) checks whether TAG exists for ET.
			%  CHECK = Element.EXISTSTAG(ET, TAG) checks whether TAG exists for ET.
			%  CHECK = Element.EXISTSTAG(ETC1, TAG) checks whether TAG exists for ETC1.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:ETC1:WrongInput]
			%
			% Alternative forms to call this method are:
			%  ET.EXISTSTAG(TAG) throws error if TAG does NOT exist for ET.
			%   Error id: [BRAPH2:ETC1:WrongInput]
			%  Element.EXISTSTAG(ET, TAG) throws error if TAG does NOT exist for ET.
			%   Error id: [BRAPH2:ETC1:WrongInput]
			%  Element.EXISTSTAG(ETC1, TAG) throws error if TAG does NOT exist for ETC1.
			%   Error id: [BRAPH2:ETC1:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				etc1_tag_list = { 'nm'  'np'  'nd'  'ng'  'nf'  'nr'  'sm'  'sp'  'sd'  'sg'  'sf'  'sr'  'cm'  'cp'  'cd'  'cg'  'cf'  'cr' };
				
				check = any(strcmpi(tag, etc1_tag_list));
			else
				assert( ...
					ETC1.existsTag(tag), ...
					[BRAPH2.STR ':ETC1:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ETC1:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for ETC1'] ...
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
			%  PROPERTY = ET.GETPROPPROP(POINTER) returns property number of POINTER of ET.
			%  PROPERTY = Element.GETPROPPROP(ETC1, POINTER) returns property number of POINTER of ETC1.
			%  PROPERTY = ET.GETPROPPROP(ETC1, POINTER) returns property number of POINTER of ETC1.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				etc1_tag_list = { 'nm'  'np'  'nd'  'ng'  'nf'  'nr'  'sm'  'sp'  'sd'  'sg'  'sf'  'sr'  'cm'  'cp'  'cd'  'cg'  'cf'  'cr' };
				
				tag = pointer;
				ETC1.existsTag(tag);
				
				prop = find(strcmpi(tag, etc1_tag_list));
			else % numeric
				prop = pointer;
				ETC1.existsProp(prop);
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
			%  TAG = ET.GETPROPTAG(POINTER) returns tag of POINTER of ET.
			%  TAG = Element.GETPROPTAG(ETC1, POINTER) returns tag of POINTER of ETC1.
			%  TAG = ET.GETPROPTAG(ETC1, POINTER) returns tag of POINTER of ETC1.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				ETC1.existsTag(tag);
			else % numeric
				prop = pointer;
				ETC1.existsProp(prop);
				
				switch prop
					case ETC1.NM
						tag = ETC1.NM_TAG;
					case ETC1.NP
						tag = ETC1.NP_TAG;
					case ETC1.ND
						tag = ETC1.ND_TAG;
					case ETC1.NG
						tag = ETC1.NG_TAG;
					case ETC1.NF
						tag = ETC1.NF_TAG;
					case ETC1.NR
						tag = ETC1.NR_TAG;
					case ETC1.SM
						tag = ETC1.SM_TAG;
					case ETC1.SP
						tag = ETC1.SP_TAG;
					case ETC1.SD
						tag = ETC1.SD_TAG;
					case ETC1.SG
						tag = ETC1.SG_TAG;
					case ETC1.SF
						tag = ETC1.SF_TAG;
					case ETC1.SR
						tag = ETC1.SR_TAG;
					case ETC1.CM
						tag = ETC1.CM_TAG;
					case ETC1.CP
						tag = ETC1.CP_TAG;
					case ETC1.CD
						tag = ETC1.CD_TAG;
					case ETC1.CG
						tag = ETC1.CG_TAG;
					case ETC1.CF
						tag = ETC1.CF_TAG;
					case ETC1.CR
						tag = ETC1.CR_TAG;
				end
			end
		end
		function prop_category = getPropCategory(pointer)
			%GETPROPCATEGORY returns the category of a property.
			%
			% CATEGORY = Element.GETPROPCATEGORY(PROP) returns the
			%  category of the property PROP.
			%
			% CATEGORY = Element.GETPROPCATEGORY(TAG) returns the
			%  category of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CATEGORY = ET.GETPROPCATEGORY(POINTER) returns category of POINTER of ET.
			%  CATEGORY = Element.GETPROPCATEGORY(ETC1, POINTER) returns category of POINTER of ETC1.
			%  CATEGORY = ET.GETPROPCATEGORY(ETC1, POINTER) returns category of POINTER of ETC1.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = ETC1.getPropProp(pointer);
			
			switch prop
				case ETC1.NM
					prop_category = ETC1.NM_CATEGORY;
				case ETC1.NP
					prop_category = ETC1.NP_CATEGORY;
				case ETC1.ND
					prop_category = ETC1.ND_CATEGORY;
				case ETC1.NG
					prop_category = ETC1.NG_CATEGORY;
				case ETC1.NF
					prop_category = ETC1.NF_CATEGORY;
				case ETC1.NR
					prop_category = ETC1.NR_CATEGORY;
				case ETC1.SM
					prop_category = ETC1.SM_CATEGORY;
				case ETC1.SP
					prop_category = ETC1.SP_CATEGORY;
				case ETC1.SD
					prop_category = ETC1.SD_CATEGORY;
				case ETC1.SG
					prop_category = ETC1.SG_CATEGORY;
				case ETC1.SF
					prop_category = ETC1.SF_CATEGORY;
				case ETC1.SR
					prop_category = ETC1.SR_CATEGORY;
				case ETC1.CM
					prop_category = ETC1.CM_CATEGORY;
				case ETC1.CP
					prop_category = ETC1.CP_CATEGORY;
				case ETC1.CD
					prop_category = ETC1.CD_CATEGORY;
				case ETC1.CG
					prop_category = ETC1.CG_CATEGORY;
				case ETC1.CF
					prop_category = ETC1.CF_CATEGORY;
				case ETC1.CR
					prop_category = ETC1.CR_CATEGORY;
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
			%  FORMAT = ET.GETPROPFORMAT(POINTER) returns format of POINTER of ET.
			%  FORMAT = Element.GETPROPFORMAT(ETC1, POINTER) returns format of POINTER of ETC1.
			%  FORMAT = ET.GETPROPFORMAT(ETC1, POINTER) returns format of POINTER of ETC1.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = ETC1.getPropProp(pointer);
			
			switch prop
				case ETC1.NM
					prop_format = ETC1.NM_FORMAT;
				case ETC1.NP
					prop_format = ETC1.NP_FORMAT;
				case ETC1.ND
					prop_format = ETC1.ND_FORMAT;
				case ETC1.NG
					prop_format = ETC1.NG_FORMAT;
				case ETC1.NF
					prop_format = ETC1.NF_FORMAT;
				case ETC1.NR
					prop_format = ETC1.NR_FORMAT;
				case ETC1.SM
					prop_format = ETC1.SM_FORMAT;
				case ETC1.SP
					prop_format = ETC1.SP_FORMAT;
				case ETC1.SD
					prop_format = ETC1.SD_FORMAT;
				case ETC1.SG
					prop_format = ETC1.SG_FORMAT;
				case ETC1.SF
					prop_format = ETC1.SF_FORMAT;
				case ETC1.SR
					prop_format = ETC1.SR_FORMAT;
				case ETC1.CM
					prop_format = ETC1.CM_FORMAT;
				case ETC1.CP
					prop_format = ETC1.CP_FORMAT;
				case ETC1.CD
					prop_format = ETC1.CD_FORMAT;
				case ETC1.CG
					prop_format = ETC1.CG_FORMAT;
				case ETC1.CF
					prop_format = ETC1.CF_FORMAT;
				case ETC1.CR
					prop_format = ETC1.CR_FORMAT;
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
			%  DESCRIPTION = ET.GETPROPDESCRIPTION(POINTER) returns description of POINTER of ET.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(ETC1, POINTER) returns description of POINTER of ETC1.
			%  DESCRIPTION = ET.GETPROPDESCRIPTION(ETC1, POINTER) returns description of POINTER of ETC1.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = ETC1.getPropProp(pointer);
			
			switch prop
				case ETC1.NM
					prop_description = 'NM (metadata, scalar) is a scalar, metadata.';
				case ETC1.NP
					prop_description = 'NP (parameter, scalar) is a scalar, parameter.';
				case ETC1.ND
					prop_description = 'ND (data, scalar) is a scalar, data.';
				case ETC1.NG
					prop_description = 'NG (gui, scalar) is a scalar, gui.';
				case ETC1.NF
					prop_description = 'NF (figure, scalar) is a scalar, figure.';
				case ETC1.NR
					prop_description = 'NR (result, scalar) is a scalar, result.';
				case ETC1.SM
					prop_description = 'SM (metadata, string) is a scalar, metadata.';
				case ETC1.SP
					prop_description = 'SP (parameter, string) is a scalar, parameter.';
				case ETC1.SD
					prop_description = 'SD (data, string) is a scalar, data.';
				case ETC1.SG
					prop_description = 'SG (gui, string) is a scalar, gui.';
				case ETC1.SF
					prop_description = 'SF (figure, string) is a scalar, figure.';
				case ETC1.SR
					prop_description = 'SR (result, string) is a scalar, result.';
				case ETC1.CM
					prop_description = 'CM (metadata, cvector) is a cvector, metadata.';
				case ETC1.CP
					prop_description = 'CP (parameter, cvector) is a cvector, parameter.';
				case ETC1.CD
					prop_description = 'CD (data, cvector) is a cvector, data.';
				case ETC1.CG
					prop_description = 'CG (gui, cvector) is a cvector, gui.';
				case ETC1.CF
					prop_description = 'CF (figure, cvector) is a cvector, figure.';
				case ETC1.CR
					prop_description = 'CR (result, cvector) is a cvector, result.';
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
			%  SETTINGS = ET.GETPROPSETTINGS(POINTER) returns settings of POINTER of ET.
			%  SETTINGS = Element.GETPROPSETTINGS(ETC1, POINTER) returns settings of POINTER of ETC1.
			%  SETTINGS = ET.GETPROPSETTINGS(ETC1, POINTER) returns settings of POINTER of ETC1.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = ETC1.getPropProp(pointer);
			
			switch prop
				case ETC1.NM
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case ETC1.NP
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case ETC1.ND
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case ETC1.NG
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case ETC1.NF
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case ETC1.NR
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case ETC1.SM
					prop_settings = Format.getFormatSettings(Format.STRING);
				case ETC1.SP
					prop_settings = Format.getFormatSettings(Format.STRING);
				case ETC1.SD
					prop_settings = Format.getFormatSettings(Format.STRING);
				case ETC1.SG
					prop_settings = Format.getFormatSettings(Format.STRING);
				case ETC1.SF
					prop_settings = Format.getFormatSettings(Format.STRING);
				case ETC1.SR
					prop_settings = Format.getFormatSettings(Format.STRING);
				case ETC1.CM
					prop_settings = Format.getFormatSettings(Format.CVECTOR);
				case ETC1.CP
					prop_settings = Format.getFormatSettings(Format.CVECTOR);
				case ETC1.CD
					prop_settings = Format.getFormatSettings(Format.CVECTOR);
				case ETC1.CG
					prop_settings = Format.getFormatSettings(Format.CVECTOR);
				case ETC1.CF
					prop_settings = Format.getFormatSettings(Format.CVECTOR);
				case ETC1.CR
					prop_settings = Format.getFormatSettings(Format.CVECTOR);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = ETC1.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = ETC1.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = ET.GETPROPDEFAULT(POINTER) returns the default value of POINTER of ET.
			%  DEFAULT = Element.GETPROPDEFAULT(ETC1, POINTER) returns the default value of POINTER of ETC1.
			%  DEFAULT = ET.GETPROPDEFAULT(ETC1, POINTER) returns the default value of POINTER of ETC1.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = ETC1.getPropProp(pointer);
			
			switch prop
				case ETC1.NM
					prop_default = [0:1:10];
				case ETC1.NP
					prop_default = [0:1:10];
				case ETC1.ND
					prop_default = [0:1:10];
				case ETC1.NG
					prop_default = [0:1:10];
				case ETC1.NF
					prop_default = [0:1:10];
				case ETC1.NR
					prop_default = [0:1:10];
				case ETC1.SM
					prop_default = Format.getFormatDefault(Format.STRING, ETC1.getPropSettings(prop));
				case ETC1.SP
					prop_default = Format.getFormatDefault(Format.STRING, ETC1.getPropSettings(prop));
				case ETC1.SD
					prop_default = Format.getFormatDefault(Format.STRING, ETC1.getPropSettings(prop));
				case ETC1.SG
					prop_default = Format.getFormatDefault(Format.STRING, ETC1.getPropSettings(prop));
				case ETC1.SF
					prop_default = Format.getFormatDefault(Format.STRING, ETC1.getPropSettings(prop));
				case ETC1.SR
					prop_default = Format.getFormatDefault(Format.STRING, ETC1.getPropSettings(prop));
				case ETC1.CM
					prop_default = [0:1:10];
				case ETC1.CP
					prop_default = [0:1:20];
				case ETC1.CD
					prop_default = [0:1:30];
				case ETC1.CG
					prop_default = [0:1:40];
				case ETC1.CF
					prop_default = [0:1:50];
				case ETC1.CR
					prop_default = [0:1:60];
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = ETC1.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = ETC1.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = ET.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of ET.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(ETC1, POINTER) returns the conditioned default value of POINTER of ETC1.
			%  DEFAULT = ET.GETPROPDEFAULTCONDITIONED(ETC1, POINTER) returns the conditioned default value of POINTER of ETC1.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = ETC1.getPropProp(pointer);
			
			prop_default = ETC1.conditioning(prop, ETC1.getPropDefault(prop));
		end
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = ET.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = ET.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of ET.
			%  CHECK = Element.CHECKPROP(ETC1, PROP, VALUE) checks VALUE format for PROP of ETC1.
			%  CHECK = ET.CHECKPROP(ETC1, PROP, VALUE) checks VALUE format for PROP of ETC1.
			% 
			% ET.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:ETC1:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  ET.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of ET.
			%   Error id: [BRAPH2:ETC1:WrongInput]
			%  Element.CHECKPROP(ETC1, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ETC1.
			%   Error id: [BRAPH2:ETC1:WrongInput]
			%  ET.CHECKPROP(ETC1, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ETC1.
			%   Error id: [BRAPH2:ETC1:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = ETC1.getPropProp(pointer);
			
			switch prop
				case ETC1.NM
					check = Format.checkFormat(Format.SCALAR, value, ETC1.getPropSettings(prop));
				case ETC1.NP
					check = Format.checkFormat(Format.SCALAR, value, ETC1.getPropSettings(prop));
				case ETC1.ND
					check = Format.checkFormat(Format.SCALAR, value, ETC1.getPropSettings(prop));
				case ETC1.NG
					check = Format.checkFormat(Format.SCALAR, value, ETC1.getPropSettings(prop));
				case ETC1.NF
					check = Format.checkFormat(Format.SCALAR, value, ETC1.getPropSettings(prop));
				case ETC1.NR
					check = Format.checkFormat(Format.SCALAR, value, ETC1.getPropSettings(prop));
				case ETC1.SM
					check = Format.checkFormat(Format.STRING, value, ETC1.getPropSettings(prop));
				case ETC1.SP
					check = Format.checkFormat(Format.STRING, value, ETC1.getPropSettings(prop));
				case ETC1.SD
					check = Format.checkFormat(Format.STRING, value, ETC1.getPropSettings(prop));
				case ETC1.SG
					check = Format.checkFormat(Format.STRING, value, ETC1.getPropSettings(prop));
				case ETC1.SF
					check = Format.checkFormat(Format.STRING, value, ETC1.getPropSettings(prop));
				case ETC1.SR
					check = Format.checkFormat(Format.STRING, value, ETC1.getPropSettings(prop));
				case ETC1.CM
					check = Format.checkFormat(Format.CVECTOR, value, ETC1.getPropSettings(prop));
				case ETC1.CP
					check = Format.checkFormat(Format.CVECTOR, value, ETC1.getPropSettings(prop));
				case ETC1.CD
					check = Format.checkFormat(Format.CVECTOR, value, ETC1.getPropSettings(prop));
				case ETC1.CG
					check = Format.checkFormat(Format.CVECTOR, value, ETC1.getPropSettings(prop));
				case ETC1.CF
					check = Format.checkFormat(Format.CVECTOR, value, ETC1.getPropSettings(prop));
				case ETC1.CR
					check = Format.checkFormat(Format.CVECTOR, value, ETC1.getPropSettings(prop));
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':ETC1:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ETC1:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' ETC1.getPropTag(prop) ' (' ETC1.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function et = ETC1(varargin)
			% ETC1() creates a test Element C.
			%
			% ETC1(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% ETC1(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of ETC1 properties is:
			%  <strong>1</strong> <strong>nm</strong> 	NM (metadata, scalar) is a scalar, metadata.
			%  <strong>2</strong> <strong>np</strong> 	NP (parameter, scalar) is a scalar, parameter.
			%  <strong>3</strong> <strong>nd</strong> 	ND (data, scalar) is a scalar, data.
			%  <strong>4</strong> <strong>ng</strong> 	NG (gui, scalar) is a scalar, gui.
			%  <strong>5</strong> <strong>nf</strong> 	NF (figure, scalar) is a scalar, figure.
			%  <strong>6</strong> <strong>nr</strong> 	NR (result, scalar) is a scalar, result.
			%  <strong>7</strong> <strong>sm</strong> 	SM (metadata, string) is a scalar, metadata.
			%  <strong>8</strong> <strong>sp</strong> 	SP (parameter, string) is a scalar, parameter.
			%  <strong>9</strong> <strong>sd</strong> 	SD (data, string) is a scalar, data.
			%  <strong>10</strong> <strong>sg</strong> 	SG (gui, string) is a scalar, gui.
			%  <strong>11</strong> <strong>sf</strong> 	SF (figure, string) is a scalar, figure.
			%  <strong>12</strong> <strong>sr</strong> 	SR (result, string) is a scalar, result.
			%  <strong>13</strong> <strong>cm</strong> 	CM (metadata, cvector) is a cvector, metadata.
			%  <strong>14</strong> <strong>cp</strong> 	CP (parameter, cvector) is a cvector, parameter.
			%  <strong>15</strong> <strong>cd</strong> 	CD (data, cvector) is a cvector, data.
			%  <strong>16</strong> <strong>cg</strong> 	CG (gui, cvector) is a cvector, gui.
			%  <strong>17</strong> <strong>cf</strong> 	CF (figure, cvector) is a cvector, figure.
			%  <strong>18</strong> <strong>cr</strong> 	CR (result, cvector) is a cvector, result.
			%
			% See also Category, Format, set, check.
			
			et = et@Element(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = ETC1.getPropProp(pointer);
			
			switch prop
				case ETC1.NM
					value = value(2);
					
				case ETC1.NP
					value = value(3);
					
				case ETC1.ND
					value = value(4);
					
				case ETC1.NG
					value = value(5);
					
				case ETC1.NF
					value = value(6);
					
				case ETC1.NR
					if ~isa(value, 'NoValue')
					    value = value(7);
					end
					
				case ETC1.SM
					value = 'SM1';
					
				case ETC1.SP
					value = 'SP1';
					
				case ETC1.SD
					value = 'SD1';
					
				case ETC1.SG
					value = 'SG1';
					
				case ETC1.SF
					value = 'SF1';
					
				case ETC1.SR
					value = 'SR1';
					
				case ETC1.CM
					value = value';
					
				case ETC1.CP
					value = value';
					
				case ETC1.CD
					value = value';
					
				case ETC1.CG
					value = value';
					
				case ETC1.CF
					value = value';
					
				case ETC1.CR
					if ~isa(value, 'NoValue')
					    value = value';
					end
					
				otherwise
					if prop <= Element.getPropNumber()
						value = conditioning@Element(pointer, value);
					end
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(et, prop)
		
			switch prop
				otherwise
					value = calculateValue@Element(et, prop);
					
			end
		end
	end
end
