function vout_ = BPrun(lin_, lout_, vin_)
% function 'BPrun' gives the ouput vector of a BP neural network
vout_ = lout_.run(sigmoid(lin_.run(vin_)));
end

