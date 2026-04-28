 format short
 clear all
 clc
 % Setup the Initial Tableau
 % Maximize Z = 3x1 + 5x2
 % Subject to: x1 <= 4, 2x2 <= 12, 3x1 + 2x2 <= 18
 % Columns: [x1, x2, s1, s2, s3, RHS]
 Tableau = [1  0  1  0  0   4; 
           0  2  0  1  0  12; 
           3  2  0  0  1  18; 
          -3 -5  0  0  0   0]; 
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
