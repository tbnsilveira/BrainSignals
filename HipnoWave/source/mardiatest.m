function [H stats] = mardiatest(X,alpha)
% MARDIATEST Mardia multivariate normality test using skewness & kurtosis.
%   H = MARDIATEST(X,ALPHA) performs Mardia's test of multivariate
%   normality to determine if the null hypothesis of multivariate 
%   normality is a reasonable assumption regarding the population
%   distributions of a random samples contained within the columns of X. X
%   must be a N-values by M-samples array. The desired significance level,
%   ALPHA, is an optional scalar input (default = 0.05).
%
%   The function performs three tests: of the multivariate skewness; the
%   multivariate skewness corrected for small samples; and the multivariate
%   kurtosis. H is a 1-by-3 array indicating the results of the hypothesis
%   tests:
%     H(i) = 0 => Do not reject the null hypothesis at significance level
%     ALPHA.
%     H(i) = 1 => Reject the null hypothesis at significance level ALPHA.
%
%   [H STATS] = MARDIATEST(...) also returns a structure array with the
%   following fields:
%     stats.Hs  - logical scalar indicating whether to reject the null
%                 hypothesis that the multivariate skewness is consistent
%                 with a multivariate normal distribution.  
%     stats.Ps  - the P value for the multivariate skewness.
%     stats.Ms  - the Mardia test statistic for the multivariate skewness.
%     stats.CVs - the critical value for the multivariate skewness.
%     stats.Hsc - logical scalar indicating whether to reject the null
%                 hypothesis that the multivariate skewness (corrected for
%                 small samples) is consistent with a multivariate normal
%                 distribution.
%     stats.Psc - the P value for the multivariate skewness (corrected for
%                 small samples).
%     stats.Msc - the Mardia test statistic for the multivariate skewness
%                 (corrected for small samples).
%     stats.Hk  - logical scalar indicating whether to reject the null
%                 hypothesis that the multivariate kurtosis is consistent
%                 with a multivariate normal distribution.  
%     stats.Pk  - the P value for the multivariate kurtosis.
%     stats.Mk  - the Mardia test statistic for the multivariate kurtosis.
%     stats.CVk - the critical value for the multivariate kurtosis.
%
%   Notes:
%   For multivariate data, tests of normality of the individual variables
%   are not sufficent to determine multivariate normality. Even if every
%   variable in a set is normally distributed, it is still possible that
%   the combined distribution is not multivariate normal. Mardia's test is
%   one means testing for multivariate normality. The test is based on
%   independent tests of multivariate skewness and kurtosis. Data can be
%   assumed to conform to multivariate normality only if the null
%   hypothesis is not rejected for both tests.
%
%   Example:
%   >> X = [2.4  2.1  2.4; ...
%           3.5  1.8  3.9; ...
%           6.7  3.6  5.9; ...
%           5.3  3.3  6.1; ...
%           5.2  4.1  6.4; ...
%           3.2  2.7  4.0; ...
%           4.5  4.9  5.7; ...
%           3.9  4.7  4.7; ...
%           4.0  3.6  2.9; ...
%           5.7  5.5  6.2; ...
%           2.4  2.9  3.2; ...
%           2.7  2.6  4.1];
% 
%   >> [H stats] = mardiatest(X, 0.05)
% 
%   H =
%        0     0     1
% 
%   stats = 
%        Hs: 0
%        Ps: 0.9660
%        Ms: 3.5319
%       CVs: 18.3070
%       Hsc: 0
%       Psc: 0.8918
%       Msc: 4.9908
%        Hk: 1
%        Pk: 0.0452
%        Mk: -1.6936
%       CVk: 1.6449
%   
%   The magnitude of the Mardia kurtosis test statistic (Mk) is greater
%   than critical value (CVk) for a 5% level test, so the hypothesis of
%   multivariate normality is rejected. 
%
%   See also JBTEST, KSTEST, KSTEST2, LILLIETEST.
%   
%   This version:
%   Copyright 2006 David Graham, Loughborough University
%   (D.J.Graham@lboro.ac.uk)

