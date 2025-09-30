function [clusterLabels,clusterCenters] = survey_FreeCollision_funcSymbolClustering(clusterPoints,clusterNumber)

tmp = [real(clusterPoints);imag(clusterPoints)].';

[clusterLabels,clusterCenters] = kmeans(tmp,clusterNumber,'Distance','cityblock','MaxIter',10000,'Replicates',100); 

end

