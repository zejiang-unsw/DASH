function[] = psmFailureMessage( str, d, t )
z
fprintf(['PSM %0.f failed to run in time step %0.f with the error message: \n', ...
        str, '\n', ...
        '\tDash will not use observation %0.f to update the analysis in time step %0.f.\n\n'], ...
        d, t, d, t );
end