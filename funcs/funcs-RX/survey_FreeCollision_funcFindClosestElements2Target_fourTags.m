function [estBaseH] = survey_FreeCollision_funcFindClosestElements2Target_fourTags(channelSet,target)

tmp_min = abs(target-channelSet(1:4));
len = length(channelSet);
estBaseH = ones(4,1);
estBaseH = channelSet(1:4);

for idx1 = 1:len
    for idx2 = (idx1+1):len
        for idx3 = (idx2+1):len
            for idx4 = (idx3+1):len
                idxSet = [idx1,idx2,idx3,idx4];
                tmp_comp = abs(target-sum(channelSet(idxSet)));
                if tmp_comp <= tmp_min
                    estBaseH(1,1) = channelSet(idx1);
                    estBaseH(2,1) = channelSet(idx2);
                    estBaseH(3,1) = channelSet(idx3);
                    estBaseH(4,1) = channelSet(idx4);
                    tmp_min = tmp_comp;
                end
            end
        end
    end
end

end

