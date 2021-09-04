% Built the inputs dataset for to neural netwok
inputs = [];

% Create the inputs data set for 6 diferent persons
for i = 1:4
    inputs = [inputs random_data_generator([i;i+1],4,10)];
end

for i = 1:2:3
    inputs = [inputs random_data_generator([i;i+2],4,10)];
end

