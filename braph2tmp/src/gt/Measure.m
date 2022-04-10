classdef Measure < Element
	% Measure is a measure.
	% It is a subclass of <a href="matlab:help Element">Element</a>.
	%
	% Measure provides the methods necessary for all graph measures. 
	% Instances of this class should not be created. 
	% Use one of its subclasses instead.
	%
	% The list of Measure properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the graph measure.
	%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the graph measure.
	%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the graph measure.
	%  <strong>4</strong> <strong>g</strong> 	G (data, item) is the measure graph.
	%  <strong>5</strong> <strong>m</strong> 	M (result, cell) is the measure result.
	%
	% Measure methods (constructor):
	% Measure - constructor
	%
	% Measure methods (Static):
	%  getList - T returns the list of measures
	%  getCompatibleGraphNumber - returns the number of compatible graphs.
	%  getCompatibleGraphList - returns the list of graphs.
	%  is_nonparametric - checks if measure is non-parametric.
	%  is_parametric - checks if measure is parametric.
	%  getMeasureParametricity - returns the parametricity of the measure.
	%  is_bilayer - checks if measure is bi-layer.
	%  is_unilayer - checks if measure is unilayer.
	%  is_superglobal - checks if measure is superglobal.
	%  getMeasureScope - returns the measure scope.
	%  is_binodal - checks if measure is bi-nodal.
	%  is_nodal - checks if measure is nodal.
	%  is_global - checks if measure is global.
	%  getMeasureShape - returns the measure shape.
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in graph measure/error.
	%  existsProp - checks whether property exists in graph measure/error.
	%  getPropNumber - returns the property number of graph measure.
	%  getProps - returns the property list of graph measure.
	%  getDescription - returns the description of the graph measure.
	%  getName - returns the name of the graph measure.
	%  getClass - returns the class of the graph measure.
	%
	% Measure methods:
	%  getPlotProp - returns a prop plot.
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
	% Measure methods (operators):
	%  isequal - determines whether two Measure are equal (values, locked)
	%
	% Measure methods (display):
	%  tostring - string with information about the Measure
	%  disp - displays information about the Measure
	%  tree - displays the element of Measure
	%
	% Measure method (element list):
	%  getElementList - returns a list with all subelements of Measure
	%
	% Measure method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the Measure
	%
	% Measure method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the Measure
	%
	% Measure methods (copy):
	%  copy - copies the Measure
	%  deepclone - deep-clones the Measure
	%  clone - clones the Measure
	%
	% Measure methods (inspection, Static):
	%  getClass - returns Measure
	%  getName - returns the name of Measure
	%  getDescription - returns the description of Measure
	%  getProps - returns the property list of Measure
	%  getPropNumber - returns the property number of Measure
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
	% Measure methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% Measure methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% Measure methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% Measure methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% Measure properties (Constant).
	%  GLOBAL - 1
	%  GLOBAL_NAME - 'Global'
	%  GLOBAL_DESCRIPTION - 'Global measure refers to global properties of a single layer graph and, therefore, consists of a single number for each graph.'
	%  NODAL - 2
	%  NODAL_NAME - 'Nodal'
	%  NODAL_DESCRIPTION - 'Nodal measure refers to properties of the nodes ofa single layer graph and, therefore, consists of a vector of numbers, one for each node of the graph.'
	%  BINODAL - 3
	%  BINODAL_NAME - 'Binodal'
	%  BINODAL_DESCRIPTION - 'Binodal measure refers to properties between nodes ofa single layer graph and, therefore, consists of a matrix of numbers, one for each node of the graph.'
	%  SHAPE_NUMBER - 3
	%  SHAPE_NAME - cell[3 1] { 'Global' 'Nodal' 'Binodal' }
	%  SHAPE_DESCRIPTION - cell[3 1] { 'Global measure refers to global properties of a single layer graph and, therefore, consists of a single number for each graph.' 'Nodal measure refers to properties of the nodes ofa single layer graph and, therefore, consists of a vector of numbers, one for each node of the graph.' 'Binodal measure refers to properties between nodes ofa single layer graph and, therefore, consists of a matrix of numbers, one for each node of the graph.' }
	%  SUPERGLOBAL - 1
	%  SUPERGLOBAL_NAME - 'Superglobal'
	%  SUPERGLOBAL_DESCRIPTION - 'Superglobal measure consists of a single number for each non single layer graphs.'
	%  UNILAYER - 2
	%  UNILAYER_NAME - 'Unilayer'
	%  UNILAYER_DESCRIPTION - 'Unilayer measure consists of a vector with nodal/binodal/global measures for every layer.'
	%  BILAYER - 3
	%  BILAYER_NAME - 'Bilayer'
	%  BILAYER_DESCRIPTION - 'Bilayer measure consists of a matrix with nodal/binodal/global measures between layers.'
	%  SCOPE_NUMBER - 3
	%  SCOPE_NAME - cell[3 1] { 'Superglobal' 'Unilayer' 'Bilayer' }
	%  SCOPE_DESCRIPTION - cell[3 1] { 'Superglobal measure consists of a single number for each non single layer graphs.' 'Unilayer measure consists of a vector with nodal/binodal/global measures for every layer.' 'Bilayer measure consists of a matrix with nodal/binodal/global measures between layers.' }
	%  PARAMETRIC - 1
	%  PARAMETRIC_NAME - 'Parametric'
	%  PARAMETRIC_DESCRIPTION - 'Parametric measure consists of a measure that outputs the results based on a parameter.'
	%  NONPARAMETRIC - 2
	%  NONPARAMETRIC_NAME - 'Non-parametric'
	%  NONPARAMETRIC_DESCRIPTION - 'Non-parametric measure consists of a measure where the results are not based on a parameter.'
	%  PARAMETRICITY_NUMBER - 2
	%  PARAMETRICITY_NAME - cell[2 1] { 'Parametric' 'Non-parametric' }
	%  PARAMETRICITY_DESCRIPTION - cell[2 1] { 'Parametric measure consists of a measure that outputs the results based on a parameter.' 'Non-parametric measure consists of a measure where the results are not based on a parameter.' }
	%  ID - 1
	%  ID_TAG - 'id'
	%  ID_CATEGORY - 'd'
	%  ID_FORMAT - 'st'
	%  LABEL - 2
	%  LABEL_TAG - 'label'
	%  LABEL_CATEGORY - 'm'
	%  LABEL_FORMAT - 'st'
	%  NOTES - 3
	%  NOTES_TAG - 'notes'
	%  NOTES_CATEGORY - 'm'
	%  NOTES_FORMAT - 'st'
	%  G - 4
	%  G_TAG - 'g'
	%  G_CATEGORY - 'd'
	%  G_FORMAT - 'it'
	%  M - 5
	%  M_TAG - 'm'
	%  M_CATEGORY - 'r'
	%  M_FORMAT - 'll'
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
	% See also Graph.
	
	properties (Constant) % constants
		% Measure shape
		GLOBAL = 1  
		GLOBAL_NAME = 'Global'
		GLOBAL_DESCRIPTION = ['Global measure refers to global properties of ' ... 
		'a single layer graph and, therefore, consists of a single number for each graph.']
		
		NODAL = 2
		NODAL_NAME = 'Nodal'
		NODAL_DESCRIPTION = ['Nodal measure refers to properties of the nodes of' ... 
		'a single layer graph and, therefore, consists of a vector of numbers, ' ...
		'one for each node of the graph.']
		
		BINODAL = 3
		BINODAL_NAME = 'Binodal'
		BINODAL_DESCRIPTION = ['Binodal measure refers to properties between nodes of' ... 
		'a single layer graph and, therefore, consists of a matrix of numbers, ' ...
		'one for each node of the graph.']
		
		SHAPE_NUMBER = 3
		
		SHAPE_NAME = {
		    Measure.GLOBAL_NAME
		    Measure.NODAL_NAME
		    Measure.BINODAL_NAME
		    }
		
		SHAPE_DESCRIPTION = {
		    Measure.GLOBAL_DESCRIPTION
		    Measure.NODAL_DESCRIPTION
		    Measure.BINODAL_DESCRIPTION
		    }
		
		% Measure scope
		SUPERGLOBAL = 1
		SUPERGLOBAL_NAME = 'Superglobal'
		SUPERGLOBAL_DESCRIPTION = ['Superglobal measure consists of a single ' ...
		    'number for each non single layer graphs.']
		
		UNILAYER = 2
		UNILAYER_NAME = 'Unilayer'
		UNILAYER_DESCRIPTION = ['Unilayer measure consists of a vector with ' ... 
		'nodal/binodal/global measures for every layer.']
		
		BILAYER = 3
		BILAYER_NAME = 'Bilayer'
		BILAYER_DESCRIPTION = ['Bilayer measure consists of a matrix with '... 
		    'nodal/binodal/global measures between layers.']
		
		SCOPE_NUMBER = 3
		
		SCOPE_NAME = {
		    Measure.SUPERGLOBAL_NAME
		    Measure.UNILAYER_NAME
		    Measure.BILAYER_NAME
		    }
		
		SCOPE_DESCRIPTION = {
		    Measure.SUPERGLOBAL_DESCRIPTION
		    Measure.UNILAYER_DESCRIPTION
		    Measure.BILAYER_DESCRIPTION
		    }
		
		% Parametricity
		PARAMETRIC = 1
		PARAMETRIC_NAME = 'Parametric'
		PARAMETRIC_DESCRIPTION = ['Parametric measure consists of a measure ' ...
		    'that outputs the results based on a parameter.']
		
		NONPARAMETRIC = 2
		NONPARAMETRIC_NAME = 'Non-parametric'
		NONPARAMETRIC_DESCRIPTION = ['Non-parametric measure consists of a measure ' ...
		    'where the results are not based on a parameter.']
		
		PARAMETRICITY_NUMBER = 2
		
		PARAMETRICITY_NAME = {
		    Measure.PARAMETRIC_NAME
		    Measure.NONPARAMETRIC_NAME
		    }
		
		PARAMETRICITY_DESCRIPTION = {
		    Measure.PARAMETRIC_DESCRIPTION
		    Measure.NONPARAMETRIC_DESCRIPTION
		    }
	end
	methods (Static) % static methods
		function measure_shape = getMeasureShape(m)
		    %GETMEASURESHAPE returns the measure shape.
		    %
		    % MEASURE_TYPE = GETMEASURESHAPE(M) returns the measure shape of measure M
		    %  (e.g., GLOBAL, NODAL, BINODAL).
		    %
		    % MEASURE_TYPE = GETMEASURESHAPE(MEASURE_CLASS) returns the measure shape
		    %  of the measure whose class is MEASURE_CLASS (e.g., GLOBAL, NODAL,
		    %  BINODAL).
		    %
		    % See also is_binodal, is_global, is_nodal.
		
		    
		    if strcmp(Element.getClass(m), 'Measure')
		        measure_shape = Measure.NODAL;
		    else
		        measure_shape = eval([Element.getClass(m) '.getMeasureShape()']);
		    end
		end
		function bool = is_global(m)
		    %IS_GLOBAL checks if measure is global.
		    %
		    % BOOL = IS_GLOBAL(M) returns true if the concrete measure M is global and
		    %  false otherwise.
		    %
		    % BOOL = IS_GLOBAL(MEASURE_CLASS) returns true if the measure whose class
		    %  is MEASURE_CLASS is global and false otherwise.
		    %
		    % See also getMeasureShape, is_binodal, is_nodal.
		
		    bool = Measure.getMeasureShape(m) == Measure.GLOBAL;
		end
		function bool = is_nodal(m)
		    %IS_NODAL checks if measure is nodal.
		    %
		    % BOOL = IS_NODAL(M) returns true if the concrete measure M is nodal and
		    %  false otherwise.
		    %
		    % BOOL = IS_NODAL(MEASURE_CLASS) returns true if the measure whose class is
		    %  MEASURE_CLASS is nodal and false otherwise.
		    %
		    % See also getMeasureShape, is_binodal, is_global.
		
		    bool = Measure.getMeasureShape(m) == Measure.NODAL;
		end
		function bool = is_binodal(m)
		    %IS_BINODAL checks if measure is bi-nodal.
		    %
		    % BOOL = IS_BINODAL(M) returns true if concrete measure M is binodal and
		    %  false otherwise.
		    %
		    % BOOL = IS_BINODAL(MEASURE_CLASS) returns true if a  measure whose class
		    %  is MEASURE_CALSS is binodal and false otherwise.
		    %
		    % See also getMeasureShape, is_global, is_nodal.
		
		    bool = Measure.getMeasureShape(m) == Measure.BINODAL;
		end
		function measure_scope = getMeasureScope(m)
		    %GETMEASURESCOPE returns the measure scope.
		    %
		    % MEASURE_SCOPE = GETMEASURESCOPE(M) returns the measure scope of measure M
		    %  (e.g., SUPERGLOBAL, UNILAYER, BILAYER).
		    %
		    % MEASURE_SCOPE = GETMEASURESCOPE(MEASURE_CLASS) returns the measure scope
		    %  of the measure whose class is MEASURE_CLASS (e.g., SUPERGLOBAL, UNILAYER,
		    %  BILAYER).
		    %
		    % See also is_bilayer, is_superglobal, is_unilayer.
		
		    if strcmp(Element.getClass(m), 'Measure')
		        measure_scope = Measure.UNILAYER;
		    else
		        measure_scope = eval([Element.getClass(m) '.getMeasureScope()']);
		    end
		end
		function bool = is_superglobal(m)
		    %IS_SUPERGLOBAL checks if measure is superglobal.
		    %
		    % BOOL = IS_SUPERGLOBAL(M) returns true if the concrete measure M is
		    %  superglobal and false otherwise.
		    %
		    % BOOL = IS_SUPERGLOBAL(MEASURE_CLASS) returns true if the measure whose
		    %  class is MEASURE_CLASS is superglobal and false otherwise.
		    %
		    % See also getMeasureScope, is_bilayer, is_unilayer.
		
		    bool = Measure.getMeasureScope(m) == Measure.SUPERGLOBAL;
		end
		function bool = is_unilayer(m)
		    %IS_UNILAYER checks if measure is unilayer.
		    %
		    % BOOL = IS_UNILAYER(M) returns true if the concrete measure M is unilayer
		    %  and false otherwise.
		    %
		    % BOOL = IS_UNILAYER(MEASURE_CLASS) returns true if the measure whose class
		    %  is MEASURE_CLASS is unilayer and false otherwise.
		    %
		    % See also getMeasureScope, is_bilayer, is_superglobal.
		
		    bool = Measure.getMeasureScope(m) == Measure.UNILAYER;
		end
		function bool = is_bilayer(m)
		    %IS_BILYER checks if measure is bi-layer.
		    %
		    % BOOL = IS_BILYER(M) returns true if concrete measure M is bi-layer and
		    %  false otherwise.
		    %
		    % BOOL = IS_BILYER(MEASURE_CLASS) returns true if a measure whose class is
		    %  MEASURE_CALSS is bi-layer and false otherwise.
		    %
		    % See also getMeasureScope, is_superglobal, is_unilayer.
		
		    bool = Measure.getMeasureScope(m) == Measure.BILAYER;
		end
		function parametricity = getMeasureParametricity(m)
		    %GETMEASUREPARAMETRICITY returns the parametricity of the measure.
		    %
		    % PARAMETRICITY = GETMEASUREPARAMETRICITY(M) returns the parametricity of measure
		    %  M (e.g., NONPARAMETRIC, PARAMETRIC).
		    %
		    % PARAMETRICITY = GETMEASUREPARAMETRICITY(MEASURE_CLASS) returns the parametricity
		    %  of the measure whose class is MEASURE_CLASS (e.g., NONPARAMETRIC,
		    %  PARAMETRIC).
		    %
		    % See also is_nonparametric, is_parametric.
		
		    if strcmp(Element.getClass(m), 'Measure')
		        parametricity = Measure.NONPARAMETRIC;
		    else
		        parametricity = eval([Element.getClass(m) '.getMeasureParametricity()']);
		    end
		end
		function bool = is_parametric(m)
		    %IS_PARAMETRIC checks if measure is parametric.
		    %
		    % BOOL = IS_PARAMETRIC(M) returns true if the concrete measure M is
		    %  parametric and false otherwise.
		    %
		    % BOOL = IS_PARAMETRIC(MEASURE_CLASS) returns true if the measure whose
		    %  class is MEASURE_CLASS is parametric and false otherwise.
		    %
		    % See also getMeasureParametricity, is_nonparametric.
		
		    bool = Measure.getMeasureParametricity(m) == Measure.PARAMETRIC;
		end
		function bool = is_nonparametric(m)
		    %IS_NONPARAMETRIC checks if measure is non-parametric.
		    %
		    % BOOL = IS_NONPARAMETRIC(M) returns true if the concrete measure M is
		    %  non-parametric and false otherwise.
		    %
		    % BOOL = IS_NONPARAMETRIC(MEASURE_CLASS) returns true if the measure whose
		    %  class is MEASURE_CLASS is non-parametric and false otherwise.
		    %
		    % See also getMeasureParametricity, is_parametric.
		
		    bool = Measure.getMeasureParametricity(m) == Measure.NONPARAMETRIC;
		end
		function list = getCompatibleGraphList(m)
		    %GETCOMPATIBLEGRAPHLIST returns the list of graphs.
		    %
		    % GRAPH_CLASS_LIST = GETCOMPATIBLEGRAPHLIST(M) returns a cell array of
		    % compatible graph classes to the concrete measure M. M will not work if
		    % the graph is not compatible.
		    %
		    % GRAPH_CLASS_LIST = GETCOMPATIBLEGRAPHLIST(MEASURE_CLASS)
		    % returns a cell array of compatible graph classes to the measure
		    % whose class is MEASURE_CLASS. M will not work if the
		    % graph is not compatible. 
		    %
		    % See also getCompatibleGraphNumber, getMeasure.
		
		    list = eval([Element.getClass(m) '.getCompatibleGraphList()']);
		end
		function n = getCompatibleGraphNumber(m)
		    %GETCOMPATIBLEGRAPHNUMBER returns the number of compatible graphs.
		    %
		    % N = GETCOMPATIBLEGRAPHNUMBER(M) returns the number of compatible graphs
		    %  to the concrete measure M.
		    %
		    % N = GETCOMPATIBLEGRAPHNUMBER(MEASURE_CLASS) returns the number of
		    %  compatible graphs to the a measure whose class is MEASURE_CLASS.
		    %
		    % See also getCompatibleGraphList, getMeasure.
		
		    list = Measure.getCompatibleGraphList(m);
		    n = numel(list);
		end
		function list = getList()
		    % GETLIST returns the list of measures
		    %
		    % MEASURE_LIST = GETLIST() returns the list of measures (cell array)
		    % that are subclasses of Measure.
		    %
		    % See also getClass, Measure.
		
		    list = subclasses( ...
		        'Measure', ...
		        [fileparts(which('braph2')) filesep 'measures'] ...
		        );
		end
	end
	properties (Constant) % properties
		ID = 1;
		ID_TAG = 'id';
		ID_CATEGORY = Category.DATA;
		ID_FORMAT = Format.STRING;
		
		LABEL = 2;
		LABEL_TAG = 'label';
		LABEL_CATEGORY = Category.METADATA;
		LABEL_FORMAT = Format.STRING;
		
		NOTES = 3;
		NOTES_TAG = 'notes';
		NOTES_CATEGORY = Category.METADATA;
		NOTES_FORMAT = Format.STRING;
		
		G = 4;
		G_TAG = 'g';
		G_CATEGORY = Category.DATA;
		G_FORMAT = Format.ITEM;
		
		M = 5;
		M_TAG = 'm';
		M_CATEGORY = Category.RESULT;
		M_FORMAT = Format.CELL;
	end
	methods (Static) % inspection methods
		function m_class = getClass()
			%GETCLASS returns the class of the graph measure.
			%
			% CLASS = Measure.GETCLASS() returns the class 'Measure'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the graph measure M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('Measure') returns 'Measure'.
			%
			% See also getName, getDescription.
			
			m_class = 'Measure';
		end
		function m_name = getName()
			%GETNAME returns the name of the graph measure.
			%
			% NAME = Measure.GETNAME() returns the name of the 'graph measure'.
			%  Graph Measure.
			%
			% Alternative forms to call this method are:
			%  NAME = M.GETNAME() returns the name of the graph measure M.
			%  NAME = Element.GETNAME(M) returns the name of 'M'.
			%  NAME = Element.GETNAME('Measure') returns the name of 'Measure'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			m_name = 'Graph Measure';
		end
		function m_description = getDescription()
			%GETDESCRIPTION returns the description of the graph measure.
			%
			% STR = Measure.GETDESCRIPTION() returns the description of the 'graph measure'.
			%  which is:
			%
			%  Measure provides the methods necessary for all graph measures. 
			%  Instances of this class should not be created. 
			%  Use one of its subclasses instead.
			%
			% Alternative forms to call this method are:
			%  STR = M.GETDESCRIPTION() returns the description of the graph measure M.
			%  STR = Element.GETDESCRIPTION(M) returns the description of 'M'.
			%  STR = Element.GETDESCRIPTION('Measure') returns the description of 'Measure'.
			%
			% See also getClass, getName.
			
			m_description = [
				'Measure provides the methods necessary for all graph measures. ' ...
				'Instances of this class should not be created. ' ...
				'Use one of its subclasses instead.' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of graph measure.
			%
			% PROPS = Measure.GETPROPS() returns the property list of graph measure.
			%
			% PROPS = Measure.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the graph measure M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('Measure'[, CATEGORY]) returns the property list of 'Measure'.
			%
			% See also getPropNumber.
			
			if nargin < 1
				category = 'all';
			end
			
			switch category
				case Category.METADATA
					prop_list = [
						Measure.LABEL
						Measure.NOTES
						];
				case Category.PARAMETER
					prop_list = [
						];
				case Category.DATA
					prop_list = [
						Measure.ID
						Measure.G
						];
				case Category.RESULT
					prop_list = [
						Measure.M
						];
				case Category.FIGURE
					prop_list = [
						];
				case Category.GUI
					prop_list = [
						];
				otherwise
					prop_list = [
						Measure.ID
						Measure.LABEL
						Measure.NOTES
						Measure.G
						Measure.M
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of graph measure.
			%
			% N = Measure.GETPROPNUMBER() returns the property number of graph measure.
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER() returns the property number of the graph measure M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('Measure') returns the property number of 'Measure'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 5;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in graph measure/error.
			%
			% CHECK = Measure.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(Measure, PROP) checks whether PROP exists for Measure.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:Measure:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:Measure:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:Measure:WrongInput]
			%  Element.EXISTSPROP(Measure, PROP) throws error if PROP does NOT exist for Measure.
			%   Error id: [BRAPH2:Measure:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5 ]);
			else
				assert( ...
					Measure.existsProp(prop), ...
					[BRAPH2.STR ':Measure:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':Measure:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for Measure.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in graph measure/error.
			%
			% CHECK = Measure.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(Measure, TAG) checks whether TAG exists for Measure.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:Measure:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:Measure:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:Measure:WrongInput]
			%  Element.EXISTSTAG(Measure, TAG) throws error if TAG does NOT exist for Measure.
			%   Error id: [BRAPH2:Measure:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				measure_tag_list = { 'id'  'label'  'notes'  'g'  'm' };
				
				check = any(strcmpi(tag, measure_tag_list));
			else
				assert( ...
					Measure.existsTag(tag), ...
					[BRAPH2.STR ':Measure:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':Measure:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for Measure'] ...
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
			%  PROPERTY = M.GETPROPPROP(POINTER) returns property number of POINTER of M.
			%  PROPERTY = Element.GETPROPPROP(Measure, POINTER) returns property number of POINTER of Measure.
			%  PROPERTY = M.GETPROPPROP(Measure, POINTER) returns property number of POINTER of Measure.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				measure_tag_list = { 'id'  'label'  'notes'  'g'  'm' };
				
				tag = pointer;
				Measure.existsTag(tag);
				
				prop = find(strcmpi(tag, measure_tag_list));
			else % numeric
				prop = pointer;
				Measure.existsProp(prop);
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
			%  TAG = M.GETPROPTAG(POINTER) returns tag of POINTER of M.
			%  TAG = Element.GETPROPTAG(Measure, POINTER) returns tag of POINTER of Measure.
			%  TAG = M.GETPROPTAG(Measure, POINTER) returns tag of POINTER of Measure.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				Measure.existsTag(tag);
			else % numeric
				prop = pointer;
				Measure.existsProp(prop);
				
				switch prop
					case Measure.ID
						tag = Measure.ID_TAG;
					case Measure.LABEL
						tag = Measure.LABEL_TAG;
					case Measure.NOTES
						tag = Measure.NOTES_TAG;
					case Measure.G
						tag = Measure.G_TAG;
					case Measure.M
						tag = Measure.M_TAG;
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
			%  CATEGORY = M.GETPROPCATEGORY(POINTER) returns category of POINTER of M.
			%  CATEGORY = Element.GETPROPCATEGORY(Measure, POINTER) returns category of POINTER of Measure.
			%  CATEGORY = M.GETPROPCATEGORY(Measure, POINTER) returns category of POINTER of Measure.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = Measure.getPropProp(pointer);
			
			switch prop
				case Measure.ID
					prop_category = Measure.ID_CATEGORY;
				case Measure.LABEL
					prop_category = Measure.LABEL_CATEGORY;
				case Measure.NOTES
					prop_category = Measure.NOTES_CATEGORY;
				case Measure.G
					prop_category = Measure.G_CATEGORY;
				case Measure.M
					prop_category = Measure.M_CATEGORY;
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
			%  FORMAT = M.GETPROPFORMAT(POINTER) returns format of POINTER of M.
			%  FORMAT = Element.GETPROPFORMAT(Measure, POINTER) returns format of POINTER of Measure.
			%  FORMAT = M.GETPROPFORMAT(Measure, POINTER) returns format of POINTER of Measure.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = Measure.getPropProp(pointer);
			
			switch prop
				case Measure.ID
					prop_format = Measure.ID_FORMAT;
				case Measure.LABEL
					prop_format = Measure.LABEL_FORMAT;
				case Measure.NOTES
					prop_format = Measure.NOTES_FORMAT;
				case Measure.G
					prop_format = Measure.G_FORMAT;
				case Measure.M
					prop_format = Measure.M_FORMAT;
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
			%  DESCRIPTION = M.GETPROPDESCRIPTION(POINTER) returns description of POINTER of M.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(Measure, POINTER) returns description of POINTER of Measure.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(Measure, POINTER) returns description of POINTER of Measure.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = Measure.getPropProp(pointer);
			
			switch prop
				case Measure.ID
					prop_description = 'ID (data, string) is a few-letter code for the graph measure.';
				case Measure.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the graph measure.';
				case Measure.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the graph measure.';
				case Measure.G
					prop_description = 'G (data, item) is the measure graph.';
				case Measure.M
					prop_description = 'M (result, cell) is the measure result.';
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
			%  SETTINGS = M.GETPROPSETTINGS(POINTER) returns settings of POINTER of M.
			%  SETTINGS = Element.GETPROPSETTINGS(Measure, POINTER) returns settings of POINTER of Measure.
			%  SETTINGS = M.GETPROPSETTINGS(Measure, POINTER) returns settings of POINTER of Measure.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = Measure.getPropProp(pointer);
			
			switch prop
				case Measure.ID
					prop_settings = Format.getFormatSettings(Format.STRING);
				case Measure.LABEL
					prop_settings = Format.getFormatSettings(Format.STRING);
				case Measure.NOTES
					prop_settings = Format.getFormatSettings(Format.STRING);
				case Measure.G
					prop_settings = 'Graph';
				case Measure.M
					prop_settings = Format.getFormatSettings(Format.CELL);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = Measure.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = Measure.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(Measure, POINTER) returns the default value of POINTER of Measure.
			%  DEFAULT = M.GETPROPDEFAULT(Measure, POINTER) returns the default value of POINTER of Measure.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = Measure.getPropProp(pointer);
			
			switch prop
				case Measure.ID
					prop_default = Format.getFormatDefault(Format.STRING, Measure.getPropSettings(prop));
				case Measure.LABEL
					prop_default = Format.getFormatDefault(Format.STRING, Measure.getPropSettings(prop));
				case Measure.NOTES
					prop_default = Format.getFormatDefault(Format.STRING, Measure.getPropSettings(prop));
				case Measure.G
					prop_default = Format.getFormatDefault(Format.ITEM, Measure.getPropSettings(prop));
				case Measure.M
					prop_default = Format.getFormatDefault(Format.CELL, Measure.getPropSettings(prop));
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = Measure.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = Measure.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(Measure, POINTER) returns the conditioned default value of POINTER of Measure.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(Measure, POINTER) returns the conditioned default value of POINTER of Measure.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = Measure.getPropProp(pointer);
			
			prop_default = Measure.conditioning(prop, Measure.getPropDefault(prop));
		end
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = M.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = M.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of M.
			%  CHECK = Element.CHECKPROP(Measure, PROP, VALUE) checks VALUE format for PROP of Measure.
			%  CHECK = M.CHECKPROP(Measure, PROP, VALUE) checks VALUE format for PROP of Measure.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:Measure:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: [BRAPH2:Measure:WrongInput]
			%  Element.CHECKPROP(Measure, PROP, VALUE) throws error if VALUE has not a valid format for PROP of Measure.
			%   Error id: [BRAPH2:Measure:WrongInput]
			%  M.CHECKPROP(Measure, PROP, VALUE) throws error if VALUE has not a valid format for PROP of Measure.
			%   Error id: [BRAPH2:Measure:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = Measure.getPropProp(pointer);
			
			switch prop
				case Measure.ID
					check = Format.checkFormat(Format.STRING, value, Measure.getPropSettings(prop));
				case Measure.LABEL
					check = Format.checkFormat(Format.STRING, value, Measure.getPropSettings(prop));
				case Measure.NOTES
					check = Format.checkFormat(Format.STRING, value, Measure.getPropSettings(prop));
				case Measure.G
					check = Format.checkFormat(Format.ITEM, value, Measure.getPropSettings(prop));
				case Measure.M
					check = Format.checkFormat(Format.CELL, value, Measure.getPropSettings(prop));
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':Measure:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':Measure:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' Measure.getPropTag(prop) ' (' Measure.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function m = Measure(varargin)
			% Measure() creates a graph measure.
			%
			% Measure(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% Measure(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of Measure properties is:
			%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the graph measure.
			%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the graph measure.
			%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the graph measure.
			%  <strong>4</strong> <strong>g</strong> 	G (data, item) is the measure graph.
			%  <strong>5</strong> <strong>m</strong> 	M (result, cell) is the measure result.
			%
			% See also Category, Format, set, check.
			
			m = m@Element(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = Measure.getPropProp(pointer);
			
			switch prop
				otherwise
					if prop <= Element.getPropNumber()
						value = conditioning@Element(pointer, value);
					end
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(m, prop)
		
			switch prop
				case Measure.M
					rng(m.getPropSeed(Measure.M), 'twister')
					
					value = {};
					
				otherwise
					value = calculateValue@Element(m, prop);
					
			end
		end
	end
	methods % GUI
		function pr = getPlotProp(m, prop, varargin)
			%GETPLOTPROP returns a prop plot.
			%
			% PR = GETPLOTPROP(EL, PROP) returns the plot of prop PROP.
			%
			% PR = GETPLOTPROP(EL, PROP, 'Name', Value, ...) sets the settings.
			%
			% See also PlotProp, PlotPropCell, PlotPropClass, PlotPropClassList,
			%  PlotPropIDict, PlotPropItem, PlotPropItemList, PlotPropLogical,
			%  PlotPropMatrix, PlotPropOption, PlotPropScalar, PlotPropString.
			
			switch prop
				case Measure.NOTES
					pr = PlotPropString('EL', m, 'PROP', Measure.NOTES, 'LINES', 'multi', 'EDITHEIGHT', 4.5, varargin{:});
					
				case Measure.M
					pr = PPMeasure_M('EL', m, 'PROP', Measure.M, varargin{:});
					
				otherwise
					pr = getPlotProp@Element(m, prop, varargin{:});
					
			end
		end
	end
end
