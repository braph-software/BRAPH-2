function printed_out = print(h, filename, varargin)

    if nargin < 2 || isempty(filename)
        % select file
        filter = {'*.jpg';'*.png';'*.tif';'*.gif';'*.pdf';'*.eps'};
        [file, path, filterindex] = uiputfile(filter, ['Select the figure file.']);
        % save file
        if filterindex
            filename = fullfile(path, file);
        else 
            filename = '';
        end
    end

    if ~isempty(filename)
        exportgraphics(h, filename, varargin{:});

        saved = true;
    else
        saved = false;
    end

    if nargout
        printed_out = saved;
    end
end