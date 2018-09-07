function y = dsigmoid(x)
% function 'dsigmoid' is the derivative of function 'sigmoid'
y = sigmoid(x) .* (1 - sigmoid(x));
end

