function unit_step = u(time)
    % Return a unit step function for a list of times
    % u(t) = 0 when t < 0 and 1 when t >= 0
    unit_step = zeros(size(time));
    unit_step(time >= 0) = 1;
end