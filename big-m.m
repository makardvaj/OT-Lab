 % Minimize Z = 4x1 + x2 
% Subject to: 3x1 + x2 = 3, 4x1 + 3x2 >= 6, x1 + 2x2 <= 4
 M = 10000; % Define a massive penalty
 % Columns: [x1, x2, s1(surplus), s2(slack), a1, a2, RHS]
 Tableau = [ 3  1  0  0  1  0   3;
            4  3 -1  0  0  1   6;
            1  2  0  1  0  0   4;
           -4 -1  0  0  M  M   0]; 
% Isolate M: Zero out the M penalties in the bottom row 
Tableau(end, :) = Tableau(end, :) - M * Tableau(1, :); % a1 row
 Tableau(end, :) = Tableau(end, :) - M * Tableau(2, :); % a2 row
 % Proceed exactly as the Simplex code (while any bottom row < 0...)

iter = 0; maxiter = 10;
 % Optimality Condition
 while any(Tableau(end, 1:end-1) < 0) && iter < maxiter
 % Find Pivot Column (Entering Variable)
    [~, pivotCol] = min(Tableau(end, 1:end-1));
 % Find Pivot Row (Leaving Variable) using Minimum Ratio Test
    RHS = Tableau(1:end-1, end);
    ColVals = Tableau(1:end-1, pivotCol);
    ratios = RHS ./ ColVals;
    ratios(ratios <= 0) = inf; 
    [~, pivotRow] = min(ratios);
 % Row Operations (Update the Tableau)
    Tableau(pivotRow, :) = Tableau(pivotRow, :) / Tableau(pivotRow, pivotCol);
 for i = 1:size(Tableau, 1)
 if i ~= pivotRow
            Tableau(i, :) = Tableau(i, :) - Tableau(i, pivotCol) * Tableau(pivotRow, :);
 end
 end
    iter = iter + 1;
 end
 fprintf('Optimal Z value: %f\n', Tableau(end, end));
