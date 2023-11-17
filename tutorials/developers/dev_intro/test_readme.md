# General Developer Tutorial for BRAPH 2.0

[![Tutorial General Developer Tutorial for BRAPH 2.0](https://img.shields.io/badge/PDF-Download-red?style=flat-square&logo=adobe-acrobat-reader)](dev_intro.pdf)

The software architecture of BRAPH 2.0 provides a clear structure for developers to understand and extend its functionalities. All objects (`elements`) in BRAPH 2.0 are derived from the base object `Element`. Developers can easily add new elements by writing the new elements in the simplified BRAPH 2.0 pseudocode. 
By recompiling BRAPH 2.0, the new elements and their functionalities are immediately integrated, also into the graphical user interface.
In this Developer Tutorial, we will explain how BRAPH 2.0 is compiled, how the elements are strcutured, and how new elements can be implemented.




%%%%% %%%%% %%%%% %%%%% %%%%%

## Compilation and Element (Re)Generation

BRAPH 2.0 is a compiled object-oriented programming software.
Its objects are `elements`, which contain a set of `props` of various `categories` and `formats`, as described in detail in the following sections. 
These elements are written in the BRAPH 2.0 pseudocode, which simplifies and streamlines the coding process.
To convert them into usable matlab objects, BRAPH 2.0 needs to be compiled, which is done by calling the script `braph2genesis`, which will compile the whole code, as shown in `compilation`.
%


During the compilation, there are several phases to improve the computational efficiency of the executable code:begin`enumerate`
	- ** First compilation**, where the elements are created.
	- ** Second compilation**, where the elements are computationally optimized.
	- ** Constant hard-coding**, where several contants are hard-coded in the executable code to further optimize the run time.end`enumerate`

Because this multi-stage compilation, it is not always possible to regenerate a single element without regenerating the whole BRAPH 2.0. 
Nevertheless, it is usually possible to regenerate a single element as long as the element already exists and its props have not been changed.
This can be done with the function `regenerate()`, as shown in `regenerate`.
%


## Elements

The base class for all elements is `Element`. 
Each element is essentially a container for a series of `props` (properties). Each prop is characterized by the following static features (i.e., equal for all instances of the prop):

	- A `sequential number` (integer starting from 1).
		
	- A `tag` (a string).
	
	- A `category`, which determines for how a prop is used.footnote`The possible categories and formats are shown in the boxes below.`
	
	- A `format`, which determines what a prop can contain.

The functions to inspect these features can be found by using the command `help Element` in the MatLab command line.

Furthermore, each instance of a prop has the following features:

	- A `value`.footnote`The value is by defalut a `NoValue`. For `PARAMETER`, `DATA`, `FIGURE`, and `GUI` props, it can also be a callback. For `CONSTANT` props, it is usually a concrete value.`
	The functions to set, get, and memorize a value will be discussed in the following sections.
	
	- A `seed` for the random number generator to ensure the reproducibility of the results. 
	The seed of each property is a 32-bit unsigned integer and is initialized when an element is constructed by calling `randi(intmax('uint32'))`.
	
	The seed can be obtained using:code`seed = el.getPropSeed(pointer)`
	where `pointer` can be either a prop number or tag.
	It cannot be changed.
 	
	- A `checked` status, which is true by default.
	Checked props are checked for format when they are set and for value when they are set/calculated.footnote{Whencode`BRAPH2.CHECKED = false`, no checks are performed. This needs to be changes in the file "BRAPH2.m".}
	
	The checked status of a prop can be altered with the functions:
	`el.checked(pointer)`
	`el.unchecked(pointer)`
	The checked status of a prop can be assessed with the function:code`checked = el.isChecked(pointer)`
	where `pointer` can be either a prop number or tag.
	
	- A `locked` status, which is false by default.footnote`The `PARAMETER` and `DATA` props get locked the first time a `RESULT` property is successfully calculated. The locked status is not used for `CONSTANT` props.`
	
	A prop can be locked with the function:
	`el.lock(pointer)`
	Once locked, it cannot be unlocked.
	The locked status of a prop can be assessed with the function:code`locked = el.isLocked(pointer)`
	where `pointer` can be either a prop number or tag.
	
	- A `callback` instance.footnote`Callbacks are not used with `METADATA` props.`
	
	The callback to a prop can be obtained using the function:code`cb = el.getCallback(pointer)`
	where `pointer` can be either a prop number or tag.
	

Additional functions to operate with these features can be found by using the command `help Element` in the MatLab command line.begin`fullwidth`
> **Property Categories**
> >  
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
>:end`fullwidth`begin`fullwidth`end`fullwidth`

Even though it is > **Property Formats**
> >  
	- [`EMPTY`:
> ```matlab
> Empty has an empty value and is typically used as a result or query to execute some code. 
>  
> ```
possible to create instances of `Element`, typically one uses its subclasses and does not have any props.
Its three direct subclasses are `NoValue`, `Callback`, and `ConcreteElement`, as shown in Figure elements.

![Element tree](fig01_big.jpg) 
 > **Figure 01. Element tree.** All elements derive from the base class `Element`. 
	Its direct children are `NoValue`, `Callback`, and `ConcreteElement`, whose properties are also indicated.
	Concrete elements further derive directly or indirectly from `ConcreteElement`.
	

The element `NoValue` is used to represent a value that has not been set (for properties of categories `METADATA`, `PARAMETER`, `DATA`, `FIGURE` or `GUI`) or calculated (for properties of category `RESULT`, `QUERY`, `EVANESCENT`), while it should not be used for properties of category `CONSTANT`.
It should be instantiated using `novalue`.
%

%
No element can be a subclass of NoValue.
  
A `Callback` refers to a prop of another element `el`, identified by prop number or tag.
It should be instantiated using `callback`.
%

%
No element can be a subclass of `Callback`.

A concrete element (`ConcreteElement`) provides the infrastructure necessary for all concrete elements. 
In particular, it has the constant props `ELCLASS` (string), `NAME` (string) and `DESCRIPTION` (string), the property `TEMPLATE` (item), the indexing properties `ID` (string), `LABEL` (string), and `NOTES` (string), and the query prop `TOSTRING` (string).
Even though it is possible to create instances of `ConcreteElement`, typically one uses its subclasses.

### Setting Props

The value of a prop can be set with `set`.
%

%
When a prop is set to a certain value, the following operations are performed:begin`enumerate`
	- The value is ** conditioned** before being set (by calling the protected `static` function `conditioning()`, which can be defined in each subelement).
	
	This can be set with the token `¡conditioning!`.
	
	- The value is ** preset** before being set (by calling the protected function `preset()`, which can be defined in each subelement).footnote`Differently from the `static` function `conditioning()`, the function `preset()` has access to the element instance.`

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
	
	- When a prop is successfully set, an ** event** `PropSet()` is ** notified**.end`enumerate` 

### Getting Props

The value of a prop can be retrieved with `get`.
%


If the raw value of the property is a `NoValue`, it proceed to return the default property value (for categories `METADATA`, `PARAMETER`, `DATA`, `FIGURE`, and `GUI`).
 
If the raw value of the property is a callback, it retrieves the value of the linked property (for categories `PARAMETER`, `DATA`, `FIGURE`, and `GUI`).
 
If a property of category `RESULT`, `QUERY`, or `EVANESCENT` is not calculated (i.e., its raw value is `NoValue`), it proceeds to calculate it (but not to memorize it, i.e., its raw value remains `NoValue`). After the calculation of a property of category `RESULT` all properties of categories `PARAMETER` and `DATA` are irreversibly locked.
If the property is checked, it proceeds to check all properties after the calculation calling the function `check()`. If the check fails, it resets the property to `NoValue` and returns `NoValue`, does not lock the property, and throws a warning with warning id `BRAPH2:<Element Class>`.

The raw value of a prop can be retrieved with `getr`.
%


### Memorizing Props  

The value of a prop can be memorized using `memorize`.
%


If the property is of category `RESULT`, `QUERY`, or `EVANESCENT`, it calls the function check, proceed to save the result, and notifies an ** event PropMemorized**.

If the property is `not` of category `RESULT`, `QUERY`, or `EVANESCENT` and has not been set yet, it sets it to its default value.
 
If the property is `not` of category `RESULT`, `QUERY`, or `EVANESCENT` and is a callback, it iteratively memorizes the property of the element in the callback.
 
If a property of category `QUERY` is memorized, a warning is thrown with warning id `BRAPH2:<Element Class>`, because query properties are generally not supposed to be memorized. If such behavior is intended, consider enclosing the command between warning off and warning on.

## Element tokens

A generator file has the structure illustrated `tokens`.
%begin`fullwidth`end`fullwidth`

A list of special instructions is shown in `special`.
%


## Overview of Elements

![BRAPH 2.0 genesis.](../braph2genesis.png) 
 > **Figure br. BRAPH 2.0 genesis..** Directory structure of "braph2genesis" (left) and "braph2" (right).
	

The directory structure of "braph2" and the relation with "braph2genesis" is illustrated in Figure genesis.
All objects are derived from a base object called `Element` and written in a simplified pseudocode (files "*.gen.m") that is compiled into the actual elements (files "*.m") by the command `braph2genesis` (some examples of these elements are shown).
The compiled code can be launched by the command `braph2`.
The core of BRAPH 2.0 (gray shaded area) includes the compiler (`genesis`), the essential source code ("src"), and the essential functionalities for the GUI ("gui", yellow-shaded area).
The users can easily add new brain surfaces ("brainsurfs"), atlases ("atlases"), example scripts and GUI pipelines (in the corresponding folder under "pipelines").
Furthermore, the users can add new elements such as new graphs (e.g., `GraphWU` in "graphs"), measures (e.g., `Strength` in "measures"), data types (e.g., `SubjectCON` in "pipelines/connectivity"), data importers (e.g., `ImporterGroupSubjectCON_XLS` in "pipelines/connectivity"), data exporters (e.g., `ExporterGroupSubjectCON_XLS` in "pipelines/connectivity"), and analyses (e.g., `AnalyzeEnsemble_CON_WU` in "pipelines/connectivity") by writing new elements and recompiling the whole code: the new elements and their functionalities will be immediately available also in the GUI.
Finally, BRAPH 2.0 is provided with a set of unit tests (executable by the command "test_braph2") that ensure the formal correctness of the code, including that of any newly added elements.

## Implementation of an Element

We will now see how to implement a few concrete elements.begin`fullwidth`end`fullwidth`

### A Simple Calculator

We will now create our first element (`ao`), a simple calcualator that contains two numbers (which are data scalar props) and calculates their sum and difference (which are result scalar props).



### Calculator with Seeded Randomness

We can now create an element that demonstrate how the seeded randomness works (`sr`).



### Query

We can now demonstrate the use of query props by expanding the `ArithmeticOperations` (`ao2`).



### Evanescent, Gui, Figure

We can now demonstrate the use of evanescent props and graphical handles (`f`).



%bibliography`biblio`
%bibliographystyle`plainnat`
