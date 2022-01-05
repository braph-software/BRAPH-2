%% ¡header!
PPPipeline_PSDict < PlotProp (pl, pipeline plot) is a plot of a pipeline.

%%% ¡description!
PPPipeline_PCDict plots a pipeline allowing the user to execute it in the correct order.
   
%%% ¡seealso!
Pipeline, PlotProp

%% ¡properties!
p
ps_panels % list of section panels
pc_btns % 2D cell array of code buttons
pc_GUIs % 2D cell array of GUIs

%% ¡methods!
function h_panel = draw(pr, varargin)
    %DRAW draws the pipeline panel.
    %
    % DRAW(PR) draws the pipeline panel.
    %
    % H = DRAW(PR) returns a handle to the property panel.
    %
    % DRAW(PR, 'Property', VALUE, ...) sets the properties of the graphical
    %  panel with custom Name-Value pairs.
    %  All standard plot properties of uipanel can be used.
    %
    % It is possible to access the properties of the various graphical
    %  objects from the handle H of the panel.
    %
    % See also update, redraw, refresh, uipanel.

    pr.p = draw@PlotProp(pr, 'DeleteFcn', {@close_GUIs}, varargin{:});
    function close_GUIs(~, ~)
        for i = 1:1:length(pr.pc_GUIs)
            for j = 1:1:length(pr.pc_GUIs{i})
                delete(pr.pc_GUIs{i}{j})
            end
        end
    end

    % deletes all graphic objects
    % panels and btns
    if ~isempty(pr.ps_panels)
        cellfun(@(panel) delete(panel), pr.ps_panels)
        pr.ps_panels = {};
        pr.pc_btns = {}; % deleted through panels
    end
    % GUIs
    if ~isempty(pr.pc_GUIs)
        close_GUIs()
        pr.pc_GUIs = {};
    end
    
    pip = pr.get('EL');

    % the checks on the existence of the panels and btns are not necessary
    % because they have been deleted at the beginning of the script
    ps_dict = pip.get('PS_DICT');
    for s = 1:1:ps_dict.length()
        ps = ps_dict.getItem(s);

        % if length(pl.ps_panels) < s || isempty(pl.ps_panels{s}) || ~isgraphics(pl.ps_panels{s}, 'uipanel')
            pr.ps_panels{s} = uipanel( ...
                'Parent', pr.p, ...
                'Title', [ps.get('ID') '. ' ps.get('LABEL')], ...
                'Tooltip', ps.get('NOTES'), ...
                'FontUnits', BRAPH2.FONTUNITS, ...
                'FontSize', BRAPH2.FONTSIZE, ...
                'BorderType', 'none' ...
                );

            pc_dict = ps.get('PC_DICT');
            for c = 1:1:pc_dict.length()
                pc = pc_dict.getItem(c);

                % if length(pl.pc_btns) < s || length(pl.pc_btns{s}) < c || isempty(pl.pc_btns{s}{c}) || ~isgraphics(pl.pc_btns{s}{c}, 'uicontrol') || ~strcmpi(get(pl.pc_btns{s}{c}, 'Style'), 'pushbutton')
                    pr.pc_btns{s}{c} = uicontrol( ...
                        'Style', 'pushbutton', ...
                        'Parent', pr.ps_panels{s}, ...
                        'Tooltip', pc.get('NOTES'), ...
                        'Enable', 'off', ...
                        'String', pc.get('TEXT_BEFORE_EXEC'), ...
                        'FontAngle', 'italic', ...
                        'FontUnits', BRAPH2.FONTUNITS, ...
                        'FontSize', BRAPH2.FONTSIZE, ...
                        'UserData', [s c], ...
                        'Callback', {@cb_pc_btn} ...
                        );
                % end
            end
        % end
    end
    
    % callback
    function cb_pc_btn(src, ~)
        userdata = get(src, 'UserData');
        s = userdata(1);
        c = userdata(2);
        
        pr.update('Section', s, 'Code', c)
    end
    
    if nargout > 0
        h_panel = pr.p;
    end
end
function update(pr, varargin)
    %UPDATE updates the content and permissions of the pushbutton.
    %
    % UPDATE(PR) updates the content and permissions of the pushbutton.
    %
    % See also draw, redraw, refresh, PlotElement.

    s_selected = get_from_varargin(0, 'Section', varargin); % selected section
    c_selected = get_from_varargin(0, 'Code', varargin); % selected code
    
    update@PlotProp(pr)
    
    pip = pr.get('EL');

    s_to_be_calculated = 1;
    s_dict = pip.get('PS_DICT');
    for s = 1:1:s_dict.length()
        section = s_dict.getItem(s);
        
        code_dict = section.get('PC_DICT');
        for c = 1:1:code_dict.length()
            code = code_dict.getItem(c);
            moniker = code.get('MONIKER');
