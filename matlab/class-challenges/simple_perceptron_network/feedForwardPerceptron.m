function [Yk, ecm, w] = feedForwardPerceptron(alfa, entradas, deseados, w, entrena)
    % Analizamos la base de datos
    nd = size(deseados,2);
    ns = size(deseados,1);
    
    %% Creamos salida y ecm
    Yk = zeros(ns, nd);
    ecm = zeros(ns,1);
    
    for i = 1:nd
        %% Calculamos la agregacion Aj
        
        Aj = w*entradas(:,i);
        
        %% Calculamos la funcion de activacion 
        Yk(:,i) = (Aj>=0);
        
        %% Calculamos el error 
        Ek = deseados(:,i) - Yk(:,i);
        
        %% Calculamos el error cuadratico medio
        ecm(:) = ecm(:) + (Ek.^2)./2;
        
        %% Entrenamos
        if entrena == 1
            w = w + alfa*Ek*entradas(:,i)',
        end
    end
    
end

