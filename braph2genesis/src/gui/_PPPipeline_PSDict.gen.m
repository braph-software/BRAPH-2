%% ¡header!
PPPipeline_PSDict < PanelProp (pr, pipeline plot) plots the panel for a pipeline.

%%% ¡description!
% % % PPPipeline_PCDict plots a pipeline allowing the user to execute it in the correct order.
% % % 
% % % CALLBACKS - These are callback functions:
% % % 
% % %     pr.<strong>cb_bring_to_front</strong>() - brings to the front the pipeline figure
% % %     pr.<strong>cb_hide</strong>() - hides the pipeline figure and all dependent figures
% % %     pr.<strong>cb_close</strong>() - closes the pipeline figure and all dependent figures

%%% ¡seealso!
Pipeline, PanelProp

%% ¡properties!
p
ps_panels % list of section panels
pc_btns % 2D cell array of code buttons
pc_GUIs % 2D cell array of GUIs

%% ¡methods!
function p_out = draw(pr, varargin)
    %DRAW draws the pipeline panel.
    %
    % DRAW(PR) draws the pipeline panel.
    %
    % P = DRAW(PR) returns a handle to the property panel.
    %
    % DRAW(PR, 'Property', VALUE, ...) sets the properties of the graphical
    %  panel with custom Name-Value pairs.
    %  All standard plot properties of uipanel can be used.
    %
    % It is possible to access the properties of the various graphical
    %  objects from the handle P of the panel.
    %
    % See also update, redraw, uipanel.

    pr.p = draw@PanelProp(pr, 'DeleteFcn', {@close_GUIs}, varargin{:});
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
                'FontSize', BRAPH2.FONTSIZE, ...
                'BorderType', 'none' ...
                );

            pc_dict = ps.get('PC_DICT');
            for c = 1:1:pc_dict.length()
                pc = pc_dict.getItem(c);

                % if length(pl.pc_btns) < s || length(pl.pc_btns{s}) < c || isempty(pl.pc_btns{s}{c}) || ~isgraphics(pl.pc_btns{s}{c}, 'uicontrol') || ~strcmpi(get(pl.pc_btns{s}{c}, 'Style'), 'pushbutton')
                    pr.pc_btns{s}{c} = uibutton( ...
                        'Parent', pr.ps_panels{s}, ...
                        'Tooltip', pc.get('NOTES'), ...
                        'Enable', 'off', ...
                        'Text', pc.get('TEXT_BEFORE_EXEC'), ...
                        'FontAngle', 'italic', ...
                        'FontSize', BRAPH2.FONTSIZE, ...
                        'UserData', [s c], ...
                        'ButtonPushedFcn', {@cb_pc_btn} ...
                        );
                % end
            end
        % end
    end
    
    % callback
    function cb_pc_btn(src, ~)
        persistent time
        if isempty(time)
            time = 0;
        end
        if now - time > 1.0 / (24 * 60 * 60)
            time = now;
            set(src, 'Enable', 'off')
            %%% start callback %%%

            userdata = get(src, 'UserData');
            s = userdata(1);
            c = userdata(2);

            pr.update('Section', s, 'Code', c)

            %%% end callback %%%
            set(src, 'Enable', 'on')
        end
    end
    
    if nargout > 0
        p_out = pr.p;
    end
