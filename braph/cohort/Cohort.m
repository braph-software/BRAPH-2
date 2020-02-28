classdef Cohort < handle & matlab.mixin.Copyable
	properties (GetAccess=protected, SetAccess=protected) 
        name  % brain atlas name
        sub_class  % class of the subjects
        subdict  % dictionary with subjects
    end
    methods (Access=protected)
%         function ba_copy = copyElement(ba)
%             
%             % Make a shallow copy
%             ba_copy = copyElement@matlab.mixin.Copyable(ba);
%             
%             % Make a deep copy of brdict
%             ba_copy.subdict = containers.Map('KeyType', 'int32', 'ValueType', 'any');
%             brain_regions = values(ba.subdict);
%             for i = 1:1:length(brain_regions)
%                 br = brain_regions{i};
%                 ba_copy.subdict(i) = br.copy();
%             end
%         end        
    end        
    methods
        function cohort = Cohort(name, sub_class, subs)
            % subs must be a cell array of Subjects of class sub_class
                        
            cohort.name = name;
            
            assert(any(strcmp(Subject.getList(), sub_class)), ...
                ['BRAPH:Cohort:SubjectClassErr'], ...
                [sub_class ' is not a valid Subject class'])
            cohort.sub_class = sub_class;

            cohort.subdict = containers.Map('KeyType', 'int32', 'ValueType', 'any');
            for i = 1:1:length(subs)
                cohort.addSubject(subs{i}, i);
            end
        end
        function str = tostring(cohort)
            str = ['Cohort with ' int2str(cohort.subjectnumber()) ' ' cohort.getSubjectClass()];
        end
        function disp(cohort)
            disp(['<a href="matlab:help ' class(cohort) '">' class(cohort) '</a>'])
            disp([' size: ' int2str(cohort.subjectnumber()) ' <a href="matlab:help ' cohort.getSubjectClass() '">' cohort.getSubjectClass() '</a>'])
        end
        function name = getName(cohort)
            name = cohort.name;
        end
        function sub_class = getSubjectClass(cohort)
            sub_class = cohort.sub_class;
        end
        function n = subjectnumber(cohort)
            n = length(cohort.subdict);
        end
        function bool = contains_subject(cohort, sub_index)
            bool = isKey(cohort.subdict, sub_index);
        end
        function sub = getBrainRegion(cohort, sub_index)
            sub = cohort.subdict(sub_index);
        end
%         function brain_regions = getBrainRegions(ba)
%             brain_regions = values(ba.subdict);
%         end
%         function br_labels = getBrainRegionLabels(ba)
%             br_labels = cell(1, ba.brainregionnumber());
%             for i = 1:1:ba.brainregionnumber()
%                 br = ba.getBrainRegion(i);
%                 br_labels{i} = br.getLabel();
%             end
%         end
%         function br_names = getBrainRegionNames(ba)
%             br_names = cell(1, ba.brainregionnumber());
%             for i = 1:1:ba.brainregionnumber()
%                 br = ba.getBrainRegion(i);
%                 br_names{i} = br.getName();
%             end
%         end
%         function br_xs = getBrainRegionXs(ba)
%             br_xs = cell(1, ba.brainregionnumber());
%             for i = 1:1:ba.brainregionnumber()
%                 br = ba.getBrainRegion(i);
%                 br_xs{i} = br.getX();
%             end
%         end
%         function br_ys = getBrainRegionYs(ba)
%             br_ys = cell(1, ba.brainregionnumber());
%             for i = 1:1:ba.brainregionnumber()
%                 br = ba.getBrainRegion(i);
%                 br_ys{i} = br.getY();
%             end
%         end
%         function br_zs = getBrainRegionZs(ba)
%             br_zs = cell(1, ba.brainregionnumber());
%             for i = 1:1:ba.brainregionnumber()
%                 br = ba.getBrainRegion(i);
%                 br_zs{i} = br.getZ();
%             end
%         end
%         function br_positions = getBrainRegionPositions(ba)
%             br_positions = cell(1, ba.brainregionnumber());
%             for i = 1:1:ba.brainregionnumber()
%                 br = ba.getBrainRegion(i);
%                 br_positions{i} = br.getPosition();
%             end
%         end
        function addSubject(cohort, sub, i)
            
            if nargin < 3 || i < 0 || i > cohort.subjectnumber()
                i = cohort.subjectnumber() + 1;
            end

            assert(isa(sub, cohort.getSubjectClass()), ...
                ['BRAPH:Cohort:SubjectClassErr'], ...
                ['All Subject classes should be ' cohort.getSubjectClass() ', but one is ' sub.getClass()])
            
            if i <= cohort.subjectnumber()
                for j = cohort.subjectnumber():-1:i
                    cohort.subdict(j+1) = cohort.subdict(j);
                end
                cohort.subdict(i) = sub;
            else
                cohort.subdict(i) = sub;
            end
        end
