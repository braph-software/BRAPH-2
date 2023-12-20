# General Developer Tutorial for BRAPH 2.0

[![Tutorial General Developer Tutorial for BRAPH 2.0](https://img.shields.io/badge/PDF-Download-red?style=flat-square&logo=adobe-acrobat-reader)](dev_intro.pdf)

The software architecture of BRAPH 2.0 provides a clear structure for developers to understand and extend its functionalities. All objects (`elements`) in BRAPH 2.0 are derived from the base object `Element`. Developers can easily add new elements by writing the new elements in the simplified BRAPH 2.0 pseudocode. 
By recompiling BRAPH 2.0, the new elements and their functionalities are immediately integrated, also into the graphical user interface.
In this Developer Tutorial, we will explain how BRAPH 2.0 is compiled, how the elements are strcutured, and how new elements can be implemented.





## Compilation and Element (Re)Generation

BRAPH 2.0 is a compiled object-oriented programming software.
Its objects are `elements`, which contain a set of `props` of various `categories` and `formats`, as described in detail in the following sections. 
These elements are written in the BRAPH 2.0 pseudocode, which simplifies and streamlines the coding process.
To convert them into usable matlab objects, BRAPH 2.0 needs to be compiled, which is done by calling the script `braph2genesis`, which will compile the whole code, as shown in `compilation`.

** Compilation of BRAPH 2.0.**
		Executing the script `braph2genesis` compiles BRAPH 2.0 and , subsequently, unit tests it.
		Importantly, this function might take several hours to run (plus several more hours to unit test the compiled code).
> ```matlab
> 
> >> braph2genesis
> 


During the compilation, there are several phases to improve the computational efficiency of the executable code:

	- ** First compilation**, where the elements are created.
	- ** Second compilation**, where the elements are computationally optimized.
	- ** Constant hard-coding**, where several contants are hard-coded in the executable code to further optimize the run time.


Because this multi-stage compilation, it is not always possible to regenerate a single element without regenerating the whole BRAPH 2.0. 
Nevertheless, it is usually possible to regenerate a single element as long as the element already exists and its props have not been changed.
This can be done with the function `regenerate()`, as shown in `regenerate`.

** Regeneration of elements.**
		The function `regenerate()` can be used to regenerate some elements, as long as they already exist in the current BRAPH 2.0 compilation and their list of props has not been altered (e.g., renamed, moved, added). In this case, it is necessary to recompile BRAPH 2.0 with `braph2genesis`.
> ```matlab
> 
> >> close all; delete(findall(0, 'type', 'figure')); clear all  `1`
> 
> >> regenerate(regenerate('/src/gui', {'Pipeline'})  `2`
> 
> >> regenerate(regenerate('/src/gui', {'Pipeline'}, 'DoubleCompilation', false)  `3`
> 
> >> regenerate(regenerate('/src/gui', {'Pipeline'}, 'CreateElement', false)  `4`
> 
> >> regenerate(regenerate('/src/gui', {'Pipeline'}, 'CreateLayout', false)  `5`
> 
> >> regenerate(regenerate('/src/gui', {'Pipeline'}, 'CreateTest', false)  `6`
> 
> >> regenerate(regenerate('/src/gui', {'Pipeline'}, 'UnitTest', false)  `7`
> 
> >> regenerate(regenerate('/src/gui', {'Pipeline'}, 'CreateLayout', false, 'UnitTest', false)  `8`
> 
> >> regenerate(regenerate('/src/gui', {'Pipeline', 'GUI'
>`1` clears the workspace (not always necessary, but needed is some element instances are still in the workspace).>`2` regenerates `Pipeline`.
>`3` performs only one compilation.
>`4` does not regenerate the element, but only the layout and the unit test.
>`5` does not regenerate the layout.
>`6` does not regenerate the unit test.
>`7` does not perform the unit test.
>`8` Multiple options can be selected at once. In this ces, it does not regenerate the layout and it does not perform the unit test.
>`9` Multiple elements can be regenerated at once. This can throw an error, typically because an instance of the element to be regenerated remains in the workspace. In this case, regenerate the elements one by one.

})  `9`
> 


## Elements

The base class for all elements is `Element`. 
Each element is essentially a container for a series of `props` (properties). Each prop is characterized by the following static features (i.e., equal for all instances of the prop):

	- A `sequential number` (integer starting from 1).
		
	- A `tag` (a string).
	
	- A `category`, which determines for how a prop is used. The possible categories and formats are shown in the boxes below.
	
	- A `format`, which determines what a prop can contain.

The functions to inspect these features can be found by using the command `help Element` in the MatLab command line.

Furthermore, each instance of a prop has the following features:

	- A `value`. The value is by defalut a `NoValue`. For `PARAMETER`, `DATA`, `FIGURE`, and `GUI` props, it can also be a callback. For `CONSTANT` props, it is usually a concrete value.
	The functions to set, get, and memorize a value will be discussed in the following sections.
	
	- A `seed` for the random number generator to ensure the reproducibility of the results. 
	The seed of each property is a 32-bit unsigned integer and is initialized when an element is constructed by calling `randi(intmax('uint32'))`.
	
	The seed can be obtained using:
	`seed = el.getPropSeed(pointer)`
	where `pointer` can be either a prop number or tag.
	It cannot be changed.
 	
	- A `checked` status, which is true by default.
	Checked props are checked for format when they are set and for value when they are set/calculated. When `BRAPH2.CHECKED = false`, no checks are performed. This needs to be changes in the file "BRAPH2.m".
	
	The checked status of a prop can be altered with the functions:
	`el.checked(pointer)`
	`el.unchecked(pointer)`
	The checked status of a prop can be assessed with the function:
	`checked = el.isChecked(pointer)`
	where `pointer` can be either a prop number or tag.
	
	- A `locked` status, which is false by default. The `PARAMETER` and `DATA` props get locked the first time a `RESULT` property is successfully calculated. The locked status is not used for `CONSTANT` props.
	
	A prop can be locked with the function:
	`el.lock(pointer)`
	Once locked, it cannot be unlocked.
	The locked status of a prop can be assessed with the function:
	`locked = el.isLocked(pointer)`
	where `pointer` can be either a prop number or tag.
	
	- A `callback` instance. Callbacks are not used with `METADATA` props.
	
	The callback to a prop can be obtained using the function:
	`cb = el.getCallback(pointer)`
	where `pointer` can be either a prop number or tag.
	

Additional functions to operate with these features can be found by using the command `help Element` in the MatLab command line.


> **Property Categories**
 >  
 	> `CONSTANT` Static constant equal for all instances of the element. It allows incoming callbacks.
 
 	> `METADATA` Metadata NOT used in the calculation of the results. It does not allow callbacks. It is not locked when a result is calculated.
 
 	> `PARAMETER` Parameter used to calculate the results of the element. It allows incoming and outgoing callbacks. It is connected with a callback when using a template. It is locked when a result is calculated.
 
 	> `DATA` Data used to calculate the results of the element. It is `NoValue` when not set. It allows incoming and outgoing callbacks. It is locked when a result is calculated.
 
 	> `RESULT` Result calculated by the element using parameters and data. The calculation of a result locks the element. It is `NoValue` when not calculated. It allows incoming callbacks.
 
 	> `QUERY` Query result calculated by the element. The calculation of a query does NOT lock the element. It is `NoValue` when not calculated. Typically, it should not be memorized.
It does not allow callbacks.
 
 	> `EVANESCENT` Evanescent variable calculated at runtime (typically employed for handles of GUI components). It is `NoValue` when not calculated. Typically, it should be memorized at first use.
It does not allow callbacks.
 
 	> `FIGURE` Parameter used to plot the results in a figure. It allows incoming and outgoing callbacks. It is not locked when a result is calculated.
                
 	> `GUI` Parameter used by the graphical user interface (GUI). It allows incoming and outgoing callbacks. It is not locked when a result is calculated.
> 




> **Property Formats**
 >  
	- `EMPTY` Empty has an empty value and is typically used as a result or query to execute some code. 
 
	- `STRING` String is a char array.
 
	- `STRINGLIST` StringList is a cell array with char arrays.
 
	- `LOGICAL` Logical is a boolean value.
 
	- `OPTION` Option is a char array representing an option within a set defined in the element (case sensitive). 
> ```matlab
> '` for red.
>  
> 	- `ALPHA` Alpha is a transparency level between 0 and 1.
>  
> 	- `SIZE` Size represents the size of a graphical componet. It is a positive number (default = 1).
>  
> 	- `MARKER` Marker represents the marker style.
> ```



Even though it is possible to create instances of `Element`, typically one uses its subclasses and does not have any props.
Its three direct subclasses are `NoValue`, `Callback`, and `ConcreteElement`, as shown in Figure elements.


<img src="fig01_big.jpg" alt="Element tree">

> **Figure 01.Element tree**
> All elements derive from the base class `Element`. 
	Its direct children are `NoValue`, `Callback`, and `ConcreteElement`, whose properties are also indicated.
	Concrete elements further derive directly or indirectly from `ConcreteElement`.
	


The element `NoValue` is used to represent a value that has not been set (for properties of categories `METADATA`, `PARAMETER`, `DATA`, `FIGURE` or `GUI`) or calculated (for properties of category `RESULT`, `QUERY`, `EVANESCENT`), while it should not be used for properties of category `CONSTANT`.
It should be instantiated using `novalue`.

** Instantiation of `NoValue`.**
		For computational efficiency, it is best to use only one instance using this script, instead of creating new instances using the constructor `NoValue()`.
> ```matlab
> 
> Element.getNoValue()
> 


No element can be a subclass of NoValue.
  
A `Callback` refers to a prop of another element `el`, identified by prop number or tag.
It should be instantiated using `callback`.

** Instantiation of a `Callback`.**
		For computational efficiency, it is best to use only one instance of `Callback` for each prop of an instance of a concrete element `el` with the code shown below, instead of creating new callback instances using its constructor.
> ```matlab
> 
> el.getCallback('PROP', PROP_NUMBER)
> el.getCallback('TAG', PROP_TAG)
> 


No element can be a subclass of `Callback`.

A concrete element (`ConcreteElement`) provides the infrastructure necessary for all concrete elements. 
In particular, it has the constant props `ELCLASS` (string), `NAME` (string) and `DESCRIPTION` (string), the property `TEMPLATE` (item), the indexing properties `ID` (string), `LABEL` (string), and `NOTES` (string), and the query prop `TOSTRING` (string).
Even though it is possible to create instances of `ConcreteElement`, typically one uses its subclasses.

### Setting Props

The value of a prop can be set with `set`.

** Setting a prop.**
		This script illustrates various ways in which props can be set.
> ```matlab
> 
> el.set('ID', 'new el id')  `1 and 2`
> el.set(5, 'new el id')  `2`
> 
> el.set( ...  `3`
> 	'ID', 'new el id', ...
> 	'LABEL', 'new el label', ...
> 	7, 'new el notes' ...
> 	) 
> 
> el = el.set('ID', 'new el id
>`3` sets the values of multiple props at once. The pointers can be either property numbers or property tags.>`3` returns the element.
>`1 2` set the value of a prop with the prop tag or the prop number.

')  `3`
> 


When a prop is set to a certain value, the following operations are performed:

	- The value is ** conditioned** before being set (by calling the protected `static` function `conditioning()`, which can be defined in each subelement).
	
	This can be set with the token `¡conditioning!`.
	
	- The value is ** preset** before being set (by calling the protected function `preset()`, which can be defined in each subelement). Differently from the `static` function `conditioning()`, the function `preset()` has access to the element instance.

	This can be set with the token `¡preset!`.
	
	- If a property is checked, its ** format is checked** before proceeding to its setting by calling `Format.checkFormat()`.
	If the check fails, the property is not set and an error is thrown with error id
	`BRAPH2:<Element Class>:WrongInput`.
	
	This can be set with the token `¡checkProp!`.

	- The value is ** set**.

		If the property is of category `PARAMETER`, `DATA`, `FIGURE`, or `GUI`, the value is set only if the property is unlocked.
		If an attempt is made to set a locked property, no setting occurs and a warning is thrown with warning id `BRAPH2:<Element Class>`.
		If the value is a callback, a warning is thrown if the element, property number and/or settings of the callback do not coincide with those of the property with warning id
		`BRAPH2:<Element Class>`.
 
		If the property is of category RESULT, QUERY or EVANESCENT, the value can only be set to `Element.getNoValue()`.

	- The value is ** postset** after being set (by calling the protected function `postset()`, which is defined in each subelement).
	
	This can be set with the token `¡postset!`.

	- ** All props** are ** postprocessed** after being set (by calling the protected function `postprocessing()`, which is defined in each subelement).
	
	This can be set with the token `¡postprocessing!`.

	- If ANY property is checked, the function `Element.check()` is called after all settings are made and the consistency of the values of ** all pros** are ** checked**.
	If the check fails an error is thrown with error id
	`BRAPH2:<Element Class>:WrongInput`.
	
	- When a prop is successfully set, an ** event** `PropSet()` is ** notified**.
 

### Getting Props

The value of a prop can be retrieved with `get`.

** Getting a prop.**
		This script illustrates various ways in which the value of a prop can be retrieved.
> ```matlab
> 
> value = el.get('ID');  `1`
> 
> value = el.get(ConcreteElement.ID);  `2`
> 
> el.get('ID')  `3 and 4`
> el.get(ConcreteElement.ID)  `4`
> 
> value = el.get('QUERY', ARG1, ARG2, ... 
>`1` gets the value of a prop using the prop tag.>`2` gets the value of a prop using the prop number.
>`5` can be used with a series of arguments for props of category `QUERY`. Any additional arguments are ignored for props of other categories.
>`3 4` do not return any output value. This can be useful, e.g., when a code needs to be executed, e.g., by a `QUERY`.

);  `5`
> 


If the raw value of the property is a `NoValue`, it proceed to return the default property value (for categories `METADATA`, `PARAMETER`, `DATA`, `FIGURE`, and `GUI`).
 
If the raw value of the property is a callback, it retrieves the value of the linked property (for categories `PARAMETER`, `DATA`, `FIGURE`, and `GUI`).
 
If a property of category `RESULT`, `QUERY`, or `EVANESCENT` is not calculated (i.e., its raw value is `NoValue`), it proceeds to calculate it (but not to memorize it, i.e., its raw value remains `NoValue`). After the calculation of a property of category `RESULT` all properties of categories `PARAMETER` and `DATA` are irreversibly locked.
If the property is checked, it proceeds to check all properties after the calculation calling the function `check()`. If the check fails, it resets the property to `NoValue` and returns `NoValue`, does not lock the property, and throws a warning with warning id `BRAPH2:<Element Class>`.

The raw value of a prop can be retrieved with `getr`.

** Getting the raw value of a prop.**
		This script illustrates various ways in which the raw value of a prop can be retrieved.
> ```matlab
> 
> value = el.getr('ID');
> value = el.getr(ConcreteElement.ID);
> 


### Memorizing Props  

The value of a prop can be memorized using `memorize`.

** Getting a prop.**
		This script illustrates various ways in which the value of a prop can be retrieved.
> ```matlab
> 
> value = el.memorize('ID');  `1 and 2`
> value = el.memorize(ConcreteElement.ID);  `2`
> 
> el.memorize('ID')  `3 and 4`
> el.memorize(ConcreteElement.I
>`1 2` memorize the value of a prop using the prop tag and the prop number.>`3 4` do not return any output value.

D)  `4`
> 


If the property is of category `RESULT`, `QUERY`, or `EVANESCENT`, it calls the function check, proceed to save the result, and notifies an ** event PropMemorized**.

If the property is `not` of category `RESULT`, `QUERY`, or `EVANESCENT` and has not been set yet, it sets it to its default value.
 
If the property is `not` of category `RESULT`, `QUERY`, or `EVANESCENT` and is a callback, it iteratively memorizes the property of the element in the callback.
 
If a property of category `QUERY` is memorized, a warning is thrown with warning id `BRAPH2:<Element Class>`, because query properties are generally not supposed to be memorized. If such behavior is intended, consider enclosing the command between warning off and warning on.

## Element tokens

A generator file has the structure illustrated `tokens`.


** Element tokens in a generator file.**
		All tokens available in a generator file.
		The name of this file must end with ".gen.m", and tipically starts with "_".
		The token `¡header!` is required, while the rest is optional.
> ```matlab
> 
> %% ¡header!
>   <class_name> < <superclass_name> (<moniker>, <descriptive_name>) <header_description>.
>   %%% ¡class_attributes!
>    Class attributes is a single line, e.g. Abstract = true, Sealed = true.
>   %%% ¡description!
>    This is a plain description of the element.
>    It can occupy several lines.
>   %%% ¡seealso!
>    Related functions and classes in a single line, coma-separated and without fullstop.
>   
>  %% ¡constants!
>   Constants.
>  
>  %% ¡props!
>   %%% ¡prop!
>    <tag1> (<category>, <format>) <description>.
>    %%%% ¡settings!
>     Prop settings, depending on format.
>    %%%% ¡default!
>     Prop default value (seldom needed).
>    %%%% ¡conditioning!
>     Code to condition value (before checks and calculation).
>     Can be on multiple lines.
>     The prop value is in the variable 'value', 
>     where also the conditioned prop value is returned.
>    %%%% ¡preset!
>     Code to preset element (before checks and calculation).
>     Can be on multiple lines.
>     The prop value is in the variable 'value', 
>     where also the preset prop value is returned.
>    %%%% ¡check_prop!
>     Code to check prop format (before calculation).
>     Can be on multiple lines.
>     The prop value is in the variable 'value'.
>     The outcome should be in variable 'check'.
>    %%%% ¡postset!
>     Postset code (executed after setting, but before checking, value),
>     executed on ONLY the set property.
>     Can be on multiple lines.
>     Does not return anything.
>    %%%% ¡postprocessing!
>     Postprocessing code (executed after setting, but before checking,
>     value), executed on ALL unlocked props after each set operation.
>     Can be on multiple lines.
>     Does not return anything.
>    %%%% ¡check_value!
>     Code to check prop value (after calculation).
>     Can be on multiple lines.
>     The prop value is in the variable 'value'.
>     The outcome should be in variable 'check' and the message in 'msg'.
>    %%%% ¡calculate!
>     Code to calculate prop results (only for category RESULT).
>     Can be on multiple lines.
>     Can include callbacks as {@cb_get, 'TAG', varargin} and 
>     {@cb_set, 'TAG1', value1, ...}.
>     The result should be in variable 'value'.
>    %%%% ¡calculate_callbacks!
>     Callbacks to be used in calculate, typically as functions 
>     cb_name(src, event).
>     Can be on multiple lines.
>    %%%% ¡gui!
>     GUI code for representing the panel of the prop.
>     Can be on multiple lines.
>     Should return a PanelProp object in 'pr'.
>   %%% ¡prop!
>     <tag2> ...
>   
>  %% ¡props_update!
>   %%% ¡prop!
>    <tag1> (<category>, <format>) <description>. [Only description can be different from original prop]
>    %%%% ¡settings!
>     Updated settings.
>    %%%% ¡default!
>     Updated default.
>    %%%% ¡conditioning!
>     Update value conditioning (before checks and calculation).
>    %%%% ¡preset!
>     Update element value preset (before checks and calculation).
>    %%%% ¡check_prop!
>     Updated check prop format (before calculation).
>    %%%% ¡postset!
>     Update postset (after setting, but before checking, value).
>    %%%% ¡postprocessing!
>     Update value postprocessing (after setting, but before checking, value).
>    %%%% ¡check_value!
>     Updated check prop value (after calculation).
>    %%%% ¡calculate!
>     Updated calculation.
>    %%%% ¡calculate_callbacks!
>     Updated calculate callbacks.
>    %%%% ¡gui!
>     Updated GUI.
>   %%% ¡prop!
>    <tag2> ...
> 
>  %% ¡gui!
>   %%% ¡menu_import!
>    Menu Import for the GUI figure. 
>    The element is el.
>    The menu is menu_import.
>    The plot element is pe.
>   %%% ¡menu_export!
>    Menu Export for the GUI figure. 
>    The element is el.
>    The menu is menu_export.
>    The plot element is pe.
> 
>   %% ¡layout!
>   %%% ¡prop!
>    %%% ¡id!
>     Prop id, e.g., Element.TAG, ordered as they should appead.
>    %%% ¡title!
>     String containing the title of the prop panel.
>   %%% ¡prop!
>    ...
>   
>  %% ¡tests!
>   %%% ¡excluded_props!
>    Row vector with list of props to be excluded from standard tests.
>   %%% ¡warning_off!
>    Switches off the warnings regarding the element.
>   %%% ¡test!
>    %%%% ¡name!
>    Name of the text on a single line.
>    %%%% ¡probability!
>    Probability with which this test is performed. By default it is 1.
>    %%%% ¡code!
>    Code of the test.
>    Can be on multiple lines.
>   %%% ¡test!
>    ...
>   %%% ¡test_functions!
>   Functions used in the test.
>   Can be on multiple lines.
> 



A list of special instructions is shown in `special`.

** Special instruction in a generator file.**
		There are some special and specialized instructions that can be used in a generator file.
> ```matlab
> 
> ConcreteElement.NAME  `1`
> 
> __Category.CONSTANT__  `2`circlednote{2}{keeps `Category.CONSTANT` even after hard-coding the element, instead of substituting it with its value.circled{3}-circled{5} It works similarly also for the other constants of `Category` and `Format`.}
> __Category.CONSTANT_TAG__  `3`
> ...
> __Format.EMPTY__  `4`
> __Format.EMPTY_TAG__  `5`
> ...
> 
> %%%__WARN_TBI
>`1` substitutes the prop with its default value, when hard-coding the element.>`6` adds a warning that the specific feature is not implemented yet.

__  `6`
> 


## Overview of Elements


<img src="../braph2genesis.png" alt="BRAPH 2.0 genesis.">

> **Figure 02.BRAPH 2.0 genesis.**
> Directory structure of "braph2genesis" (left) and "braph2" (right).
	


The directory structure of "braph2" and the relation with "braph2genesis" is illustrated in Figure genesis.
All objects are derived from a base object called `Element` and written in a simplified pseudocode (files "*.gen.m") that is compiled into the actual elements (files "*.m") by the command `braph2genesis` (some examples of these elements are shown).
The compiled code can be launched by the command `braph2`.
The core of BRAPH 2.0 (gray shaded area) includes the compiler (`genesis`), the essential source code ("src"), and the essential functionalities for the GUI ("gui", yellow-shaded area).
The users can easily add new brain surfaces ("brainsurfs"), atlases ("atlases"), example scripts and GUI pipelines (in the corresponding folder under "pipelines").
Furthermore, the users can add new elements such as new graphs (e.g., `GraphWU` in "graphs"), measures (e.g., `Strength` in "measures"), data types (e.g., `SubjectCON` in "pipelines/connectivity"), data importers (e.g., `ImporterGroupSubjectCON_XLS` in "pipelines/connectivity"), data exporters (e.g., `ExporterGroupSubjectCON_XLS` in "pipelines/connectivity"), and analyses (e.g., `AnalyzeEnsemble_CON_WU` in "pipelines/connectivity") by writing new elements and recompiling the whole code: the new elements and their functionalities will be immediately available also in the GUI.
Finally, BRAPH 2.0 is provided with a set of unit tests (executable by the command "test_braph2") that ensure the formal correctness of the code, including that of any newly added elements.

## Implementation of an Element

We will now see how to implement a few concrete elements.


> **Light compilation of BRAPH 2.0**
 To speed up the compilation of BRAPH 2.0 when trying these examples, it is possible to perform a light version of the compilation using the script `braph2genesis 
> ```matlab
> ...
>  Add here all included and excluded folders and elements
>  '-folder'                 the folder and its elements will be excluded
> 
>  '+folder'                 the folder is included, but not its elements
>    '+_ElementName.gen.m'   the element is included,
>                            if the folder is included
> 
>  '+folder*'                the folder and its elements are included
>    '-_ElementName.gen.m'   the element is excluded,
>                            if the folder and its elements are included
>  (by default, the folders are included as '+folder*')
> rollcall = { ...
>     '+util*', '-_Exporter.gen.m', '+_Importer.gen.m', ...
>     '+ds*', '-ds_examples', ...
>     '-atlas', ...
>     '-gt', ...
>     '-cohort', ...
>     '-analysis', ...
>     '-nn', ...
>     '-gui', '-gui_examples', ...
>     '-brainsurfs', ...
>     '-atlases', ...
>     '-graphs', ...
>     '-measures', ...
>     '-neuralnetworks', ...
>     '-pipelines', ...
>     '+test*', ...
>     '-sandbox' ...
>     };
> ...
> ```



### A Simple Calculator

We will now create our first element (`ao`), a simple calcualator that contains two numbers (which are data scalar props) and calculates their sum and difference (which are result scalar props).

** Arithmetic Operation Calculator.**
		This is a simple element direclty deriving from `ConcreteElement`.
> ```matlab
> 
> %% ¡header!  `1`
> ArithmeticOperations < ConcreteElement (ao, arithmetic operation calculator) calculates simple arithmetic operations.
> 
> %%% ¡description!
> An Arithmetic Operation Calculator (ArithmeticOperations) contains two 
>  numbers as data scalar props and calculates their sum and difference as 
>  result scalar props.
> 
> %%% ¡seealso!
> LogicalOperations, GeometricalOperations
> 
> 
> %% ¡props_update!  `2`
> 
> %%% ¡prop!
> ELCLASS (constant, string) is the class of the arithmetic operation calculator.
> %%%% ¡default!
> 'ArithmeticOperations'  `3`
> 
> %%% ¡prop!
> NAME (constant, string) is the name of the arithmetic operation calculator.
> %%%% ¡default!
> 'Arithmetic Operation Calculator'
> 
> %%% ¡prop!
> DESCRIPTION (constant, string) is the description of the arithmetic operation calculator.
> %%%% ¡default!
> 'An Arithmetic Operations element (ArithmeticOperations) contains two numbers as data scalar props and calculates their sum and difference as result scalar props.'
> 
> %%% ¡prop!
> TEMPLATE (parameter, item) is the template of the arithmetic operation calculator.
> %%%% ¡settings!
> 'ArithmeticOperations'  `4`
> 
> %%% ¡prop!
> ID (data, string) is a few-letter code for the arithmetic operation calculator.
> %%%% ¡default!
> 'ArithmeticOperations ID'
> 
> %%% ¡prop!
> LABEL (metadata, string) is an extended label of the arithmetic operation calculator.
> %%%% ¡default!
> 'ArithmeticOperations label'
> 
> %%% ¡prop!
> NOTES (metadata, string) are some specific notes about the arithmetic operation calculator.
> %%%% ¡default!
> 'ArithmeticOperations notes'
> 
> %%% ¡prop!  `5`
> TOSTRING (query, string) returns a string that represents the  arithmetic operation calculator.
> %%%% ¡calcualte!  `6`
> a = ao.get('A');
> b = ao.get('B');
> value = ['Calculator of the sum and difference of ' num2str(A) ' and ' num2str(B)];
> 
> 
> %% ¡props!  `7`
> 
> %%% ¡prop!  `8 and 9`
> A (data, scalar) is the first number.
> 
> %%% ¡prop!  `9`
> B (data, scalar) is the second number.
> 
> %%% ¡prop!  `10`
> SUM (result, scalar) is the sum of the two numbers (A + B).
> %%%% ¡calculate!  `11`
> value = ao.get('A') + ao.get('B');
> 
> %%% ¡prop!  `12`
> DIFF (result, scalar) is the difference of the two numbers (A - B).
> %%%% ¡calculate!  `13`
> value = ao.get('A') - ao.get('B');
> 
> 
> %% ¡tests!  `14`
> 
> %%% ¡test!
> %%%% ¡name!
> Simple test
> %%%% ¡code!
> ao = ArithmeticOperations('A', 6, 'B', 4)
> 
> string = ao.get('TOSTRING')
> assert(~ao.isLocked('A'))  `15 and 16`
> assert(~ao.isLocked('B'))  `16`
> 
> sum = ao.get('SUM')
> 
> assert(ao.isLocked('A'))  `17 and 18`
> assert(ao.isLocked('B'))  `18`
> 
> diff = ao.get('DIFF')
> 
> sum_raw = ao.getr('SUM')  `19 and 20`
> diff_raw = ao.getr('DIFF')  `20`
> assert(isa(sum_raw, 'NoValue') && isa(diff_raw, 'NoValue'))
> 
> %%% ¡test!   `21`
> %%%% ¡name!
> Simple test with memorization
> %%%% ¡code!
> ao = ArithmeticOperations('A', 6, 'B', 4)
> 
> sum = ao.memorize('SUM')
> diff = ao.memorize('DIFF')
> 
> sum_raw = ao.getr('SUM')
> diff_raw = ao.getr('DIFF')
> assert(~isa(sum_raw, 'NoValue') && ~isa(diff_raw, 'No
>`1` The `¡header!` token is the only required one.>`2` The `¡props_update!` token permits to update the properties of the `ConcreteElement`. The updated parts have been highlighted.
>`3` must be the name of the element.
>`4` must be the name of the element.
>`5` Often, it is not necessary to updated `TOSTRING`, as the default works for most cases.
>`6` returns the string, which must be saved in the variable `value`.
>`7` The `¡props!` token permits to add additional props.
>`10` is a result prop.
>`11` calculates the sum of the two numbers. The result must be saved in the variable `value`.
>`12` is a result prop.
>`13` calculates the difference of the two numbers. The result must be saved in the variable `value`.
>`14` The `¡tests!` token permits to add unit tests.
>`21` alters the previous test to memorize the results.
>`8 9` are two data props.
>`15 16` Both props `A` and `B` are not locked, even though the query prop `TOSTRING` has been calculated.
>`17 18` Both props `A` and `B` are now locked, because the result prop `SUM` has been calculated. From now on their value cannot be changed.
>`19 20` Note that both the result props `SUM` and `DIFF` are `NoValue`, because they have not been memorized yet.

Value'))
> 


### Calculator with Seeded Randomness

We can now create an element that demonstrate how the seeded randomness works (`sr`).

** Arithmetic Operation Calculator.**
		This is a simple element direclty deriving from `ConcreteElement`.
> ```matlab
> 
> %% ¡header!
> SeededRandomness < ConcreteElement (sr, randomizer) generates a random number.
> 
> %%% ¡description!
> ...  `1`
> 
> 
> %% ¡props_update!
> 
> %%% ¡prop!
> ELCLASS (constant, string) is the class of the randomizer.
> %%%% ¡default!
> 'SeededRandomness'
> 
> ...  `2`
> 
> 
> %% ¡props!
> 
> %%% ¡prop!
> RANDOM_NUMBER (result, scalar) is a random number.
> %%%% ¡calculate!
> value = rand();
> 
> 
> %% ¡tests!
> 
> %%% ¡test!
> Simple test
> %%%% ¡code!
> sr1 = SeededRandomness()
> sr2 = SeededRandomness()
> 
> assert(sr1.get('RANDOM_NUMBER') == sr1.get('RANDOM_NUMBER'))  `3 and 4`
> assert(sr2.get('RANDOM_NUMBER') == sr2.get('RANDOM_NUMBER'))  `5`
> assert(sr1.get('RANDOM_NUMBER') ~= sr2.get('RANDOM_NUMBER'
>`1` Here, a detailed description should be provided.>`2` Here, the other standard properties derived from `ConcreteElement` should be updated as well (with the possible exception of `TOSTRING`).
>`6` checks that calls to the calculation of the random number of differen randomizers return different values.
>`3 4` check that subsequent calls to the calculation of the random number return the same value.

))  `6`
> 


### Query

We can now demonstrate the use of query props by expanding the `ArithmeticOperations` (`ao2`).

** Arithmetic Operation Calculator with Queries.**
		This element derives from `ArithmeticOperations` to include a query with arguments.
> ```matlab
> 
> %% ¡header!
> ArithmeticOperationsWithQuery < ArithmeticOperations (ao, calculator with query) calculates simple arithmetic operations with a query.
> 
> %%% ¡description!
> ...
> 
> 
> %% ¡props_update!
> 
> %%% ¡prop!
> ELCLASS (constant, string) is the class of the calculator with query.
> %%%% ¡default!
> 'ArithmeticOperationsWithQuery'
> 
> ...
> 
> 
> %% ¡props!
> 
> %%% ¡prop!
> SUM_OR_DIFF (query, scalar) returns the sum or difference depending on the argument.
> %%%% ¡calculate!
> % R = ao.get('SUM_OR_DIFF', SUM_OR_DIFF) returns the sum of A and B if  `1`
> %  SUM_OR_DIFF = 'SUM' or the difference of A and B if SUM_OR_DIFF = 'DIFF'.
> 
> if isempty(varargin)  `2`
>     value = NaN;
>     return
> end    
> sum_or_diff = varargin{1};
> 
> switch sum_or_diff 
>     case 'SUM'
>         value = ao.get('SUM');
> 
>     case 'DIFF'
>         value = ao.get('DIFF');
> 
>     otherwise
>         value = NaN;
> end
> 
> 
> 
> %% ¡tests!
> 
> %%% ¡test!
> Simple test
> %%%% ¡code!
> ao = ArithmeticOperationsWithQuery('A', 6, 'B', 4)
> 
> assert(ao.get('SUM_OR_DIFF', 'SUM') == ao.get('SUM'))  `3 and 4`
> assert(ao.get('SUM_OR_DIFF', 'DIFF') == ao.get('DIFF'))  `4`
> assert(isnan(ao.get('SUM_OR_DIFF')))  `5 and 6`
> assert(isnan(ao.get('SUM_OR_DIFF', 'anything else')
>`1` It is good practice to add some comments about the arguments for the query.>`2` It is also good practice to check the input arguments and provide a reasonable output for absent/unexpected arguments.
>`3 4` returns the sum or the difference depening on the argument.
>`5 6` retunrs `NaN` when the input is absent or unexpected.

))  `6`
> 


### Evanescent, Gui, Figure

We can now demonstrate the use of evanescent props and graphical handles (`f`).

** Element with figure.**
		Element with a figure to illustrate how to use evanescent handles.
> ```matlab
> 
> %% ¡header!
> ElementWithFigure < ConcreteElement (ef, element with figure) is an element with a figure.
> 
> %%% ¡description!
> ...
> 
> 
> %% ¡props_update!
> 
> %%% ¡prop!
> ELCLASS (constant, string) is the class of the element with figure.
> %%%% ¡default!
> 'ElementWithFigure'
> 
> ...
> 
> 
> %% ¡props!
> 
> %%% ¡prop!
> FIG (evanescent, handle) is the handle of a figure.
> %%%% ¡calculate!
> value = uifigure( ...  `1`
>     'Name', 'Figure from ElementWithFigure', ...
>     'Color', BRAPH2.COL ...
>     );
> 
> %%% ¡prop!
> PANEL (evanescent, handle) is the handle of the panel.
> %%%% ¡calculate!
> if ~check_graphics(ef.memorize('FIG'), 'figure')  `2`circlednote{2}{checks whether the figure still exists, otherwisecircled{3} erases it so thatcircled{4} recreates it.}
>     ef.set('FIG', Element.getNoValue());  `3`
> end
> 
> fig = ef.memorize('FIG');  `4`
> 
> value = uipanel( ...
>     'Parent', fig, ...  `5`
>     'Units', 'normalized', ...
>     'Position', [.25 .25 .50 .50], ...
>     'BackgroundColor', BRAPH2.COL_BKG ...
>     );
> 
> %%% ¡prop!
> BUTTONS (evanescent, handlelist) is the list of handles of the buttons.
> %%%% ¡calculate!
> if ~check_graphics(ef.getr('PANEL'), 'uipanel')  `6`circlednote{6}{checks whether the panel still exists, otherwisecircled{7} erases it so thatcircled{8} recreates it.}
>     ef.set('PANEL', Element.getNoValue());  `7`
> end
> 
> panel = ef.memorize('PANEL');  `8`
> 
> value = {};
> for i = 1:1:10
>     value{i} = uibutton( ...
>         'Parent', panel, ...  `9`
>         'Text', ['B' int2str(i)], ...
>         'Position', [ ...
>             (i - 1) * w(panel, 'pixels') / 10 ...
>             (i - 1) * h(panel, 'pixels') / 10 ...
>             w(panel, 'pixels') / 10 ...
>             h(panel, 'pixels') / 10 ...
>             ], ...
>         'ButtonPushedFcn', {@cb_button} ...  `10`
>         );
> end
> %%%% ¡calculate_callbacks!  `11`
> function cb_button(src, ~)  `12`
>     disp(src.get('Text'))
> end
> 
> 
> %% ¡tests!
> 
> %%% ¡excluded_props!  `13`
> [ElementWithFigure.PANEL ElementWithFigure.BUTTONS]
> 
> %%% ¡test!  `14`
> %%%% ¡name!
> Remove Figures
> %%%% ¡code!
> warning('off', [BRAPH2.STR ':ElementWithFigure'])
> assert(length(findall(0, 'type', 'figure')) == 4) 
> delete(findall(0, 'type', 'figure'))
> warning('on', [BRAPH2.STR ':ElementWithFigure'])
> 
> %%% ¡test!
> Simple test
> %%%% ¡code!
> ef = ElementWithFigure()
> 
> ef.memorize('BUTTONS')  `15`
> 
> close(ef.get('FIG')
>`1` renders a figure and returns its handle.>`5` ensures that `FIG` is the parent of the panel.
>`9` ensures that `PANEL` is the parent of each button.
>`10` defines the same callback for all buttons.
>`11` The callbacks are defined in the token `¡calculate_callbacks!`.
>`12` All callbacks have two parameters at least, corresponding to the source of the callback `src` and to its event (here, not used).
>`13` The token `¡excluded_props!` determines which props to exclude from testing. Often evanescent handle and handlelist properties need to be excluded from the unit testing.
>`14` This test removes the figures left over from the basic unit testing. It is good practice to ensure that no figures are left over at the end of the unit testing.
>`15` memorizes the prop `BUTTON`, which in turn memorizes the props `PANEL` and `FIG`.
>`16` closes the figure created in this test to ensure that no figures are left over at the end of the unit testing.

)  `16`
>
