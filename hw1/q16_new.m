clear
load train.dat
X = ones(size(train));
X(:, 2: end) = train(:, 1: 4);
y = train(:, 5);
[m, n] = size(X);
rng(0);
tot_iter = 0;
num_rounds = 0;

while num_rounds ~= 2000
	cycles = randperm(m);

	theta = zeros(n, 1);
	% PLA
	while has_mistake(X, theta, y);
		for i = cycles
			if my_sign(X(i, :), theta) ~= y(i);
				theta = theta + y(i) * X(i, :)';
				tot_iter = tot_iter + 1;
			end
		end
	end

	num_rounds = num_rounds + 1;
	fprintf('num_rounds = %d, tot_iter = %d\n', num_rounds, tot_iter);
end

fprintf('avg. rounds is %d\n', tot_iter/2000);
