% Project 11: Investigating the Onset of Chaos in the Logistic Map
% Tyson Shannon, Soung Bin Kwon
% Logistic Map Bifurcation Analysis with Lyapunov Exponent Calculation
clc; clear; close all;
tic %start program timer

% Define r values
r_values = linspace(2.5, 4, 500); % Range of r from 2.5 to 4
num_iterations = 1000;  % Total iterations
num_last = 200;         % How many values to plot (ignore transients)

% Different initial conditions
x0_values = [0.5]; % change me --------------
colors = lines(length(x0_values)); % Get distinct colors for each x0

figure; hold on; % Create bifurcation diagram figure
xlabel('r'); ylabel('x'); title('Bifurcation Diagram for Different x_0');
legend_entries = cell(1, length(x0_values));

% Lyapunov exponent setup
lyap_r = linspace(2.5, 4, 500);  % Same r range 2.5-4
lyap_exp = zeros(length(lyap_r), length(x0_values)); % Store Lyapunov exponents

for j = 1:length(x0_values)
    x0 = x0_values(j) % Pick an initial condition
    bifurcation_points = []; % Store steady-state values
    
    for i = 1:length(r_values)
        r = r_values(i);
        x = x0; % Initialize x for each r
        sum_lyap = 0; % Sum for Lyapunov exponent calculation
        
        % Iterate the logistic map
        for n = 1:num_iterations
            x = r * x * (1 - x); %change to different maps -----------
            
            % Lyapunov exponent sum update
            if x > 0 && x < 1
                sum_lyap = sum_lyap + log(abs(r * (1 - 2*x)));
            end

            % Ignore transients, store steady-state values
            if n > (num_iterations - num_last) 
                bifurcation_points = [bifurcation_points; r, x]; 
            end
        end
        
        % Compute Lyapunov exponent for this r
        lyap_exp(i, j) = sum_lyap / num_iterations;
    end
    
    % Plot bifurcation diagram for this x0
    scatter(bifurcation_points(:,1), bifurcation_points(:,2), 1, colors(j, :), 'filled');
    legend_entries{j} = sprintf('x_0 = %.2f', x0);
end

legend(legend_entries); % Add legend
hold off;

% Plot Lyapunov exponent vs r
figure; hold on;
xlabel('r'); ylabel('Lyapunov Exponent');
title('Lyapunov Exponent vs. r for Different x_0');
for j = 1:length(x0_values)
    plot(lyap_r, lyap_exp(:, j), 'Color', colors(j, :), 'LineWidth', 1.5);
end
yline(0, 'k--'); % Mark zero line for chaos transition
legend(legend_entries);
hold off;

toc %end program timer
