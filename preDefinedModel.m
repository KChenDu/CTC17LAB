function net = preDefinedModel(identifier)
    switch identifier
        case 1
            trainFcn = 'trainlm'; % Levenberg-Marquardt
            hiddenLayerSize = 15;
            net = fitnet(hiddenLayerSize, trainFcn)
            net.layers{1}.transferFcn = 'tansig'; % Hyperbolic tangent
        case 2
            trainFcn = 'trainlm'; % Levenberg-Marquardt
            hiddenLayerSize = [10, 10];
            net = fitnet(hiddenLayerSize, trainFcn)
            net.layers{1}.transferFcn = 'poslin'; % ReLU
            net.layers{2}.transferFcn = 'poslin'; % ReLU
        case 3
            trainFcn = 'trainrp'; % Resilient Backpropapation
            hiddenLayerSize = 15; % ESCOLHER UMA CONFIGURAÇÃO
            net = fitnet(hiddenLayerSize, trainFcn)
        case 4
            trainFcn = 'traincgp'; % Polak-Ribiére Conjugate Gradient 
            hiddenLayerSize = 25;
            net = fitnet(hiddenLayerSize, trainFcn)
            net.layers{1}.transferFcn = 'poslin'; % ReLU
        case 5
            trainFcn = 'trainbr'; % Bayesian Regularization 
            hiddenLayerSize = [25, 25];
            net = fitnet(hiddenLayerSize, trainFcn)
            net.layers{1}.transferFcn = 'tansig'; % Hyperbolic tangent
            net.layers{2}.transferFcn = 'tansig'; % Hyperbolic tangent
        case 6
            trainFcn = 'trainbr'; % ESCOLHER ALGORITMO
            hiddenLayerSize = 15; % ESCOLHER UMA CONFIGURAÇÃO
            net = fitnet(hiddenLayerSize, trainFcn)
        otherwise
            error("Unexpected model identifier")
    end
end