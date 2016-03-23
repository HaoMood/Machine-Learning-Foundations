clear
load pocket_train.dat
X = ones(size(pocket_train));
X(:, 2: end) = pocket_train(:, 1: 4);
y = pocket_train(:, 5);
[m, n] = size(X);
load pocket_test.dat;
X_test = ones(size(pocket_test));
X_test(:, 2: end) = pocket_test(:, 1: 4);
y_test = pocket_test(:, 5);
m_test = size(X_test, 1);
tot_err_rate = 0;

rng(0);
num_rounds = 0;
while num_rounds ~= 2000
	cycles = randperm(m);
	theta_star = zeros(n, 1);
	theta = zeros(n, 1);
	pocket_rounds = 0;

	% PLA
	while pocket_rounds <= 100;
		for i = cycles
			if my_sign(X(i, :), theta) ~= y(i);
				theta = theta + y(i) * X(i, :)';
				pocket_rounds = pocket_rounds + 1;
			end

			if num_mistakes(X, theta, y) < num_mistakes(X, theta_star, y)
				theta_star = theta;
			end
		end

	end

	% eval
	tot_err_rate = tot_err_rate + num_mistakes(X_test, theta_star, y_test) / m_test;
	num_rounds = num_rounds + 1;
	fprintf('num_rounds = %d, tot_err_rate = %f\n', num_rounds, tot_err_rate);
end

fprintf('avg. rounds is %f\n', tot_err_rate/2000);
