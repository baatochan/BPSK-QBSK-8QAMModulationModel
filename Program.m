clear;

%zmienne manipuluj?ce program
BIT_NUMBER = 1000; %ilosc bitow do wygenerowania
WAWE_FREQUENCY = 1000; %[Hz] czestotliwosc fali nosnej
sigmaU=0.1;                            %odchylenie standardowe U
sigmaOmega=0.05;                        %odchylenie standardowe Omegi

bitArray = RandomBitsGenerator(BIT_NUMBER)

[carrierWawe, timeAxis] = QPSKModulator(WAWE_FREQUENCY, BIT_NUMBER, bitArray);
[carrierWawe2, timeAxis2] = BPSKModulator(WAWE_FREQUENCY, BIT_NUMBER, bitArray);
[carrierWawe3, timeAxis3, numberOfSamplesInSymbol3, x3, y3] = ChannelQPSK( WAWE_FREQUENCY, BIT_NUMBER, bitArray, sigmaU, sigmaOmega);
[carrierWawe4, timeAxis4, numberOfSamplesInSymbol4, x4, y4] = ChannelPSK(WAWE_FREQUENCY, BIT_NUMBER, bitArray, sigmaU, sigmaOmega);

figure(1)
subplot(2,1,1);
plot (timeAxis,carrierWawe,'b')
xlabel ('czas[s]');
ylabel ('sygnal');
subplot(2,1,2);
plot (timeAxis2,carrierWawe2,'b')
xlabel ('czas[s]');
ylabel ('sygnal');
%
figure(2)
subplot(2,1,1);
plot (timeAxis3,carrierWawe3,'b')
xlabel ('czas[s]');
ylabel ('sygnal');
subplot(2,1,2);
plot (timeAxis4,carrierWawe4,'b')
xlabel ('czas[s]');
ylabel ('sygnal');

[colorPSK, colorQPSK] = getColors (BIT_NUMBER, bitArray);

figure(3)
scatter(x3,y3,10,colorQPSK,'filled');
axis([-1 1 -1 1]);

figure(4)
scatter(x4,y4,10,colorPSK,'filled');
axis([-1 1 -1 1]);

[ demodulatedBitArrayPSK ] = demodulatorPSK (x4, BIT_NUMBER);
[ demodulatedBitArrayQPSK ] = demodulatorQPSK (x3, y3, BIT_NUMBER);


BER_PSK = calculateBER (BIT_NUMBER, bitArray, demodulatedBitArrayPSK);
BER_QPSK = calculateBER (BIT_NUMBER, bitArray, demodulatedBitArrayQPSK);

BER_PSK
BER_QPSK