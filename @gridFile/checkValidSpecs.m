function[] = checkValidSpecs( specs )

% Scalar structure
if ~isstruct(specs) || ~isscalar(specs)
    error('The variable "specs" must be a scalar structure (a struct).');
end

% Check that each field of specs is a vector of a NetCDF4 data type
specNames = string( fieldnames( specs ) );
for s = 1:numel(specNames)
    if (~gridFile.isnctype( specs.(specNames(s))) && ~ischar(specs.(specNames(s))) ) || ~isvector( specs.(specNames(s)) )
        error('The "%s" field in the "specs" structure must be a vector of a valid NetCDF4 data types (See listnctypes.m) or a character vector.', specNames(s) );
    end
end

end