function [Yk, ecm, Cji, Wkj, Dj] = FeedForwardBaseRadialNetwork(inputs, ne, no, Cji, Wkj, desired, Dj, alpha, ns, nd, train)
    % Define important variables of the network
    Hj = zeros(no+1,1);
    Yk = zeros(ns,nd);
    ecm = zeros(ns,1);
    
    % Go through the data
    for i = 1:nd
        t1 = repmat(inputs(:,i),1,no) - Cji;
        dist = sum(t1.^2)';
        
        Hj(1) = 1; % Add the BIAS
        Hj(2:end) = exp(-(dist./(2.*Dj.^2)));
        
        Ak = Wkj'*Hj;
        Yk(:,i) = 1./(1+exp(-Ak));
        
        Ek = desired(:,i) - Yk(:,i);
        ecm(:) = ecm(:) + (Ek.^2)./2;
        
        if (train == 1)
            % Calculate diameters matrix
            dr = repmat(Dj,1,ne);
            
            
        end
    end
end