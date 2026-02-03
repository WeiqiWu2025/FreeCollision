function [estBaseH] = survey_FreeCollision_funcFindClosestElements2Target(channelSet,target,numTags)

switch numTags
    case 2
        estBaseH = survey_FreeCollision_funcFindClosestElements2Target_twoTags(channelSet,target);
    case 3
        estBaseH = survey_FreeCollision_funcFindClosestElements2Target_threeTags(channelSet,target);
    case 4
        estBaseH = survey_FreeCollision_funcFindClosestElements2Target_fourTags(channelSet,target);
    case 5
        estBaseH = survey_FreeCollision_funcFindClosestElements2Target_fiveTags(channelSet,target);
    case 6
        estBaseH = survey_FreeCollision_funcFindClosestElements2Target_sixTags(channelSet,target);
    case 7
        estBaseH = survey_FreeCollision_funcFindClosestElements2Target_sevenTags(channelSet,target);
    case 8
        estBaseH = survey_FreeCollision_funcFindClosestElements2Target_eightTags(channelSet,target);
    case 9
        estBaseH = survey_FreeCollision_funcFindClosestElements2Target_nineTags(channelSet,target);
    case 10
        estBaseH = survey_FreeCollision_funcFindClosestElements2Target_tenTags(channelSet,target);
    case 11
        estBaseH = survey_FreeCollision_funcFindClosestElements2Target_elevenTags(channelSet,target);
    case 12
        estBaseH = survey_FreeCollision_funcFindClosestElements2Target_twelveTags(channelSet,target);
    otherwise
        error("Exceed 12 Tags!");
end

end

