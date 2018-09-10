% script 'BPtrain' is used to train a BP neural network
% created by Bill

% matrices 'trainIn' and 'trainOut' are the training set
% each column of matrix is a vector
trainIn = -0.5:0.01:0.5;
trainOut = cos(30* trainIn);

nhidden = 80; % number of neurons in hidden layer
learningRate = 0.01; % learning rate
times = 10000000; % training times
checkInterval = 100;
activationFunction = 'tanh';

nin = length(trainIn(:, 1)); % length of input vector
nout = length(trainOut(:, 1)); % length of output vector
trainSize = length(trainIn(1, :)); % size(number of vectors) of the training set

% create layers
l1 = layer(nin, nhidden);
l2 = layer(nhidden, nout);

% matrices 'x', 'y' are used to record the training pocess
if nin == 1 && nout == 1
    x = [];
    y = [];
end

% start training
for i = 1 : times
    % temporary variables
    loss = 0;
    tloss = 0;
    
    for j = 1:trainSize
        % feed forward
        tempHidden = l1.run(trainIn(:, j));
        if activationFunction == 'tanh'
            tempOut = l2.run(tanh(tempHidden));
        elseif activationFunction == 'sigmoid'
            tempOut = l2.run(sigmoid(tempHidden));
        end
        loss = sumsqr(tempOut - trainOut(:, j)); % loss function
        tloss = tloss + loss;
        
        % back propagation
        a = 2 * (tempOut - trainOut(:, j));
        l2.b = l2.b - learningRate * a;
        if activationFunction == 'tanh'
            l2.w = l2.w - learningRate * (tanh(tempHidden)' .* a);
            b = (dtanh(tempHidden) .* (l2.w' * a));
        elseif activationFunction == 'sigmoid'
            l2.w = l2.w - learningRate * (sigmoid(tempHidden)' .* a);
            b = (dsigmoid(tempHidden) .* (l2.w' * a));
        end
        l1.b = l1.b - learningRate * b;
        l1.w = l1.w - learningRate * (trainIn(:, j)' .* b); 
    end
    loss = tloss / (trainSize); % 'loss' is the average loss of the training set
    
    % check training result
    if mod(i, checkInterval) == 0 
        if nin == 1 && nout == 1
            % record the present training result
            x = [x, trainIn'];
            y = [y, trainOut'];
            for k = 1 : length(x(:, 1))
                y(k, end) = BPrun(l1, l2, x(k, end), activationFunction);
            end
        end
        
        % print the training progress and loss
        fprintf(['Training Steps: ', num2str(i), '/', num2str(times), ';\t', 'loss: ', num2str(loss), '\n']);
    end
    
    % break the training process if loss is low enough
    if loss < 0.00001
        break
    end
end