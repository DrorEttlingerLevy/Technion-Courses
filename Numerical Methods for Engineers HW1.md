**Numerical methods for engineers \- HW 1**

**[1\_a	1](#1_a)**

[**1\_b	1**](#1_b)

[**1\_c	1**](#1_c)

[**1\_d	1**](#1_d)

[**2\_a	3**](#2_a)

[**2\_b	4**](#2_b)

[**4	6**](#heading)

### 1\_a {#1_a}

1. function norms \= MyDist\_a(P,P0)  
      norms \= sqrt((P(:,1)-P0(1)).^2+(P(:,2)-P0(2)).^2)  
   end

### 1\_b {#1_b}

2. function norms \= MyDist\_b(P,P0)  
   norms \= \[\];  
   for i \= 1:size(P,1)  
      R \= sqrt((P(i,1)-P0(1))^2+(P(i,2)-P0(2))^2);  
      norms(end+1) \= R;  
   end  
   End

### 1\_c {#1_c}

3. MyDist\_a: 0.006440 seconds  
   MyDist\_b: 0.041396 seconds

### 1\_d {#1_d}

4. function \[\] \= MyPlot(P, P0)  
      % Calculate the Euclidean norms using the MyDist\_a function  
      norms \= MyDist\_a(P, P0);  
       
      % Create scatter plot of points  
      scatter(P(:,1), P(:,2), 'filled');  
      hold on;  
       
      % Plot lines from each point in P to P0  
      for i \= 1:size(P, 1\)  
          plot(\[P(i, 1), P0(1)\], \[P(i, 2), P0(2)\], 'r'); % Draw solid red line  
          % Annotate the index of the point with 'P1', 'P2', etc.  
          text(P(i, 1), P(i, 2), \['P' num2str(i)\], 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');  
           
          % Annotate the distance with a smaller offset to avoid overlap and round to hundredths  
          offset \= 0.02; % Define a smaller offset  
          rounded\_distance \= round(norms(i), 2); % Round the distance to the hundredths place  
          text((P(i, 1\) \+ P0(1)) / 2 \+ offset, ...  
               (P(i, 2\) \+ P0(2)) / 2 \+ offset, ...  
               num2str(rounded\_distance, '%.2f'), 'Color', 'blue', 'FontSize', 8); % Format to two decimal places  
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
     
   

   

### 2\_a {#2_a}

syms x y;  
f \= sin(x) \* log(x \* y);  
a\_x \= 1;  
a\_y \= 1;  
f\_a \= subs(f, {x, y}, {a\_x, a\_y});  
f\_x \= diff(f, x);  
f\_y \= diff(f, y);  
f\_x\_a \= subs(f\_x, {x, y}, {a\_x, a\_y});  
f\_y\_a \= subs(f\_y, {x, y}, {a\_x, a\_y});  
f\_xx\_a \= subs(diff(f\_x, x), {x, y}, {a\_x, a\_y});  
f\_yy\_a \= subs(diff(f\_y, y), {x, y}, {a\_x, a\_y});  
f\_xy\_a \= subs(diff(f\_x, y), {x, y}, {a\_x, a\_y});  
f\_xxx\_a \= subs(diff(f\_xx\_a, x), {x, y}, {a\_x, a\_y});  
f\_yyy\_a \= subs(diff(f\_yy\_a, y), {x, y}, {a\_x, a\_y});  
f\_xxy\_a \= subs(diff(f\_xx\_a, y), {x, y}, {a\_x, a\_y});  
f\_xyy\_a \= subs(diff(f\_xy\_a, y), {x, y}, {a\_x, a\_y});  
f\_xyx\_a \= subs(diff(f\_xy\_a, x), {x, y}, {a\_x, a\_y});  
% Taylor Polynomial of order 1  
T1 \= f\_a \+ f\_x\_a \* (x \- a\_x) \+ f\_y\_a \* (y \- a\_y);  
% Taylor Polynomial of order 2  
T2 \= T1 \+ (f\_xx\_a / 2\) \* (x \- a\_x)^2 \+ (f\_yy\_a / 2\) \* (y \- a\_y)^2 \+ f\_xy\_a \* (x \- a\_x) \* (y \- a\_y);  
% Taylor Polynomial of order 3  
T3 \= T2 \+ (f\_xxx\_a / 6\) \* (x \- a\_x)^3 \+ (f\_yyy\_a / 6\) \* (y \- a\_y)^3 \+ ...  
   (f\_xxy\_a / 2\) \* (x \- a\_x)^2 \* (y \- a\_y) \+ (f\_xyy\_a / 2\) \* (x \- a\_x) \* (y \- a\_y)^2 \+ ...  
   (f\_xyx\_a / 6\) \* (x \- a\_x)^2 \* (y \- a\_y);  
% Display the results  
disp('Taylor Polynomial of Order 1:');  
pretty(T1)  
disp('Taylor Polynomial of Order 2:');  
pretty(T2)  
disp('Taylor Polynomial of Order 3:');  
pretty(T3)

### 2\_b {#2_b}

syms x y;  
f \= sin(x) \* log(x \* y);  
a\_x \= 1;  
a\_y \= 1;  
f\_a \= subs(f, {x, y}, {a\_x, a\_y});  
f\_x \= diff(f, x);  
f\_y \= diff(f, y);  
f\_x\_a \= subs(f\_x, {x, y}, {a\_x, a\_y});  
f\_y\_a \= subs(f\_y, {x, y}, {a\_x, a\_y});  
f\_xx\_a \= subs(diff(f\_x, x), {x, y}, {a\_x, a\_y});  
f\_yy\_a \= subs(diff(f\_y, y), {x, y}, {a\_x, a\_y});  
f\_xy\_a \= subs(diff(f\_x, y), {x, y}, {a\_x, a\_y});  
f\_xxx\_a \= subs(diff(f\_xx\_a, x), {x, y}, {a\_x, a\_y});  
f\_yyy\_a \= subs(diff(f\_yy\_a, y), {x, y}, {a\_x, a\_y});  
f\_xxy\_a \= subs(diff(f\_xx\_a, y), {x, y}, {a\_x, a\_y});  
f\_xyy\_a \= subs(diff(f\_xy\_a, y), {x, y}, {a\_x, a\_y});  
f\_xyx\_a \= subs(diff(f\_xy\_a, x), {x, y}, {a\_x, a\_y});  
% Taylor Polynomial of order 1  
T1 \= f\_a \+ f\_x\_a \* (x \- a\_x) \+ f\_y\_a \* (y \- a\_y);  
% Taylor Polynomial of order 2  
T2 \= T1 \+ (f\_xx\_a / 2\) \* (x \- a\_x)^2 \+ (f\_yy\_a / 2\) \* (y \- a\_y)^2 \+ f\_xy\_a \* (x \- a\_x) \* (y \- a\_y);  
% Taylor Polynomial of order 3  
T3 \= T2 \+ (f\_xxx\_a / 6\) \* (x \- a\_x)^3 \+ (f\_yyy\_a / 6\) \* (y \- a\_y)^3 \+ ...  
   (f\_xxy\_a / 2\) \* (x \- a\_x)^2 \* (y \- a\_y) \+ (f\_xyy\_a / 2\) \* (x \- a\_x) \* (y \- a\_y)^2 \+ ...  
   (f\_xyx\_a / 6\) \* (x \- a\_x)^2 \* (y \- a\_y);  
% Display the results  
disp('Taylor Polynomial of Order 1:');  
pretty(T1)  
disp('Taylor Polynomial of Order 2:');  
pretty(T2)  
disp('Taylor Polynomial of Order 3:');  
pretty(T3)  
% Convert symbolic expressions to function handles for plotting  
f\_handle \= matlabFunction(f);  
T1\_handle \= matlabFunction(T1);  
T2\_handle \= matlabFunction(T2);  
T3\_handle \= matlabFunction(T3);  
% Create a grid for plotting  
\[x\_vals, y\_vals\] \= meshgrid(0.5:0.01:1.5, 0.5:0.01:1.5);  
% Evaluate the functions on the grid  
f\_vals \= f\_handle(x\_vals, y\_vals);  
T1\_vals \= T1\_handle(x\_vals, y\_vals);  
T2\_vals \= T2\_handle(x\_vals, y\_vals);  
T3\_vals \= T3\_handle(x\_vals, y\_vals);  
% Create the plot  
figure;  
hold on;  
% Plot the original function with a specific color  
surf(x\_vals, y\_vals, f\_vals, 'FaceColor', 'interp', 'FaceAlpha', 0.5, 'EdgeColor', 'none', 'DisplayName', 'Original Function f(x,y)');  
% Plot the Taylor approximations with different colors  
surf(x\_vals, y\_vals, T1\_vals, 'FaceColor', 'red', 'FaceAlpha', 0.5, 'EdgeColor', 'none', 'DisplayName', 'Taylor Polynomial Order 1');  
surf(x\_vals, y\_vals, T2\_vals, 'FaceColor', 'green', 'FaceAlpha', 0.5, 'EdgeColor', 'none', 'DisplayName', 'Taylor Polynomial Order 2');  
surf(x\_vals, y\_vals, T3\_vals, 'FaceColor', 'blue', 'FaceAlpha', 0.5, 'EdgeColor', 'none', 'DisplayName', 'Taylor Polynomial Order 3');  
% Set view angle  
view(45, 30);  
xlabel('x');  
ylabel('y');  
zlabel('f(x,y)');  
title('Function and Taylor Approximations');  
legend('Location', 'Best');  
% Set axis limits  
xlim(\[0.5, 1.5\]);  
ylim(\[0.5, 1.5\]);  
zlim(\[-1, 2\]); % Adjust based on your function's range  
% Add grid  
grid on;  
hold off;

### 3\. 

clc;  
x \= \[1; 1\]; % Initial guess  
x\_prev \= x;  
e \= 1e-5; % Convergence tolerance  
IterN \= 0;  
while norm(x \- x\_prev) \> e  
   x\_prev \= x;  
    
   % Define the system of equations  
   F \= \[x(1)^2 \+ x(2)^2 \- 4;  % Rearranged to set to zero  
        exp(x(1)) \+ x(2) \- 1\]; % Rearranged to set to zero  
    
   % Define the Jacobian matrix  
   J \= \[2\*x(1), 2\*x(2);       % Partial derivatives of the first equation  
        exp(x(1)), 1\];        % Partial derivatives of the second equation  
    
   % Use the Newton's method update step  
   dx \= \-J \\ F; % Solve J\*dx \= \-F for dx  
   x \= x \+ dx; % Update x  
   IterN \= IterN \+ 1; % Increment iteration count  
end  
% Display the results  
disp('Solution:');  
disp(x);  
disp('Number of iterations:');  
disp(IterN);

### 4  {#heading}

### Input x

### If x \< 10 Then {#heading}

###   If x \< 5 Then {#heading}

###         Print x {#heading}

###     Else {#heading}

###         x \= 5 {#heading}

###         Print x {#heading}

###     End If

###  If x \< 50 Then {#heading}

###           Print x

###   Else {#heading}

###         x \= x \- 5 {#heading}

###         Print x {#heading}

###     End If {#heading}

### Else {#heading}

###    End If

### End

###  {#heading}