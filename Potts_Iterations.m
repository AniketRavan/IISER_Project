Temperature = [500, 1000, 5000, 10000];
K.k1 = [1, 50];
K.k2 = [500, 1000];
iterations = 3000000;
for t = 1:length(Temperature) 
    for k = 1:length(K.k1)
        Potts_fine(Temperature(t), K.k1(k), K.k2(k), iterations);
        display(['Temperature = ',num2str(Temperature(t)),' k ',num2str(K.k1(k)),' ',num2str(K.k2(k))]);
    end
end