%% ¡header!
PPPipeline_PSDict < PlotProp (pl, pipeline plot) is a plot of a pipeline.

%%% ¡description!
PPPipeline_PCDict plots a pipeline allowing the user to execute it in the correct order.
   
%%% ¡seealso!
Pipeline, PlotProp

%% ¡properties!
pp
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

    pr.pp = draw@PlotProp(pr, 'DeleteFcn', {@close_GUIs}, varargin{:});
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
                'Parent', pr.pp, ...
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
        h_panel = pr.pp;
    end
end
function update(PR, varargin)
    %UPDATE updates the content and permissions of the pushbutton.
    %
    % UPDATE(PR) updates the content and permissions of the pushbutton.
    %
    % See also draw, redraw, refresh, PlotElement.

    % Important note: I use capitalized variables to avoid possible
    % conflicts with the pipeline monikers, which should be lowercase.
    % Possible errors might arise if upper-case monikers are used.
    
    S_selected = get_from_varargin(0, 'Section', varargin); % selected section
    C_selected = get_from_varargin(0, 'Code', varargin); % selected code
    
    update@PlotProp(PR)
    
    PIP = PR.get('EL');

    S_to_be_calculated = 1;
    S_dict = PIP.get('PS_DICT');
    for S = 1:1:S_dict.length()
        Section = S_dict.getItem(S);
        
        Code_dict = Section.get('PC_DICT');
        for C = 1:1:Code_dict.length()
            Code = Code_dict.getItem(C);
            Moniker = Code.get('MONIKER');
% FIXME send error if moniker equal to some variables 

            % callback code
            if S == S_selected && C == C_selected
                if isa(Code.getr('EL'), 'NoValue') % the code has not been calculated yet -- CALCULATE
                    Codeline = [Moniker ' = ' Code.get('CODE')];
                    try
                        set(PR.pc_btns{S}{C}, ...
                            'Enable', 'off' ...
                            )
                            
                        eval(Codeline)
                        Code.set('EL', eval([Moniker ';']))
                    catch e
                        set(PR.pc_btns{S}{C}, ...
                            'Enable', 'on' ...
                            )

                        if ~strcmp(e.message, BRAPH2.IM_ERR)
                            warndlg(['An error occurred while trying to execute the code:' newline() ...
                                newline() ...
                                Codeline newline() ...
                                newline() ...
                                'Error message:' newline() ...
                                newline() ...
                                e.message newline()], 'Warning');
                        end
                    end
                else % the code has already been calculated -- GUI
                    if length(PR.pc_GUIs) < S || length(PR.pc_GUIs{S}) < C || isempty(PR.pc_GUIs{S}{C}) || ~isgraphics(PR.pc_GUIs{S}{C}, 'figure')
                        Screen_pos = get(0,'screensize');  % pixels

                        F_pip = ancestor(PR.pp, 'Figure'); % Pipeline GUI
                        Backup_units = get(F_pip, 'Units');
                        set(F_pip, 'Units', 'pixels')
                        F_pip_pos = get(F_pip, 'Position'); % pixels
                        F_pip_x = F_pip_pos(1) / Screen_pos(3); % normalized
                        F_pip_y = F_pip_pos(2) / Screen_pos(4); % normalized
                        F_pip_w = F_pip_pos(3) / Screen_pos(3); % normalized
                        F_pip_h = F_pip_pos(4) / Screen_pos(4); % normalized
                        set(F_pip, 'Units', Backup_units);
                        
                        PR.pc_GUIs{S}{C} = GUI(Code.get('EL'), ...
                            'Position', [ ...
                                F_pip_x ...
                                F_pip_y ...
                                .20 ...
                                F_pip_h ...
                                ] ...
                            );
                    else
                        figure(PR.pc_GUIs{S}{C})
% FIXME ensure that all subfigures are brought to front
                    end
                end
            end

            % If a code has already been executed and the relative element exists, 
            % 1. loads the calculated element to the workspace
            % 2. updates the ID in the btn
            % 3. calculates whether to move to the next section
            if ~isa(Code.getr('EL'), 'NoValue')
                eval([Moniker ' = Code.get(''EL'');'])

                set(PR.pc_btns{S}{C}, ...
                    'Enable', 'on', ...
                    'String', [Code.get('TEXT_AFTER_EXEC') ' / ' Code.get('EL').get('ID')], ...
                    'FontAngle', 'normal', ...
                    'FontWeight', 'normal' ...
                    )

                % if all section codes calculated, updates the section to be calculated
                if all(cellfun(@(pc) ~isa(pc.getr('EL'), 'NoValue'), Code_dict.getItems()))
                    S_to_be_calculated = S + 1;
                end
            end
            
            % activates the next section that can be calculated
            % (only the codes that have not been calculated yet)
            if S == S_to_be_calculated && isa(Code.getr('EL'), 'NoValue')
                set(PR.pc_btns{S}{C}, ...
                    'Enable', 'on', ...
                    'FontAngle', 'normal', ...
                    'FontWeight', 'bold' ...
                    )
            end            
        end
    end
    
