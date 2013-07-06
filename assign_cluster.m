function [ cluster ] = assign_cluster( val, means, distance )

    distances = arrayfun(@(m) distance(val, m), means);
    [~, cluster] = min(distances);

end

