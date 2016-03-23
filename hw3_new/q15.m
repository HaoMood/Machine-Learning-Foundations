function q15()
	clear
	rng(0);

		m = 1000;
		n = 2;
		X = rand(m, n)*2 - ones(m, n);
		y = sign(X(:, 1).^2 + X(:, 2).^2 - 0.6*ones(m, 1));
		flip_idx = rand(m, 1) < 0.1;
		y(flip_idx) = -y(flip_idx);
		X = [ones(m, 1) X];

		nt = 5;
		Z = ones(m, nt+1);
		Z(:, 2: 3) = X(:, 2: 3);
		Z(:, 4) = Z(:, 2) .* Z(:, 3);
		Z(:, 5) = Z(:, 2).^2;
		Z(:, 6) = Z(:, 3).^2;

		theta = pinv(Z) * y;
		hz = sign(Z * theta);

		J_in = sum((hz ~= y)) / m

		% test
		X_test = rand(m, n)*2 - ones(m, n);
		y_test = sign(X_test(:, 1).^2 + X_test(:, 2).^2 - 0.6*ones(m, 1));
		flip_idx = rand(m, 1) < 0.1;
		y_test(flip_idx) = -y_test(flip_idx);
		X_test = [ones(m, 1) X_test];
		
		nt = 5;
		Z_test = ones(m, nt+1);
		Z_test(:, 2: 3) = X_test(:, 2: 3);
		Z_test(:, 4) = Z_test(:, 2) .* Z_test(:, 3);
		Z_test(:, 5) = Z_test(:, 2).^2;
		Z_test(:, 6) = Z_test(:, 3).^2;

		hz_test = sign(Z_test * theta);
		J_out = sum((hz_test ~= y_test)) / m
