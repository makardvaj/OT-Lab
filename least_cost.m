 format short
 clear all
 clc
 % Setup Costs, Supply, and Demand
 Cost = [2  3  1; 
        5  4  8; 
        5  6  8];
 Supply = [20, 30, 50]; 
Demand = [10, 40, 50]; 
Allocation = zeros(size(Cost));
 % Loop until all Supply and Demand are met
 while sum(Supply) > 0 && sum(Demand) > 0
 % Find the cheapest available cell
    minCost = min(Cost(:));
    [r, c] = find(Cost == minCost, 1); 
% Allocate the maximum possible amount
    qty = min(Supply(r), Demand(c));
    Allocation(r, c) = qty;
 % Update and Strike Out
    Supply(r) = Supply(r) - qty;
    Demand(c) = Demand(c) - qty;
 if Supply(r) == 0; Cost(r, :) = inf; end
 if Demand(c) == 0; Cost(:, c) = inf; end
 end
 disp('Final Allocation Matrix:');
 disp(Allocation);
