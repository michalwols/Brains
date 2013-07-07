function [ responsibs, means, covars ] = EM_gaussian_mixture( data, K, means, covars, mixing_coeffs )
% EM Gaussian Mixture - assumes seed values passed from k-means 
%                       only works with 1D data (vector)
%   K - number of gaussians to fit
%   means - initial seed means
%   covars - initial seed covariances (variances)
%   mixing_coeffs - initial weights of each gaussian (should add up to 1)
%
%   responsibs - responsibilities == "influence" of each gaussian on each
%                data point

    N = numel(data);
    point_probs = zeros(K, N);
    responsibs = zeros(K, N);
    
    for iter = 1:100
        
        % E step
        
        % calculate the values of the normal at each point times the
        % mixing coefficients
        for i = 1:K
            point_probs(i,:) = mixing_coeffs(i) * mvnpdf(data, means(i), covars(i));
        end
        
        % compute responsibility (gamma) values
        denom = sum(point_probs, 1);
        for i = 1:K
            responsibs(i,:) = point_probs(i,:) ./ denom;
        end
        
        % M step
        
        N_ks = sum(responsibs, 2);
        mixing_coeffs = N_ks / N;
        
        old_means = means;
        old_covars = covars;
        
        % update means and covariances
        for i = 1:K
            means(i) = sum( responsibs(i,:) .* data' ) / N_ks(i);
            
            diffs = data' - means(i);
            covars(i) = sum( responsibs(i,:) .* diffs .* diffs ) / N_ks(i);
        end
        
        % check for convergence
        means_changes = (abs(old_means - means) ./ means);
        covars_changes = (abs(old_covars - covars) ./ covars);
        if all(means_changes < .005) && all(covars_changes < .005)
            break;
        end
        
    end

end

