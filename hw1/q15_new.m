clear
load train.dat
X = ones(size(train));
X(:, 2: end) = train(:, 1: 4);
y = train(:, 5);
[m, n] = size(X);
theta = zeros(n, 1);
tot_rounds = 0;

while has_mistake(X, theta, y);
	for i = 1: m
		if my_sign(X(i, :), theta) ~= y(i);
			theta = theta + y(i) * X(i, :)';
			tot_rounds = tot_rounds + 1;
		end
	end
end

fprintf('tot. rounds is %d\n', tot_rounds);


