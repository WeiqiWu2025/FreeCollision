function [estBaseH] = survey_FreeCollision_funcFindClosestElements2Target_twoTags(channelSet,target)

tmp_min = abs(target-channelSet(1:2));
len = length(channelSet);
estBaseH = ones(2,1);
estBaseH = channelSet(1:2);

for idx1 = 1:len
    for idx2 = (idx1+1):len
        idxSet = [idx1,idx2];
        tmp_comp = abs(target - sum(channelSet(idxSet)));
        if tmp_comp <= tmp_min
            estBaseH(1,1) = channelSet(idx1);
            estBaseH(2,1) = channelSet(idx2);
            tmp_min = tmp_comp;
        end
    end
end

end

