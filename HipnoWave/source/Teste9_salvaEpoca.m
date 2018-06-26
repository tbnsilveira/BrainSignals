function Teste9_salvaEpoca(variavel,nome_arquivo)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% UFSM - PPGI - Grupo de Microeletrônica
% Autor: Tiago da Silveira
% Data: 12/03/2012
%
% Prepara uma época de 3000 amostras do EEG para ser salva em um arquivo de
% 4096 amostras, para posterior análise wavelet e best approx.
% Primeiramente é realizado o "zero-padding" e então o sinal é salvo.
% Baseado em scripts anteriores, ajustado para épocas EEG de 30s e fs=100hz
%
% Sintaxe: Teste9_salvaEpoca(variavel,nome_arquivo);
%           variavel = sinal de entrada; Ex.: sc4002_BDa01
%           nome_arquivo = arquivo de saída, para salvar época. Ex.:
%                   'sc4002_BDa01';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Definições
fs = 100;                                                                   % Frequência de amostragem
epLength = 30;                                                              % Cada época tem duração de 30s.

%% Salva cada época da seleção em um arquivo de texto separado:
for i=1:20
    % Leitura de cada época (30s) no total da seleção (10min):
    eDlim = [((i-1)*epLength*fs+1) (i*epLength*fs)];                        % Limites para a época nEpoca.
    epoch = variavel(eDlim(1):eDlim(2));                                    % Variavel com os valores da época D
    % Zero-padding do sinal de entrada: de 6000 amostras para 8192:
    sinalFinal = zeros(548,1);
    sinalFinal(549:3548) = epoch;
    sinalFinal(3549:4096) = zeros(548,1);
    salva_variavel(sinalFinal,4096,[nome_arquivo '_epoca' num2str(i) '.txt']);
end;
end
