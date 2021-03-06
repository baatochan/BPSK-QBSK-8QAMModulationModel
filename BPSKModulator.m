function [carrierWawe, timeAxis] = BPSKModulator(WAWE_FREQUENCY, BIT_NUMBER, bitArray)

    % Parametry
    sampleFrequency = 20000; % czestotliwosc probkowania [Hz]
    amplitude = 0.5;          % amplituda
    signalLength = (1/WAWE_FREQUENCY)*BIT_NUMBER;
    symbolLength = (1/WAWE_FREQUENCY);
    
    numberOfSamples = signalLength*sampleFrequency;
    numberOfSamplesInSymbol = symbolLength*sampleFrequency;
    timeAxis = 0:1/(sampleFrequency):(numberOfSamples-1)/(sampleFrequency);
    
    carrierWawe = zeros(1, numberOfSamplesInSymbol*BIT_NUMBER);
    
    for i = 1:BIT_NUMBER
        if bitArray(i) == 0
            offset = 0.5;
        else
            offset = 0;
        end
        
        for j = 1:numberOfSamplesInSymbol
            carrierWawe(((i-1)*numberOfSamplesInSymbol)+j) = amplitude*cos(2*pi*WAWE_FREQUENCY*timeAxis(((i-1)*numberOfSamplesInSymbol)+j) + 2*pi*offset);
        end
    end
    
end