%         function removeBrainRegion(ba, i)
%             
%             for j = i:1:ba.brainregionnumber()-1
%                 ba.subdict(j) = ba.subdict(j+1);
%             end
%             remove(ba.subdict, ba.brainregionnumber());
%         end
%         function replaceBrainRegion(ba, i, br)
% 
%             assert(isa(br, 'BrainRegion'), ...
%                     'BRAPH:BrainAtlas:ObjectNotBR', ...
%                     'Only BrainRegion objects can be added to a BrainAtlas' ...
%                     )
%             
%             if i > 0 || i <= ba.brainregionnumber()
%                 ba.subdict(i) = br;
%             end
%             
%         end
%         function invertBrainRegions(ba, i, j)
%             
%             if i > 0 && i <= ba.brainregionnumber() && j > 0 && j <= ba.brainregionnumber() && i ~= j
%                 br_i = ba.getBrainRegion(i);
%                 br_j = ba.getBrainRegion(j);
%                 ba.replaceBrainRegion(i, br_j)
%                 ba.replaceBrainRegion(j, br_i)
%             end
%         end
%         function movetoBrainRegion(ba, i, j)
%             
%             if i > 0 && i <= ba.brainregionnumber() && j > 0 && j <= ba.brainregionnumber() && i ~= j
%                 br = ba.getBrainRegion(i);
%                 if i > j
%                     ba.removeBrainRegion(i)
%                     ba.addBrainRegion(br, j)
%                 else  % j < i
%                     ba.addBrainRegion(br, j+1)
%                     ba.removeBrainRegion(i)
%                 end
%             end            
%         end
%         function selected = removeBrainRegions(ba, selected)
%             
%             for i = length(selected):-1:1
%                 ba.removeBrainRegion(selected(i))
%             end
%             selected = [];
%         end
%         function [selected, added] = addaboveBrainRegions(ba, selected)
%             
%             for i = length(selected):-1:1
%                 ba.addBrainRegion(BrainRegion(), selected(i))
%             end
%             selected = selected + reshape(1:1:numel(selected), size(selected));
%             added = selected - 1;
%         end
%         function [selected, added] = addbelowBrainRegions(ba, selected)
%             
%             for i = length(selected):-1:1
%                 ba.addBrainRegion(BrainRegion(), selected(i) + 1)
%             end
%             selected = selected + reshape(0:1:numel(selected)-1, size(selected));
%             added = selected + 1;
%         end
%         function selected = moveupBrainRegions(ba, selected)
%             
%             if ~isempty(selected)
%                 
%                 first_index_to_process = 1;
%                 unprocessable_length = 1;
%                 while first_index_to_process <= ba.brainregionnumber() ...
%                         && first_index_to_process <= numel(selected) ...
%                         && selected(first_index_to_process) == unprocessable_length
%                     first_index_to_process = first_index_to_process + 1;
%                     unprocessable_length = unprocessable_length + 1;
%                 end
% 
%                 for i = first_index_to_process:1:numel(selected)
%                     ba.invertBrainRegions(selected(i), selected(i)-1);
%                     selected(i) = selected(i) - 1;
%                 end
%             end
%         end
%         function selected = movedownBrainRegions(ba, selected)
%             
%             if ~isempty(selected)
% 
%                 last_index_to_process = numel(selected);
%                 unprocessable_length = ba.brainregionnumber();
%                 while last_index_to_process > 0 ...
%                         && selected(last_index_to_process) == unprocessable_length
%                     last_index_to_process = last_index_to_process - 1;
%                     unprocessable_length = unprocessable_length - 1;
%                 end
% 
%                 for i = last_index_to_process:-1:1
%                     ba.invertBrainRegions(selected(i), selected(i) + 1);
%                     selected(i) = selected(i) + 1;
%                 end
%             end
%         end
%         function selected = move2topBrainRegions(ba, selected)
%             
%             if ~isempty(selected)
%                 for i = 1:1:numel(selected)
%                     ba.movetoBrainRegion(selected(i), i);
%                 end
%                 selected = reshape(1:1:numel(selected), size(selected));
%             end
%         end
%         function selected = move2bottomBrainRegions(ba, selected)
%             
%             if ~isempty(selected)
%                 for i = numel(selected):-1:1
%                     ba.movetoBrainRegion(selected(i), ba.brainregionnumber() - (numel(selected)-i));
%                 end
%                 selected = reshape(ba.brainregionnumber() - numel(selected)+1:1:ba.brainregionnumber(), size(selected));
%             end
%         end
    end
end