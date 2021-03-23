classdef JSON
    % JSON JSON converter
    % JSON provides static methods to serialize or deserialize structs to
    % the indicated path
    %
    % JSON provides serialize method to convert a MATLAB struct to a .JSON file to
    % the indicated path. It also provides deserialize method to convert a
    % .JSON file from a indicated path to a MATLAB struct. 
    %
    % JSON Static methods:
    %   Serialize          - serialize a struct to a .json file
    %   Deserialize        - deserialize a .json file to a struct
    %
    % See also arrow3d, clinder3d.  
  
    methods (Static)
        function Serialize(struct, varargin)
            % SERIALIZE converts a struct to a .JSON file.
            % 
            % SERILIAZE(STRUCT, JSONPATH, PATH) converts a MATLAB struct to
            % a .json file to PATH.
            %
            % See also Deserialize.
            
            file = get_from_varargin('', 'File', varargin{:});
            if isequal(file, '')  % select file
                msg = get_from_varargin(BRAPH2.JSON_MSG_PUTFILE, 'MSG', varargin{:});
                [filename, filepath, filterindex] = uiputfile(BRAPH2.JSON_EXTENSION, msg);
                file = [filepath filename];
                
                if ~filterindex
                    return
                end
            end
            
            json_structure = jsonencode(struct);
            fid = fopen(file, 'w');
            if fid == -1, error('Cannot create JSON file'); end
            fwrite(fid, json_structure, 'char');
            fclose(fid);            
        end
        function struct = Deserialize(varargin) 
            % DESERIALIZE converts a .JSON file to a MATLAB struct.
            % 
            % STRUCT = DESERIALIZE(PATH) converts a .JSON file to a MATLAB
            % struct.
            %
            % See also Deserialize.
            
             % file (fullpath)
            file = get_from_varargin('', 'File', varargin{:});
            if isequal(file, '')  % select file
                msg = get_from_varargin(BRAPH2.JSON_MSG_GETFILE, 'MSG', varargin{:});
                [filename, filepath, filterindex] = uigetfile(BRAPH2.JSON_EXTENSION, msg);
                file = [filepath filename];
                
                if ~filterindex
                    return
                end
            end
            
            struct = jsondecode(fileread(file));
        end
    end
end