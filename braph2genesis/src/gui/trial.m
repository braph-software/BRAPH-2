clear all

%# create figure, panel, and slider
w = 600; h = 500;           %# width/height of figure
handles.hFig = figure('Menubar','figure', 'Resize','on', ...
    'Units','pixels', 'Position',[200 200 w h]);
handles.hPan = uipanel('Parent',handles.hFig, ...
    'Units','pixels', 'Position',[0 0 w-20 h]);
handles.hSld = uicontrol('Parent',handles.hFig, ...
    'Style','slider', 'Enable','off', ...
    'Units','pixels', 'Position',[w-20 0 20 h], ...
    'Min',0-eps, 'Max',0, 'Value',0, ...
    'Callback',{@onSlide,handles.hPan});

%# add and plot to axes one-by-one
hAx = zeros(7,1);
clr = lines(7);
for i=1:7
    hAx(i) = addAxis(handles);
    plot(hAx(i), cumsum(rand(100,1)-0.5), 'LineWidth',2, 'Color',clr(i,:))
    title(hAx(i), sprintf('plot %d',i))
    pause(1)   %# slow down so that we can see the updates
end

function hAx = addAxis(handles)
    %# look for previous axes
    ax = findobj(handles.hPan, 'type','axes');

    if isempty(ax)
        %# create first axis
        hAx = axes('Parent',handles.hPan, ...
            'Units','normalized', 'Position',[0.13 0.11 0.775 0.815]);
        set(hAx, 'Units','pixels');

    else
        %# get height of figure
        p = get(handles.hFig, 'Position');
        h = p(4);

        %# increase panel height, and shift it to show new space
        p = get(handles.hPan, 'Position');
        set(handles.hPan, 'Position',[p(1) p(2)-h p(3) p(4)+h])

        %# compute position of new axis: append on top (y-shifted)
        p = get(ax, 'Position');
        if iscell(p), p = cell2mat(p); end
        p = [p(1,1) max(p(:,2))+h p(1,3) p(1,4)];

        %# create the new axis
        hAx = axes('Parent',handles.hPan, ...
            'Units','pixels', 'Position',p);

        %# adjust slider, and call its callback function
        mx = get(handles.hSld, 'Max');
        set(handles.hSld, 'Max',mx+h, 'Min',0, 'Enable','on')
        %#set(handles.hSld, 'Value',mx+h)       %# scroll to new space
        hgfeval(get(handles.hSld,'Callback'), handles.hSld, []);
    end

    %# force GUI update
    drawnow
end

function onSlide(hSld,ev,hPan)
    %# slider value
    offset = get(hSld,'Value');

    %# update panel position
    p = get(hPan, 'Position');  %# panel current position
    set(hPan, 'Position',[p(1) -offset p(3) p(4)])
end