function [ Z ] = lrr_relaxed( X, lambda )

max_iterations = 200;

func_vals = zeros(max_iterations, 1);
previous_func_val = Inf;

n = size(X, 2);

Z = zeros(n);
J = zeros(n);
Y = zeros(n);

mu = 1;

for k = 1 : max_iterations
    
    % Solve for J
    
    J = (X'*X + mu*speye(size(J))) \ (X'*X + Y + mu*Z);
    
    % Solve for Z
    
    V = J - (1/mu) * Y;
    
    [Z, s] = solve_nn(V, lambda / mu );
    
    % Update Y
    
    Y = Y + mu*(Z - J);
    
    % Check convergence
    
    func_vals(k) = 0.5*norm(X - X*Z, 'fro')^2 + lambda * sum(s);
    
    if ( abs(func_vals(k) - previous_func_val) <= 1*10^-6 )
        break;
    else
        previous_func_val = func_vals(k);
    end
    
end

end

