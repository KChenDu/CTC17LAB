function data = getData(file)
    data = readtable(file);
    data(:, {'Date', 'Open', 'High', 'Low', 'AdjClose'}) = [];
    data = rmmissing(data);
    data(ismember(data.Volume, 0), :) = [];
    data(:, "Volume") = [];
    data = data.Close;
end