% % %     S_selected = get_from_varargin(0, 'Section', varargin); % selected section
% % %     C_selected = get_from_varargin(0, 'Code', varargin); % selected code
% % %     
% % %     update@PlotProp(PL)
% % %     
% % %     PIP = PL.get('EL');
% % % 
% % %     S_to_be_calculated = 1;
% % %     S_dict = PIP.get('PS_DICT');
% % %     for S = 1:1:S_dict.length()
% % %         Section = S_dict.getItem(S);
% % %         
% % %         Code_dict = Section.get('PC_DICT');
% % %         for C = 1:1:Code_dict.length()
% % %             Code = Code_dict.getItem(C);
% % %             Moniker = Code.get('MONIKER');
% % % 
% % % % FIXME send error if moniker equal to some variables 
% % % 
% % %             % If a code has already been executed and the relative element exists, 
% % %             % loads the calculated element to the workspace
% % %             % and update the ID in the btn
% % %             if ~isa(Code.getr('EL'), 'NoValue')
% % %                 eval([Moniker ' = Code.get(''EL'');'])
% % % %                 set(PL.pc_btns{S}{C}, ...
% % % %                     'String', [Code.get('TEXT_AFTER_EXEC') ' / ' Code.get('EL').get('ID')] ...
% % % %                     )
% % % set(PL.pc_btns{S}{C}, ...
% % %     'Enable', 'on', ...
% % %     'String', [Code.get('TEXT_AFTER_EXEC') ' / ' Code.get('EL').get('ID')], ...
% % %     'FontAngle', 'normal', ...
% % %     'FontWeight', 'normal' ...
% % %     )
% % % 
% % % % if all section codes calculated, updates the section to be calculated
% % % if all(cellfun(@(pc) ~isa(pc.getr('EL'), 'NoValue'), Code_dict.getItems()))
% % %     S_to_be_calculated = S + 1;
% % % end
% % %             end
% % %             
% % %             % activates the next section that can be calculated
% % %             % (only the codes that have not been calculated yet)
% % %             if S == S_to_be_calculated && isa(Code.getr('EL'), 'NoValue')
% % %                 set(PL.pc_btns{S}{C}, ...
% % %                     'Enable', 'on', ...
% % %                     'FontAngle', 'normal', ...
% % %                     'FontWeight', 'bold' ...
% % %                     )
% % %             end
% % %             
% % %             % callback code
% % %             if S == S_selected && C == C_selected
% % %                 if isa(Code.getr('EL'), 'NoValue') % the code has not been calculated yet -- CALCULATE
% % %                     Codeline = [Moniker ' = ' Code.get('CODE')];
% % %                     try
% % %                         set(PL.pc_btns{S}{C}, ...
% % %                             'Enable', 'off' ...
% % %                             )
% % %                             
% % %                         eval(Codeline)
% % %                         Code.set('EL', eval([Moniker ';']))
% % % 
% % %                         set(PL.pc_btns{S}{C}, ...
% % %                             'Enable', 'on', ...
% % %                             'String', [Code.get('TEXT_AFTER_EXEC') ' / ' Code.get('EL').get('ID')], ...
% % %                             'FontAngle', 'normal', ...
% % %                             'FontWeight', 'normal' ...
% % %                             )
% % %                         
% % %                         % if all section codes calculated, updates the section to be calculated
% % %                         if all(cellfun(@(pc) ~isa(pc.getr('EL'), 'NoValue'), Code_dict.getItems()))
% % %                             S_to_be_calculated = S + 1;
% % %                         end
% % %                     catch e
% % %                         set(PL.pc_btns{S}{C}, ...
% % %                             'Enable', 'on' ...
% % %                             )
% % % 
% % %                         if ~strcmp(e.message, BRAPH2.IM_ERR)
% % %                             warndlg(['An error occurred while trying to execute the code:' newline() ...
% % %                                 newline() ...
% % %                                 Codeline newline() ...
% % %                                 newline() ...
% % %                                 'Error message:' newline() ...
% % %                                 newline() ...
% % %                                 e.message newline()], 'Warning');
% % %                         end
% % %                     end
% % %                 else % the code has already been calculated -- GUI
% % %                     PL.pc_GUIs{S}{C} = eval(['GUI(' Moniker ')']);
% % % % FIXME ensure that only one figure exists at a time
% % % % FIXME manage the position of the appearing figures
% % %                 end
% % %             end
% % %         end
% % %     end
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