function generate_readme(tex_file, readme_file)

if nargin < 2
    readme_file = 'readme.md';
end

tex = fileread(tex_file);

%% Analysis

% title
title = regexp(tex, '\\title(?:(.*?))?{([^{}]*)}', 'tokens', 'all'); %
title = strtrim(title{1});

if length(title) == 2
    title = strtrim(title{2});

else
    title = strtrim(title{1});
end

% document
document = regexp(tex, '\\begin{document}(.*)\\end{document}', 'tokens', 'once');
document = document{1};
document = regexprep(document, '\\maketitle', '');
document = regexprep(document, '\\noindent', '');
document = regexprep(document, '\\clearpage', '');
document = regexprep(document, '\\begin\{abstract\}', '');
document = regexprep(document, '\\end\{abstract\}', '');

% basic reformatting
document = regexprep(document, 'BRAPH~2.0', 'BRAPH 2.0');
document = regexprep(document, '---', '-');
document = regexprep(document, '\\\\\n', '\n');

% (sub)section
arrow_up_icon = char(11014);
document = regexprep(document, '\\section{([^{}]*)}', ['## $1  [' arrow_up_icon '](#table-of-contents)']);
document = regexprep(document, '\\subsection{([^{}]*)}',  ['### $1  [' arrow_up_icon '](#table-of-contents)']);
document = regexprep(document, '\\subsubsection{([^{}]*)}',  ['#### $1  [' arrow_up_icon '](#table-of-contents)']);

% table of contents
% document = regexprep(document, '\\tableofcontents', ''); old way
document = regexprep(document, '\\tableofcontents', '## Table of contents');
table_index = regexp(document, '## Table of contents');
tc_l = length('## Table of contents');

% patternSection = regexp(document, ['##\s(.*?)' char(13) '|###\s(.*?)' char(13) '|####\s(.*?)' char(13)], 'tokens', 'all');
patternSection = regexp(document, ['##(.*?)' char(13)], 'tokens', 'all');

acum = 0;
for i = 2:length(patternSection)
    tmp_section_title = patternSection{i}{1};
    tmp_section_title_array = split(tmp_section_title, '[');
    tmp_section_title = tmp_section_title_array{1};
    occur_tmp = regexp(tmp_section_title, '#');
    name_string = strtrim(replace(tmp_section_title, '#', ''));
    link_string = replace(name_string, ' ', '-');
    new_table_line = ['>' newline() '> [' name_string '](#' link_string ')' char(13) newline()];
    for j = 1:length(occur_tmp)
        new_table_line = insertAfter(new_table_line, 3, '>');
    end
    document = insertAfter(document, table_index + tc_l  + acum,  new_table_line);
    acum = acum + length(new_table_line);
end

