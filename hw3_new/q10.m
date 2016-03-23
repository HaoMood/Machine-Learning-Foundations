function q10()
	clear
	theta = [0; 0];
	Hessian(theta)
	theta = theta - inv(Hessian(theta)) * gradF(theta);
	theta = theta - inv(Hessian(theta)) * gradF(theta);
	theta = theta - inv(Hessian(theta)) * gradF(theta);
	theta = theta - inv(Hessian(theta)) * gradF(theta);
	theta = theta - inv(Hessian(theta)) * gradF(theta);

	x = theta(1);
	y = theta(2);
	f = exp(x) + exp(2*y) + exp(x*y) + x*x - 2*x*y + 2*y*y - 3*x - 2*y;
	fprintf('%f\n', f)


function grad = gradF(theta)
	x = theta(1);
	y = theta(2);
	grad = zeros(2, 1);
	grad(1) = exp(x) + y*exp(x) + 2*x - 2*y - 3;
	grad(2) = 2*exp(2*y) + x*exp(y) - 2*x + 4*y - 2;

function H = Hessian(theta)
	x = theta(1);
	y = theta(2);
	H = zeros(2, 2);
	H(1, 1) = exp(x) + y*exp(x) + 2;
	H(2, 2) = 4*exp(2*y) + x*exp(y) + 4;
	H(1, 2) = exp(x) - 2;
	H(2, 1) = H(1, 2);
