function num = num_mistakes(X, theta, y)
	h = my_sign(X, theta);
	num = sum(h ~= y);
