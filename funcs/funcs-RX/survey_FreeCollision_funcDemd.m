function [demodData] = survey_FreeCollision_funcDemd(estBaseH,numTagData,Q,numTags)

% demodData = zeros(numTagData,numTags);

possiValue = survey_FreeCollision_funcPossibleValues(numTags);
demodData = survey_FreeCollision_funcMLDetector(possiValue,estBaseH,Q,numTagData,numTags);

end

