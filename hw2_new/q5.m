clear;

m = 1: 20;

VC = sqrt(8 * log( 4*(2.*m).^50/0.05 ) ./ m);
plot(m, VC, 'y');
hold on
grid on
xlabel('m')

RP = sqrt(2 * log(2 * m.^51) ./ m) + sqrt(2 * log(1/0.05) ./ m) + 1 ./ m;
plot(m, RP, 'm');

VVC = sqrt(16 * log(2 * m.^50 / sqrt(0.05)) ./ m);
plot(m, VVC, 'c');

PVB = (1+sqrt(1+m.*log(120 * (2*m).^50))) ./ m;
plot(m, PVB, 'r');

D = zeros(size(m));
for i = 1: size(m, 2)
	epsilon_new = 20;
	epsilon_old = 40;
	while abs(epsilon_new - epsilon_old) > 1;
		epsilon_old = epsilon_new;
		epsilon_new = sqrt( ( 4*epsilon_old*(1+epsilon_old) + log(80) + 100*log(m(i)) )/( 2*m(i) ) );
	end
	D(i) = epsilon_new;
end

plot(m, D, 'g');
%ylim([0, 2.5]);
legend('VC', 'RP', 'VVC', 'PVB', 'D');
