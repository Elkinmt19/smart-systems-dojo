function [inputs, desired] = time_series_preprocessing(time_serie, N, Win)
    %{
        This is a function that makes the preprocessing of a 
        time serie in order to get the inputs and desired vectors.
        :param time_serie: Row vector with the time serie's data
        :param N: Horizon 
        :param Win: Window
    %}

    % Define inputs and desired arrays
    inputs = [];
    desired = [];
    
    % Define the number of iterations for the system
    iterations = size(time_serie,2) - N + 1;
    
    for i = (Win + 1):iterations
        % Concatenate the arrays
        inputs = [inputs time_serie((i - Win):(i - 1))'];
        desired = [desired time_serie(i:(i + N - 1))'];
    end

end
