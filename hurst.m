clear
clc

data = getData('PETR4.SA.csv');

y = [];
x = [];
len = length(data);
N = len;

while N > 4
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
    N = ceil(N / 2);
end

x = log2(x);
y = log2(y);

hurst_exp = regress(y, x)

function RS = getRS(data)
    m = mean(data);
    diff = data - m;
    Vk  = diff(1);
    N = length(data);
    V = zeros(N, 1);
    V(1) = Vk;
    for k = 2 : N
        Vk = Vk + diff(k);
        V(k) = Vk;
    end
    RS = (max(V) - min(V)) / std(data);
end