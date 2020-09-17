function[X] = permuteToOrder(X, order, nDims)
%% Permutes an array so that the its dimensions are in a specified order.
%
% X = dash.permuteToOrder(X, order, nDims)
% 
% ----- Inputs -----
%
% X: An array
%
% order: Specifies the order of the current dimensions in the final
%    permuted array. First element is the desired location of the current
%    first dimension, etc.
%
% nDims: The number of dimensions in the final array
%
% ----- Outputs -----
%
% X: The final permuted array

dims = 1:nDims;
[~, reorder] = ismember(dims, order);
reorder(reorder==0) = dims(~ismember(dims, reorder));
X = permute(X, reorder);

end