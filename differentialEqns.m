% Main function to solve the drug diffusion model and plot the results
function drug_diffusion_model
    % Define the parameters for the model
    k_b = 0.5;   % Rate constant for drug transfer from blood to tissue
    k_t = 0.3;   % Rate constant for drug transfer from tissue to blood
    k_bl = 0.2;  % Rate constant for drug transfer from blood to liver
    k_lb = 0.1;  % Rate constant for drug transfer from liver to blood
    k_bk = 0.4;  % Rate constant for drug transfer from blood to kidneys
    k_kt = 0.2;  % Rate constant for drug transfer from kidneys to tissue
    k_e = 0.1;   % Elimination rate constant from the kidneys

    % Initial conditions for the drug concentrations in each compartment
    c0 = [1; 0; 0; 0]; % Initial concentration: 1 unit in blood, 0 in others

    % Time span for the simulation
    tspan = [0 10]; % Simulate from time t = 0 to t = 10

    % Solve the ODE system using ode45 solver
    [t, C] = ode45(@(t, C) odes(t, C, k_b, k_t, k_bl, k_lb, k_bk, k_kt, k_e), tspan, c0);

    % Plot the results
    plot(t, C(:, 1), '--r', 'DisplayName', 'Drug concentration in blood'); % Plot blood concentration
    hold on; % Hold the current plot to add more plots to it
    plot(t, C(:, 2), 'dg', 'DisplayName', 'Drug concentration in tissue'); % Plot tissue concentration
    plot(t, C(:, 3), '-b', 'DisplayName', 'Drug concentration in liver'); % Plot liver concentration
    plot(t, C(:, 4), '-m', 'DisplayName', 'Drug concentration in kidney'); % Plot kidneys concentration
    hold off; % Release the plot hold
    xlabel('Time'); % Label the x-axis as 'Time'
    ylabel('Concentration'); % Label the y-axis as 'Concentration'
    legend; % Add a legend to the plot
    title('Drug Concentration Over Time'); % Title for the plot
    grid on; % Add a grid to the plot for better readability

end

% Function that defines the ODE system
function dCdt = odes(t, C, k_b, k_t, k_bl, k_lb, k_bk, k_kt, k_e)
    % Extract the concentrations from the state vector C
    c_b = C(1); % Concentration in blood
    c_t = C(2); % Concentration in tissue
    c_l = C(3); % Concentration in liver
    c_k = C(4); % Concentration in kidneys
    
    % Define the rate of change of concentrations based on the given ODEs
    dc_bdt = - (k_b + k_e + k_bl + k_bk) * c_b + k_t * c_t + k_lb * c_l;
    dc_tdt = k_b * c_b - k_t * c_t;
    dc_ldt = k_bl * c_b - k_lb * c_l;
    dc_kdt = k_bk * c_b - (k_kt + k_e) * c_k;
    
    % Combine the rates of change into a column vector
    dCdt = [dc_bdt; dc_tdt; dc_ldt; dc_kdt];
end
