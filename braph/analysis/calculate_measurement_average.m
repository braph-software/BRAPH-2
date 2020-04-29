function measure_average = calculate_measurement_average(measure_code, measures)
if Measure.is_binodal(measure_code)
    suma = zeros(size(measures{1}));
    for i=1:1:numel(measures)
        suma = suma + measures{i};
    end
    measure_average = suma / numel(measures);
elseif Measure.is_nodal(measure_code)
    measure_average = mean([measures{:}], 2);
else
    measure_average = sum(cellfun(@sum, measures)) ./ sum(cellfun(@length, measures));
end
end