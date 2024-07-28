function drug_diffusion_model
    % Parameters
    k_b = 0.5;
    k_t = 0.3;
    k_bl = 0.2;
    k_lb = 0.1;
    k_bk = 0.4;
    k_kt = 0.2;
    k_e = 0.1;

    % Initial conditions
    c0 = [1; 0; 0; 0]; % assuming initial concentration in blood is 1 unit

    % Time points
    tspan = [0 10];
    
    % Solve ODE using ode45
    [t45, C45] = ode45(@(t, C) odes(t, C, k_b, k_t, k_bl, k_lb, k_bk, k_kt, k_e), tspan, c0);

    % Solve ODE using ode23
    [t23, C23] = ode23(@(t, C) odes(t, C, k_b, k_t, k_bl, k_lb, k_bk, k_kt, k_e), tspan, c0);

    % Solve ODE using ode15s
    [t15s, C15s] = ode15s(@(t, C) odes(t, C, k_b, k_t, k_bl, k_lb, k_bk, k_kt, k_e), tspan, c0);

    % Interpolate solutions to the same time points
    C23_interp = interp1(t23, C23, t45);
    C15s_interp = interp1(t15s, C15s, t45);

    % Calculate absolute errors
    abs_error_23 = abs(C23_interp - C45);
    abs_error_15s = abs(C15s_interp - C45);

    % Calculate relative errors
    rel_error_23 = abs_error_23 ./ abs(C45);
    rel_error_15s = abs_error_15s ./ abs(C45);

    % Plot results for ode45
    figure;
    subplot(3,1,1);
    plot(t45, C45(:, 1), 'o-', 'DisplayName', 'c_b(t) - ode45');
    hold on;
    plot(t45, C45(:, 2), '-g', 'DisplayName', 'c_t(t) - ode45');
    plot(t45, C45(:, 3), 'p-', 'DisplayName', 'c_l(t) - ode45');
    plot(t45, C45(:, 4), 's-', 'DisplayName', 'c_k(t) - ode45');
    hold off;
    xlabel('Time');
    ylabel('Concentration');
    legend;
    title('Drug Concentration Over Time using ode45');
    grid on;

    % Plot results for ode23
    subplot(3,1,2);
    plot(t23, C23(:, 1), 'o-', 'DisplayName', 'c_b(t) - ode23');
    hold on;
    plot(t23, C23(:, 2), '-g', 'DisplayName', 'c_t(t) - ode23');
    plot(t23, C23(:, 3), 'p-', 'DisplayName', 'c_l(t) - ode23');
    plot(t23, C23(:, 4), 's-', 'DisplayName', 'c_k(t) - ode23');
    hold off;
    xlabel('Time');
    ylabel('Concentration');
    legend;
    title('Drug Concentration Over Time using ode23');
    grid on;

    % Plot results for ode15s
    subplot(3,1,3);
    plot(t15s, C15s(:, 1), 'o-', 'DisplayName', 'c_b(t) - ode15s');
    hold on;
    plot(t15s, C15s(:, 2), '-g', 'DisplayName', 'c_t(t) - ode15s');
    plot(t15s, C15s(:, 3), 'p-', 'DisplayName', 'c_l(t) - ode15s');
    plot(t15s, C15s(:, 4), 's-', 'DisplayName', 'c_k(t) - ode15s');
    hold off;
    xlabel('Time');
    ylabel('Concentration');
    legend;
    title('Drug Concentration Over Time using ode15s');
    grid on;
    
    % Plot absolute errors
    figure;
    subplot(2,1,1);
    plot(t45, abs_error_23(:, 1), 'o-', 'DisplayName', 'abs error c_b(t) - ode23');
    hold on;
    plot(t45, abs_error_23(:, 2), '-g', 'DisplayName', 'abs error c_t(t) - ode23');
    plot(t45, abs_error_23(:, 3), 'p-', 'DisplayName', 'abs error c_l(t) - ode23');
    plot(t45, abs_error_23(:, 4), 's-', 'DisplayName', 'abs error c_k(t) - ode23');
    hold off;
    xlabel('Time');
    ylabel('Absolute Error');
    legend;
    title('Absolute Error using ode23 compared to ode45');
    grid on;
    
    subplot(2,1,2);
    plot(t45, abs_error_15s(:, 1), 'o-', 'DisplayName', 'abs error c_b(t) - ode15s');
    hold on;
    plot(t45, abs_error_15s(:, 2), '-g', 'DisplayName', 'abs error c_t(t) - ode15s');
    plot(t45, abs_error_15s(:, 3), 'p-', 'DisplayName', 'abs error c_l(t) - ode15s');
    plot(t45, abs_error_15s(:, 4), 's-', 'DisplayName', 'abs error c_k(t) - ode15s');
    hold off;
    xlabel('Time');
    ylabel('Absolute Error');
    legend;
    title('Absolute Error using ode15s compared to ode45');
    grid on;
    
    % Plot relative errors
    figure;
    subplot(2,1,1);
    plot(t45, rel_error_23(:, 1), 'o-', 'DisplayName', 'rel error c_b(t) - ode23');
    hold on;
    plot(t45, rel_error_23(:, 2), '-g', 'DisplayName', 'rel error c_t(t) - ode23');
    plot(t45, rel_error_23(:, 3), 'p-', 'DisplayName', 'rel error c_l(t) - ode23');
    plot(t45, rel_error_23(:, 4), 's-', 'DisplayName', 'rel error c_k(t) - ode23');
    hold off;
    xlabel('Time');
    ylabel('Relative Error');
    legend;
    title('Relative Error using ode23 compared to ode45');
    grid on;
    
    subplot(2,1,2);
    plot(t45, rel_error_15s(:, 1), 'o-', 'DisplayName', 'rel error c_b(t) - ode15s');
    hold on;
    plot(t45, rel_error_15s(:, 2), '-g', 'DisplayName', 'rel error c_t(t) - ode15s');
    plot(t45, rel_error_15s(:, 3), 'p-', 'DisplayName', 'rel error c_l(t) - ode15s');
    plot(t45, rel_error_15s(:, 4), 's-', 'DisplayName', 'rel error c_k(t) - ode15s');
    hold off;
    xlabel('Time');
    ylabel('Relative Error');
    legend;
    title('Relative Error using ode15s compared to ode45');
    grid on;
end

function dCdt = odes(t, C, k_b, k_t, k_bl, k_lb, k_bk, k_kt, k_e)
    c_b = C(1);
    c_t = C(2);
    c_l = C(3);
    c_k = C(4);
    
    dc_bdt = - (k_b + k_e + k_bl + k_bk) * c_b + k_t * c_t + k_lb * c_l;
    dc_tdt = k_b * c_b - k_t * c_t;
    dc_ldt = k_bl * c_b - k_lb * c_l;
    dc_kdt = k_bk * c_b - (k_kt + k_e) * c_k;
    
    dCdt = [dc_bdt; dc_tdt; dc_ldt; dc_kdt];
end
