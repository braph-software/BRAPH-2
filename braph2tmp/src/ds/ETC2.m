classdef ETC2 < ETC1
	% ETC2 tests conditioning inheritance.
	% It is a subclass of <a href="matlab:help ETC1">ETC1</a>.
	%
	% ETC2 tests conditioning inheritance.
	%
	% The list of ETC2 properties is:
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
	%  <strong>19</strong> <strong>rm</strong> 	RM (metadata, rvector) is a rvector, metadata.
	%  <strong>20</strong> <strong>rp</strong> 	RP (parameter, rvector) is a rvector, parameter.
	%  <strong>21</strong> <strong>rd</strong> 	RD (data, rvector) is a rvector, data.
	%  <strong>22</strong> <strong>rg</strong> 	RG (gui, rvector) is a rvector, gui.
	%  <strong>23</strong> <strong>rf</strong> 	RF (figure, rvector) is a rvector, figure.
	%  <strong>24</strong> <strong>rr</strong> 	RR (result, rvector) is a rvector, result.
	%
	% ETC2 methods (constructor):
	% ETC2 - constructor
	%
	% ETC2 methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in test Element C2/error.
	%  existsProp - checks whether property exists in test Element C2/error.
	%  getPropNumber - returns the property number of test Element C2.
	%  getProps - returns the property list of test Element C2.
	%  getDescription - returns the description of the test Element C2.
	%  getName - returns the name of the test Element C2.
	%  getClass - returns the class of the test Element C2.
	%
	% ETC2 methods:
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
	% ETC2 methods (operators):
	%  isequal - determines whether two ETC2 are equal (values, locked)
	%
	% ETC2 methods (display):
	%  tostring - string with information about the ETC2
	%  disp - displays information about the ETC2
	%  tree - displays the element of ETC2
	%
	% ETC2 method (element list):
	%  getElementList - returns a list with all subelements of ETC2
	%
	% ETC2 method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the ETC2
	%
	% ETC2 method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the ETC2
	%
	% ETC2 methods (copy):
	%  copy - copies the ETC2
	%  deepclone - deep-clones the ETC2
	%  clone - clones the ETC2
	%
	% ETC2 methods (inspection, Static):
	%  getClass - returns ETC2
	%  getName - returns the name of ETC2
	%  getDescription - returns the description of ETC2
	%  getProps - returns the property list of ETC2
	%  getPropNumber - returns the property number of ETC2
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
	% ETC2 methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% ETC2 methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% ETC2 methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% ETC2 methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% ETC2 properties (Constant).
	%  RM - 19
	%  RM_TAG - 'rm'
	%  RM_CATEGORY - 'm'
	%  RM_FORMAT - 'nr'
	%  RP - 20
	%  RP_TAG - 'rp'
	%  RP_CATEGORY - 'p'
	%  RP_FORMAT - 'nr'
	%  RD - 21
	%  RD_TAG - 'rd'
	%  RD_CATEGORY - 'd'
	%  RD_FORMAT - 'nr'
	%  RG - 22
	%  RG_TAG - 'rg'
	%  RG_CATEGORY - 'g'
	%  RG_FORMAT - 'nr'
	%  RF - 23
	%  RF_TAG - 'rf'
	%  RF_CATEGORY - 'f'
	%  RF_FORMAT - 'nr'
	%  RR - 24
	%  RR_TAG - 'rr'
	%  RR_CATEGORY - 'r'
	%  RR_FORMAT - 'nr'
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
	% See also Element, Category, Format, ETC1, ETC3.
	
	properties (Constant) % properties
		RM = ETC1.getPropNumber() + 1;
		RM_TAG = 'rm';
		RM_CATEGORY = Category.METADATA;
		RM_FORMAT = Format.RVECTOR;
		
		RP = ETC1.getPropNumber() + 2;
		RP_TAG = 'rp';
		RP_CATEGORY = Category.PARAMETER;
		RP_FORMAT = Format.RVECTOR;
		
		RD = ETC1.getPropNumber() + 3;
		RD_TAG = 'rd';
		RD_CATEGORY = Category.DATA;
		RD_FORMAT = Format.RVECTOR;
		
		RG = ETC1.getPropNumber() + 4;
		RG_TAG = 'rg';
		RG_CATEGORY = Category.GUI;
		RG_FORMAT = Format.RVECTOR;
		
		RF = ETC1.getPropNumber() + 5;
		RF_TAG = 'rf';
		RF_CATEGORY = Category.FIGURE;
		RF_FORMAT = Format.RVECTOR;
		
		RR = ETC1.getPropNumber() + 6;
		RR_TAG = 'rr';
		RR_CATEGORY = Category.RESULT;
		RR_FORMAT = Format.RVECTOR;
	end
	methods (Static) % inspection methods
		function et_class = getClass()
			%GETCLASS returns the class of the test Element C2.
			%
			% CLASS = ETC2.GETCLASS() returns the class 'ETC2'.
			%
			% Alternative forms to call this method are:
			%  CLASS = ET.GETCLASS() returns the class of the test Element C2 ET.
			%  CLASS = Element.GETCLASS(ET) returns the class of 'ET'.
			%  CLASS = Element.GETCLASS('ETC2') returns 'ETC2'.
			%
			% See also getName, getDescription.
			
			et_class = 'ETC2';
		end
		function et_name = getName()
			%GETNAME returns the name of the test Element C2.
			%
			% NAME = ETC2.GETNAME() returns the name of the 'test Element C2'.
			%  Test Element C2.
			%
			% Alternative forms to call this method are:
			%  NAME = ET.GETNAME() returns the name of the test Element C2 ET.
			%  NAME = Element.GETNAME(ET) returns the name of 'ET'.
			%  NAME = Element.GETNAME('ETC2') returns the name of 'ETC2'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			et_name = 'Test Element C2';
		end
		function et_description = getDescription()
			%GETDESCRIPTION returns the description of the test Element C2.
			%
			% STR = ETC2.GETDESCRIPTION() returns the description of the 'test Element C2'.
			%  which is:
			%
			%  ETC2 tests conditioning inheritance.
			%
			% Alternative forms to call this method are:
			%  STR = ET.GETDESCRIPTION() returns the description of the test Element C2 ET.
			%  STR = Element.GETDESCRIPTION(ET) returns the description of 'ET'.
			%  STR = Element.GETDESCRIPTION('ETC2') returns the description of 'ETC2'.
			%
			% See also getClass, getName.
			
			et_description = [
				'ETC2 tests conditioning inheritance.' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of test Element C2.
			%
			% PROPS = ETC2.GETPROPS() returns the property list of test Element C2.
			%
			% PROPS = ETC2.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = ET.GETPROPS([CATEGORY]) returns the property list of the test Element C2 ET.
			%  PROPS = Element.GETPROPS(ET[, CATEGORY]) returns the property list of 'ET'.
			%  PROPS = Element.GETPROPS('ETC2'[, CATEGORY]) returns the property list of 'ETC2'.
			%
			% See also getPropNumber.
			
			if nargin < 1
				category = 'all';
			end
			
			switch category
				case Category.METADATA
					prop_list = [
						ETC1.getProps(Category.METADATA)
						ETC2.RM
						];
				case Category.PARAMETER
					prop_list = [
						ETC1.getProps(Category.PARAMETER)
						ETC2.RP
						];
				case Category.DATA
					prop_list = [
						ETC1.getProps(Category.DATA)
						ETC2.RD
						];
				case Category.RESULT
					prop_list = [
						ETC1.getProps(Category.RESULT)
						ETC2.RR
						];
				case Category.FIGURE
					prop_list = [
						ETC1.getProps(Category.FIGURE)
						ETC2.RF
						];
				case Category.GUI
					prop_list = [
						ETC1.getProps(Category.GUI)
						ETC2.RG
						];
				otherwise
					prop_list = [
						ETC1.getProps()
						ETC2.RM
						ETC2.RP
						ETC2.RD
						ETC2.RG
						ETC2.RF
						ETC2.RR
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of test Element C2.
			%
			% N = ETC2.GETPROPNUMBER() returns the property number of test Element C2.
			%
			% Alternative forms to call this method are:
			%  N = ET.GETPROPNUMBER() returns the property number of the test Element C2 ET.
			%  N = Element.GETPROPNUMBER(ET) returns the property number of 'ET'.
			%  N = Element.GETPROPNUMBER('ETC2') returns the property number of 'ETC2'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 24;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in test Element C2/error.
			%
			% CHECK = ETC2.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = ET.EXISTSPROP(PROP) checks whether PROP exists for ET.
			%  CHECK = Element.EXISTSPROP(ET, PROP) checks whether PROP exists for ET.
			%  CHECK = Element.EXISTSPROP(ETC2, PROP) checks whether PROP exists for ETC2.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:ETC2:WrongInput]
			%
			% Alternative forms to call this method are:
			%  ET.EXISTSPROP(PROP) throws error if PROP does NOT exist for ET.
			%   Error id: [BRAPH2:ETC2:WrongInput]
			%  Element.EXISTSPROP(ET, PROP) throws error if PROP does NOT exist for ET.
			%   Error id: [BRAPH2:ETC2:WrongInput]
			%  Element.EXISTSPROP(ETC2, PROP) throws error if PROP does NOT exist for ETC2.
			%   Error id: [BRAPH2:ETC2:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24 ]);
			else
				assert( ...
					ETC2.existsProp(prop), ...
					[BRAPH2.STR ':ETC2:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ETC2:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for ETC2.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in test Element C2/error.
			%
			% CHECK = ETC2.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = ET.EXISTSTAG(TAG) checks whether TAG exists for ET.
			%  CHECK = Element.EXISTSTAG(ET, TAG) checks whether TAG exists for ET.
			%  CHECK = Element.EXISTSTAG(ETC2, TAG) checks whether TAG exists for ETC2.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:ETC2:WrongInput]
			%
			% Alternative forms to call this method are:
			%  ET.EXISTSTAG(TAG) throws error if TAG does NOT exist for ET.
			%   Error id: [BRAPH2:ETC2:WrongInput]
			%  Element.EXISTSTAG(ET, TAG) throws error if TAG does NOT exist for ET.
			%   Error id: [BRAPH2:ETC2:WrongInput]
			%  Element.EXISTSTAG(ETC2, TAG) throws error if TAG does NOT exist for ETC2.
			%   Error id: [BRAPH2:ETC2:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				etc2_tag_list = { 'nm'  'np'  'nd'  'ng'  'nf'  'nr'  'sm'  'sp'  'sd'  'sg'  'sf'  'sr'  'cm'  'cp'  'cd'  'cg'  'cf'  'cr'  'rm'  'rp'  'rd'  'rg'  'rf'  'rr' };
				
				check = any(strcmpi(tag, etc2_tag_list));
			else
				assert( ...
					ETC2.existsTag(tag), ...
					[BRAPH2.STR ':ETC2:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ETC2:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for ETC2'] ...
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
			%  PROPERTY = Element.GETPROPPROP(ETC2, POINTER) returns property number of POINTER of ETC2.
			%  PROPERTY = ET.GETPROPPROP(ETC2, POINTER) returns property number of POINTER of ETC2.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				etc2_tag_list = { 'nm'  'np'  'nd'  'ng'  'nf'  'nr'  'sm'  'sp'  'sd'  'sg'  'sf'  'sr'  'cm'  'cp'  'cd'  'cg'  'cf'  'cr'  'rm'  'rp'  'rd'  'rg'  'rf'  'rr' };
				
				tag = pointer;
				ETC2.existsTag(tag);
				
				prop = find(strcmpi(tag, etc2_tag_list));
			else % numeric
				prop = pointer;
				ETC2.existsProp(prop);
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
			%  TAG = Element.GETPROPTAG(ETC2, POINTER) returns tag of POINTER of ETC2.
			%  TAG = ET.GETPROPTAG(ETC2, POINTER) returns tag of POINTER of ETC2.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				ETC2.existsTag(tag);
			else % numeric
				prop = pointer;
				ETC2.existsProp(prop);
				
				switch prop
					case ETC2.RM
						tag = ETC2.RM_TAG;
					case ETC2.RP
						tag = ETC2.RP_TAG;
					case ETC2.RD
						tag = ETC2.RD_TAG;
					case ETC2.RG
						tag = ETC2.RG_TAG;
					case ETC2.RF
						tag = ETC2.RF_TAG;
					case ETC2.RR
						tag = ETC2.RR_TAG;
					otherwise
						tag = getPropTag@ETC1(prop);
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
			%  CATEGORY = Element.GETPROPCATEGORY(ETC2, POINTER) returns category of POINTER of ETC2.
			%  CATEGORY = ET.GETPROPCATEGORY(ETC2, POINTER) returns category of POINTER of ETC2.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = ETC2.getPropProp(pointer);
			
			switch prop
				case ETC2.RM
					prop_category = ETC2.RM_CATEGORY;
				case ETC2.RP
					prop_category = ETC2.RP_CATEGORY;
				case ETC2.RD
					prop_category = ETC2.RD_CATEGORY;
				case ETC2.RG
					prop_category = ETC2.RG_CATEGORY;
				case ETC2.RF
					prop_category = ETC2.RF_CATEGORY;
				case ETC2.RR
					prop_category = ETC2.RR_CATEGORY;
				otherwise
					prop_category = getPropCategory@ETC1(prop);
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
			%  FORMAT = Element.GETPROPFORMAT(ETC2, POINTER) returns format of POINTER of ETC2.
			%  FORMAT = ET.GETPROPFORMAT(ETC2, POINTER) returns format of POINTER of ETC2.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = ETC2.getPropProp(pointer);
			
			switch prop
				case ETC2.RM
					prop_format = ETC2.RM_FORMAT;
				case ETC2.RP
					prop_format = ETC2.RP_FORMAT;
				case ETC2.RD
					prop_format = ETC2.RD_FORMAT;
				case ETC2.RG
					prop_format = ETC2.RG_FORMAT;
				case ETC2.RF
					prop_format = ETC2.RF_FORMAT;
				case ETC2.RR
					prop_format = ETC2.RR_FORMAT;
				otherwise
					prop_format = getPropFormat@ETC1(prop);
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(ETC2, POINTER) returns description of POINTER of ETC2.
			%  DESCRIPTION = ET.GETPROPDESCRIPTION(ETC2, POINTER) returns description of POINTER of ETC2.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = ETC2.getPropProp(pointer);
			
			switch prop
				case ETC2.RM
					prop_description = 'RM (metadata, rvector) is a rvector, metadata.';
				case ETC2.RP
					prop_description = 'RP (parameter, rvector) is a rvector, parameter.';
				case ETC2.RD
					prop_description = 'RD (data, rvector) is a rvector, data.';
				case ETC2.RG
					prop_description = 'RG (gui, rvector) is a rvector, gui.';
				case ETC2.RF
					prop_description = 'RF (figure, rvector) is a rvector, figure.';
				case ETC2.RR
					prop_description = 'RR (result, rvector) is a rvector, result.';
				case ETC2.NM
					prop_description = 'NM (metadata, scalar) is a scalar, metadata.';
				case ETC2.NP
					prop_description = 'NP (parameter, scalar) is a scalar, parameter.';
				case ETC2.ND
					prop_description = 'ND (data, scalar) is a scalar, data.';
				case ETC2.NG
					prop_description = 'NG (gui, scalar) is a scalar, gui.';
				case ETC2.NF
					prop_description = 'NF (figure, scalar) is a scalar, figure.';
				case ETC2.NR
					prop_description = 'NR (result, scalar) is a scalar, result.';
				case ETC2.SM
					prop_description = 'SM (metadata, string) is a scalar, metadata.';
				case ETC2.SP
					prop_description = 'SP (parameter, string) is a scalar, parameter.';
				case ETC2.SD
					prop_description = 'SD (data, string) is a scalar, data.';
				case ETC2.SG
					prop_description = 'SG (gui, string) is a scalar, gui.';
				case ETC2.SF
					prop_description = 'SF (figure, string) is a scalar, figure.';
				case ETC2.SR
					prop_description = 'SR (result, string) is a scalar, result.';
				otherwise
					prop_description = getPropDescription@ETC1(prop);
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
			%  SETTINGS = Element.GETPROPSETTINGS(ETC2, POINTER) returns settings of POINTER of ETC2.
			%  SETTINGS = ET.GETPROPSETTINGS(ETC2, POINTER) returns settings of POINTER of ETC2.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = ETC2.getPropProp(pointer);
			
			switch prop
				case ETC2.RM
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case ETC2.RP
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case ETC2.RD
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case ETC2.RG
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case ETC2.RF
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case ETC2.RR
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				otherwise
					prop_settings = getPropSettings@ETC1(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = ETC2.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = ETC2.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = ET.GETPROPDEFAULT(POINTER) returns the default value of POINTER of ET.
			%  DEFAULT = Element.GETPROPDEFAULT(ETC2, POINTER) returns the default value of POINTER of ETC2.
			%  DEFAULT = ET.GETPROPDEFAULT(ETC2, POINTER) returns the default value of POINTER of ETC2.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = ETC2.getPropProp(pointer);
			
			switch prop
				case ETC2.RM
					prop_default = [0:1:10]';
				case ETC2.RP
					prop_default = [0:1:20]';
				case ETC2.RD
					prop_default = [0:1:30]';
				case ETC2.RG
					prop_default = [0:1:40]';
				case ETC2.RF
					prop_default = [0:1:50]';
				case ETC2.RR
					prop_default = [0:1:60]';
				case ETC2.NM
					prop_default = -[0:1:10];
				case ETC2.NP
					prop_default = -[0:1:10];
				case ETC2.ND
					prop_default = -[0:1:10];
				case ETC2.NG
					prop_default = -[0:1:10];
				case ETC2.NF
					prop_default = -[0:1:10];
				case ETC2.NR
					prop_default = -[0:1:10];
				otherwise
					prop_default = getPropDefault@ETC1(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = ETC2.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = ETC2.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = ET.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of ET.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(ETC2, POINTER) returns the conditioned default value of POINTER of ETC2.
			%  DEFAULT = ET.GETPROPDEFAULTCONDITIONED(ETC2, POINTER) returns the conditioned default value of POINTER of ETC2.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = ETC2.getPropProp(pointer);
			
			prop_default = ETC2.conditioning(prop, ETC2.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(ETC2, PROP, VALUE) checks VALUE format for PROP of ETC2.
			%  CHECK = ET.CHECKPROP(ETC2, PROP, VALUE) checks VALUE format for PROP of ETC2.
			% 
			% ET.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:ETC2:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  ET.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of ET.
			%   Error id: [BRAPH2:ETC2:WrongInput]
			%  Element.CHECKPROP(ETC2, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ETC2.
			%   Error id: [BRAPH2:ETC2:WrongInput]
			%  ET.CHECKPROP(ETC2, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ETC2.
			%   Error id: [BRAPH2:ETC2:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = ETC2.getPropProp(pointer);
			
			switch prop
				case ETC2.RM
					check = Format.checkFormat(Format.RVECTOR, value, ETC2.getPropSettings(prop));
				case ETC2.RP
					check = Format.checkFormat(Format.RVECTOR, value, ETC2.getPropSettings(prop));
				case ETC2.RD
					check = Format.checkFormat(Format.RVECTOR, value, ETC2.getPropSettings(prop));
				case ETC2.RG
					check = Format.checkFormat(Format.RVECTOR, value, ETC2.getPropSettings(prop));
				case ETC2.RF
					check = Format.checkFormat(Format.RVECTOR, value, ETC2.getPropSettings(prop));
				case ETC2.RR
					check = Format.checkFormat(Format.RVECTOR, value, ETC2.getPropSettings(prop));
				otherwise
					check = checkProp@ETC1(prop, value);
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':ETC2:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ETC2:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' ETC2.getPropTag(prop) ' (' ETC2.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function et = ETC2(varargin)
			% ETC2() creates a test Element C2.
			%
			% ETC2(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% ETC2(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of ETC2 properties is:
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
			%  <strong>19</strong> <strong>rm</strong> 	RM (metadata, rvector) is a rvector, metadata.
			%  <strong>20</strong> <strong>rp</strong> 	RP (parameter, rvector) is a rvector, parameter.
			%  <strong>21</strong> <strong>rd</strong> 	RD (data, rvector) is a rvector, data.
			%  <strong>22</strong> <strong>rg</strong> 	RG (gui, rvector) is a rvector, gui.
			%  <strong>23</strong> <strong>rf</strong> 	RF (figure, rvector) is a rvector, figure.
			%  <strong>24</strong> <strong>rr</strong> 	RR (result, rvector) is a rvector, result.
			%
			% See also Category, Format, set, check.
			
			et = et@ETC1(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = ETC2.getPropProp(pointer);
			
			switch prop
				case ETC2.RM
					value = value';
					
				case ETC2.RP
					value = value';
					
				case ETC2.RD
					value = value';
					
				case ETC2.RG
					value = value';
					
				case ETC2.RF
					value = value';
					
				case ETC2.RR
					if ~isa(value, 'NoValue')
					    value = value';
					end
					
				case ETC2.NM
					value = value(2);
					
				case ETC2.NP
					value = value(3);
					
				case ETC2.ND
					value = value(4);
					
				case ETC2.NG
					value = value(5);
					
				case ETC2.NF
					value = value(6);
					
				case ETC2.NR
					if ~isa(value, 'NoValue')
					    value = value(7);
					end
					
				case ETC2.SM
					value = 'SM2';
					
				case ETC2.SP
					value = 'SP2';
					
				case ETC2.SD
					value = 'SD2';
					
				case ETC2.SG
					value = 'SG2';
					
				case ETC2.SF
					value = 'SF2';
					
				case ETC2.SR
					value = 'SR2';
					
				otherwise
					if prop <= ETC1.getPropNumber()
						value = conditioning@ETC1(pointer, value);
					end
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(et, prop)
		
			switch prop
				otherwise
					value = calculateValue@ETC1(et, prop);
					
			end
		end
	end
end
