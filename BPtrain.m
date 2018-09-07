% script 'BPtrain' is used to train a BP neural network
% created by Bill

% matrices 'trainIn' and 'trainOut' are the training set
% each column of matrix is a vector
trainIn = -0.5:0.01:0.5;
trainOut = -cos(8.*trainIn).^2.*trainIn.^2 + 0.01 * rand(size(trainIn));

nhidden = 10; % number of neurons in hidden layer
learningRate = 0.05; % learning rate
times = 10000000; % training times
checkInterval = 100;

nin = length(trainIn(:, 1)); % length of input vector
nout = length(trainOut(:, 1)); % length of output vector
trainSize = length(trainIn(1, :)); % size(number of vectors) of the training set

% create layers
lin = layer(nin, nhidden);
lout = layer(nhidden, nout);

% matrices 'x', 'y' are used to record the training pocess
x = [];
y = [];

% start training
for i = 1 : times
    % temporary variables
    tempout = [];
    loss = 0;
    tloss = 0;
    
    for j = 1 : trainSize
        % forward propagation
        tempHidden = lin.run(trainIn(:, j));
        tempOut = lout.run(sigmoid(tempHidden));
        loss = sumsqr(tempOut - trainOut(:, j)); % loss function
        tloss = tloss + loss;
        
        % backward propagation
        a = 2 * (tempOut - trainOut(:, j));
        lout.b = lout.b - learningRate * a;
        lout.w = lout.w - learningRate * (sigmoid(tempHidden)' .* a);
        b = (dsigmoid(tempHidden) .* (lout.w' * a));
        lin.b = lin.b - learningRate * b;
        lin.w = lin.w - learningRate * (trainIn(:, j)' .* b); 
    end
    
    loss = tloss / trainSize; % 'loss' is the average loss of the training set
    
    % check training result
    if mod(i, checkInterval) == 0
        % record the present training result
        x = [x, (-0.5:0.01:0.5)'];
        y = [y, (-0.5:0.01:0.5)'];
        for k = 1 : length(x(:, 1))
            y(k, end) = BPrun(lin, lout, x(k, end));
        end
        
        % print the training progress and loss
        fprintf(['Training Steps: ', num2str(i), '/', num2str(times), ';\t', 'loss: ', num2str(loss), '\n']);
    end
    
    % break the training process if loss is low enough
    if loss < 0.00001
        break
    end
end