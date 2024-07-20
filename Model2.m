% Solve a System of Differential Equations
% Solve a system of several ordinary differential equations in several variables by using the dsolve function, with or without initial conditions. To solve a single differential equation, see Solve Differential Equation.

% Solve System of Differential Equations
% Solve this system of linear first-order differential equations.

% First, represent  and  by using syms to create the symbolic functions u(t) and v(t).
syms kb ke c0 kt
syms u(t) v(t)
kb = 0.5;
ke = 0.05;
kt = 0.25;
c0 = 600;

% Define the equations using == and represent differentiation using the diff function.
ode1 = diff(u) == -(kb + ke)*u + kt*v;
ode2 = diff(v) == kb*u - kt*v;
odes = [ode1; ode2];

% Solve the system with the initial conditions u(0) == c0 and v(0) == 0.
cond1 = u(0) == c0;
cond2 = v(0) == 0;
conds = [cond1; cond2];
[uSol(t), vSol(t)] = dsolve(odes, conds);

% Visualize the solution using fplot.
fplot(uSol, [0, 6])
hold on
fplot(vSol, [0, 6])
grid on
legend('Concentration in blood', 'Concentration in tissue', 'Location', 'best')

% Label the axes
xlabel('Time')
ylabel('Concentration')

% Title for the plot
title('Concentration vs. Time')
