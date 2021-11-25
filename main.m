clear
clc

data = getData('PETR4.SA.csv');
datasize = size(data , 1);

% Network parameters
inputSize = 10;
outputSize = 1;
modelId = 1;
testSize = 65; % starts in day 2021-07-19, three months before than
               % last day in file: 2021-10-19

% Get input data and target data
[X, T] = getInputTarget(data, inputSize, outputSize);
% Get test data separately (testSize days)
[X, T, testX, testT, actualTestSize] = splitTest(X, T, testSize, inputSize, outputSize);

% Training
setdemorandstream(23);
net = preDefinedModel(modelId);
net.divideParam.testRatio = 0;
[net, tr] = train(net, X, T);
plotperform(tr)

% Test
Y = [];
for day = 1 : actualTestSize
    % Alteração do Moc™
    % forecast = net(testX);
    % testX = [testX(2 : end); forecast]
    % Y = [Y, forecast];
    display(testX(:,day));
    forecast = net(testX(:, day));
    Y = [Y, forecast];
end

plot(testT)
hold on
plot(Y)
legend({'actual','forcast'})