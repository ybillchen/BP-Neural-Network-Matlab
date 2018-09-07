classdef layer
    %  class 'layer' is used in artificial neural network
    
    properties
        nin % input vector's size
        nout % output vector's size
        w % weight matrix
        b % bias vector
    end
    
    methods
        function obj = layer(nin_, nout_)
            % function 'layer' constructs an instance of this class
            % layer(input vector's size, output vector's size)
            obj.nin = nin_;
            obj.nout = nout_;
            obj.w = - ones(nout_, nin_) + 2 * rand(nout_, nin_);
            obj.b = - ones(nout_, 1) + rand(nout_, 1);
        end
        
        function vout = run(obj, vin)
            % function 'run' outputs a vector
            % run(input vector)
            vout = obj.w * vin + obj.b;
        end
    end
end

