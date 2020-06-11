function convert_x3d_to_nv(file, varargin)
% CONVERT_X3D_TO_NV converts a x3d file to  nv file
%
% CONVERT_X3D_TO_NV() opens a gui dialog box to select a x3d file, this
% file will be converted to a nv file. It places the output file in the
% same folder as the input file.
%
% CONVERT_X3D_TO_NV(FILE) converts the FILE with extension x3d to
% an nv file. It places the output file in the same folder as the input FILE.
%
% CONVERT_X3D_TO_NV([], 'MSG', MESSAGE) opens  gui dialog box to select a
% x3d file, this dialog box will use a personlized message MESSAGE. It
% places the output file in the sme folder as the input file.
%


% If no file argument is present it opens a gui dialog box.
if nargin< 1 || isempty(file)
    msg = get_from_varargin(BRAPH2.X3D__MSG_GETFILE, 'msg', varargin{:});
    [filename, filepath, filterindex] = uigetfile(BRAPH2.X3D_EXTENSION, msg);
    file = [filepath filename];
    
    if ~filterindex
        return
    end
end

% x3d files are xml files. we open it using xmlread. The following
% commands work with x3d files that have the same pattern as the ones in
% https://scalablebrainatlas.incf.org/
xml_file  = xmlread(file);
x3d_inner_file = xml_file.getFirstChild();
scene_elements = x3d_inner_file.getElementsByTagName('Scene');
scene = scene_elements.item(0);
transform_elements = scene.getElementsByTagName('Transform');
transform = transform_elements.item(0);
transform_inner_elements = transform.getElementsByTagName('Transform');
transform_inner = transform_inner_elements.item(0);
shape_elements = transform_inner.getElementsByTagName('Shape');
shape = shape_elements.item(0);
index_facet_elements = shape.getElementsByTagName('IndexedFaceSet');
index_facet = index_facet_elements.item(0);
triangles = index_facet.getAttribute('coordIndex');
coordinate_elements = index_facet.getElementsByTagName('Coordinate');
coordinate_element = coordinate_elements.item(0);
coordinates = coordinate_element.getAttribute('point');

% manage the triangles and coordinates extracted from the x3d
triangles = erase(char(triangles), '             ');  % manage strings to remove leading space
triangles = strrep(triangles, '-1', newline);  % remove unwanted chars
triangles = split(triangles, newline);  % split the string in the newlines.
triangles = strtrim(triangles);  % trim white space
triangles = triangles(~cellfun('isempty', triangles));  % remove empty cells
number_triangles = length(triangles);  % triangles need to increase the number by 1, because matlab patch needs to be >= 1
for i = 1:number_triangles
    tmp = triangles{i, 1};
    tmp_array = split(tmp, ' ');
    tmp_array = cellfun(@(x) str2num(x) + 1, tmp_array); %#ok<ST2NM>
    triangles{i, 1} = [num2str(tmp_array(1)) ' ' num2str(tmp_array(2)) ' ' num2str(tmp_array(3))];
end
coordinates = erase(char(coordinates), '             ');
coordinates = strrep(coordinates, ',' , newline);
coordinates = split(coordinates, newline);
coordinates = strtrim(coordinates);
coordinates = coordinates(~cellfun('isempty', coordinates));
number_coordinates = length(coordinates);

% write output file
file = strrep(file, '.x3d', '.nv');  % remove file extension to the file name
nv_file = fopen(file, 'w');  % create new file and give writing permission
fprintf(nv_file, num2str(number_coordinates));  % number of coordinates
fprintf(nv_file, newline);
for i = 1:number_coordinates  % coordintes
    fprintf(nv_file, coordinates{i,1});
    fprintf(nv_file, newline);
end
fprintf(nv_file, num2str(number_triangles));  % number of triangles
fprintf(nv_file, newline);
for i = 1:number_triangles
    fprintf(nv_file, triangles{i, 1});  % triangles
    fprintf(nv_file, newline);
end
fclose(nv_file);
end