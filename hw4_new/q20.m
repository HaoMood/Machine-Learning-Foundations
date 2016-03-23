function q19()
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

	log_lambda_star = 1e3;
	J_cv_star = 1e5;

	for logLambda = 2:-1:-10
		lambda = 10^logLambda;

		J_cv = rigdeReg(X, y, lambda);

		if J_cv < J_cv_star
			J_cv_star = J_cv;
			log_lambda_star = logLambda;
		end
	end

	 theta = inv(10^log_lambda_star*eye(n+1, n+1) + X'*X) * X'*y;
	 J_in = ( sum( sign(X*theta) ~= y ) ) / m
	 J_out = ( sum( sign(X_test*theta) ~= y_test ) ) / m_test
	 

function J_cv = rigdeReg(X, y, lambda)
	J_cv = 0;
	for k = 1: 5
		X_cv = X((k-1)*40+1: 40 * k, :);
		y_cv = y((k-1)*40+1: 40 * k, :);

		if k == 1
			X_train = X(41: end, :);
			y_train = y(41: end, :);
		else
			if k == 5
				X_train = X(1: 160, :);
				y_train = y(1: 160, :);
			else
				X_train = X([1: (k-1)*40 40*k+1: end], :);
				y_train = y([1: (k-1)*40 40*k+1: end], :);
			end
		end

		[m_train, n] = size(X_train(:, 2: end));
		m_cv = size(X_cv, 1);

		theta = inv(lambda*eye(n+1, n+1) + X_train'*X_train) * X_train'*y_train;

		J_cv = J_cv + ( sum( sign(X_cv*theta) ~= y_cv ) ) / m_cv;
	end
	J_cv = J_cv / 5;