% FIXME send error if moniker equal to some variables 

            % callback code
            if s == s_selected && c == c_selected
                if isa(code.getr('EL'), 'NoValue') % the code has not been calculated yet -- CALCULATE
                    codeline = [moniker ' = ' code.get('CODE')];
                    try
                        set(pr.pc_btns{s}{c}, ...
                            'Enable', 'off' ...
                            )
                            
                        eval(codeline)
                        code.set('EL', eval([moniker ';']))
                    catch e
                        set(pr.pc_btns{s}{c}, ...
                            'Enable', 'on' ...
                            )

                        if ~strcmp(e.message, BRAPH2.IM_ERR)
                            warndlg(['An error occurred while trying to execute the code:' newline() ...
                                newline() ...
                                codeline newline() ...
                                newline() ...
                                'Error message:' newline() ...
                                newline() ...
                                e.message newline()], 'Warning');
                        end
                    end
                else % the code has already been calculated -- GUI
                    if length(pr.pc_GUIs) < s || length(pr.pc_GUIs{s}) < c || ~check_graphics(pr.pc_GUIs{s}{c}, 'figure')
                        f_pip = ancestor(pr.p, 'Figure'); % Pipeline GUI

                        pr.pc_GUIs{s}{c} = GUI( ...
                            'PE', code.get('EL'), ...
                            'Position', [ ...
                                Plot.x0(f_pip, 'normalized') + .20 ...
                                Plot.y0(f_pip, 'normalized') ...
                                .20 ...
                                Plot.h(f_pip, 'normalized') ...
                                ] ...
                            ).draw();
                    else
                        figure(pr.pc_GUIs{s}{c})
% FIXME ensure that all subfigures are brought to front
                    end
                end
            end

            % If a code has already been executed and the relative element exists, 
            % 1. loads the calculated element to the workspace
            % 2. updates the ID in the btn
            % 3. calculates whether to move to the next section
            if ~isa(code.getr('EL'), 'NoValue')
                eval([moniker ' = code.get(''EL'');'])

                set(pr.pc_btns{s}{c}, ...
                    'Enable', 'on', ...
                    'String', [code.get('TEXT_AFTER_EXEC') ' / ' code.get('EL').get('ID')], ...
                    'FontAngle', 'normal', ...
                    'FontWeight', 'normal' ...
                    )

                % if all section codes calculated, updates the section to be calculated
                if all(cellfun(@(pc) ~isa(pc.getr('EL'), 'NoValue'), code_dict.getItems()))
                    s_to_be_calculated = s + 1;
                end
            end
            
            % activates the next section that can be calculated
            % (only the codes that have not been calculated yet)
            if s == s_to_be_calculated && isa(code.getr('EL'), 'NoValue')
                set(pr.pc_btns{s}{c}, ...
                    'Enable', 'on', ...
                    'FontAngle', 'normal', ...
                    'FontWeight', 'bold' ...
                    )
            end            
        end
    end
end
function redraw(pr, varargin)
    %REDRAW resizes the property panel and repositions its graphical objects.
    %
    % REDRAW(PR) resizes the property panel and repositions its
    %   graphical objects. 
    % 
    % Important notes:
    % 1. REDRAW() sets the units 'characters' for panel and all its graphical objects. 
    % 2. REDRAW() is typically called internally by PlotElement and does not need 
    %  to be explicitly called in children of PlotProp.
    %
    % REDRAW(PR, 'X0', X0, 'Y0', Y0, 'Width', WIDTH, 'Height', HEIGHT)
    %  repositions the property panel. It is possible to use a
    %  subset of the Name-Value pairs.
    %  By default:
    %  - X0 does not change
    %  - Y0 does not change
    %  - WIDTH does not change
    %  - HEIGHT=3.33 characters.
    %
    % See also draw, update, refresh, PlotElement.
    
    pip = pr.get('EL');
    ps_dict = pip.get('PS_DICT');
        
    ps_number = ps_dict.length();
    pc_numbers = cellfun(@(ps) ps.get('PC_DICT').length(), ps_dict.getItems());
    
    h_min = 2;  % default (minumum) height
    h_ps_header = .5; % height section header
    h_pc = 2.5; % height code button
    h_ps_footer = .5; % height section footer
    h_ps_margin = .5; % height section margin
    h = h_min + (h_ps_margin + h_ps_header + h_ps_footer) * ps_number + h_pc * sum(pc_numbers);
    pr.redraw@PlotProp('Height', h, varargin{:})

    for s = 1:1:ps_number
        ps_y = h_ps_header * (ps_number - s) ...
            + h_pc * sum(pc_numbers(s+1:end)) ...
            + h_ps_footer * (ps_number - s) ...
            + h_ps_margin * (ps_number - s + 1);
        ps_h = h_ps_header + h_pc * pc_numbers(s) + h_ps_footer;
        
        set(pr.ps_panels{s}, ...
            'Units', 'normalized', ...
            'Position', [.02 ps_y/h .96 ps_h/h] ...
            )
        
        for c = 1:1:pc_numbers(s)
            set(pr.pc_btns{s}{c}, ...
                'Units', 'normalized', ...
                'Position', [.02 (h_ps_footer+(pc_numbers(s) - c)*h_pc)/ps_h .96 h_pc/ps_h] ...
                )
        end
    end
end