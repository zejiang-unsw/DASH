classdef particleFilter < dashFilter
    % Implements a particle filter.
    
    properties
        % Settings
        type;    % Weighting scheme, N best or probabilistic
        N;       % Number of best particles for N best weights
        big;     % Whether the ensemble is too large to fit into memory
        nEns;   % How many ensemble members to process per batch for large ensembles.
        
        % Analysis values
        M;   % Model prior
        D;   % Observations
        R;   % Observation uncertainty
        F;   % Model estimates (Ye)
    end
    
    % Constructor
    methods
        function obj = particleFilter( M, D, R, F )
            % Creates a new particleFilter object
            %
            % obj = particleFilter( M, D, R, F )
            %
            % ----- Inputs -----
            %
            % M: An ensemble (nState x nEns)
            %
            % D: Observations (nObs x nTime)
            %
            % R: Observation Uncertainty (nObs x nTime)
            %
            % F: A cell vector of PSM objects (nObs x 1)
            %
            % ----- Outputs -----
            % 
            % obj: A new particleFilter object.
            
            % Default settings
            obj.type = 'weight';
            obj.N = NaN;
            obj.big = false;
            obj.nEns = NaN;
            
            % Set values, prevent empty constructor
            if nargin < 4
                error('Insufficient inputs')
            end
            obj.setValues( M, D, R, F );
            
        end
    end
    
    % User methods
    methods
        
        % Run the filter
        output = run( obj );
        
        % Change the settings
        settings( obj, varargin );
        
    end
    
    % Static analysis utilities
    methods (Static)
        
        % Particle filter
        output = pf( M, D, R, F, N );
        
        % Particle filter for big ensemble
        output = bigpf( ens, D, R, F, N, batchSize );
        
        % Compute particle weights
        weights = pfWeights( sse, N );
        
        % Normalize exponentials by their combined sum (efficiently)
        [Y] = normexp( X, dim, nanflag )
        
    end
    
end