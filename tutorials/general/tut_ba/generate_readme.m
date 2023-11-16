clear all, clc

tex_file = 'tut_ba.tex';

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
document = strtrim(document);

% basic reformatting
document = regexprep(document, 'BRAPH~2.0', 'BRAPH 2.0');
document = regexprep(document, '---', '-');
document = regexprep(document, '\\\\\n', '\n');

% (sub)section
document = regexprep(document, '\\section{([^{}]*)}', '## $1');
document = regexprep(document, '\\subsection{([^{}]*)}', '### $1');
document = regexprep(document, '\\subsubsection{([^{}]*)}', '#### $1');

% figures
document = regexprep(document, '{\\bf ([a-z])}', '**$1**');
pattern = '\\fig\{[^}]+\}\s*\{([^}]+)\}\s*\{(?:\s*\[h!\]\s*)?(?:\s*\[b!\]\s*)?\\includegraphics(?:\[height=10cm\])?\{([^{}]*)}(?:\s*)?\}\s*\{([^{}]*)\}';
findings = regexp(document, pattern, 'tokens', 'all');
for i = 1:length(findings)
    finding = findings{i};
    document = regexprep(document, pattern, ['![' finding{3} '](' finding{2} ')'], 'once');    
end

document = regexprep(document, '\\fn\{([^\{\}]*)\}', '"$1"');

pattern = '\!\[([^\[\]]*)\]\(([^()]*)\)\s*\{\s*([^{}]*)';
findings = regexp(document, pattern, 'tokens', 'all');
for i = 1:length(findings)
    finding = findings{i};
    fig_number = finding{2};
    document = regexprep(document, pattern, ['![' finding{1} '](' finding{2} ') \n \> **Figure ' fig_number(4:5) '. ' finding{1} '.** ' finding{3} ], 'once');
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

% tcolorbox
tmp_tcolorbox = regexp(document, '\\begin{tcolorbox}(.*?)\\end\{tcolorbox\}', 'tokens', 'all'); % hold it
index_tcolorbox = regexp(document, '\\begin{tcolorbox}(.*?)\\end\{tcolorbox\}', 'all');
document = regexprep(document, '\\begin{tcolorbox}(.*?)\\end\{tcolorbox\}', ''); % remove it
pattern = '\[\s*title=([^=\]]*)\]([^\]\\]*)(.*)\}';
pattern2 = '\}..\]..([^\]\\]*)\\';
pattern3= '(.*?)\n';
for i = 1:length(tmp_tcolorbox)
    % get sections
    tmp_finding = regexp(tmp_tcolorbox{i}, pattern, 'tokens', 'once');

    % get code
    section_code = regexp(tmp_tcolorbox{i}, pattern2, 'tokens', 'once');
    section_title =  ['> **' strtrim(tmp_finding{1}{1}) '**'];
    section_explanation = [ newline() '> ' strtrim(tmp_finding{1}{2})];
    % insert into document
    document = insertBefore(document, index_tcolorbox(i),  section_title);
    document = insertBefore(document, index_tcolorbox(i)+length(section_title),  [section_explanation ':' newline()]);
    % code
    init_position_code =index_tcolorbox(i)+length(section_title)+length(section_explanation)+2; % +2, because im adding a newline and a ':'
    % indicate it is matlab language
    matlab_lang_tag = ['> ```matlab' newline()];
    document = insertBefore(document, init_position_code,  matlab_lang_tag);
    init_position_code = init_position_code+length(matlab_lang_tag);
    code_split = regexp(section_code{1}{1}, pattern3, 'tokens', 'all');
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

document = regexprep(document, '\.\s*\}', '');
document = regexprep(document, '\\code\{([^=\}]*)\}', '`$1`');
document = regexprep(document, ['\`\`([^\`\`]*)\''' '\'''], '"$1"');

% txt or xls
document = regexprep(document, '\(\\fn\{\*\.txt\}\)', '(.txt)');
document = regexprep(document, '\(\\fn\{\*\.xls\}\)', '(.xls)');
document = regexprep(document, '\(\\fn\{\*\.xlsx\}\)', '(.xlsx)');
document = regexprep(document, '\(\\fn\{..xls\} or \\fn\{..xlsx\}\)', '(.xls or .xlsx)');

% references
document = regexprep(document, '\$([^\$\^]*)\^\{(?:\^\{)?\\rm\s*([^\s*\}]*)\}\$', '$1 $2');
document = regexprep(document, '\\Figref\{fig:([^:\}]*)\}', 'Figure $1');
document = regexprep(document, '\\fn\{([^\{\}]*)\}', '"$1"');
document = regexprep(document, '\{([^\{\}]*)\}', '`$1`');

% web
document = regexprep(document, '\(\\url\`.*\`\)', '');

% extra
document = regexprep(document, '\s*\\', '');
document = regexprep(document, '\`bf\s*', '');
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

% % trick to remove white space
% text = readlines('test_readme.md');
% output = cellfun(@(x) strtrim(x), text);
% writelines(output, 'test_readme.md');

