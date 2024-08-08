clear all
tex_file = 'tut_ba.tex';
readme_file = 'readme.md';
% function generate_readme(tex_file, readme_file)
% 
% if nargin < 2
%     readme_file = 'readme.md';
% end

tex = fileread(tex_file);
 
%% Analysis

% title
title = regexp(tex, '\\title(?:(.*?))?{([^{}]*)}', 'tokens', 'once');
title = strtrim(title{1});

% document
document = regexp(tex, '\\begin{document}(.*)\\end{document}', 'tokens', 'once');
document = document{1};
document = regexprep(document, '\\maketitle', '');
document = regexprep(document, '\\noindent', '');
document = regexprep(document, '\\clearpage', '');
document = regexprep(document, '\\begin\{abstract\}', '');
document = regexprep(document, '\\end\{abstract\}', '');

% basic reformatting
document = regexprep(document, 'BRAPH~2', 'BRAPH 2');
document = regexprep(document, '---', '-');  % ---
document = regexprep(document, '\\\\\n', '\n');  % \\
document = regexprep(document, '{\\bf ([^{}]*)}', '**$1**');  % bold
document = regexprep(document, '\\fn{([^{}]*)}', '"$1"');  % \fn
document = regexprep(document, '\\code{([^{}]*)}', '`$1`');  % \code

% table of contents
sections = regexp(document, '\\(sub)?(sub)?section\{([^{}]*)\}', 'tokens', 'all');
toc = '## Table of Contents';
for i = 1:1:length(sections)
    section = sections{i};
    
    section_title = section{3};
    
    if section{2}  % subsubsection
        level = 3;
    elseif section{1}  % subsection
        level = 2;
    else  % section
        level = 1;
    end

    toc = [toc newline() repmat('>', 1, level) ' [' section_title '](#' regexprep(section_title, ' ', '-') ')' newline() repmat('>', 1, level)]; %#ok<AGROW> 
end
document = regexprep(document, '\\tableofcontents', toc);

% (sub)section
arrow_up_icon = char(11014);
document = regexprep(document, '\\section{([^{}]*)}', ['## $1  [' arrow_up_icon '](#Table-of-Contents)']);
document = regexprep(document, '\\subsection{([^{}]*)}',  ['### $1  [' arrow_up_icon '](#Table-of-Contents)']);
document = regexprep(document, '\\subsubsection{([^{}]*)}',  ['#### $1  [' arrow_up_icon '](#Table-of-Contents)']);

% itemize
document = regexprep(document, '\\begin{itemize}', '');
document = regexprep(document, '\\item ', '- ');
document = regexprep(document, '\\end{itemize}', '');

% figures
figures = regexp(document, '\\fig{(marginfigure|figure|figure\*)}\s*{([^{}]*)}\s*{[^{}]*\\includegraphics{([^{}]*)}[^{}]*}\s*{([^{}]*)}\s*{([^{}]*)}', 'tokens', 'all');
document = regexprep(document, '\\fig{(marginfigure|figure|figure\*)}\s*{([^{}]*)}\s*{[^{}]*\\includegraphics{([^{}]*)}[^{}]*}\s*{([^{}]*)}\s*{([^{}]*)}', '');

figs = regexp(document, '(%!FIG\d*) ?(\w*)', 'tokens', 'all');
assert(length(figures) == length(figs), 'The number of figures and %!FIG should be equal!')

for i = length(figures):-1:1
    figure = figures{i};
    figure_file = strtrim(figure{3});
    figure_title = strtrim(figure{4});
    figure_caption = strtrim(figure{5});

    if figs{i}{2}
        fig_img = ['<img src="' figure_file '" alt="' figure_title '" height="' figs{i}{2} '">'];
    else
        fig_img = ['<img src="' figure_file '" alt="' figure_title '">'];
    end
    document = regexprep(document, figs{i}{1}, [fig_img newline() strrep([newline() '**Figure ' int2str(i) '. ' figure_title '**' newline() figure_caption], newline(), [newline() '> '])]);

    figure_ref = strtrim(figure{2});
    document = regexprep(document, ['\\Figref{' figure_ref '}'], ['Figure ' int2str(i)]);
end

%% Generate README file
readme = [
    '# ' title newline() ...
    newline() ...
    '[![Tutorial ' title '](https://img.shields.io/badge/PDF-Download-red?style=flat-square&logo=adobe-acrobat-reader)](' tex_file(1:end-4) '.pdf)' newline() ...
    newline() ...
    strtrim(document)
    ];


%% Save readme
writelines(readme, readme_file)