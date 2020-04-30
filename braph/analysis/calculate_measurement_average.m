function measure_average = calculate_measurement_average(measure_code, measure_values)

suma = zeros(size(measure_values{1}));
for i=1:1:numel(measure_values)
    suma = suma + measure_values{i};
end
measure_average = suma / numel(measure_values);

end