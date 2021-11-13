clear
clc

data = getData('PETR4.SA.csv');
len = length(data);
N = fix(len / 10);
x = zeros(10, 1);

for i = 1 : 9
    m = mean(data(1 : N));
    diff = data(1 : N) - m;
    Vk  = diff(1);
    RS = zeros(N, 1);
    V = zeros(N, 1);
    V(1) = Vk;
    for k = 2 : N
        Vk = Vk + diff(k);
        V(k) = Vk;
        RS(k) = (max(V(1 : k)) - min(V(1 : k))) / std(data(1 : k));
    end
    x(i) = mean(RS);
    data(1 : N) = [];
end

m = mean(data(1 : end));
diff = data(1 : end) - m;
Vk  = diff(1);
len = length(data);
RS = zeros(len, 1);
V = zeros(len, 1);
V(1) = Vk;
for k = 2 : len
    Vk = Vk + diff(k);
    V(k) = Vk;
    RS(k) = (max(V(1 : k)) - min(V(1 : k))) / std(data(1 : k));
end
x(10) = mean(RS);

% y = c * k^h;
% f = fit(x, y, 'exp1');