end
function update(pr, varargin)
    %UPDATE updates the content and permissions.
    %
    % UPDATE(PR) updates the content and permissions.
    %
    % See also draw, redraw, PlotElement.

    s_selected = get_from_varargin(0, 'Section', varargin); % selected section
    c_selected = get_from_varargin(0, 'Code', varargin); % selected code
    
    update@PanelProp(pr)
    
    pip = pr.get('EL');

    to_be_executed = {};
    
    s_to_be_calculated = 1;
    s_dict = pip.get('PS_DICT');
    for s = 1:1:s_dict.length()
        section = s_dict.getItem(s);
        
        code_dict = section.get('PC_DICT');
        for c = 1:1:code_dict.length()
            code = code_dict.getItem(c);
            moniker = code.get('MONIKER'); % FIXME send error if moniker equal to varargin

            % callback code
            if s == s_selected && c == c_selected
                if isa(code.getr('EL'), 'NoValue') % the code has not been calculated yet -- CALCULATE
                    try
                        set(pr.pc_btns{s}{c}, ...
                            'Enable', 'off' ...
                            )
                        pr.x_update(to_be_executed{:}, ...
                            {moniker, code, [moniker ' = ' code.get('CODE') ';']}, ... % varargin{1}{2} = code
                            {moniker, code, ['varargin{1}{2}.set(''EL'', ' moniker ');']}) % varargin{1}{2} = code
                    catch e
                        set(pr.pc_btns{s}{c}, ...
                            'Enable', 'on' ...
                            )

                        if ~strcmp(e.message, [BRAPH2.STR ':PPPipeline_PSDict: ' BRAPH2.BUG_IO])
                            warndlg(['An error occurred while trying to execute the code:' newline() ...
                                newline() ...
                                moniker ' = ' code.get('CODE') ';' newline() ...
                                newline() ...
                                'Error message:' newline() ...
                                newline() ...
                                e.message newline()], 'Warning');
                        end
                    end
                end
                    
                if ~isa(code.getr('EL'), 'NoValue') % the code has already been calculated -- GUI
                    if length(pr.pc_GUIs) < s || length(pr.pc_GUIs{s}) < c || ~check_graphics(pr.pc_GUIs{s}{c}, 'figure')
                        f_pip = ancestor(pr.p, 'Figure'); % Pipeline GUI

                        pr.pc_GUIs{s}{c} = GUIElement( ...
                            'PE', code.get('EL'), ...
                            'Position', [ ...
                                x0(f_pip, 'normalized') + .20 ...
                                y0(f_pip, 'normalized') ...
                                .20 ...
                                h(f_pip, 'normalized') ...
                                ], ...
                                'CLOSEREQ', false ...
                            ).draw();
                    else
                        gui = get(pr.pc_GUIs{s}{c}, 'UserData');
                        if get(pr.pc_GUIs{s}{c}, 'Visible')
                            gui.cb_hide()
                        else
                            gui.cb_bring_to_front()
                        end
                    end
                end
            end

            % If a code has already been executed and the relative element exists, 
            % 1. loads the calculated element to the workspace
            % 2. updates the ID in the btn
            % 3. calculates whether to move to the next section
            if ~isa(code.getr('EL'), 'NoValue')
                to_be_executed = {to_be_executed{:}, {moniker, code, [moniker ' = varargin{1}{2}.get(''EL'');']}}; % varargin{1}{2} = code

                set(pr.pc_btns{s}{c}, ...
                    'Enable', 'on', ...
                    'Text', [code.get('TEXT_AFTER_EXEC') ' / ' code.get('EL').get('ID')], ...
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
function x_update(varargin)
    %X_UPDATE internal function - do NOT use.

    % Safe environment to evaluate the codes of the pipeline
    % varargin consists of cell arrays with triplets:
    %  varargin{n} = {moniker, code, codeline}

    varargin = varargin(2:end); % eliminates pr from varargin
    
    while ~isempty(varargin)
        eval(varargin{1}{3})
        varargin = varargin(2:end);
    end
end
function redraw(pr, varargin)
    %REDRAW resizes the property panel and repositions its graphical objects.
    %
    % REDRAW(PR) resizes the property panel and repositions its
    %   graphical objects. 
    % 
    % Important notes:
    % 1. REDRAW() sets the units 'pixels' for panel. 
    % 2. REDRAW() is typically called internally by PlotElement and does not need 
    %  to be explicitly called in children of PanelProp.
    %
    % The dimensions of this panel are set automatically.
    %
    % See also draw, update, PlotElement.
    
    pip = pr.get('EL');
    ps_dict = pip.get('PS_DICT');
        
    ps_number = ps_dict.length();
    pc_numbers = cellfun(@(ps) ps.get('PC_DICT').length(), ps_dict.getItems());
    
    h_min = ceil(2 * BRAPH2.FONTSIZE * BRAPH2.S);  % default (minumum) height
    h_ps_header = ceil(2 * BRAPH2.FONTSIZE * BRAPH2.S); % height section header
    h_pc = ceil(2.5 * BRAPH2.FONTSIZE * BRAPH2.S); % height code button
    h_ps_footer = ceil(.5 * BRAPH2.FONTSIZE * BRAPH2.S); % height section footer
    h_ps_margin = ceil(.5 * BRAPH2.FONTSIZE * BRAPH2.S); % height section margin
    h_p = h_min + (h_ps_margin + h_ps_header + h_ps_footer) * ps_number + h_pc * sum(pc_numbers);
    pr.redraw@PanelProp('Height', h_p, varargin{:})

    s5 = ceil(5 * BRAPH2.S);
    for s = 1:1:ps_number
        ps_y = h_ps_header * (ps_number - s) ...
            + h_pc * sum(pc_numbers(s+1:end)) ...
            + h_ps_footer * (ps_number - s) ...
            + h_ps_margin * (ps_number - s + 1);
        ps_h = h_ps_header + h_pc * pc_numbers(s) + h_ps_footer;
        
        set(pr.ps_panels{s}, ...
            'Units', 'pixels', ...
            'Position', [ ...
                s5 ...
                ps_y ...
                w(pr.p, 'pixels')-s5-s5 ...
                ps_h ...
                ] ...
            )
        
        for c = 1:1:pc_numbers(s)
            set(pr.pc_btns{s}{c}, ...
                'Position', [ ...
                    s5 ...
                    (h_ps_footer+(pc_numbers(s) - c)*h_pc) ...
                    w(pr.ps_panels{s}, 'pixels')-s5-s5 ...
                    h_pc ...
                    ] ...
               )
        end
    end
end
function cb_bring_to_front(pr)
    %CB_BRING_TO_FRONT brings to the front the figure with the pipeline panel.
    %
    % CB_BRING_TO_FRONT(PR) brings to the front the figure with the pipeline panel 
    %  but not its dependent figures. 
    %
    % See also cb_hide, cb_close.

    pr.cb_bring_to_front@Plot()
    
    % code to bring to front the dependent figures, currently not in use
    % for i = 1:1:length(pr.pc_GUIs)
    %     for j = 1:1:length(pr.pc_GUIs{i})
    %         gui = get(pr.pc_GUIs{i}{j}, 'UserData');
    %         gui.cb_bring_to_front()
    %     end
    % end
end
function cb_hide(pr)
    %CB_HIDE hides the figure containing the pipeline panel and all dependent figures.
    %
    % CB_HIDE(PR) hides the figure containing the pipeline panel and all
    %  dependent figures. 
    %
    % See also cb_bring_to_front, cb_close.
    
    pr.cb_hide@PanelProp()
    
    for i = 1:1:length(pr.pc_GUIs)
        for j = 1:1:length(pr.pc_GUIs{i})
            gui = get(pr.pc_GUIs{i}{j}, 'UserData');
            gui.cb_hide()
        end
    end    
end
function cb_close(pr)
    %CB_CLOSE closes the figure containing the pipeline panel and all dependent figures.
    % 
    % CB_CLOSE(PR) closes the figure containing the pipeline panel and
    %  deletes all dependent figures. 
    %
    % See also cb_bring_to_front, cb_hide.

    pr.cb_close@PanelProp() % this triggers a call for the delete function defined in draw() that deletes the dependent figures
end
