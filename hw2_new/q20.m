clear, clc;
load train.dat;
X = train(:, 1: end - 1);
[m, n] = size(X);
y = train(:, end);
load test.dat;
X_test = test(:, 1: end - 1);
y_test = test(:, end);
m_test = size(X_test, 1);

theta_star = zeros(1, n);
s_star = zeros(1, n);
J_in_star = ones(1, n);
for	j = 1: n
	% dec. stump for one dim.
	xj = X(:, j);
	xj_sorted = sort(xj);
	theta_range = [-100 ( xj_sorted(2: end)'-xj_sorted(1: end-1)' )/2];

	for theta = theta_range
		J_in = sum( sign(xj - theta*ones(m, 1)) ~= y ) ./ m;
		if J_in < J_in_star(j)
			J_in_star(j) = J_in;
			theta_star(j) = theta;
			s_star(j) = +1;
		end
		if (1-J_in) < J_in_star(j)
			J_in_star(j) = 1-J_in;
			theta_star(j) = theta;
			s_star(j) = -1;
		end
	end
end

[J_in_star_star j_star] = min(J_in_star);
fprintf('J_in_star_star = %f, j_star = %d\n', J_in_star_star, j_star);

J_out = sum( s_star(j_star) * sign(X_test(:, j_star) - theta_star(j_star)*ones(m_test, 1)) ~= y_test ) ./ m_test;
fprintf('J_out = %f\n', J_out);
