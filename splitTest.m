function [X, T, testX, testT] = splitTest(X, T, testSize, inputSize, outputSize)
    % splitTest splits the data into training and test data
    % testT must predict testSize days, independent of its size

    % ERRADO:
    % outputSize = 3; testSize = 6;
    % [1 2 3] [4 5 6] -> testT_size = 2
    % testT_size = fix(testSize / outputSize)
    % CORRETO:
    % outputSize = 3; testSize = 6;
    % [1 2 3] [2 3 4] [3 4 5] [4 5 6] -> testT_size = 4
    testT_size = testSize - outputSize + 1


    % outputSize = 7
    % testSize = 12
    % _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
    
    % A partir daqui notação pythonica
    % objetivo: prever ultimos 90 dias
    % seja data o conjunto de todos os dados temporais
    % seja netInputSize = 10
    % seja netOutputSize = 5
    % trainSize + testSize == len(data)
    % pergunta: trainSize = ?
% trainEntrada contem os elementos:
    %   [data[t0i:t0i+netInputSize] for t0i in range(0:X)]
    % trainSaida contem os elementos:
    %   [data[tf:tf+netOutputSize] for tf in range(networkInputSize:X+networkInputSize)]
    % o ultimo elemento de trainSaida é data[X+networkInputSize-1:
    %                                        X+networkInputSize-1+networkOutputSize]
    % o ultimo elemento do ultimo elemento(sic) de trainSaida é
    %   data[X+networkInputSize+networkOutputSize - 1]
    % pergunta: pode o index disso daí ser maior que trainDatasetSize durante o treinamento?
    % vulgo, pode treinar com dados que teoricamente deveriam ser previstos no teste?
    % 
    
    % testT has testT_size elements of size outputSize
    testT = T(end - testT_size + 1 : end);
    T = T(1 : end - testT_size);
    
    % testX has testT_size elements of size size(x, 2)
    testX = X(:, end - testT_size + 1 : end);
    X = X(:, 1 : end - testT_size);
end
