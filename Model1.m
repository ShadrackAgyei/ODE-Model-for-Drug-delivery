% Solve a System of Differential Equations
syms k n c0
syms u(t) v(t)
n = 0.2213;
c0 = 600;

% Define the equations
ode1 = diff(u) == -k*u;
ode2 = diff(v) == k*u - n*v;
odes = [ode1; ode2];

% Solve the system with the initial conditions
cond1 = u(0) == c0;
cond2 = v(0) == 0;
conds = [cond1; cond2];

% Solve the system symbolically
[uSol(t), vSol(t)] = dsolve(odes, conds);

% Define k values
k_values = [0.9776, 0.7448, 0.3293, 0.2213];

% Plot u(sol) for different k values
figure;
hold on;
for i = 1:length(k_values)
    k = k_values(i);
    uSol_numeric = matlabFunction(subs(uSol));
    fplot(uSol_numeric, [0, 6], 'LineWidth', 2);
end

grid on;
legend(arrayfun(@(x) sprintf('k = %.4f /hr', x), k_values, 'UniformOutput', false), 'Location', 'best');
xlabel('Time');
ylabel('Concentration');
title('u(t) for Different k Values');
hold off;

%%
% graph for different inital concentration of k1
% Solve a System of Differential Equations
syms k n c0
syms u(t) v(t)
n = 0.2213;
k = 0.5293;

% Define the equations
ode1 = diff(u) == -k*u;
ode2 = diff(v) == k*u - n*v;
odes = [ode1; ode2];

% Define initial concentrations
c0_values = [600, 300, 150, 75];

% Plot u(t) for different initial concentrations
figure;
hold on;
for i = 1:length(c0_values)
    c0 = c0_values(i);
    
    % Solve the system with the initial conditions
    cond1 = u(0) == c0;
    cond2 = v(0) == 0;
    conds = [cond1; cond2];
    
    % Solve the system symbolically
    [uSol(t), vSol(t)] = dsolve(odes, conds);
    
    % Convert symbolic solution to numeric function
    uSol_numeric = matlabFunction(uSol);
    
    % Plot the solution
    fplot(uSol_numeric, [0, 6], 'LineWidth', 2);
end

grid on;
legend(arrayfun(@(x) sprintf('c_0 = %d units', x), c0_values, 'UniformOutput', false), 'Location', 'best');
xlabel('Time');
ylabel('Concentration');
title('u(t) for Different Initial Concentrations with k = 0.5293 /hr');
hold off;
