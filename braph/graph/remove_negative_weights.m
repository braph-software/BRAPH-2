function B = remove_negative_weights(A, rule)

%the rule is going to get pass as a string? int?

    switch (rule)
        case '0'
            B = max(A,0); %  change negative values to zeros

        case 'zero'
            B = max(A,0); %  change negative values to zeros
            
        case 'null'
            A(isnan(A))=0 ; %  change NaN values to zeros
            B = A;
            
        otherwise
            B = abs(A); %  want the absolute value of every element in the matrix A
    end

end