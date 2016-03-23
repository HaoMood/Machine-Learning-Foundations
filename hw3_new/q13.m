function q13()
	clear
	rng(0);

	rounds = 1000;
	J_in = zeros(rounds, 1);

	while rounds > 0;
	
		m = 1000;
		n = 2;
		X = rand(m, n)*2 - ones(m, n);
		y = sign(X(:, 1).^2 + X(:, 2).^2 - 0.6*ones(m, 1));
		flip_idx = rand(m, 1) < 0.1;
		y(flip_idx) = -y(flip_idx);
		X = [ones(m, 1) X];

		theta = pinv(X) * y;
		hx = sign(X * theta);

		J_in(rounds) = sum((hx ~= y)) / m;

		rounds = rounds - 1;
	end

	fprintf('%f\n', sum(J_in) / 1000);
