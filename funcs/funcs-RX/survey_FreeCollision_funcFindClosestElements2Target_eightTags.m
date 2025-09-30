function [estBaseH] = survey_FreeCollision_funcFindClosestElements2Target_eightTags(channelSet,target)

tmp_min = abs(target-channelSet(1:8));
len = length(channelSet);
estBaseH = ones(8,1);
estBaseH = channelSet(1:8);

for idx1 = 1:len
    for idx2 = (idx1+1):len
        for idx3 = (idx2+1):len
            for idx4 = (idx3+1):len
                for idx5 = (idx4+1):len
                    for idx6 = (idx5+1):len
                        for idx7 = (idx6+1):len
                            for idx8 = (idx7+1):len
                                idxSet = [idx1,idx2,idx3,idx4,idx5,idx6,idx7,idx8];
                                tmp_comp = abs(target-sum(channelSet(idxSet)));
                                if tmp_comp <= tmp_min
                                    estBaseH(1,1) = channelSet(idx1);
                                    estBaseH(2,1) = channelSet(idx2);
                                    estBaseH(3,1) = channelSet(idx3);
                                    estBaseH(4,1) = channelSet(idx4);
                                    estBaseH(5,1) = channelSet(idx5);
                                    estBaseH(6,1) = channelSet(idx6);
                                    estBaseH(7,1) = channelSet(idx7);
                                    estBaseH(8,1) = channelSet(idx8);
                                    tmp_min = tmp_comp;
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

end

