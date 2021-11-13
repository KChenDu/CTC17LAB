function [X, T] = getInputTarget(data, inputSize, outputSize)
    X = [];
    T = [];
    for i = 1 : size(data) - outputSize - inputSize + 1
        X = [X, data(i : i + inputSize - 1)];
        T = [T, data(i + inputSize : i + inputSize + outputSize - 1)];
    end
end
