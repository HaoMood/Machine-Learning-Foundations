function q20()
	clear
	% load data
	load train.dat
	X = train(:, 1: end-1);
	[m, n] = size(X);
	X = [ones(m, 1) X];
	y = train(:, end);
	
	load test.dat
	X_test = test(:, 1: end-1);
	m_test = size(X_test, 1);
	X_test = [ones(m_test, 1) X_test];
	y_test = test(:, end);

	% para
	alpha = 0.001;
	T = 2000;

	% init
	theta = pinv(X) * y;
	%theta = zeros(n+1, 1);

	% train
	while T > 0
		for i = 1: m
			grad = g( -y(i)*(X(i, :)*theta) ) * y(i)*X(i, :)';
			theta = theta - alpha * grad;
			T = T - 1;
		end
	end

	% test
	hx = sign(X_test * theta)
	J_out = sum(hx ~= y_test) / m_test

function gs = g(s)
	[m, n] = size(s);
	gs = 1 ./ (ones(m, n) + exp(-s));
