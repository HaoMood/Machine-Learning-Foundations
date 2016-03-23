function q17()
	clear
	load train.dat
	X = train(:, 1: end - 1);
	y = train(:, end);
	[m, n] = size(X);
	X = [ones(m, 1) X];
	X_train = X(1: 120, :);
	y_train = y(1: 120, :);
	m_train = 120;
	X_val = X(121: end, :);
	y_val = y(121: end, :);
	m_val = 80;
	load test.dat;
	X_test = test(:, 1: end - 1);
	y_test = test(:, end);
	m_test = size(X_test, 1);
	X_test = [ones(m_test, 1) X_test];

	lambda_star = 1e3;
	J_train_star = 1e5;
	J_val_star = 1e5;
	J_out_star = 1e5;

	for logLambda = 2:-1:-10
		lambda = 10^logLambda;
		[J_train, J_val, J_out] = rigdeReg(X_train, X_val, X_test, y_train, y_val, y_test, lambda);

		if J_val < J_val_star
			J_train_star = J_train;
			J_val_star = J_val;
			J_out_star = J_out;
			lambda_star = logLambda;
		end
	end

	lambda_star
	J_train_star
	J_val_star
	J_out_star

function [J_train, J_val, J_out] = rigdeReg(X_train, X_val, X_test, y_train, y_val, y_test, lambda)
	[m_train, n] = size(X_train(:, 2: end));
	m_val = size(X_val, 1);
	m_test = size(X_test, 1);

	theta = inv(lambda*eye(n+1, n+1) + X_train'*X_train) * X_train'*y_train;

	J_train = ( sum( sign(X_train*theta) ~= y_train ) ) / m_train;
	J_val = ( sum( sign(X_val*theta) ~= y_val ) ) / m_val;
	J_out = ( sum( sign(X_test*theta) ~= y_test ) ) / m_test;
