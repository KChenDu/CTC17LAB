function [X, T, testX, testT] = splitTest(X, T, testSize, inputSize, outputSize)
    % splitTest splits the data into training and test data
    % testT must predict testSize days, independent of its size

    actualTestSize = testSize - outputSize + 1;
    trainBegin = 1;
    trainEnd = size(X, 2) - testSize;
    testBegin = size(X, 2) - testSize + outputSize;
    testEnd = size(X, 2);
    
    testT = T(:, testBegin : testEnd);
    T = T(:, trainBegin : trainEnd);

    testX = X(:, testBegin : testEnd);
    X = X(:, trainBegin : trainEnd);

    % testT has testT_size elements of size outputSize
    % testT = T(:, end - actualTestSize + 1 : end);
    % T = T(:, 1 : end - actualTestSize);
    
    % testX has testT_size elements of size size(x, 2)
    % testX = X(:, end - actualTestSize + 1 : end);
    % X = X(:, 1 : end - actualTestSize);
end
