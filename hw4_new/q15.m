function q15()
	clear
	load train.dat
	X = train(:, 1: end - 1);
	y = train(:, end);
	[m, n] = size(X);
	X = [ones(m, 1) X];
	load test.dat;
	X_test = test(:, 1: end - 1);
	y_test = test(:, end);
	m_test = size(X_test, 1);
	X_test = [ones(m_test, 1) X_test];

	lambda_star = 1e3;
	J_in_star = 1e5;
	J_out_star = 1e5;

	for logLambda = 2:-1:-10
		lambda = 10^logLambda;
		[J_in, J_out] = rigdeReg(X, X_test, y, y_test, lambda);

		if J_out < J_out_star
			J_in_star = J_in;
			J_out_star = J_out;
			lambda_star = lambda;
		end
	end

	lambda_star
	J_in_star
	J_out_star

function [J_in, J_out] = rigdeReg(X, X_test, y, y_test, lambda)
	[m, n] = size(X(:, 2: end));
	m_test = size(X_test, 1);
	theta = inv(lambda*eye(n+1, n+1) + X'*X) * X'*y;

	J_in = ( sum( sign(X*theta) ~= y ) ) / m;
	J_out = ( sum( sign(X_test*theta) ~= y_test ) ) / m_test;
