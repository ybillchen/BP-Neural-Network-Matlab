function vout_ = BPrun(lin_, lout_, vin_, activationFunction)
% function 'BPrun' gives the ouput vector of a BP neural network
if activationFunction == 'tanh'
    vout_ = lout_.run(tanh(lin_.run(vin_)));
elseif activationFunction == 'sigmoid'
    vout_ = lout_.run(sigmoid(lin_.run(vin_)));
end
end

