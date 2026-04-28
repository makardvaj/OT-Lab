 format short
 clear all
 clc
 % Define objective function
 syms x1 x2
 f1 = x1 - x2 + 2*x1^2 + 2*x1*x2 + x2^2;
 fobj = matlabFunction(f1, 'Vars', {[x1, x2]}); 
% Compute gradient of f
 grad = gradient(f1, [x1, x2]);
 gradx = matlabFunction(grad, 'Vars', {[x1, x2]});
 % Compute Hessian Matrix
 H1 = hessian(f1, [x1, x2]);
 Hx = matlabFunction(H1, 'Vars', {[x1, x2]});
 % Iterations
 x0 = [1, 1]; maxiter = 4; tol = 10^(-3); iter = 0;
 while norm(gradx(x0)) > tol && iter < maxiter
    S = -gradx(x0);                     
    H = Hx(x0);                         
    lambda = (S' * S) / (S' * H * S);   
    x0 = x0 + lambda * S';              
    iter = iter + 1;
 end
 fprintf('Optimal Solution x = [%f, %f]\n', x0(1), x0(2))
 fprintf('Optimal Value f(x) = %f \n', fobj(x0))