% bracket control
document = regexprep(document, '\\begin\{fullwidth\}', '');
document = regexprep(document, '\\end\{fullwidth\}', '');
document = regexprep(document, '\\code\{(.*?)\}', '`$1`');
document = regexprep(document, ['\`\`([^\`\`]*)\''' '\'''], '"$1"');
document = regexprep(document, '\\fn\{([^\{\}]*)\}', '"$1"');
document = regexprep(document, '\\emph\{([^=\}]*)\}', '_$1_');
document = regexprep(document, '\\footnote\{(.*?)\}', ' $1');

% code refences
% document = regexprep(document, '\\Coderef\{..\:([^\:\}]*)\}', '`$1`');
% find all coderefences
references = regexp(document, '\\Coderef\{..\:([^\:\}]*)\}', 'tokens', 'all');
document = regexprep(document, '\\Coderef\{..\:([^\:\}]*)\}', '<refgoeshere>**!'); % put mark
for i = 1:length(references)
    index_ref = regexp(document, '<refgoeshere>\*\*\!', 'all');
    tmp_ref = references{i}{1};
    pattern = ['cd:' tmp_ref ',\s*caption\=\{\s*\{\\bf\s(.*?)\}'];
    tmp_finding_ref= regexp(document, pattern, 'tokens', 'once');
    if ~isempty(tmp_finding_ref)
        tmp_finding_ref = tmp_finding_ref{1}(1:end-1);
    else
        tmp_finding_ref = tmp_ref;
    end
    section_title = strtrim(tmp_finding_ref);
    % insert into document
    document = insertBefore(document, index_ref(i),  section_title);
end
document = regexprep(document, '<refgoeshere>\*\*\!', ''); % remove mark

% enumerate
enumerate_objs = regexp(document, '\\begin\{enumerate\}(.*?)\\end\{enumerate\}', 'tokens', 'all');
document = regexprep(document, '\\begin\{enumerate\}(.*?)\\end\{enumerate\}', '<enumerategoeshere>**!'); % put mark
document = regexprep(document, '\\begin\{enumerate\}', '');
document = regexprep(document, '\\end\{enumerate\}', '');
patternItem = '\\item\s+([^\\]*)';
for i = 1:length(enumerate_objs)
    index_enumerate = regexp(document, '<enumerategoeshere>\*\*\!', 'all');
    tmp_obj = enumerate_objs{i};
    % put a 1 at the beginning of each line
    tmp_obj = regexprep(tmp_obj, char(9), '');
    tmp_ind = regexp(tmp_obj{1}, '\\item', 'all');
    acumulated_tmp = 0;
    for j = 1:length(tmp_ind)
        infotmp = [num2str(j) '. '];
        tmp_obj = insertBefore(tmp_obj, tmp_ind(j)  + acumulated_tmp, infotmp);
        acumulated_tmp = acumulated_tmp + length(infotmp);
    end
    % modify the item
    findItem = regexp(tmp_obj, patternItem, 'tokens', 'all');
    for k = 1:length(findItem{1})
        finding = findItem{1}{k};
        tmp_obj = regexprep(tmp_obj, patternItem, strtrim(finding{1}), 'once');
    end

    % insert into document
    document = insertBefore(document, index_enumerate(i) - 1,  tmp_obj{1}(1:end-3));
end
document = regexprep(document, '<enumerategoeshere>\*\*\!', ''); % remove mark

% figrefs
figrefs1 = regexp(document, '\\Figref\{fig:([^:\}]*)\}', 'tokens', 'all');
for i = 1:length(figrefs1)
    document = regexprep(document, '\\Figref\{fig:([^:\}]*)\}', ['Figure ' num2str(str2double(figrefs1{i}{1}))], 'once');
end
figrefs2 = regexp(document, '\\Figsref\{fig:([^:\}]*)\}', 'tokens', 'all');
for i = 1:length(figrefs2)
   document = regexprep(document, '\\Figsref\{fig:([^:\}]*)\}', ['Figures ' num2str(str2double(figrefs2{i}{1}))], 'once');
end

% change includegraphics
includegraphpatter = '\\includegraphics(?:\[height=10cm\])?\{([^{}]*)}';
document = regexprep(document, includegraphpatter, '!*$1!*');

% figures
document = regexprep(document, '\{\\bf\s(.*?)\}', '**$1**');
pattern = '\\fig\{[^}]+\}\s*\{([^}]+)\}\s*\{(?:\s*\[h!\]\s*)?(?:\s*\[b!\]\s*)?([^{}]*)\}(?:\s*)?\s*\{([^{}]*)\}\s*\{\s*([^{}]*)\}';
figPattern = '\#\!FIG(..)(?:s)?(.*?)\n';
newFigMods =  regexp(document, figPattern, 'tokens', 'all');
findings = regexp(document, pattern, 'tokens', 'all');
document = regexprep(document, pattern, '', 'all');
for i = 1:length(findings)
    % find marks index and remove them
    finding = findings{i};
    newPos = regexp(document, figPattern, 'once');
    document = regexprep(document, figPattern, '', 'once');

    % replace old info with new way in new position
    figNameTMP = finding{2};
    figTitle = finding{3};

    % check if multi figure
    fig_tokens = regexp(figNameTMP, '\!\*([^\*\!]*)\!\*', 'tokens', 'all');
    tagSize_tmp = 1;
    for j = 1:length(fig_tokens)
        figName = fig_tokens{j}{1};
        if ~isempty(newFigMods) && length(newFigMods{i}{2}) > 1
            figSizeMod = strtrim(newFigMods{i}{2});
            newFormat = [newline() '<img src="' figName '" alt="' figTitle ' " height="' figSizeMod '">'];
        else
            newFormat = [newline() '<img src="' figName '" alt="' figTitle '">'];
        end

        
        document = insertBefore(document, newPos - 2 + tagSize_tmp,  newFormat);

        % insert fig explanation
        tagSize = length(newFormat);
        tagSize_tmp = tagSize_tmp + tagSize;        
    end  

    document = insertBefore(document, newPos - 2 + tagSize_tmp,  [newline() newline() '> **Figure '  num2str(str2double(newFigMods{i}{1})) '. ' finding{3} '**' newline() '> ' finding{end} newline()]);
end

% itemize
% document = regexprep(document, '\\begin\{itemize\}', '');
% document = regexprep(document, '\\end\{itemize\}', '');
tmp_itemizes = regexp(document, '\\begin{itemize}(.*?)\\end\{itemize\}', 'tokens', 'all'); % hold it
document = regexprep(document, '\\begin{itemize}(.*?)\\end\{itemize\}', '<itemizegoeshere>**!'); % put mark
pattern = '\\item\s+([^\\]*)';
for i = 1:length(tmp_itemizes)
    % get index
    index_itemize = regexp(document, '\<itemizegoeshere>\*\*\!', 'all');
    tmp_itemize = tmp_itemizes{i};

    % go through each item
    tmp_items = regexp(strtrim(tmp_itemize{1}), pattern, 'tokens', 'all');
    hold_this_paragraph = '';
    for j = 1:length(tmp_items)
        tmp_item = tmp_items{j};
        hold_this_line = ['- ' strtrim(tmp_item{1}) char(13) newline()];
        hold_this_paragraph = [hold_this_paragraph  hold_this_line]; %#ok<AGROW> 
    end
    document = insertBefore(document, index_itemize(i) - 1,  hold_this_paragraph);

end
document = regexprep(document, '<itemizegoeshere>\*\*\!', ''); % remove mark

% for non itemize items
findings = regexp(document, pattern, 'tokens', 'all');
for j = 1:length(findings)
    finding = findings{j};
    document = regexprep(document, pattern, ['- ' strtrim(finding{1}) char(13) newline()], 'once');
end

% item
document = regexprep(document, '\\item\[\\code\{([^\{\}]*)\}\]\s*(.*?)\n', '> `$1` $2');
document = regexprep(document, '\\item\[([^\[\]]*)\]', '> $1');
document = regexprep(document, '\-\s\[\`([^\[\]]*)\`\]', '> - `$1`');

% tcolorbox
tmp_tcolorbox = regexp(document, '\\begin{tcolorbox}(.*?)\\end\{tcolorbox\}', 'tokens', 'all'); % hold it
document = regexprep(document, '\\begin{tcolorbox}(.*?)\\end\{tcolorbox\}', '<tcolorboxgoeshere>**!'); % put mark
pattern = '\[\s*title=([^=\]]*)\]([^\]\\]*)(.*)(?:\>*)?(?:\}*)?';
pattern2 = '\]\s*(?:\>*)?\s*(?:\>*)?\s*([^\]\\]*)(?:\\*)?';
pattern3= '(.*?)\n';
pattern4 = '\\begin{description}(.*?)\\end\{description\}';
pattern5 = 'title=([^=\]]*)';
nl = 2;
matlab_lang_tag = ['> ```matlab' newline()];
mat_length = length(matlab_lang_tag);
for i = 1:length(tmp_tcolorbox)
    % get index
    index_tcolorbox = regexp(document, '\<tcolorboxgoeshere>\*\*\!', 'all');
    % optional for developer
    tmp_description = regexp(tmp_tcolorbox{i}, pattern4, 'tokens', 'once');
  
    if ~isempty(tmp_description) && ~isempty(tmp_description{1})
        % get sections
%         tmp_finding = regexp(tmp_tcolorbox{i}{1}, pattern5, 'tokens', 'once');
        % remove description
        section_title = regexp(tmp_tcolorbox{i}{1}, pattern5, 'tokens', 'once');
        section_title =  ['> **' strtrim(section_title{1}) '**'];
        section_explanation = [newline() ' ' strtrim(tmp_description{1}{1})];
        section_explanation = regexprep(section_explanation, char(9), ''); % remove tabs
        section_explanation = regexprep(section_explanation, [newline() '\s*' newline() '\s*'], [newline() '>' newline()]); % remove tabs
        tmp_finding{1}{1} = section_title;
        tmp_finding{1}{2} = section_explanation;
    else
        % get sections
        tmp_finding = regexp(tmp_tcolorbox{i}, pattern, 'tokens', 'once');
        tmp_finding{1}{2} = regexprep(tmp_finding{1}{2}, '\\begin\{description\}', '> ');
        tmp_finding{1}{2} = regexprep(tmp_finding{1}{2}, '\\end\{description\}', '> ');

        section_title =  ['> **' strtrim(tmp_finding{1}{1}) '**'];
        section_explanation = [newline() ' ' strtrim(tmp_finding{1}{2})];
        section_explanation = regexprep(section_explanation, char(9), ''); % remove tabs
        section_explanation = regexprep(section_explanation, [newline() '\s*' newline() '\s*'], [newline() '>' newline()]); % remove tabs
    end

    % insert into document
    document = insertBefore(document, index_tcolorbox(i) - nl,  section_title);
    document = insertBefore(document, index_tcolorbox(i) - nl + length(section_title),  [section_explanation ' ' newline()]);
    % code
    if length(tmp_finding{1}) >2 && ~isempty(tmp_finding{1}{3})
        section_code = regexp(tmp_finding{1}{3}, pattern2, 'tokens', 'once');
        init_position_code = index_tcolorbox(i) - nl + length(section_title) + length(section_explanation) + 2; % +2, because im adding a newline and a ' '
        % indicate it is matlab language
        document = insertBefore(document, init_position_code,  matlab_lang_tag);
        init_position_code = init_position_code + mat_length;
        code_split = regexp(section_code{1}, pattern3, 'tokens', 'all');
        accumulated_length = 0;
        for j = 1:length(code_split)
            line_of_code = code_split{j};
            line_of_code_with_modifier = ['> ' line_of_code{1} newline()];
            line_of_code_position = init_position_code + accumulated_length;
            document = insertBefore(document, line_of_code_position,  line_of_code_with_modifier);
            accumulated_length = accumulated_length + length(line_of_code_with_modifier);
        end
        document = insertBefore(document, init_position_code+accumulated_length,  ['> ```' newline()]);
    end
end
document = regexprep(document, '<tcolorboxgoeshere>\*\*\!', ''); % remove mark
document = regexprep(document,'\%\:', '>');

% lstlisting
tmp_lstlisting = regexp(document, '\\begin{lstlisting}(.*?)\\end\{lstlisting\}', 'tokens', 'all'); % hold it
document = regexprep(document, '\\begin{lstlisting}(.*?)\\end\{lstlisting\}', '<lstlistinggoeshere>**!'); % put mark
document = regexprep(document, '\%', ''); % put mark
pattern = 'caption\=\{(.*?)\}(.*?)\](.*)';
patternOR = '\¥\\circled\{([^{}]*)\}(.*?)\¥';
patternOR2 = '\\threecirclednotes\{([^{}]*)\}\{([^{}]*)\}\{([^{}]*)\}\{([^{}]*)\}|\\twocirclednotes\{([^{}]*)\}\{([^{}]*)\}\{([^{}]*)\}|\\circlednote\{([^{}]*)\}\{([^{}]*)\}';
unicode_circled = 9311; % utf 16
for i = 1:length(tmp_lstlisting)
    %
    index_lstlisting = regexp(document, '\<lstlistinggoeshere>\*\*\!', 'all');

    % find circlenotes and replace them with anotations
    tmp_circlenotes = regexp(tmp_lstlisting{i}, patternOR, 'tokens', 'all');
    tmp_circlenotes = tmp_circlenotes{1};

    tmp_circlexp = regexp(tmp_lstlisting{i}, patternOR2, 'tokens', 'all');
    tmp_circlexp = tmp_circlexp{1};

    % put the markings
    for j = 1:length(tmp_circlenotes)
        % get the item
        tmp_marking = tmp_circlenotes{j};
        tmp_lstlisting{i} = regexprep(tmp_lstlisting{i}, patternOR, [char(unicode_circled+str2double(tmp_marking{1}))], 'once');
    end

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
    code_with_no_notes = ['> ' codeSection newline()];
    code_length = length(code_with_no_notes);

    % insert into document
    document = insertBefore(document, index_lstlisting(i) - nl,  section_title);
    document = insertBefore(document, index_lstlisting(i) - nl + explanation_length,  matlab_lang_tag);
    document = insertBefore(document, index_lstlisting(i) - nl + mat_length + explanation_length, code_with_no_notes);

    % insert circlenotes info
    acumulated = 0;
    if ~isempty(tmp_circlexp) && ~isempty(tmp_circlexp{1})
        for j = 1:length(tmp_circlexp)
            tmp_circlexp_note = tmp_circlexp{j};

            % cases
            if length(tmp_circlexp_note) == 4 % case 4
                note = ['> ' char(unicode_circled+str2double(tmp_circlexp_note{1})) ' ' char(unicode_circled+str2double(tmp_circlexp_note{2})) ' ' char(unicode_circled+str2double(tmp_circlexp_note{3})) ' ' tmp_circlexp_note{end} char(13) newline() '>' newline()];
            elseif length(tmp_circlexp_note) == 3  % case 3
                note = ['> ' char(unicode_circled+str2double(tmp_circlexp_note{1})) ' ' char(unicode_circled+str2double(tmp_circlexp_note{2})) ' ' tmp_circlexp_note{end} char(13) newline() '>' newline()];
            else % case 2
                note = ['> ' char(unicode_circled+str2double(tmp_circlexp_note{1})) ' ' tmp_circlexp_note{end} char(13) newline() '>' newline()];
            end
            
            tmp_position = index_lstlisting(i) - nl + explanation_length + mat_length + code_length + acumulated;
            if j == 1
                document = insertBefore(document, tmp_position,  newline());
                tmp_position = tmp_position + 1;
                acumulated = acumulated + 1;
            end
            document = insertBefore(document, tmp_position,  note);
            acumulated = acumulated + length(note);
        end
    end
end
document = regexprep(document, '<lstlistinggoeshere>\*\*\!', ''); % remove mark
document = regexprep(document, '\¥', '');
document = regexprep(document, '\€', '');
document = regexprep(document, '\¤', '');

% txt or xls
document = regexprep(document, '\(\\fn\{\*\.txt\}\)', '(.txt)');
document = regexprep(document, '\(\\fn\{\*\.xls\}\)', '(.xls)');
document = regexprep(document, '\(\\fn\{\*\.xlsx\}\)', '(.xlsx)');
document = regexprep(document, '\(\\fn\{..xls\} or \\fn\{..xlsx\}\)', '(.xls or .xlsx)');

% references
document = regexprep(document,  ['\$([^\$\^]*)\^\{(?:\^\{)?(?:' char(13) char(10) ')?\\rm\s*([^\s*\}]*)\}\$'], '$1 $2');
document = regexprep(document, '\\fn\{([^\{\}]*)\}', '"$1"');

% web
document = regexprep(document, '\(\\url\{(.*?)\}\)', '');

% extra
document = regexprep(document, '\s*\\', '');
document = regexprep(document, '\`bf\s*', '\`');
document = regexprep(document,'bibliography(.*?)\}', '');
document = regexprep(document,'\$\&\$', '&');
% document = regexprep(document, [newline() '\s*' newline() '\s*' newline()], newline());
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
writelines(readme, readme_file)