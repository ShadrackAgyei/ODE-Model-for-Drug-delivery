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
    
    % Solve ODE
    [t, C] = ode45(@(t, C) odes(t, C, k_b, k_t, k_bl, k_lb, k_bk, k_kt, k_e), tspan, c0);

    % Plot results
    plot(t, C(:, 1), 'o', 'DisplayName', 'c_b(t)');
    hold on;
    plot(t, C(:, 2), '-g', 'DisplayName', 'c_t(t)');
    plot(t, C(:, 3), 'p', 'DisplayName', 'c_l(t)');
    plot(t, C(:, 4), '-', 'DisplayName', 'c_k(t)');
    hold off;
    xlabel('Time');
    ylabel('Concentration');
    legend;
    title('Drug Concentration Over Time');
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
