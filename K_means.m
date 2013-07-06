function [ clustered, means ] = K_means( src, k, means, distance )
% K-means clustering algorithm
% src - data to be clustered
% k - number of clusters
% means - initial seed means
% distance - (optional) distance measure to be used instead of euclidean 
%            distance

    if isempty(distance)
        distance = @(x, y) norm(x-y);
    end
        
    if isempty(means)
        vals = unique(src(:));
        if numel(vals) < k
            throw(MException('K_means:ClusterNum', ...
                'The number of clusters is larger than the number of distinct values'));
        else
            step = floor(numel(vals) / k);
            means = vals(1:step:end);
        end    
    end
    
    while true
        
        %assign clusters
        clustered = arrayfun(@(elem) assign_cluster(elem, means, distance), src);

        old_means = means;
        
        %update means
        for i = 1:k
            means(i) = mean( src( clustered == i ));
        end
        
        if old_means == means
            break;
        end
        
    end

end

