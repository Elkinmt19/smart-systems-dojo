function [inputs] = random_data_generator(data_set, number_inputs, number_data)
    %{
        This is a simple matlab function that allows to create a random
        dataset based on a specific list of datas, a number of inputs and 
        a number of datas.
        :param data_set: Column vector with the elements to put in the inputs
        :param number_inputs: Number of inputs for the result dataset
        :param number_data: Number of datas for the result dataset
    %}

    inputs = [];
    for i = 1:number_data
        idx = randi(numel(data_set), number_inputs, 1);
        data_set(idx);
        inputs = [inputs data_set(idx)];
    end
end
