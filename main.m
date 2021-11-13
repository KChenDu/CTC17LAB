clear
clc

data = readtable('PETR4.SA.csv');
data(:, {'Date', 'Open', 'High', 'Low', 'AdjClose'}) = [];
data = rmmissing(data);
data(ismember(data.Volume, 0), :) = [];
data(:, "Volume") = [];

X = [];
T1 = [];
T10 = [];

datasize = size(data);

for i = 1 : datasize(1) - 10
    X = [X, data.Close(i : i + 9)];
    T1 = [T1, data.Close(i + 10)];
    % T10 = [T10, data.Close(i + 10 : i + 19)]
end

testX = X(:, end - 30);
X = X(:, 1 : end - 31);
testT = T1(end - 30 : end);
T1 = T1(1 : end - 31);

% Training
setdemorandstream(23);
net = preDefinedModel(1);
[net, tr] = train(net, X, T1);
plotperform(tr)

% Test
Y = [];
for day = 1 : 30
    forecast = net(testX);
    testX = [testX(2 : end); forecast];
    Y = [Y, forecast];
end

plot(testT)
hold on
plot(Y)
legend({'actual','forcast'})