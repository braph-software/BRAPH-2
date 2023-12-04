clear all, clc

tex_file = 'dev_intro.tex';

tex = fileread(tex_file);

%% Analysis

% title
title = regexp(tex, '\\title{([^{}]*)}', 'tokens', 'once');
title = strtrim(title{1});

% document
document = regexp(tex, '\\begin{document}(.*)\\end{document}', 'tokens', 'once');
document = document{1};
document = regexprep(document, '\\maketitle', '');
document = regexprep(document, '\\noindent', '');
document = regexprep(document, '\\tableofcontents', '');
document = regexprep(document, '\\clearpage', '');
document = regexprep(document, '\\begin\{abstract\}', '');
document = regexprep(document, '\\end\{abstract\}', '');
% document = strtrim(document);

% basic reformatting
document = regexprep(document, 'BRAPH~2.0', 'BRAPH 2.0');
document = regexprep(document, '---', '-');
document = regexprep(document, '\\\\\n', '\n');

% (sub)section
document = regexprep(document, '\\section{([^{}]*)}', '## $1');
document = regexprep(document, '\\subsection{([^{}]*)}', '### $1');
document = regexprep(document, '\\subsubsection{([^{}]*)}', '#### $1');

% backet control
document = regexprep(document, '\\begin\{fullwidth\}', '');
document = regexprep(document, '\\end\{fullwidth\}', '');
document = regexprep(document, '\\code\{(.*?)\}', '`$1`');
document = regexprep(document, '\\Coderef\{..\:([^\:\}]*)\}', '`$1`');
document = regexprep(document, ['\`\`([^\`\`]*)\''' '\'''], '"$1"');
document = regexprep(document, '\\fn\{([^\{\}]*)\}', '"$1"');
document = regexprep(document, '\\emph\{([^=\}]*)\}', '`$1`');
document = regexprep(document, '\\begin\{enumerate\}', '');
document = regexprep(document, '\\end\{enumerate\}', '');
document = regexprep(document, '\\footnote\{(.*?)\}', ' $1');
document = regexprep(document, '\\Figref\{fig:([^:\}]*)\}', 'Figure $1');
document = regexprep(document, '\\Figsref\{fig:([^:\}]*)\}', 'Figures $1');

% figures
document = regexprep(document, '\{\\bf(.*?)\}', '**$1**');
pattern = '\\fig\{[^}]+\}\s*\{([^}]+)\}\s*\{(?:\s*\[h!\]\s*)?(?:\s*\[b!\]\s*)?\\includegraphics(?:\[height=10cm\])?\{([^{}]*)}(?:\s*)?\}\s*\{([^{}]*)\}\s*\{\s*([^{}]*)\}';
figPattern = '\#\!(..)(?:\_)?(.*?)\n';
newFigMods =  regexp(document, figPattern, 'tokens', 'all');
findings = regexp(document, pattern, 'tokens', 'all');
document = regexprep(document, pattern, '', 'all');
for i = 1:length(findings)
    % find marks index and remove them
    finding = findings{i};
    newPos = regexp(document, figPattern, 'once');
    document = regexprep(document, figPattern, '', 'once');

    % replace old info with new way in new position
    figName = finding{2};
    figTitle = finding{3};
    
    if ~isempty(newFigMods) && length(newFigMods{i}{2}) > 1
        figSizeMod = strtrim(newFigMods{i}{2});
        newFormat = ['<img src="' figName '" alt="' figTitle ' " height="' figSizeMod '">'];
    else
        newFormat = ['<img src="' figName '" alt="' figTitle '">'];
    end

    tagSize = length(newFormat);    
    document = insertBefore(document, newPos - 1,  newFormat);

    % insert fig explanation
    document = insertBefore(document, newPos - 1 + tagSize,  [newline() newline() '> **Figure ' newFigMods{i}{1} '.' finding{3} '**' newline() '> ' finding{end} newline()]);
end

% itemize
document = regexprep(document, '\\begin\{itemize\}', '');
document = regexprep(document, '\\end\{itemize\}', '');
pattern = '\\item\s+([^\\]*)';
findings = regexp(document, pattern, 'tokens', 'all');
for i = 1:length(findings)
    finding = findings{i};
    document = regexprep(document, pattern, ['- ' finding{1}], 'once');
end

% item
document = regexprep(document, '\\item\[\\code\{([^\{\}]*)\}\]\s*(.*?)\n', '`$1` $2');
document = regexprep(document, '\\item\[([^\[\]]*)\]', '> $1');

% descriptions
document = regexprep(document, '\\begin\{description\}', '> ');
document = regexprep(document, '\\end\{description\}', '> ');

% tcolorbox
tmp_tcolorbox = regexp(document, '\\begin{tcolorbox}(.*?)\\end\{tcolorbox\}', 'tokens', 'all'); % hold it
document = regexprep(document, '\\begin{tcolorbox}(.*?)\\end\{tcolorbox\}', '<tcolorboxgoeshere>**!'); % put mark
pattern = '\[\s*title=([^=\]]*)\]([^\]\\]*)(.*)(?:\>*)?(?:\}*)?';
pattern2 = '\]\s*(?:\>*)?\s*(?:\>*)?\s*([^\]\\]*)(?:\\*)?';
pattern3= '(.*?)\n';
for i = 1:length(tmp_tcolorbox)
    % get index
    index_tcolorbox = regexp(document, '\<tcolorboxgoeshere>\*\*\!', 'all');
    % get sections
    tmp_finding = regexp(tmp_tcolorbox{i}, pattern, 'tokens', 'once');

    % get code
    section_title =  ['> **' strtrim(tmp_finding{1}{1}) '**'];
    section_explanation = [ newline() '> ' strtrim(tmp_finding{1}{2})];
    % insert into document
    document = insertBefore(document, index_tcolorbox(i) - 1,  section_title);
    document = insertBefore(document, index_tcolorbox(i) - 1 + length(section_title),  [section_explanation ' ' newline()]);
    % code
    if ~isempty(tmp_finding{1}{3})
        section_code = regexp(tmp_finding{1}{3}, pattern2, 'tokens', 'once');
        init_position_code = index_tcolorbox(i) - 1 + length(section_title) + length(section_explanation) + 2; % +2, because im adding a newline and a ' '
        % indicate it is matlab language
        matlab_lang_tag = ['> ```matlab' newline()];
        document = insertBefore(document, init_position_code,  matlab_lang_tag);
        init_position_code = init_position_code+length(matlab_lang_tag);
        code_split = regexp(section_code{1}, pattern3, 'tokens', 'all');
        accumulated_length = 0;
        for j = 1:length(code_split)
            line_of_code = code_split{j};
            line_of_code_with_modifier = ['> ' line_of_code{1} newline()];
            line_of_code_position = init_position_code+accumulated_length;
            document = insertBefore(document, line_of_code_position,  line_of_code_with_modifier);
            accumulated_length = accumulated_length + length(line_of_code_with_modifier);
        end
        document = insertBefore(document, init_position_code+accumulated_length,  ['> ```' newline()]);
    end
end
document = regexprep(document, '\<tcolorboxgoeshere>\*\*\!', ''); % remove mark
document = regexprep(document,'\%\:', '>');

% lstlisting
tmp_lstlisting = regexp(document, '\\begin{lstlisting}(.*?)\\end\{lstlisting\}', 'tokens', 'all'); % hold it
document = regexprep(document, '\\begin{lstlisting}(.*?)\\end\{lstlisting\}', '<lstlistinggoeshere>**!'); % put mark
document = regexprep(document, '\%', ''); % put mark
pattern = 'caption\=\{(.*?)\}(.*?)\](.*)';
pattern2 = '\¥\\circled\{([^{}]*)\}';
pattern3= '\\circlednote{([^{}]*)}\{([^{}]*)\}';
pattern4 = '\\twocirclednotes\{([^{}]*)\}\{([^{}]*)\}\{([^{}]*)\}\¥';
pattern5 = '\¥\\circled\{([^{}]*)\}\\twocirclednotes\{([^{}]*)\}\{([^{}]*)\}\{([^{}]*)\}\¥';
for i = 1:length(tmp_lstlisting)
    %
    index_lstlisting = regexp(document, '\<lstlistinggoeshere>\*\*\!', 'all');
    % find circlenotes and replace them with anotations

    tmp_circlenotes = regexp(tmp_lstlisting{i}, pattern3, 'tokens', 'all');
    tmp_circlenotes = tmp_circlenotes{1};
    tmp_two_circlenotes = regexp(tmp_lstlisting{i}, pattern4, 'tokens', 'all');
    tmp_two_circlenotes = tmp_two_circlenotes{1};

    % replace old pisitions with numbers
    tmp_lstlisting{i} = regexprep(tmp_lstlisting{i}, pattern5, '\\twocirclednotes\{$2\}\{$3\}\{$4\}\¥');
    tmp_lstlisting{i} = regexprep(tmp_lstlisting{i}, pattern4, ' \`$1 and $2\`');
    tmp_lstlisting{i} = regexprep(tmp_lstlisting{i}, pattern2, ' \`$1\`');
    tmp_lstlisting{i} = regexprep(tmp_lstlisting{i}, pattern3, '');    

    % get sections
    tmp_finding = regexp(tmp_lstlisting{i}, pattern, 'tokens', 'all');
    tmp_finding = tmp_finding{1};
    section_title = [strtrim(tmp_finding{1}{1}) newline()];
    explanation_length = length(section_title);
    
    % manage code section
    codeSection = tmp_finding{1}{3};
    codeSection = regexprep(codeSection, char(13), '');
    codeSection = regexprep(codeSection, newline(), [newline() '> ']); % char(10) == newline()
    codeSection = regexprep(codeSection, [newline() '\>([^\>\%]*)\s*\%'] , [newline() '>' newline() '>$1%' ]);
    code_with_no_notes = [newline() '> ' codeSection newline()];
    code_length = length(code_with_no_notes);

    % insert into document
    document = insertBefore(document, index_lstlisting(i) - 1,  section_title);
    document = insertBefore(document, index_lstlisting(i) - 1 + explanation_length, code_with_no_notes);

    n_total_circlenotes = length(tmp_circlenotes) + length(tmp_two_circlenotes);
    arr_circlenotes = cell(n_total_circlenotes, 1);
    % arrange circlenotes
    if ~isempty(tmp_circlenotes) && ~isempty(tmp_circlenotes{1})
        arr_circlenotes(1:length(tmp_circlenotes)) = tmp_circlenotes(:);
    end

    if  ~isempty(tmp_two_circlenotes) && ~isempty(tmp_two_circlenotes{1})
        arr_circlenotes(length(tmp_circlenotes)+1:end) = tmp_two_circlenotes(:);
    end

    % insert circlenotes info
    acumulated = 0;
    if ~isempty(arr_circlenotes) && ~isempty(arr_circlenotes{1})
        count_circle = 1;
        k = 1;
        for j = 1:length(arr_circlenotes)
            tmp_circlenote = arr_circlenotes{j};
            if length(tmp_circlenote) == 3
                note = ['> \`' tmp_circlenote{1} ' ' tmp_circlenote{2} '\` ' tmp_circlenote{end} newline()];
            else
                note = ['> \`' tmp_circlenote{1} '\` ' tmp_circlenote{end} newline()];
            end

            tmp_position = index_lstlisting(i) - 1 + explanation_length + code_length + acumulated;
            if j == 1
                document = insertBefore(document, tmp_position,  newline());
                tmp_position = tmp_position+1;
            end
            document = insertBefore(document, tmp_position,  note);
            acumulated = acumulated + length(note);
        end
    end
end
document = regexprep(document, '\<lstlistinggoeshere>\*\*\!', ''); % remove mark
document = regexprep(document, '\¥', '');

% txt or xls
document = regexprep(document, '\(\\fn\{\*\.txt\}\)', '(.txt)');
document = regexprep(document, '\(\\fn\{\*\.xls\}\)', '(.xls)');
document = regexprep(document, '\(\\fn\{\*\.xlsx\}\)', '(.xlsx)');
document = regexprep(document, '\(\\fn\{..xls\} or \\fn\{..xlsx\}\)', '(.xls or .xlsx)');

% references
document = regexprep(document, '\$([^\$\^]*)\^\{(?:\^\{)?\\rm\s*([^\s*\}]*)\}\$', '$1 $2');
document = regexprep(document, '\\fn\{([^\{\}]*)\}', '"$1"');

% web
document = regexprep(document, '\(\\url\{(.*?)\}\)', '');

% extra
document = regexprep(document, '\s*\\', '');
document = regexprep(document, '\`bf\s*', '\`');
document = regexprep(document,'bibliography(.*?)\}', '');
% document = regexprep(document,'\<\n', '');
document = strtrim(document);

%% Generate README file
readme = [
    '# ' title newline() ...
    newline() ...
    '[![Tutorial ' title '](https://img.shields.io/badge/PDF-Download-red?style=flat-square&logo=adobe-acrobat-reader)](' tex_file(1:end-4) '.pdf)' newline() ...
    newline()
    ];

readme = [readme ...
    document
    ];


%% Save readme
writelines(readme, 'test_readme.md')