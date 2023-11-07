clear all, clc

tex_file = 'tut_ba.tex';

tex = fileread(tex_file);

%% Analysis

% title
title = regexp(tex, '\\title{([^{}]*)}', 'tokens', 'once'); 
title = strtrim(title{1});

% document
document = regexp(tex, '\\begin{abstract}(.*)\\end{document}', 'tokens', 'once');
document = document{1};
document = regexprep(document, '\\maketitle', '');
document = regexprep(document, '\\noindent', '');
document = regexprep(document, '\\tableofcontents', '');
document = regexprep(document, '\\clearpage', '');
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
pattern = '\\fig\{[^}]+\}\s*\{([^}]+)\}\s*\{(?:\s*\[h!\]\s*)?(?:\s*\[b!\]\s*)?\\includegraphics(?:\[height=10cm\])?\{([^{}]*)}(?:\s*)?\}\s*\{([^{}]*)\}';
findings = regexp(document, pattern, 'tokens', 'all');
for i = 1:length(findings)
    finding = findings{i};
    document = regexprep(document, pattern, ['![' finding{3} '](' finding{2} ') \n '], 'once');
    document = regexprep(document, '{\\bf ([a-z])}', '**$1**');
end

pattern = '\(([^()]*)\)\s*\{\s*([^{}]*)\}';
findings = regexp(document, pattern, 'tokens', 'all');
for i = 1:length(findings)
    finding = findings{i};
    document = regexprep(document, pattern, ['(' finding{1} ') \n \> ' finding{2} '\n' ], 'once');
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

% listbox to code
tmp_listbox = regexp(document, '\\begin{tcolorbox}(.*)\\end{tcolorbox}', 'tokens', 'all'); % hold it
index_list = regexp(document, '\\begin{tcolorbox}(.*)\\end{tcolorbox}', 'all');
document = regexprep(document, '\\begin{tcolorbox}(.*)\\end{tcolorbox}', ''); % remove it

pattern = '\[\s*title=([^=\]]*)\]([^\]\\]*)(.*)\}';
pattern2 = '\}..\]..([^\]\\]*)\\';
for i = 1:length(tmp_listbox)
    % get sections
    tmp_finding = regexp(tmp_listbox{i}, pattern, 'tokens', 'once');

    % get code
    tmp_code = regexp(tmp_listbox{i}, pattern2, 'tokens', 'once');
    tmp_code_array = split(tmp_code{1}, ';');
    tmp_code_array = cellfun(@(x) strtrim(x), tmp_code_array, 'UniformOutput', false);
    
    final_code_string = '';
    for j = 1:length(tmp_code_array)
        final_code_string = [final_code_string '>' tmp_code_array{j} '\n']; %#ok<AGROW> 
    end

    final_tmp_string = ['> **' tmp_finding{1}{1} '**' '*\n> ' tmp_finding{1}{2}  final_code_string];
    
    % insert into document
    document = insertBefore(document, index_list(i),final_tmp_string);
   
end

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

writelines(readme, 'test_readme.md')
