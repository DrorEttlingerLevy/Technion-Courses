clc; clear; close all;
% Define the Rosenbrock function
rosenbrock = @(x, y) -cos(x).*cos(y).*exp(-((x-pi).^2+(y-pi).^2));
% Define the grid for plotting
x = linspace(-200, 100, 100);
y = linspace(-200, 100, 100);
[X, Y] = meshgrid(x, y);
Z = rosenbrock(X, Y);
% Create a larger figure for the surface plot
figure('Position', [100, 100, 800, 600]); % Set figure size (width, height)
surf(X, Y, Z);
shading interp;
colormap jet;
colorbar;
xlabel('x');
ylabel('y');
zlabel('z');
title('Rosenbrock Function Surface');
grid on;
hold on; % Keep the current plot

% Simulated Annealing Parameters
max_iterations = 10^4; % Maximum number of iterations
initial_temp = 100;     % Initial temperature
cooling_rate = 0.95;    % Cooling rate
min_temp = 1e-3;        % Minimum temperature
convergence_criteria = 1e-4; % Convergence criteria

% Set of different initial conditions
initial_conditions = [
   -2, -1;  % Initial condition 1
   1, 2;    % Initial condition 2
   -1, 3;   % Initial condition 3
   2, -2;   % Initial condition 4
   0, 0     % Initial condition 5
];

% Loop through each initial condition
for k = 1:size(initial_conditions, 1)
   % Initial solution
   current_solution = initial_conditions(k, :); % Use the k-th initial condition
   current_energy = rosenbrock(current_solution(1), current_solution(2));
   best_solution = current_solution;
   best_energy = current_energy;
   
   % Initialize counters and variables
   iteration = 0;
   function_evaluations = 0; % Count of function evaluations
   change = inf; % Initialize change to a large number
   last_step_size = 0; % To store the step size of the last iteration
   last_change_in_value = 0; % To store the change in function value of the last iteration
   
   % Simulated Annealing Main Loop
temperature = initial_temp;
while temperature > min_temp && iteration < max_iterations
    iteration = iteration + 1;
    previous_solution = current_solution; % Store the previous solution
    previous_energy = current_energy; % Store the previous function value

    for i = 1:max_iterations
        % Generate a new solution by perturbing the current solution
        new_solution = current_solution + randn(1, 2) * 0.1; % Small random step
        new_energy = rosenbrock(new_solution(1), new_solution(2));
        function_evaluations = function_evaluations + 1; % Increment function evaluations

        % Calculate the change in energy
        delta_energy = new_energy - current_energy;

        % Accept the new solution with a certain probability
        if delta_energy < 0 || rand() < exp(-delta_energy / temperature)
            current_solution = new_solution;
            current_energy = new_energy;

            % Update the best solution found
            if current_energy < best_energy
                best_solution = current_solution;
                best_energy = current_energy;
            end
        end

        % Calculate the change in the solution
        change = norm(current_solution - previous_solution); % Euclidean distance
        last_step_size = change; % Store the step size of the last iteration
        last_change_in_value = current_energy - previous_energy; % Correct function value change

        % **Stop immediately if convergence is reached**
        if change <= convergence_criteria
            break; % Exit inner loop
        end
    end

    % **Break outer loop as well if convergence is reached**
    if change <= convergence_criteria
        break;
    end

    % Cool down the temperature
    temperature = temperature * cooling_rate;
end

   
   % Display results for the current initial condition
   fprintf('Initial Condition %d:\n', k);
   fprintf('Number of iterations: %d\n', iteration);
   fprintf('Number of function evaluations: %d\n', function_evaluations);
   fprintf('Step size on the last iteration: %f\n', last_step_size);
   fprintf('Change in function value on the last iteration: %f\n', last_change_in_value);
   fprintf('Minimum position (x, y): (%f, %f)\n', best_solution(1), best_solution(2));
   fprintf('Minimum value: %f\n\n', best_energy);
   
   % Mark the minimum position on the plot for the current initial condition
   plot3(best_solution(1), best_solution(2), best_energy, 'ro', 'MarkerSize', 8, 'LineWidth', 5); % Circle for the best solution
end
hold off; % Release the plot hold
title('Rosenbrock Function solved with SA'); % Update title
view(3); % Set the view for 3D plot