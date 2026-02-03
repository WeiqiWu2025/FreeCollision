function [demdData] = survey_FreeCollision_funcMLDetector(possiValue,estBaseH,Q,numTagData,numTags)

demdData = zeros(numTagData,numTags);
possiValue(possiValue==0) = -1;
hat_Q = possiValue*estBaseH;

for idx_1 = 1:numTagData
    [~,tmp_indx] = min(hat_Q-Q(idx_1));
    demdData(idx_1,:) = possiValue(tmp_indx,:);
end
demdData(demdData == -1) = 0;

end

