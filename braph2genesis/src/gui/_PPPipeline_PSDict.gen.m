%% ¡header!
PPPipeline_PSDict < PlotProp (pl, pipeline plot) is a plot of a pipeline.

%%% ¡description!
PPPipeline_PCDict plots a pipeline allowing the user to execute it in the correct order.

%%% ¡seealso!
Pipeline, PlotProp

%% ¡properties!
pp
ps_panels % list of section panels
pc_btns % 2D-list of code buttons

%% ¡methods!
function h_panel = draw(pl, varargin)
    %DRAW draws the pipeline graphical panel.
    %
    % DRAW(PL) draws the pipeline graphical panel.
    %
    % H = DRAW(PL) returns a handle to the pipeline graphical panel.
    %
    % DRAW(PL, 'Property', VALUE, ...) sets the properties of the graphical
    %  panel with custom property-value couples.
    %  All standard plot properties of uipanel can be used.
    %
    % It is possible to access the properties of the various graphical
    %  objects from the handle H.
    %
    % see also update, resize, refresh, settings, uipanel, isgraphics.
    % output

    pl.pp = draw@PlotProp(pl, varargin{:});

    pip = pl.get('EL');

    ps_dict = pip.get('PS_DICT');
    for s = 1:1:ps_dict.length()
        ps = ps_dict.getItem(s);

        pl.ps_panels(s) = uipanel( ...
            'Parent', pl.pp, ...
            'Title', [ps.get('ID') '. ' ps.get('LABEL')], ...
            'Tooltip', ps.get('NOTES'), ...
            'FontUnits', BRAPH2.FONTUNITS, ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'BorderType', 'none' ...
            );
        
        pc_dict = ps.get('PC_DICT');
        for c = 1:1:pc_dict.length()
            pc = pc_dict.getItem(c);
            
            pl.pc_btns(s, c) = uicontrol( ...
                'Style', 'pushbutton', ...
                'Parent', pl.ps_panels(s), ...
                'Tooltip', pc.get('NOTES'), ...
                'FontUnits', BRAPH2.FONTUNITS, ...
                'FontSize', BRAPH2.FONTSIZE, ...
                'Callback', {@cb_pushbutton_value} ...
                );
        end
    end
    
    if nargout > 0
        h_panel = pl.pp;
    end
end
function update(pl)
    %UPDATE updates the content of the property graphical panel.
    %
    % UPDATE(PL) updates the content of the property graphical panel.
    %
    % See also draw, resize, refresh.

    update@PlotProp(pl)
    
    pip = pl.get('EL');

    ps_dict = pip.get('PS_DICT');
    for s = 1:1:ps_dict.length()
        ps = ps_dict.getItem(s);
        
        pc_dict = ps.get('PC_DICT');
        for c = 1:1:pc_dict.length()
            pc = pc_dict.getItem(c);
        
            set(pl.pc_btns(s, c), ...
                'String', pc.get('TEXT_BEFORE_EXEC') ...
                )
        end
    end  
end
function redraw(pl, varargin)
    %REDRAW resizes the element graphical panel.
    %
    % REDRAW(PL) resizes the plot PL.
    %
    % REDRAW(PL, 'Height', HEIGHT) sets the height of PL (by default HEIGHT=2).
    %
    % See also draw, update, refresh.
    
    pip = pl.get('EL');
    ps_dict = pip.get('PS_DICT');
        
    ps_number = ps_dict.length();
    pc_numbers = cellfun(@(ps) ps.get('PC_DICT').length(), ps_dict.getItems());
    
    h_min = 2;  % default (minumum) height
    h_ps_header = .5; % height section header
    h_pc = 2.5; % height code button
    h_ps_footer = .5; % height section footer
    h_ps_margin = .5; % height section margin
    h = h_min + (h_ps_margin + h_ps_header + h_ps_footer) * ps_number + h_pc * sum(pc_numbers);
    pl.redraw@PlotProp('Height', h, varargin{:})

    for s = 1:1:ps_number
        ps_y = h_ps_header * (ps_number - s) ...
            + h_pc * sum(pc_numbers(s+1:end)) ...
            + h_ps_footer * (ps_number - s) ...
            + h_ps_margin * (ps_number - s + 1);
        ps_h = h_ps_header + h_pc * pc_numbers(s) + h_ps_footer;
        
        set(pl.ps_panels(s), ...
            'Units', 'normalized', ...
            'Position', [.02 ps_y/h .96 ps_h/h] ...
            )
        
        for c = 1:1:pc_numbers(s)
            set(pl.pc_btns(s, c), ...
                'Units', 'normalized', ...
                'Position', [.02 (h_ps_footer+(pc_numbers(s) - c)*h_pc)/ps_h .96 h_pc/ps_h] ...
                )
        end
    end
end