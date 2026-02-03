function [estBaseH] = survey_FreeCollision_funcFindNormalizedChannelCoefficients(estH_all_ones,omega,numTags)

[~,idx_omega1] = min(omega-estH_all_ones);
[~,idx_omega0] = min(omega-0);
tmp_omega = omega;
tmp_omega(tmp_omega == omega(idx_omega1)) = [];
tmp_omega(tmp_omega == omega(idx_omega0)) = [];
%%%**  Search base channel coefficients
estBaseH =  survey_FreeCollision_funcFindClosestElements2Target(tmp_omega,omega(idx_omega1),numTags); 

end

