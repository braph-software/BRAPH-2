classdef PlotBrainGraph < PlotBrainAtlas
    properties
        edges  % structure of 2D cell arrays containing edge properties
        f_edges_settings  % edge settings figure handle
        
        % edge line
        INIT_LIN_COLOR = [0 0 0];
    end
    methods
        function bg = PlotBrainGraph(atlas)
            bg = bg@PlotBrainAtlas(atlas);
            
            initEdgesProperties(atlas)
        end
        function initEdgesProperties(bg, atlas)  
            % SETEDGESPROPERTIES initializes the edge property
            
            bg.edges.h = NaN(atlas.getBrainRegions().length());
            bg.edges.X1 = zeros(atlas.getBrainRegions().length(), 1);
            bg.edges.Y1 = zeros(atlas.getBrainRegions().length(), 1);
            bg.edges.Z1 = zeros(atlas.getBrainRegions().length(), 1);
            bg.edges.X2 = zeros(atlas.getBrainRegions().length(), 1);
            bg.edges.Y2 = zeros(atlas.getBrainRegions().length(), 1);
            bg.edges.Z2 = zeros(atlas.getBrainRegions().length(), 1);
        end
    end
    methods  % edge methods
        function h = link_edge(bg, i, j, varargin)
             bg.set_axes();
             % get brain regions
             br_1 = atlas.getBrainRegions().getValue(i);
             br_2 = atlas.getBrainRegions().getValue(j);
             % get coordinates
             X1 = br_1.getX();
             Y1 = br_1.getY();
             Z1 = br_1.getZ();
             
             X2 = br_2.getX();
             Y2 = br_2.getY();
             Z2 = br_2.getZ();
             
              if ~ishandle(bg.edges.h(j, i))                  
                  if ~ishandle(bg.edges.h(i, j))
                      
                      bg.edges.h(i, j) = plot3( ...
                          bg.get_axes(), ...
                          [X1 X2], ...
                          [Y1 Y2], ...
                          [Z1 Z2], ...
                          'Color', PlotBrainGraph.INIT_LIN_COLOR);
                  else
                      x1 = bg.edges.X1(i, j);
                      y1 = bg.edges.Y1(i, j);
                      z1 = bg.edges.Z1(i, j);
                      
                      x2 = bg.edges.X2(i, j);
                      y2 = bg.edges.Y2(i, j);
                      z2 = bg.edges.Z2(i, j);
                      
                      if x1 ~= X1 || y1 ~= Y1 || z1 ~= Z1 ...
                              || x2 ~= X2 || y2 ~= Y2 || z2 ~= Z2
                          
                          set(bg.edges.h(i, j), 'XData', [X1 X2]);
                          set(bg.edges.h(i, j), 'YData', [Y1 Y2]);
                          set(bg.edges.h(i, j), 'ZData', [Z1 Z2]);
                      end
                  end
              else
                  bg.edges.h(i, j) = bg.edges.h(j, i);
              end
              bg.edges.X1(i, j) = X1;
              bg.edges.Y1(i, j) = Y1;
              bg.edges.Z1(i, j) = Z1;
              
              bg.edges.X2(i, j) = X2;
              bg.edges.Y2(i, j) = Y2;
              bg.edges.Z2(i, j) = Z2;
              
              if nargout>0
                  h = bg.edges.h(i, j);
              end
        end
         function link_edges(bg, i_vec, j_vec, varargin)
            if nargin < 2 || isempty(i_vec) || isempty(j_vec)
                for i = 1:1:bg.atlas.getBrainRegions().length() 
                    for j = 1:1:bg.atlas.getBrainRegions().length()
                        bg.link_edge(i, j, varargin{:})
                    end
                end
            else
                if length(i_vec) == 1
                    i_vec = i_vec * ones(size(j_vec));
                end
                if length(j_vec) == 1
                    j_vec = j_vec * ones(size(i_vec));
                end
                
                for m = 1:1:length(i_vec)
                    bg.link_edge(i_vec(m), j_vec(m), varargin{:})
                end
            end
        end
    end
end