classdef Category < handle
    % Category defines the category of a property.
    % Static class that defines the possible cagories of the properties of
    % the elements. It is a subclass of handle.
    %
    % The possible categories are:
    %
    % METADATA  Metadata about the element not used in the calculation of
    %           the results (does not allow callbacks). 
    %
    % PARAMETER Parameter used to calculate the results of the element
    %           (allow incoming and outgoing callbacks).
    %
    % DATA      Data used to calculate the results of the element 
    %           (can be NoResult when not set, allow incoming and outgoing
    %           callbacks).
    %
    % RESULT    Result calculated by the element using parameters and data
    %           (can be NoResult when not calculated, allows incoming
    %           callbacks).
    %
    % Category properties (Constant):
    %
	% METADATA = 'm'
    % METADATA_NAME = 'metadata'
    % METADATA_DESCRIPTION
    %
    % PARAMETER = 'p'
    % PARAMETER_NAME = 'parameter'
    % PARAMETER_DESCRIPTION
    % 
    % DATA = 'd'
    % DATA_NAME = 'data'
    % DATA_DESCRIPTION
    % 
    % RESULT = 'r'
    % RESULT_NAME = 'result'
    % RESULT_DESCRIPTION
    %
    % Category methods (Static):
    % getCategories - returns the list of categories
    % getCategoryNumber - returns the number of categories
    % existsCategory - returns whether a category exists/error
    % getCategoryName - returns the name of a category
    % getCategoryDescription - 
    %
    % See also Element, Format.
    
    properties (Constant)
        METADATA = 'm'
        METADATA_NAME = 'metadata'
        METADATA_DESCRIPTION = 'Metadata about the element not used in the calculation of the results (does not allow callbacks).'
        
        PARAMETER = 'p'
        PARAMETER_NAME = 'parameter'
        PARAMETER_DESCRIPTION = 'Parameter used to calculate the results of the element (allow incoming and outgoing callbacks).'
        
        DATA = 'd'
        DATA_NAME = 'data'
        DATA_DESCRIPTION = 'Data used to calculate the results of the element (can be NoResult when not set, allow incoming and outgoing callbacks).'

        RESULT = 'r'
        RESULT_NAME = 'result'
        RESULT_DESCRIPTION = 'Result calculated by the element using parameters and data (can be NoResult when not calculated, allows incoming callbacks).'
    end
    methods (Static)
        function categories = getCategories()
            % GETCATEGORIES returns the list of categories.
            %
            % CATEGORIES = GETCATEGORIES() returns the list of categories.
            %
            % See also getCategoryNumber, existsCategory.
            
            categories = {
                Category.METADATA
                Category.PARAMETER
                Category.DATA
                Category.RESULT
                };
        end
        function category_number = getCategoryNumber()
            % GETCATEGORYNUMBER returns the number of categories.
            %
            % N = GETCATEGORYNUMBER() returns the number of categories (4).
            %
            % See also getCategories, existsCategory.
            
            category_number = numel(Category.getCategories());
        end
        function check = existsCategory(category)
            % EXISTSCATEGORY returns whether a category exists/error.
            %
            % CHECK = EXISTSCATEGORY(CATEGORY) returns whether category
            % CATEGORY exists.
            %
            % EXISTSCATEGORY(CATEGORY) throws an error if category CATEGORY
            % doe not exist.
            % Error id: [BRAPH2.STR:Category.existsCategory:BRAPH2.WRONG_INPUT].
            %
            % See also getCategories, getCategoryNumber.
            
            if nargout == 1
                check = any(cellfun(@(x) isequal(category, x), Category.getCategories()));
            else
                assert( ...
                    Category.existsCategory(category), ...
                    [BRAPH2.STR ':Category:' BRAPH2.WRONG_INPUT], ...
                    [BRAPH2.STR ':Category:' BRAPH2.WRONG_INPUT ' ' ...
                    'The value ' tostring(category) ' is not a valid category. ' ...
                    'Admissible values are ' char(join(cellfun(@(x) ['''' x ''''], Category.getCategories(), 'UniformOutput', false))) '.'] ...
                    )
            end
        end
        function category_name = getCategoryName(category)
            % GETCATEGORYNAME returns the name of a category.
            %
            % NAME = GETCATEGORYNAME(CATEGORY) returns the name of category
            % CATEGORY.
            %
            % A list of all category names can be obtained using
            % <a href="matlab:cellfun(@(x) Category.getCategoryName(x), Category.getCategories(), 'UniformOutput', false)">cellfun(@(x) Category.getCategoryName(x), Category.getCategories(), 'UniformOutput', false)</a>
            %
            % See also getCategoryDescription, getCategories.

            Category.existsCategory(category)

            switch category
                case Category.METADATA
                    category_name = Category.METADATA_NAME;
                case Category.PARAMETER
                    category_name = Category.PARAMETER_NAME;                    
                case Category.DATA
                    category_name = Category.DATA_NAME;                    
                case Category.RESULT
                    category_name = Category.RESULT_NAME;                    
            end
        end
        function category_description = getCategoryDescription(category)
            % GETCATEGORYDESCRIPTION returns the description of a category.
            %
            % NAME = GETCATEGORYDESCRIPTION(CATEGORY) returns the description of category
            % CATEGORY.
            %
            % A list of all category descriptions can be obtained using
            % <a href="matlab:cellfun(@(x) Category.getCategoryDescription(x), Category.getCategories(), 'UniformOutput', false)">cellfun(@(x) Category.getCategoryDescription(x), Category.getCategories(), 'UniformOutput', false)</a>
            %
            % See also getCategoryName, getCategories.

            Category.existsCategory(category)

            switch category
                case Category.METADATA
                    category_description = Category.METADATA_DESCRIPTION;
                case Category.PARAMETER
                    category_description = Category.PARAMETER_DESCRIPTION;                   
                case Category.DATA
                    category_description = Category.DATA_DESCRIPTION;                    
                case Category.RESULT
                    category_description = Category.RESULT_DESCRIPTION;                    
            end
        end
    end
end