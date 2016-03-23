function h = my_sign(X, theta)
	h = sign(X * theta);
	h(h == 0) = -1;
