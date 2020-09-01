function[obj] = extractVariables(obj, varNames)
%% Returns a state vector that only includes the specified variables
%
% obj = obj.extractVariables(varNames)
%
% ----- Inputs -----
%
% varNames: The names of the variables that should remain in the state
%    vector. String vector or cellstring vector.
%
% ----- Outputs -----
%
% obj: The updated stateVector object

% Error check, variable index
v = obj.checkVariables(varNames);

% Get the variables to remove
allVars = 1:numel(obj.variables);
remove = allVars(~ismember(allVars, v));

% Update
names = obj.variableNames;
obj = obj.remove( names(remove) );

end