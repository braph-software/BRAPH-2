% Compile mex
% different options for 32bit and 64bit Matlab
ext=mexext;
directory = fileparts(which('braph2'));
path_files = [directory filesep 'graph' filesep 'measures' filesep 'MEX_SRC'];
switch ext
    case {'mexw32','mexglx','mexmac','mexmaci'} %32bit
        arraydims='-compatibleArrayDims';
    case {'mexw64','mexa64','mexmaci64'} %64bit
        arraydims='-largeArrayDims';
    otherwise %potentially new architectures in the future
        warning('unknown mexext %s, assuming 64bit',ext)
        arraydims='-largeArrayDims';
end
mkdir([path_files filesep '../private']);
setenv('CXXFLAGS',[getenv('CXXFLAGS'),' -std=c++11 -O4']);
if exist('OCTAVE_VERSION','builtin')
%     mex -DOCTAVE -Imatlab_matrix metanetwork_reduce.cpp matlab_matrix/full.cpp matlab_matrix/sparse.cpp group_index.cpp
%     mex -DOCTAVE -Imatlab_matrix group_handler.cpp matlab_matrix/full.cpp matlab_matrix/sparse.cpp group_index.cpp
%     mex -DOCTAVE ../Assignment/assignmentoptimal.c
else
    cd(path_files)
    mex(arraydims,'-Imatlab_matrix', [path_files filesep 'metanetwork_reduce.cpp'], [path_files filesep 'matlab_matrix/full.cpp'], [path_files filesep 'matlab_matrix/sparse.cpp'], [path_files filesep 'group_index.cpp'])
    mex(arraydims,'-Imatlab_matrix', [path_files filesep 'group_handler.cpp'], [path_files filesep 'matlab_matrix/full.cpp'], [path_files filesep 'matlab_matrix/sparse.cpp'], [path_files filesep 'group_index.cpp'])
    %mex(arraydims,'../Assignment/assignmentoptimal.c')
end

movefile([path_files filesep 'metanetwork_reduce.', ext], [path_files filesep '../private/metanetwork_reduce.', ext]);
movefile([path_files filesep 'group_handler.', ext],[path_files filesep '../private/group_handler.', ext]);
cd(directory)
% delete(path_files)
% movefile(['assignmentoptimal.',ext],['../Assignment/assignmentoptimal.',ext]);
