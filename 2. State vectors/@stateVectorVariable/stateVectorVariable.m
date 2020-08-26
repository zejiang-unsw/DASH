classdef stateVectorVariable
    % This class implements a custom structure to hold design parameters
    % for a variable in a state vector.
    
    properties (SetAccess = private)
        name;  % The identifying name of the variable
        
        file; % Name of the .grid file
        dims; % .grid file dimension order
        gridSize; % .grid file size
        size; % Size of the dimension in the state vector
        
        isState; % Whether a dimension is a state dimension
        stateIndices; % Data indices to use for state dimensions
        ensIndices; % Reference indices to use for ensemble dimensions
        
        seqIndices; % Sequence indices
        seqMetadata; % Sequence metadata
        
        takeMean; % Whether to take a mean over a dimension
        weightCell; % Weights for each dimension
        weightMatrix; % N-dimensional matrix of weights
        nWeights; % Number of weights in each dimension
        omitnan; % Whether to exclude NaN values
        
        
    end
    
    % Constructor
    methods
        function obj = stateVectorVariable(varName, file)
            % Creates a new stateVectorVariable object for data in a .grid
            % file.
            %
            % obj = stateVectorVariable(varName, file);
            %
            % ----- Inputs -----
            %
            % varName: The name of the variable. A string.
            %
            % file: The name of the .grid file that holds the variable
            %
            % ----- Outputs -----
            %
            % obj: The new stateVectorVariable object
            
            % Error check
            dash.assertStrFlag(varName, 'varName');
            dash.assertStrFlag(file, 'file');
            file = dash.checkFileExists(file);
            
            % Name. Use string internally
            obj.name = string(varName);
            
            % Get gridfile properties
            grid = gridfile(file);
            obj.file = grid.file;
            obj.dims = grid.dims;
            obj.gridSize = grid.size;
            
            % Initialize dimension properties
            nDims = numel(obj.dims);
            obj.size = NaN(1, nDims);
            obj.isState = true(1, nDims);
            obj.stateIndices = cell(1, nDims);
            obj.ensIndices = cell(1, nDims);
            
            obj.seqIndices = cell(1, nDims);
            obj.seqMetadata = cell(1, nDims);
            
            obj.resetMean;
            
            % Initialize all dimensions as state dimensions
            for d = 1:numel(obj.dims)
                obj = obj.design(obj.dims(d), 'state');
            end
        end
    end
    
    % Object utilities
    methods
        d = checkDimensions(obj, dims, multiple);
        obj = resetMean(obj);
    end
    
    % Interface methods
    methods
        obj = design(obj, dim, type, indices);
        obj = sequence(obj, dim, indices, metadata);
        obj = mean(obj, dims, weights, nanflag);
    end
end
        