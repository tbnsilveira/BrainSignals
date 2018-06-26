function [matriz_alpha matriz_theta] = hipnoWave_MahalaSearch_geraModelo(sinal,fs)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % UFSM - PPGI - Grupo de Microeletrônica
    % Autor: Tiago da Silveira
    % Versão:   v1.0 (2011-10-26)
    %           v2.0 (2012-02-15)
    %           v2.0.1 (2012-02-27) #ADAPTADO
    %           v3.0 (2012-02-29) #CORRIGIDO posições das componentes de
    %           frequência.
    %                (2012-04-25) Salvo em um arquivo separado, para
    %                utilização com a GUI HipnoWave v1.0.
    %
    % Descrição: gera uma base de modelo para aplicação da distância de
    %       Mahalanobis à análise de sinais EEG.
    %       O sinal de entrada considerado é dividido em épocas de 30
    %       segundos cada. De acordo com a frequência de amostragem, um
    %       número de amostras é selecionado automaticamente por época.
    %       Deve ser determinado a época do sinal a qual deseja-se
    %       trabalhar, exemplo: [1,2,3] gerará um modelo utilizando os
    %       primeiros 1,5 minutos do sinal.
    %       
    %       O modelo é construído através de 2 épocas, considerando-se 2s
    %       para a análise de frequência (periodograma) e totalizando em 90
    %       vetores características. Para tanto, é utilizado overlapping de
    %       1s na constituição das amostras. A FFT é realizada com 512
    %       pontos e janelamento de 200 pontos.
    %
    %       ADAPTADO PARA BUSCA: utiliza a época pronta já passada como
    %       parâmetro "sinal".
    %
    % Protótipo: gmicro_brain_geraModelo(sinal,fs,epocas)
    %       onde    sinal = variavel contendo amostras do EEG
    %               fs = frequência de amostragem;
    %               epocas = índice das épocas a serem utilizadas para construção
    %                   do modelo. Exemplo: 1 = 0..30s;
    %                                       4 = 1m30s..2min.
    %                   Os dados devem ser entrados na forma [1 3 4].
    %                   Utiliza o comprimento do vetor épocas para
    %                   determinar o número de amostras do modelo
    %                   (cada época gera 15 amostras).
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % Definições
    q = 2*fs;                                       % Número de amostras para avançar a cada iteração, 2s * freq.amostragem.
    k = 1*fs;                                       % Número de amostras para overlapping (1s). 
    
    % Cria matriz característica vazia:
    numVetor = 6*15;                                % Numero de vetores características (épocas * amostras por época)
    matriz_alpha = zeros(numVetor,5);               % 90 vetores, 5 dimensões referente às freqs do ritmo alfa.
    matriz_theta = zeros(numVetor,4);               % 90 vetores, 4 dimensões referente às freqs do ritmo teta.
    
    % Duplica a última amostra:
    sinalModelo = sinal;
    temp = length(sinalModelo);
    sinalModelo(temp+1:temp+k)= sinalModelo(temp-k+1:temp);
    
    % Calcula o PSD para cada segmento de 3s do sinal, 
    for i=1:numVetor
        x = sinalModelo(1+(i-1)*q:i*q+k);
        periogram = psd(x,512,fs,512,448,1);
        % periogram = psd(vetor,NFFT,FS,WINDOW,NOVERLAPP,1);
        
        % Guarda os valores em dB do PSD calculado para o segmento em
        % questão. Estes valores são obtidos manualmente através da análise
        % do vetor "valorFreq = ((1:nfft/2+1)-1)*fs/nfft;"
        % Para o valor de 8Hz, por exemplo, procura-se todos os valores da
        % FFT entre 7.5 e 8.5Hz. Da mesma forma para todas as frequências.
        % Em seguida faz-se a média e calcula-se o valor logaritmico.
        %
        % Assim, estipula-se dois casos para fs=100 e fs=200, com nfft=512.
        
        switch fs
            case 100
                % Para construção do modelo Theta
                hz4 = mean(periogram(20:24));
                hz5 = mean(periogram(25:29));
                hz6 = mean(periogram(30:34));
                hz7 = mean(periogram(35:39));
                % Para construção do modelo Alpha
                hz8 = mean(periogram(40:44));
                hz9 = mean(periogram(45:49));
                hz10 = mean(periogram(50:54));
                hz11 = mean(periogram(55:59));
                hz12 = mean(periogram(60:65));
            case 200
                % Para construção do modelo Theta
                hz4 = mean(periogram(10:12));
                hz5 = mean(periogram(13:15));
                hz6 = mean(periogram(16:17));
                hz7 = mean(periogram(18:20));
                % Para construção do modelo Alpha
                hz8 = mean(periogram(21:22));
                hz9 = mean(periogram(23:25));
                hz10 = mean(periogram(26:27));
                hz11 = mean(periogram(28:30));
                hz12 = mean(periogram(31:33));
            otherwise
                disp('Frequencia de amostragem nao suportada. Verificar algoritmo');
                return
        end
        
        % Armazena os valores das médias para então calcular o log da
        % magnitude e repassar à matriz_modelo:
        valorTheta = [hz4 hz5 hz6 hz7];
        valorAlpha = [hz8 hz9 hz10 hz11 hz12];
        matriz_alpha(i,:) = 10*log10(abs(valorAlpha));
        matriz_theta(i,:) = 10*log10(abs(valorTheta));
    end
end