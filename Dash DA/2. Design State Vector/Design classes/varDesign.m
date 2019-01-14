%% This is a custom structure that holds the design parameters for a single
% variable in a state vector.
classdef varDesign
    
    % The values needed for each variable.
    properties
        % Grid file properties
        file; % File name
        dimID; % Dimensional ordering
        name;  % Variable name
        
        % Index properties
        indices;  % The allowed indices for state or ensemble dimensions
        seqDex;  % The indices used to get dimensional sequences
        meanDex; % The indices used to take a mean
        
        % Mean properties
        takeMean; % Toggle to take a mean
        nanflag;  % How to treat NaN
        
        % State vs Ensemble properties
        dimSet;  % Whether the dimension was previously set
        isState; % Whether a dimension is a state dimension.
        ensMeta; % The metadata value for ensemble dimensions
    end
        
    methods
        %% This is the constructor that builds the design object
        function obj = varDesign( file, name )
            
            % Set the file field
            obj.file = file;
            
            % Get the dimID
            [meta, dimID, gridSize] = metaGridfile( file );
            obj.dimID = dimID;
            
            % Get the name
            obj.name = name;
                
            % Get the number of dimensions
            nDim = numel(dimID);
            
            % Preallocate dimensional quantities
            obj.indices = cell(nDim,1);
            obj.seqDex = cell(nDim,1);
            obj.meanDex = cell(nDim,1);
            
            obj.takeMean = false(nDim,1);
            obj.nanflag = cell(nDim,1);
            
            obj.dimSet = false(nDim,1);
            obj.isState = true(nDim,1);
            obj.ensMeta = cell(nDim,1);
            
            % Initialize all dimensions as state dimensions with all
            % indices selected            
            for d = 1:nDim
                obj.indices{d} = 1:gridSize(d);
                obj.nanflag{d} = 'includenan';
            end
        end
    end
    
end