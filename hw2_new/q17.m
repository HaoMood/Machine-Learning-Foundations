clear
rng(0);
m = 20;
J_in_vec = zeros(5000, 1);

round_cnt = 0;
while round_cnt < 5000
	%  ================ gen. data ===================
	X = 2 * rand(m, 1) - ones(m, 1);
	y = sign(X);
	flip_idx = rand(m, 1) < 0.2;
	y(flip_idx) = -y(flip_idx);

	% ================ dec. stump ===================
	X_sorted = sort(X);
	theta_range = [-2 ( X_sorted(2: end)'-X_sorted(1: end-1)' )/ 2];

	J_in_star = 1;
	theta_star = 0;
	s_star = 0;
	for theta = theta_range
		J_in = sum( sign(X - theta*ones(m, 1)) ~= y ) ./ m;
		if J_in < J_in_star
			J_in_star = J_in;
			theta_star = theta;
			s_star = +1;
		end
		if (1-J_in) < J_in_star
			J_in_star = 1-J_in;
			theta_star = theta;
			s_star = -1;
		end
	end
	
	% ==================  eval ======================
	round_cnt = round_cnt + 1;
	J_in_vec(round_cnt) = J_in_star;
	fprintf('round: %d, J_in_star = %f\n', round_cnt, J_in_star);
end

fprintf('avg. J_in = %f\n', sum(J_in_vec)/5000);
