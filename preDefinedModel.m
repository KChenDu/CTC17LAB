function net = preDefinedModel(identifier)
    validId = false;
    switch identifier
        case 1
            trainFcn = 'trainlm'; % Levenberg-Marquardt
            hiddenLayerSize = 15;
            net = feedforwardnet(hiddenLayerSize, trainFcn);
            net.layers{1}.transferFcn = 'tansig'; % Hyperbolic tangent
            net.layers{2}.transferFcn = 'purelin'; % Output layer: linear

            validId = true;
        case 2
            trainFcn = 'trainlm'; % Levenberg-Marquardt
            hiddenLayerSize = [10, 10];
            net = feedforwardnet(hiddenLayerSize, trainFcn);
            net.layers{1}.transferFcn = 'poslin'; % ReLU
            net.layers{2}.transferFcn = 'poslin'; % ReLU
            net.layers{3}.transferFcn = 'purelin'; % Output layer: linear

            validId = true;
        case {3, 7}
            trainFcn = 'trainrp'; % Resilient Backpropapation
            hiddenLayerSize = [170, 85]; % TODO: ESCOLHER UMA CONFIGURAÇÃO
            net = feedforwardnet(hiddenLayerSize, trainFcn);
            net.layers{1}.transferFcn = 'poslin'; % TODO: ESCOLHER UMA CONFIGURAÇÃO
            net.layers{2}.transferFcn = 'poslin'; % TODO: ESCOLHER UMA CONFIGURAÇÃO
            net.layers{3}.transferFcn = 'purelin'; % Output layer: linear

            validId = true;
        case 4
            trainFcn = 'traincgp'; % Polak-Ribiére Conjugate Gradient 
            hiddenLayerSize = 25;
            net = feedforwardnet(hiddenLayerSize, trainFcn);
            net.layers{1}.transferFcn = 'poslin'; % ReLU
            net.layers{2}.transferFcn = 'purelin'; % Output layer: linear

            validId = true;
        case 5
            trainFcn = 'trainbr'; % Bayesian Regularization 
            hiddenLayerSize = [25, 25];
            net = feedforwardnet(hiddenLayerSize, trainFcn);
            net.layers{1}.transferFcn = 'tansig'; % Hyperbolic tangent
            net.layers{2}.transferFcn = 'tansig'; % Hyperbolic tangent
            net.layers{3}.transferFcn = 'purelin'; % Output layer: linear

            validId = true;
        case 6
            trainFcn = 'trainrp'; % TODO: ESCOLHER ALGORITMO
            hiddenLayerSize = [20, 15]; % TODO: ESCOLHER UMA CONFIGURAÇÃO
            net = feedforwardnet(hiddenLayerSize, trainFcn)
            net.layers{1}.transferFcn = 'poslin'; % TODO: ESCOLHER UMA CONFIGURAÇÃO
            net.layers{2}.transferFcn = 'poslin'; % TODO: ESCOLHER UMA CONFIGURAÇÃO
            net.layers{3}.transferFcn = 'purelin'; % Output layer: linear

            validId = true;
        otherwise
            error("Unexpected model identifier")
    end

    % Configure the preprocessing
    if validId
        net.inputs{1}.processParams{2}.ymin = 0;
        net.inputs{1}.processParams{2}.ymax = 1;
        net.outputs{2}.processParams{2}.ymin = 0;
        net.outputs{2}.processParams{2}.ymax = 1;
    end
end