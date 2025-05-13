% Ergodic Theorem Simulation: Rain/No Rain Weather Model

% transition Matrix, play around changing the values!!
P = [0.9, 0.1;   % from Rain
     0.4, 0.6];  % from No Rain

% number of days to simulate
n_steps = 500;

% initial state: 1 = Rain, 2 = No Rain
state = 1;
states = zeros(1, n_steps+1);
states(1) = state;

pi_eq = null(P' - eye(2))'; 
pi_eq = pi_eq / sum(pi_eq);

% simulate the Markov chain
for t = 2:n_steps+1
    probs = P(state, :);
    state = find(rand < cumsum(probs), 1);
    states(t) = state;
end



% calculate running fraction of Rain (state == 1)
rain_fraction = cumsum(states == 1) ./ (1:n_steps+1);

%theoretical equilibrium probability of Rain

%pi_eq_rain_P = 0.5714; questo per P =[0.7,0.3;0.4,0.6];

% plot results
figure;
plot(1:n_steps+1, rain_fraction, 'b', 'LineWidth', 2);
hold on;
yline(pi_eq, 'r--', 'LineWidth', 2);
xlabel('Days');
ylabel('Fraction of Rainy Days');
title('Ergodic Theorem Simulation: Weather Markov Chain');
legend('Simulated Rain Fraction', 'Location', 'best');
grid on;

% Example: Stationary distribution for a 3-state Markov chain

% Define the transition matrix (3x3 stochastic matrix)
P_2 = [0.5, 0.3, 0.2;
     0.2, 0.7, 0.1;
     0.3, 0.4, 0.3];

%Get the size of the matrix
n = size(P_2, 1);

%Construct the system of equations to solve pi * P = pi, with sum(pi) = 1
A = [P_2' - eye(n);         % Stationary condition (pi * P = pi)
     ones(1, n)];         % Normalization condition (sum(pi) = 1)

b = [zeros(n, 1);         % Right-hand side: zeros for eigenvector condition
     1];                  % One for normalization

% Solve the linear system
pi_eq_2 = A \ b;

% Display result
disp('Stationary distribution:');
disp(pi_eq);
