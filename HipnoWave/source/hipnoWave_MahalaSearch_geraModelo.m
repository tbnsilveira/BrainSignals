function [matriz_alpha matriz_theta] = hipnoWave_MahalaSearch_geraModelo(sinal,fs)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % UFSM - PPGI - Grupo de Microeletr�nica
    % Autor: Tiago da Silveira
    % Vers�o:   v1.0 (2011-10-26)
    %           v2.0 (2012-02-15)
    %           v2.0.1 (2012-02-27) #ADAPTADO
    %           v3.0 (2012-02-29) #CORRIGIDO posi��es das componentes de
    %           frequ�ncia.
    %                (2012-04-25) Salvo em um arquivo separado, para
    %                utiliza��o com a GUI HipnoWave v1.0.
    %
    % Descri��o: gera uma base de modelo para aplica��o da dist�ncia de
    %       Mahalanobis � an�lise de sinais EEG.
    %       O sinal de entrada considerado � dividido em �pocas de 30
    %       segundos cada. De acordo com a frequ�ncia de amostragem, um
    %       n�mero de amostras � selecionado automaticamente por �poca.
    %       Deve ser determinado a �poca do sinal a qual deseja-se
    %       trabalhar, exemplo: [1,2,3] gerar� um modelo utilizando os
    %       primeiros 1,5 minutos do sinal.
    %       
    %       O modelo � constru�do atrav�s de 2 �pocas, considerando-se 2s
    %       para a an�lise de frequ�ncia (periodograma) e totalizando em 90
    %       vetores caracter�sticas. Para tanto, � utilizado overlapping de
    %       1s na constitui��o das amostras. A FFT � realizada com 512
    %       pontos e janelamento de 200 pontos.
    %
    %       ADAPTADO PARA BUSCA: utiliza a �poca pronta j� passada como
    %       par�metro "sinal".
    %
    % Prot�tipo: gmicro_brain_geraModelo(sinal,fs,epocas)
    %       onde    sinal = variavel contendo amostras do EEG
    %               fs = frequ�ncia de amostragem;
    %               epocas = �ndice das �pocas a serem utilizadas para constru��o
    %                   do modelo. Exemplo: 1 = 0..30s;
    %                                       4 = 1m30s..2min.
    %                   Os dados devem ser entrados na forma [1 3 4].
    %                   Utiliza o comprimento do vetor �pocas para
    %                   determinar o n�mero de amostras do modelo
    %                   (cada �poca gera 15 amostras).
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % Defini��es
    q = 2*fs;                                       % N�mero de amostras para avan�ar a cada itera��o, 2s * freq.amostragem.
    k = 1*fs;                                       % N�mero de amostras para overlapping (1s). 
    
    % Cria matriz caracter�stica vazia:
    numVetor = 6*15;                                % Numero de vetores caracter�sticas (�pocas * amostras por �poca)
    matriz_alpha = zeros(numVetor,5);               % 90 vetores, 5 dimens�es referente �s freqs do ritmo alfa.
    matriz_theta = zeros(numVetor,4);               % 90 vetores, 4 dimens�es referente �s freqs do ritmo teta.
    
    % Duplica a �ltima amostra:
    sinalModelo = sinal;
    temp = length(sinalModelo);
    sinalModelo(temp+1:temp+k)= sinalModelo(temp-k+1:temp);
    
    % Calcula o PSD para cada segmento de 3s do sinal, 
    for i=1:numVetor
        x = sinalModelo(1+(i-1)*q:i*q+k);
        periogram = psd(x,512,fs,512,448,1);
        % periogram = psd(vetor,NFFT,FS,WINDOW,NOVERLAPP,1);
        
        % Guarda os valores em dB do PSD calculado para o segmento em
        % quest�o. Estes valores s�o obtidos manualmente atrav�s da an�lise
        % do vetor "valorFreq = ((1:nfft/2+1)-1)*fs/nfft;"
        % Para o valor de 8Hz, por exemplo, procura-se todos os valores da
        % FFT entre 7.5 e 8.5Hz. Da mesma forma para todas as frequ�ncias.
        % Em seguida faz-se a m�dia e calcula-se o valor logaritmico.
        %
        % Assim, estipula-se dois casos para fs=100 e fs=200, com nfft=512.
        
        switch fs
            case 100
                % Para constru��o do modelo Theta
                hz4 = mean(periogram(20:24));
                hz5 = mean(periogram(25:29));
                hz6 = mean(periogram(30:34));
                hz7 = mean(periogram(35:39));
                % Para constru��o do modelo Alpha
                hz8 = mean(periogram(40:44));
                hz9 = mean(periogram(45:49));
                hz10 = mean(periogram(50:54));
                hz11 = mean(periogram(55:59));
                hz12 = mean(periogram(60:65));
            case 200
                % Para constru��o do modelo Theta
                hz4 = mean(periogram(10:12));
                hz5 = mean(periogram(13:15));
                hz6 = mean(periogram(16:17));
                hz7 = mean(periogram(18:20));
                % Para constru��o do modelo Alpha
                hz8 = mean(periogram(21:22));
                hz9 = mean(periogram(23:25));
                hz10 = mean(periogram(26:27));
                hz11 = mean(periogram(28:30));
                hz12 = mean(periogram(31:33));
            otherwise
                disp('Frequencia de amostragem nao suportada. Verificar algoritmo');
                return
        end
        
        % Armazena os valores das m�dias para ent�o calcular o log da
        % magnitude e repassar � matriz_modelo:
        valorTheta = [hz4 hz5 hz6 hz7];
        valorAlpha = [hz8 hz9 hz10 hz11 hz12];
        matriz_alpha(i,:) = 10*log10(abs(valorAlpha));
        matriz_theta(i,:) = 10*log10(abs(valorTheta));
    end
end