% This function is based on MSKEKUR by A. Trujillo-Ortiz and R.
% Hernandez-Walls. Modifications include:
%   - additional checking of inputs
%   - modification of help text for consistency with Matlab conventions
%   - the output of the test results to variables
%   - removal of the code sending test results as a string to the command
%     window
%   - removed call to 'eval'.
%
% Statements from the original code:
%
% %  Created by A. Trujillo-Ortiz and R. Hernandez-Walls
% %         Facultad de Ciencias Marinas        
% %         Universidad Autonoma de Baja California 
% %         Apdo. Postal 453  
% %         Ensenada, Baja California
% %         Mexico  
% %         atrujo@uabc.mx
% %
% %  May 22, 2003.
% %
% %  To cite this file, this would be an appropriate format:
% %  Trujillo-Ortiz, A. and R. Hernandez-Walls. (2003). Mskekur: Mardia's multivariate skewness
% %    and kurtosis coefficients and its hypotheses testing. A MATLAB file. [WWW document]. URL 
% %    http://www.mathworks.com/matlabcentral/fileexchange/loadFile.do?objectId=3519&objectType=FILE
% %
% %  References:
% % 
% %  Mardia, K. V. (1970), Measures of multivariate skewnees and kurtosis with
% %         applications. Biometrika, 57(3):519-530.
% %  Mardia, K. V. (1974), Applications of some measures of multivariate skewness
% %         and kurtosis for testing normality and robustness studies. Sankhyâ A,
% %         36:115-128
% %  Stevens, J. (1992), Applied Multivariate Statistics for Social Sciences. 2nd. ed.
% %         New-Jersey:Lawrance Erlbaum Associates Publishers. pp. 247-248.


% Check number of input arguements
if (nargin < 1) || (nargin > 2)
    error('Requires one or two input arguments.')
end

% Define default ALPHA if only one input is provided
if nargin == 1, 
    alpha = 0.05;
end

% Check for validity of ALPHA
if ~isscalar(alpha) || alpha>0.5 || alpha <0
    error('Input ALPHA must be a scalar between 0 and 0.5.')
end

[n,p] = size(X);

% Check for validity of X
if p < 2 || ~isnumeric(X)
    error('Input X must be a numeric array with at least 2 columns.')
end


difT = [];
for	j = 1:p
   difT = [difT,(X(:,j) - mean(X(:,j)))];
end;

S = cov(X);                     % Variance-covariance matrix
D = difT * inv(S) * difT';      % Mahalanobis' distances matrix
b1p = (sum(sum(D.^3))) / n^2;   % Multivariate skewness coefficient
b2p = trace(D.^2) / n;          % Multivariate kurtosis coefficient

k = ((p+1)*(n+1)*(n+3)) / ...
    (n*(((n+1)*(p+1))-6));      % Small sample correction
v = (p*(p+1)*(p+2)) / 6;        % Degrees of freedom
g1c = (n*b1p*k) / 6;            % Skewness test statistic corrected for small sample (approximates to a chi-square distribution)
g1 = (n*b1p) / 6;               % Skewness test statistic (approximates to a chi-square distribution)
P1 = 1 - chi2cdf(g1,v);         % Significance value of skewness
P1c = 1 - chi2cdf(g1c,v);       % Significance value of skewness corrected for small sample

g2 = (b2p-(p*(p+2))) / ...
    (sqrt((8*p*(p+2))/n));      % Kurtosis test statistic (approximates to a unit-normal distribution)
P2 = 1-normcdf(abs(g2));        % Significance value of kurtosis


% Prepare outputs

stats.Hs  = (P1 < alpha);
stats.Ps  = P1;
stats.Ms  = g1;
stats.CVs = chi2inv(1-alpha,v);
stats.Hsc = (P1c < alpha);
stats.Psc = P1c;
stats.Msc = g1c;
stats.Hk  = (P2 < alpha);
stats.Pk  = P2;
stats.Mk  = g2;
stats.CVk = norminv(1-alpha,0,1);

H = [stats.Hs stats.Hsc stats.Hk];

