clear
clc

data = getData('PETR4.SA.csv');

len = length(data);
y = [];
x = [];
N = 8;

while N < len
    x = [x; N];
    prev = 1;
    RSk = [];
    i = N;
    while i < len
        RSk = [RSk getRS(data(prev : i))];
        prev = i + 1;
        i = N + i;
    end
    RSk = [RSk getRS(data(prev : end))];
    y = [y; mean(RSk)];
    N = 2 * N;
end
x = [x; len];
y = [y; getRS(data)];

x = log2(x);
y = log2(y);

hurst_exp = regress(y, x);

function RS = getRS(data)
    m = mean(data);
    diff = data - m;
    Vk  = diff(1);
    N = length(data);
    % RS = zeros(N, 1);
    V = zeros(N, 1);
    V(1) = Vk;
    for k = 2 : N
        Vk = Vk + diff(k);
        V(k) = Vk;
        % RS(k) = (max(V(1 : k)) - min(V(1 : k))) / std(data(1 : k));
    end
    RS = (max(V) - min(V)) / std(data);
    %RS = mean(RS);
end