%% 1_a
function norms = MyDist_a(P,P0)
    norms = sqrt((P(:,1)-P0(1)).^2+(P(:,2)-P0(2)).^2)
end

%% 1_b
function norms = MyDist_b(P,P0)
norms = [];
for i = 1:size(P,1)
       R = sqrt((P(i,1)-P0(1))^2+(P(i,2)-P0(2))^2);
       norms(end+1) = R;
end
End

%% 1_d
function [] = MyPlot(P, P0)
norms = MyDist_a(P, P0);
 
scatter(P(:,1), P(:,2), 'filled');
hold on;
% Plot lines from each point in P to P0
for i = 1:size(P, 1)
    plot([P(i, 1), P0(1)], [P(i, 2), P0(2)], 'r'); 
    text(P(i, 1), P(i, 2), ['P' num2str(i)], 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
   
    % Annotate the distance with a smaller offset
    offset = 0.02; 
    rounded_distance = round(norms(i), 2); % Round the distance to the hundredths place
    text((P(i, 1) + P0(1)) / 2 + offset, ...
         (P(i, 2) + P0(2)) / 2 + offset, ...
         num2str(rounded_distance, '%.2f'), 'Color', 'blue', 'FontSize', 8); 
end

% Plot P0
scatter(P0(1), P0(2), 'filled', 'MarkerFaceColor', 'g');
text(P0(1), P0(2), 'P0', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right', 'Color', 'green');

% Set axis labels and title
xlabel('X-axis');
ylabel('Y-axis');
title('Scatter plot of points with Euclidean distances to P0');
grid on;
hold off;
end


%% 2_a
syms x y;
f = sin(x) * log(x * y);
a_x = 1;
a_y = 1;
f_a = subs(f, {x, y}, {a_x, a_y});
f_x = diff(f, x);
f_y = diff(f, y);
f_x_a = subs(f_x, {x, y}, {a_x, a_y});
f_y_a = subs(f_y, {x, y}, {a_x, a_y});
f_xx_a = subs(diff(f_x, x), {x, y}, {a_x, a_y});
f_yy_a = subs(diff(f_y, y), {x, y}, {a_x, a_y});
f_xy_a = subs(diff(f_x, y), {x, y}, {a_x, a_y});
f_xxx_a = subs(diff(f_xx_a, x), {x, y}, {a_x, a_y});
f_yyy_a = subs(diff(f_yy_a, y), {x, y}, {a_x, a_y});
f_xxy_a = subs(diff(f_xx_a, y), {x, y}, {a_x, a_y});
f_xyy_a = subs(diff(f_xy_a, y), {x, y}, {a_x, a_y});
f_xyx_a = subs(diff(f_xy_a, x), {x, y}, {a_x, a_y});
% Taylor Polynomial of order 1
T1 = f_a + f_x_a * (x - a_x) + f_y_a * (y - a_y);
% Taylor Polynomial of order 2
T2 = T1 + (f_xx_a / 2) * (x - a_x)^2 + (f_yy_a / 2) * (y - a_y)^2 + f_xy_a * (x - a_x) * (y - a_y);
% Taylor Polynomial of order 3
T3 = T2 + (f_xxx_a / 6) * (x - a_x)^3 + (f_yyy_a / 6) * (y - a_y)^3 + ...
   (f_xxy_a / 2) * (x - a_x)^2 * (y - a_y) + (f_xyy_a / 2) * (x - a_x) * (y - a_y)^2 + ...
   (f_xyx_a / 6) * (x - a_x)^2 * (y - a_y);
% Results
disp('Taylor Polynomial of Order 1:');
pretty(T1)
disp('Taylor Polynomial of Order 2:');
pretty(T2)
disp('Taylor Polynomial of Order 3:');
pretty(T3)

%% 2_b
% Change symbolics to functions for plotting
f_handle = matlabFunction(f);
T1_handle = matlabFunction(T1);
T2_handle = matlabFunction(T2);
T3_handle = matlabFunction(T3);

% Create a grid
[x_vals, y_vals] = meshgrid(0.5:0.01:1.5, 0.5:0.01:1.5);

% Functions on the grid
f_vals = f_handle(x_vals, y_vals);
T1_vals = T1_handle(x_vals, y_vals);
T2_vals = T2_handle(x_vals, y_vals);
T3_vals = T3_handle(x_vals, y_vals);

%Plotting
figure;
hold on;
% Original function
surf(x_vals, y_vals, f_vals, 'FaceColor', 'interp', 'FaceAlpha', 0.5, 'EdgeColor', 'none', 'DisplayName', 'Original Function f(x,y)');
% Taylor approximations
surf(x_vals, y_vals, T1_vals, 'FaceColor', 'red', 'FaceAlpha', 0.5, 'EdgeColor', 'none', 'DisplayName', 'Taylor Polynomial Order 1');
surf(x_vals, y_vals, T2_vals, 'FaceColor', 'green', 'FaceAlpha', 0.5, 'EdgeColor', 'none', 'DisplayName', 'Taylor Polynomial Order 2');
surf(x_vals, y_vals, T3_vals, 'FaceColor', 'blue', 'FaceAlpha', 0.5, 'EdgeColor', 'none', 'DisplayName', 'Taylor Polynomial Order 3');
% graph setting
view(45, 30);
xlabel('x');
ylabel('y');
zlabel('f(x,y)');
title('Function and Taylor Approximations');
legend('Location', 'Best');
xlim([0.5, 1.5]);
ylim([0.5, 1.5]);
zlim([-1, 2]); 
grid on;
hold off;

%% 3
clc;
x = [1; 1]; 
x_prev = x;
e = 1e-5;
IterN = 0;
while norm(x - x_prev) > e
   x_prev = x;
  
   % System of equations
   F = [x(1)^2 + x(2)^2 - 4; 
        exp(x(1)) + x(2) - 1]; 

   % Jacobian matrix
   J = [2*x(1), 2*x(2);       
        exp(x(1)), 1];    
  
   % Newton's method
   dx = -J \ F; 
   x = x + dx; % Update x
   IterN = IterN + 1; % Iteration count
end
% Results
disp('Solution:');
disp(x);
disp('Number of iterations:');
disp(IterN);

 