function bret = has_mistake(X, theta, y)
	h = my_sign(X, theta);
	if isequal(h, y)
		bret = false;
	else
		bret = true;
	end
