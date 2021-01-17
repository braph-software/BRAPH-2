classdef (Sealed = true) NoValue < Element
	% NoValue represents a value that has not been set or calculated.
	% It is a subclass of <a href="matlab:help Element">Element</a>.
	%
	% NoValue is an element without values used to represent a value that has
	% not been set (for properties of categories PARAMETER AND DATA) or
	% calculated (for properties of category RESULT). 
	% For computational efficiency, it is best to use only one instance of NV 
	% using NoValue.getNoValue(), instead of creating new instances using the 
	% constructor NoValue(). 
	% No element can be a subclass of NoValue.
	%
	% See also Element.
	
	methods (Static) % static methods
		function nv = getNoValue()
		    %GETNV returns a pointer to a persistent instance of NoValue.
		    %
		    % NV = GETNV() returns a pointer to a persistent instance of NoValue.
		    %  For computational efficiency, it is best to use NoValue.getNoValue(),
		    %  instead of creating new instances using the  constructor NoValue().
		
		    persistent local_nv
		    
		    if isempty(local_nv) || ~isvalid(local_nv)
		        local_nv = NoValue();
		    end
		    nv = local_nv;
		end
	end
	methods (Static) % inspection methods
		function nv_class = getClass()
			%GETCLASS returns the class of the NoValue.
			%
			% CLASS = NoValue.GETCLASS() returns the class 'NoValue'.
			%
			% Alternative forms to call this method are:
			%  CLASS = NV.GETCLASS() returns the class of the NoValue NV.
			%  CLASS = Element.GETCLASS(NV) returns the class of 'NV'.
			%  CLASS = Element.GETCLASS('NoValue') returns 'NoValue'.
			%
			% See also getName, getDescription.
			
			nv_class = 'NoValue';
		end
		function nv_name = getName()
			%GETNAME returns the name of the NoValue.
			%
			% NAME = NoValue.GETNAME() returns the name of the 'NoValue'.
			%  NoValue.
			%
			% Alternative forms to call this method are:
			%  NAME = NV.GETNAME() returns the name of the NoValue NV.
			%  NAME = Element.GETNAME(NV) returns the name of 'NV'.
			%  NAME = Element.GETNAME('NoValue') returns the name of 'NoValue'.
			%
			% See also getClass, getDescription.
			
			nv_name = regexprep('NoValue', '(\<[a-z])', '${upper($1)}');
		end
		function nv_description = getDescription()
			%GETDESCRIPTION returns the description of the NoValue.
			%
			% STR = NoValue.GETDESCRIPTION() returns the description of the 'NoValue'.
			%  which is:
			%
			%  NoValue is an element without values used to represent a value that has
			%  not been set (for properties of categories PARAMETER AND DATA) or
			%  calculated (for properties of category RESULT). 
			%  For computational efficiency, it is best to use only one instance of NV 
			%  using NoValue.getNoValue(), instead of creating new instances using the 
			%  constructor NoValue(). 
			%  No element can be a subclass of NoValue.
			%
			% Alternative forms to call this method are:
			%  STR = NV.GETDESCRIPTION() returns the description of the NoValue NV.
			%  STR = Element.GETDESCRIPTION(NV) returns the description of 'NV'.
			%  STR = Element.GETDESCRIPTION('NoValue') returns the description of 'NoValue'.
			%
			% See also getClass, getName.
			
			nv_description = [
				'NoValue is an element without values used to represent a value that has' ...
				'not been set (for properties of categories PARAMETER AND DATA) or' ...
				'calculated (for properties of category RESULT). ' ...
				'For computational efficiency, it is best to use only one instance of NV ' ...
				'using NoValue.getNoValue(), instead of creating new instances using the ' ...
				'constructor NoValue(). ' ...
				'No element can be a subclass of NoValue.' ...
				];
		end
	end
	methods % constructor
		function nv = NoValue(varargin)
			% NoValue() creates a NoValue.
			
			nv = nv@Element(varargin{:});
		end
	end
end
