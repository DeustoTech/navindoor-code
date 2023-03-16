function result = step(iBeaconSgn,t)
%STEP Summary of this function goes here
%   Detailed explanation goes here
    indexs = 1:length(iBeaconSgn.timeline);
    index = interp1(iBeaconSgn.timeline,indexs,t,'previous','extrap');
    if isnan(index)
       error('The parameter t out range.') 
    end

    result.values          = iBeaconSgn.mss(index).values;
    result.indexs_beacons  = iBeaconSgn.mss(index).indexs_beacons;
end
