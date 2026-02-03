function [estBaseH] = survey_FreeCollision_funcFindClosestElements2Target_twelveTags(channelSet,target)

tmp_min = abs(target-channelSet(1:12));
len = length(channelSet);
estBaseH = ones(12,1);
estBaseH = channelSet(1:12);

for idx1 = 1:len
    for idx2 = (idx1+1):len
        for idx3 = (idx2+1):len
            for idx4 = (idx3+1):len
                for idx5 = (idx4+1):len
                    for idx6 = (idx5+1):len
                        for idx7 = (idx6+1):len
                            for idx8 = (idx7+1):len
                                for idx9 = (idx8+1):len
                                    for idx10 = (idx9+1):len
                                        for idx11 = (idx10+1):len
                                            for idx12 = (idx11+1):len
                                                idxSet = [idx1,idx2,idx3,idx4,idx5,idx6,idx7,idx8,idx9,idx10,idx11,idx12];
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
                                                    estBaseH(9,1) = channelSet(idx9);
                                                    estBaseH(10,1) = channelSet(idx10);
                                                    estBaseH(11,1) = channelSet(idx11);
                                                    estBaseH(12,1) = channelSet(idx12);
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
        end
    end
end

end

