clear
clc

data = getData('PETR4.SA.csv');
datasize = size(data , 1);

% Network parameters
inputSize = 10;
outputSize = 1;
modelId = 1;
testSize = 90;

% Get input data and target data
[X, T] = getInputTarget(data, inputSize, outputSize);
% Get test data separately (testSize days)
[X, T, testX, testT] = splitTest(X, T, testSize, inputSize, outputSize);

% Training
setdemorandstream(23);
net = preDefinedModel(modelId);
net.divideParam.testRatio = 0;
[net, tr] = train(net, X, T);
plotperform(tr)

% Test
Y = [];
for day = 1 : testSize
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