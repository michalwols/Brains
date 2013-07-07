function [ clustered, means ] = K_means( data, k, means )
% K-means clustering algorithm
%   src - data to be clustered
%   k - number of clusters
%   means - (optional) initial seed means
        
    if isempty(means)
        vals = unique(data(:));
        step = floor(numel(vals) / k);
        means = vals(1:step:end);   
    end
    
    distances = zeros(k, numel(data));
    clustered = zeros(size(data));
    old_means = zeros(size(means));
    
    iter = 0;
    while any(old_means ~= means)
        iter = iter + 1;
        %assign clusters
        for i = 1:numel(means)
            distances(i,:) = data(:) - means(i);
        end
        [~, clustered] = min( abs(distances), [], 1);
        
        old_means = means;
        
        %update means
        for i = 1:k
            means(i) = mean( data(clustered == i) );
        end
    end
end

