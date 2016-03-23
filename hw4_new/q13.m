function q13()
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

	lambda = 10;

	theta = inv(lambda*eye(n+1, n+1) + X'*X) * X'*y;

	J_in = ( sum( sign(X*theta) ~= y ) ) / m
	J_out = ( sum( sign(X_test*theta) ~= y_test ) ) / m_test

