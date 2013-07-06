function [ clustered, means ] = K_means( src, k, means )
% K-means clustering algorithm
%   src - data to be clustered
%   k - number of clusters
%   means - (optional) initial seed means
        
    if isempty(means)
        vals = unique(src(:));
        step = floor(numel(vals) / k);
        means = vals(1:step:end);   
    end
    
    distances = zeros(size(means));
    clustered = zeros(size(src));
    old_means = zeros(size(means));
    
    while any(old_means ~= means)
        
        %assign clusters
        for n = 1:numel(src)
            for i = 1:numel(means)
                distances(i) = abs( src(n) - means(i) );
            end
            [~, clustered(n)] = min(distances);
        end
        
        old_means = means;
        
        %update means
        for i = 1:k
            means(i) = mean( src( clustered == i ));
        end
    end
end

