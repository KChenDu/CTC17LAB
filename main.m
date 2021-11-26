clear all
clc

data = getData('PETR4.SA.csv');
datasize = size(data , 1);

% Network parameters - central de mudanças
modelId = 7; % isso define, tambem, o tamanho do input e output

% flag30 = false; % é a flag que faz override dos tamanhos por 30
% inputSizeVector = [10, 10, 10, 10, 10, 10]; % TODO: 
% outputSizeVector = [1, 1, 1, 10, 10, 10]; % TODO: mudar os -1

inputSizeVector = [10, 10, 10, 10, 10, 10, 30]; % TODO: 
outputSizeVector = [1, 1, 1, 10, 10, 10, 30]; % TODO: mudar os -1

inputSize = inputSizeVector(modelId);
outputSize = outputSizeVector(modelId);

testSize = 90;
% testSize = 65; % starts in day 2021-07-19, three months before than
%                % last day in file: 2021-10-19

% Get input data and target data
[X, T] = getInputTarget(data, inputSize, outputSize);
% Get test data separately (testSize days)
[X, T, testX, testT] = splitTest(X, T, testSize, inputSize, outputSize);

% Training
setdemorandstream(23); % Seed para operações randomicas
net = preDefinedModel(modelId);
net.divideParam.trainRatio = 0.8;
net.divideParam.valRatio = 0.2;
net.divideParam.testRatio = 0;
[net, tr] = train(net, X, T);
plotperform(tr)

% Test
Y = [];
Yref = [];
for day = 1 : outputSize : size(testX, 2)
    % forecast = net(testX);
    % testX = [testX(2 : end); forecast]
    % Y = [Y, forecast];

    % display(testX(:, day));
    forecast = net(testX(:, day));
    Y = [Y; forecast];
    Yref = [Yref; testT(:, day)];
end

plot(Yref)
hold on
plot(Y)
[t,s] = title("Modelo " + num2str(modelId))
t.FontSize = 16;
t.FontName = 'arial'
t.FontWeight = 'bold'
legend({'actual','forcast'})

% Calculate std
std = sqrt(mean((Yref - Y).^2))