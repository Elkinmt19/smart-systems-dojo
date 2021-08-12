function [Yk, mse, C, W] = feed_forward_madaline(alpha, inputs, desired, W, C, train)
    %{
        This is a function that goes through the data set and trains a
        madaline neural network.
        :param alpha: The learning power
        :param inputs: Inputs of the system
        :param desired: Desired outputs of the system
        :param W: Neural weight matrix
        :param train: Training flag
    %}

    % Analyze the data set
    nd = size(desired,2);
    ns = size(desired,1);
    no = size(W,1);
    
    % Create the Hj vector
    Hj = zeros(no+1,1);
    
    % Create the output and the mse
    Yk = zeros(ns, nd);
    mse = zeros(ns,1);
    
    for i = 1:nd
        % Calculate Aj (Hidden layer)
        Aj = W*inputs(:,i);
        
        % Save the BIAS of the hidden layer
        Hj(1) = 1;
        
        % Calculate the activation function (Hidden layer)
        Hj(2:end) = 1./(1 + exp(-Aj)); % Sigmoidal function 
        
        % Calculate Ak
        Ak = C*Hj;
        
        % Calculate the activation function (Output layer)
        Yk(:,i) = 1./(1 + exp(-Ak)); % Sigmoidal function
        
        % Calculate the error 
        Ek = desired(:,i) - Yk(:,i);
        
        % Calculate the mean square error
        mse(:) = mse(:) + (Ek.^2)./2;
        
        % Train!!!
        if train
            % Calculate the sensitivity (Output layer)
            ds = Ek.*(Yk(:,i).*(1-Yk(:,i)));
            
            % Calcuate the sensitivity (Hidden layer)
            dh = (ds'*C(:,2:end)).*(Hj(2:end).*(1-Hj(2:end)))';
            
            % Update C matrix
            C = C + alpha*(ds*Hj');
            
            % Update W matrix
            W = W + alpha*(dh'*inputs(:,i)');
            
        end
    end
    
end

