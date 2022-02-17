function adjusted_values = adjustment(values, covariates)
% ADJUSTMENT adjusts the covariant of data
%
% ADJUSTED_VALUES = ADJUSTMENT(VALUES, COVARIATES) It adjusts the values in
% numerical arrays VALUES, so the differences related to COVARIATES are removed.
% It is achieved with regression analysis by means of least squares
% to approximate the effect of covariate. The adjusted values are obtained 
% from the residuals of the value after removing the effect of covariate.

Y = values;

% create the full covariates matrix (merge reg values + add ones)
no = length(covariates);
X = [ones(no, 1) covariates];

% construct the model Y = XB + E and find the LS estimate of B by using  b=(X'X)^{-1}X'y
B = inv(X'*X) * X' * Y;

% get the residuals
adjusted_values = Y - X*B;