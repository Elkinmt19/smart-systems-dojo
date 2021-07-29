function [Yk, mse, W] = feed_forward_adaline(alpha, inputs, desired, W, train)
    %{
        This is a function that goes through the data set and trains a
        adaline neural network.
        :param alpha: The learning power
        :param inputs: Inputs of the system
        :param desired: Desired outputs of the system
        :param W: Neural weight matrix
        :param train: Training flag
    %}

    % Analyze the data set
    nd = size(desired,2);
    ns = size(desired,1);
    
    % Create the output and the mse
    Yk = zeros(ns, nd);
    mse = zeros(ns,1);
    
    for i = 1:nd
        % Calculate Aj
        Aj = W*inputs(:,i);
        
        % Calculate the activation function 
        Yk(:,i) = Aj;
        
        % Calculate error 
        Ek = desired(:,i) - Yk(:,i);
        
        % Calculate mean square error
        mse(:) = mse(:) + (Ek.^2)./2;
        
        % Train!!!
        if train
            W = W + alpha*Ek*inputs(:,i)';
        end
    end
    
end

