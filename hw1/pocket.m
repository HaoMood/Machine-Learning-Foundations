clear, clc

load train.dat;
% init.
X = ones(size(train));
X(:, 2: 5) = train(:, 1: 4);
y = train(:, 5);

load test.dat;
X_test = ones(size(test));
X_test(:, 2: 5) = test(:, 1: 4);
y_test = test(:, 5);
rng(0);
tot_rounds = 2000;

% PLA
has_mistake = true;
theta = zeros(size(X, 2), 1);
while has_mistake
	has_mistake = false;
	for i = randperm(size(X, 1))
		if sign(X(i, :) * theta) <= 0
			theta = theta + 0.5 * y(i) * X(i, :)';
			has_mistake = true;
		end
	end
	rounds(tot_rounds) = rounds(tot_rounds) + 1;
	end
	tot_rounds = tot_rounds - 1;
	fprintf('tot_rounds = %d\n', tot_rounds)
end

avg_update = sum(rounds) / 2000;

% done
fprintf('avg_update = %d\n', avg_update)
