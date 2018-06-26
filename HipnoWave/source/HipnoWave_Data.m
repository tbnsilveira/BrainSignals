function varargout = HipnoWave_Data(varargin)
% HIPNOWAVE_DATA M-file for HipnoWave_Data.fig
%      HIPNOWAVE_DATA, by itself, creates a new HIPNOWAVE_DATA or raises the existing
%      singleton*.
%
%      H = HIPNOWAVE_DATA returns the handle to a new HIPNOWAVE_DATA or the handle to
%      the existing singleton*.
%
%      HIPNOWAVE_DATA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HIPNOWAVE_DATA.M with the given input arguments.
%
%      HIPNOWAVE_DATA('Property','Value',...) creates a new HIPNOWAVE_DATA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before HipnoWave_Data_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to HipnoWave_Data_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help HipnoWave_Data

% Last Modified by GUIDE v2.5 21-May-2012 18:11:49

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @HipnoWave_Data_OpeningFcn, ...
                   'gui_OutputFcn',  @HipnoWave_Data_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before HipnoWave_Data is made visible.
function HipnoWave_Data_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to HipnoWave_Data (see VARARGIN)

% Choose default command line output for HipnoWave_Data
handles.output = hObject;

% Comandos de inicialização:
% Slider13 -> SampleFreq: de 100Hz a 2000Hz
set(handles.slider13,'Min',100);                                            % Ajusta valor mínimo;
set(handles.slider13,'Max',200);                                            % Ajusta valor máximo;
set(handles.slider13,'Value',100);                                          % Ajusta valor inicial slider13;
set(handles.slider14,'Value',30);                                           % Ajusta valor inicial slider14;
% Definição inicial (valores atualizados conforme alteração de parâmetros)
handles.numEpoch = 1;
handles.sampleFreq = 100;
handles.epWidth = 30;
handles.initialEp = 1;
handles.intervalEp = 20;
handles.step = 1;
handles.transitionEpA = 0;
handles.transitionEpB = 1;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes HipnoWave_Data wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = HipnoWave_Data_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



% --- Executes on button press in pushbutton20.
function pushbutton20_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Mostra tela para que o usuario escolha o arquivo do sinal:
[rawFilename, pathname] = uigetfile('*.mat', 'Pick an input file');
% Caso não tenha sido cancelado, executa o laço:
if ~isequal(rawFilename,0)
    handles.arquivo = rawFilename;                                          % Armazena em handles o nome do arquivo
    vars = whos('-file',rawFilename);                                       % Identifica a variável que está no arquivo
    temp = load([pathname rawFilename],vars(1).name);                       % Carrega a estrutura contendo o sinal em uma variável temporária.
    handles.sinal = eval(['temp.' vars(1).name]);                           % Armazena em handles o sinal
    set(handles.pushbutton21,'Enable','on');                                % Enables button21 (2. Open hypnogram)
    set(handles.pushbutton26,'Enable','on');                                % Enables button26 (Search for transition)
    set(handles.text32,'String',rawFilename);                               % Writes RAW file name
    % Calcula o número de épocas do sinal;
    handles.numEpoch = length(handles.sinal)/(handles.epWidth*handles.sampleFreq);
end
guidata(hObject, handles);  



% --- Executes on button press in pushbutton21.
function pushbutton21_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Mostra tela para que o usuario escolha o arquivo do sinal:
[hypFilename, pathname] = uigetfile('*.mat', 'Pick an input file');
% Caso não tenha sido cancelado, executa o laço:
if ~isequal(hypFilename,0)
    handles.arquivoHyp = hypFilename;                                       % Armazena em handles o nome do arquivo
    vars = whos('-file',hypFilename);                                       % Identifica a variável que está no arquivo
    temp = load([pathname hypFilename],vars(1).name);                       % Carrega a estrutura contendo o sinal em uma variável temporária.
    handles.hypnogram = eval(['temp.' vars(1).name]);                       % Armazena em handles o sinal
    set(handles.pushbutton22,'Enable','on');                                % Enables button22 (View)
    set(handles.pushbutton23,'Enable','on');                                % Enables button23 (Clear)
    set(handles.text33,'String',hypFilename);                               % Writes RAW file name
end
guidata(hObject, handles);  


function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit13 as text
%        str2double(get(hObject,'String')) returns contents of edit13 as a double
handles.sampleFreq = round(str2double(get(hObject,'String')));              % Define o valor de sampleFreq (variavel criada em handles)
set(handles.edit13,'String',num2str(handles.sampleFreq));                   % Atualiza valor de sampleFreq no campo edit13
set(handles.slider13,'Value',handles.sampleFreq);                           % Atualiza valor do slider13.
guidata(hObject, handles);                                                  % Salva variavel GUI handles.


% --- Executes during object creation, after setting all properties.
function edit13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider13_Callback(hObject, eventdata, handles)
% hObject    handle to slider13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.sampleFreq = round(get(hObject,'Value'));                           % Define o valor de sampleFreq (var de handles)
set(handles.edit13,'String',num2str(handles.sampleFreq));                   % Atualiza valor de sampleFreq no campo edit13
guidata(hObject, handles);                                                  % Salva variavel GUI handles.


% --- Executes during object creation, after setting all properties.
function slider13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit14_Callback(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit14 as text
%        str2double(get(hObject,'String')) returns contents of edit14 as a double
handles.epochWidth = round(str2double(get(hObject,'String')));              % Define o valor de epochWidth (variavel criada em handles)
set(handles.edit14,'String',num2str(handles.epochWidth));                   % Atualiza valor no campo edit14
set(handles.slider14,'Value',handles.epochWidth);                           % Atualiza valor do slider14.
guidata(hObject, handles);                                                  % Salva variavel GUI handles.



% --- Executes during object creation, after setting all properties.
function edit14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider14_Callback(hObject, eventdata, handles)
% hObject    handle to slider14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.epochWidth = round(get(hObject,'Value'));                           % Define o valor de epochWidth (var de handles)
set(handles.edit14,'String',num2str(handles.epochWidth));                   % Atualiza valor no campo edit14
guidata(hObject, handles);                                                  % Salva variavel GUI handles.


% --- Executes during object creation, after setting all properties.
function slider14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton22.
function pushbutton22_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%% Definição do intervalo de sinal escolhido:
handles.initialPlotEp = handles.initialEp;                                  % initialPlotEp é utilizado para possibilitar o avanço em steps;
handles.finalPlotEp = handles.initialPlotEp-1 + handles.intervalEp;

handles.sigPlot = handles.sinal((handles.initialPlotEp-1)*handles.epWidth*handles.sampleFreq ...
    +1 : handles.finalPlotEp*handles.epWidth*handles.sampleFreq);

handles.hypPlot = handles.hypnogram(handles.initialPlotEp:handles.finalPlotEp);

%% Sinal original
% Define o eixo-X:
handles.eixoX = [0:1:length(handles.sigPlot)-1];
% Plot do sinal original
axes(handles.axes10);                                                       % Seleciona a componente axes10
plot(handles.eixoX,handles.sigPlot,'Color',[0 0 0.6],'LineWidth',1.0);      % Exibe o sinal de entrada
grid on;
xlim([0 length(handles.sigPlot)]);
% Ajuste do eixo-X em épocas ou segundos:
if (get(handles.radiobutton2,'Value'))                                      % radiobutton2 = seconds
    ticksSecs = 0:handles.sampleFreq:length(handles.sigPlot);
    ticksSecsLabel = ticksSecs/handles.sampleFreq;                          % Divide pela freq. amostragem para mostrar eixo-X em segundos.
    set(gca,'XTickLabelMode','manual','XTickMode','manual','XTick',ticksSecs,'XTickLabel',ticksSecsLabel);
else
    ticksEpoch = 0:(handles.sampleFreq*handles.epWidth):length(handles.sigPlot);
    ticksEpochLabel = ticksEpoch /(handles.sampleFreq*handles.epWidth);     % Divide para mostrar eixo-X em épocas.
    set(gca,'XTickLabelMode','manual','XTickMode','manual','XTick',ticksEpoch,'XTickLabel',ticksEpochLabel);
end

%% Plot do hipnograma (ver algoritmos)
% Todo o gráfico começa de 0 ao tamanho do intervalo. As epocas mostradas
% têm uma numeração local. Para localização no sinal, deve ser considerado
% o intervalo, informado à esquerda da figura.
axes(handles.axes11);
% Duplica o valor da última época:
handles.hypPlot(length(handles.hypPlot)+1) = handles.hypPlot(length(handles.hypPlot));
% Define os labels:
xHypTick = 0:1:length(handles.hypPlot);                                     % Observar que handles.hypPlot já está duplicado.
xHypTickLabel = xHypTick-1;
% Plot dos valores em formato escada
stairs(handles.hypPlot,'Color',[0.8 0 0],'LineWidth',2.0);
% Ajuste do gráfico
xlim([1 length(handles.hypPlot)]);                                          % Começa em "1" para compensar uma unidade a mais do hipnograma.
ylim([-0.2 6.2]);
%set(gca,'YTickLabel',{'N1','W (alfa)','W'},'YTick',[3 4 5],'XTick',xHypTick,'XTickLabel',xHypTickLabel);
set(gca,'YTick',[0 1 2 3 4 4.5 5 6],'XTick',xHypTick,'XTickLabel',xHypTickLabel);
grid on;

%% Espectrograma:
axes(handles.axes12);                                                       % Seleciona a componente axes12
% Ajuste do eixo-X em épocas ou segundos:
if (get(handles.radiobutton2,'Value'))                                      % radiobutton2 = seconds
    spectrogram(handles.sigPlot,512,500,512,handles.sampleFreq,'yaxis');  	% Espectrograma do sinal
else
    spectrogram(handles.sigPlot,512,500,512,handles.sampleFreq,'yaxis');  	% Espectrograma do sinal
    xlim([0 length(handles.sigPlot)/handles.sampleFreq]);
    ticksSpec = 0:handles.epWidth:length(handles.sigPlot)/handles.sampleFreq;
    ticksSpecLabel = ticksSpec/handles.epWidth;
    set(gca,'XTickLabelMode','manual','XTickMode','manual','XTick',ticksSpec,'XTickLabel',ticksSpecLabel);
    colorbar;
end

%% Atualiza informação de intervalo:
set(handles.text41,'String',['Interval: [' num2str(handles.initialPlotEp) ...
    '  ' num2str(handles.finalPlotEp) ']']);
% Desabilita botão "View", habilita botão "Clear":
set(handles.pushbutton22,'Enable','off');                                   % Disables button22 (View)
set(handles.pushbutton23,'Enable','on');                                    % Enables button23 (Clear)

% Teste para habilitar os botões Next e Previous:
if (handles.initialPlotEp + handles.intervalEp + handles.step) > handles.numEpoch +1
    set(handles.pushbutton25,'Enable','off');                               % Disables button25 (Next)
else
    set(handles.pushbutton25,'Enable','on');                                % Enables button25 (Next)
end
if (handles.finalPlotEp +1 - handles.intervalEp - handles.step) < 1
    set(handles.pushbutton24,'Enable','off');                               % Disables button24 (Previous)
else
    set(handles.pushbutton24,'Enable','on');                                % Enables button24 (Previous)
end

% Habilita o botão para o Mardia's Test:
set(handles.pushbutton27,'Enable','on');                                    % Enables button27 (Mardia's Test)
set(handles.pushbutton28,'Enable','on');                                    % Enables button28 (Best approximation Classification)
% Salva as variáveis handles:
guidata(hObject, handles);  



% --- Executes on button press in pushbutton23.
function pushbutton23_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Limpa os gráficos:
cla(handles.axes10,'reset')
cla(handles.axes11,'reset')
cla(handles.axes12,'reset')
% Habilita o botão View, novamente e desabilita os demais:
set(handles.pushbutton22,'Enable','on');
set(handles.pushbutton24,'Enable','off');
set(handles.pushbutton25,'Enable','off');


function edit15_Callback(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit15 as text
%        str2double(get(hObject,'String')) returns contents of edit15 as a double
handles.initialEp = round(str2double(get(hObject,'String')));               % Define o valor de initialEp (variavel criada em handles)
set(handles.edit15,'String',num2str(handles.initialEp));                    % Atualiza valor no campo edit15
guidata(hObject, handles);                                                  % Salva variavel GUI handles.


% --- Executes during object creation, after setting all properties.
function edit15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit16_Callback(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit16 as text
%        str2double(get(hObject,'String')) returns contents of edit16 as a double
handles.intervalEp = round(str2double(get(hObject,'String')));              % Define o valor de finalEp (variavel criada em handles)
set(handles.edit16,'String',num2str(handles.intervalEp));                   % Atualiza valor no campo edit16
guidata(hObject, handles);                                                  % Salva variavel GUI handles.


% --- Executes during object creation, after setting all properties.
function edit16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on button press in pushbutton24.
function pushbutton24_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% Definição do intervalo de sinal escolhido:
handles.initialPlotEp = handles.initialPlotEp - handles.step;                % Incrementa o valor anterior de acordo com o "step" definido
handles.finalPlotEp = handles.initialPlotEp-1 + handles.intervalEp;
handles.sigPlot = handles.sinal((handles.initialPlotEp-1)*handles.epWidth*handles.sampleFreq ...
    +1 : handles.finalPlotEp*handles.epWidth*handles.sampleFreq);

handles.hypPlot = handles.hypnogram(handles.initialPlotEp:handles.finalPlotEp);

%% Sinal original
% Define o eixo-X:
handles.eixoX = [0:1:length(handles.sigPlot)-1];
% Plot do sinal original
axes(handles.axes10);                                                       % Seleciona a componente axes10
plot(handles.eixoX,handles.sigPlot,'Color',[0 0 0.6],'LineWidth',1.0);      % Exibe o sinal de entrada
xlim([0 length(handles.sigPlot)]);
% Ajuste do eixo-X em épocas ou segundos:
if (get(handles.radiobutton2,'Value'))                                      % radiobutton2 = seconds
    ticksSecs = 0:handles.sampleFreq:length(handles.sigPlot);
    ticksSecsLabel = ticksSecs/handles.sampleFreq;                          % Divide pela freq. amostragem para mostrar eixo-X em segundos.
    set(gca,'XTickLabelMode','manual','XTickMode','manual','XTick',ticksSecs,'XTickLabel',ticksSecsLabel);
else
    ticksEpoch = 0:(handles.sampleFreq*handles.epWidth):length(handles.sigPlot);
    ticksEpochLabel = ticksEpoch /(handles.sampleFreq*handles.epWidth);     % Divide para mostrar eixo-X em épocas.
    set(gca,'XTickLabelMode','manual','XTickMode','manual','XTick',ticksEpoch,'XTickLabel',ticksEpochLabel);
end

%% Plot do hipnograma (ver algoritmos)
% Todo o gráfico começa de 0 ao tamanho do intervalo. As epocas mostradas
% têm uma numeração local. Para localização no sinal, deve ser considerado
% o intervalo, informado à esquerda da figura.
axes(handles.axes11);
% Duplica o valor da última época:
handles.hypPlot(length(handles.hypPlot)+1) = handles.hypPlot(length(handles.hypPlot));
% Define os labels:
xHypTick = 0:1:length(handles.hypPlot);                                     % Observar que handles.hypPlot já está duplicado.
xHypTickLabel = xHypTick-1;
% Plot dos valores em formato escada
stairs(handles.hypPlot,'Color',[0.8 0 0],'LineWidth',2.0);
% Ajuste do gráfico
xlim([1 length(handles.hypPlot)]);                                          % Começa em "1" para compensar uma unidade a mais do hipnograma.
ylim([-0.2 6.2]);
set(gca,'YTick',[0 1 2 3 4 4.5 5 6],'XTick',xHypTick,'XTickLabel',xHypTickLabel);
grid on;

%% Espectrograma:
axes(handles.axes12);                                                       % Seleciona a componente axes12
% Ajuste do eixo-X em épocas ou segundos:
if (get(handles.radiobutton2,'Value'))                                      % radiobutton2 = seconds
    spectrogram(handles.sigPlot,512,500,512,handles.sampleFreq,'yaxis');  	% Espectrograma do sinal
else
    spectrogram(handles.sigPlot,512,500,512,handles.sampleFreq,'yaxis');  	% Espectrograma do sinal
    xlim([0 length(handles.sigPlot)/handles.sampleFreq]);
    ticksSpec = 0:handles.epWidth:length(handles.sigPlot)/handles.sampleFreq;
    ticksSpecLabel = ticksSpec/handles.epWidth;
    set(gca,'XTickLabelMode','manual','XTickMode','manual','XTick',ticksSpec,'XTickLabel',ticksSpecLabel);
    colorbar;
end

%% Atualiza informação de intervalo:
set(handles.text41,'String',['Interval: [' num2str(handles.initialPlotEp) ...
    '  ' num2str(handles.finalPlotEp) ']']);

% Teste para habilitar os botões Next e Previous:
if (handles.initialPlotEp + handles.intervalEp + handles.step) > handles.numEpoch +1
    set(handles.pushbutton25,'Enable','off');                               % Disables button25 (Next)
else
    set(handles.pushbutton25,'Enable','on');                                % Enables button25 (Next)
end
if (handles.finalPlotEp +1 - handles.intervalEp - handles.step) < 1
    set(handles.pushbutton24,'Enable','off');                               % Disables button24 (Previous)
else
    set(handles.pushbutton24,'Enable','on');                                % Enables button24 (Previous)
end

% Salva as variáveis handles:
guidata(hObject, handles);  



% --- Executes on button press in pushbutton25.
function pushbutton25_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%% Definição do intervalo de sinal escolhido:
handles.initialPlotEp = handles.initialPlotEp + handles.step;                % Incrementa o valor anterior de acordo com o "step" definido
handles.finalPlotEp = handles.initialPlotEp-1 + handles.intervalEp;
handles.sigPlot = handles.sinal((handles.initialPlotEp-1)*handles.epWidth*handles.sampleFreq ...
    +1 : handles.finalPlotEp*handles.epWidth*handles.sampleFreq);

handles.hypPlot = handles.hypnogram(handles.initialPlotEp:handles.finalPlotEp);

%% Sinal original
% Define o eixo-X:
handles.eixoX = [0:1:length(handles.sigPlot)-1];
% Plot do sinal original
axes(handles.axes10);                                                       % Seleciona a componente axes10
plot(handles.eixoX,handles.sigPlot,'Color',[0 0 0.6],'LineWidth',1.0);      % Exibe o sinal de entrada
xlim([0 length(handles.sigPlot)]);
% Ajuste do eixo-X em épocas ou segundos:
if (get(handles.radiobutton2,'Value'))                                      % radiobutton2 = seconds
    ticksSecs = 0:handles.sampleFreq:length(handles.sigPlot);
    ticksSecsLabel = ticksSecs/handles.sampleFreq;                          % Divide pela freq. amostragem para mostrar eixo-X em segundos.
    set(gca,'XTickLabelMode','manual','XTickMode','manual','XTick',ticksSecs,'XTickLabel',ticksSecsLabel);
else
    ticksEpoch = 0:(handles.sampleFreq*handles.epWidth):length(handles.sigPlot);
    ticksEpochLabel = ticksEpoch /(handles.sampleFreq*handles.epWidth);     % Divide para mostrar eixo-X em épocas.
    set(gca,'XTickLabelMode','manual','XTickMode','manual','XTick',ticksEpoch,'XTickLabel',ticksEpochLabel);
end

%% Plot do hipnograma (ver algoritmos)
% Todo o gráfico começa de 0 ao tamanho do intervalo. As epocas mostradas
% têm uma numeração local. Para localização no sinal, deve ser considerado
% o intervalo, informado à esquerda da figura.
axes(handles.axes11);
% Duplica o valor da última época:
handles.hypPlot(length(handles.hypPlot)+1) = handles.hypPlot(length(handles.hypPlot));
% Define os labels:
xHypTick = 0:1:length(handles.hypPlot);                                     % Observar que handles.hypPlot já está duplicado.
xHypTickLabel = xHypTick-1;
% Plot dos valores em formato escada
stairs(handles.hypPlot,'Color',[0.8 0 0],'LineWidth',2.0);
% Ajuste do gráfico
xlim([1 length(handles.hypPlot)]);                                          % Começa em "1" para compensar uma unidade a mais do hipnograma.
ylim([-0.2 6.2]);
set(gca,'YTick',[0 1 2 3 4 4.5 5 6],'XTick',xHypTick,'XTickLabel',xHypTickLabel);
grid on;

%% Espectrograma:
axes(handles.axes12);                                                       % Seleciona a componente axes12
% Ajuste do eixo-X em épocas ou segundos:
if (get(handles.radiobutton2,'Value'))                                      % radiobutton2 = seconds
    spectrogram(handles.sigPlot,512,500,512,handles.sampleFreq,'yaxis');  	% Espectrograma do sinal
else
    spectrogram(handles.sigPlot,512,500,512,handles.sampleFreq,'yaxis');  	% Espectrograma do sinal
    xlim([0 length(handles.sigPlot)/handles.sampleFreq]);
    ticksSpec = 0:handles.epWidth:length(handles.sigPlot)/handles.sampleFreq;
    ticksSpecLabel = ticksSpec/handles.epWidth;
    set(gca,'XTickLabelMode','manual','XTickMode','manual','XTick',ticksSpec,'XTickLabel',ticksSpecLabel);
    colorbar;
end

%% Atualiza informação de intervalo:
set(handles.text41,'String',['Interval: [' num2str(handles.initialPlotEp) ...
    '  ' num2str(handles.finalPlotEp) ']']);

% Teste para habilitar os botões Next e Previous:
if (handles.initialPlotEp + handles.intervalEp + handles.step) > handles.numEpoch +1
    set(handles.pushbutton25,'Enable','off');                               % Disables button25 (Next)
else
    set(handles.pushbutton25,'Enable','on');                                % Enables button25 (Next)
end
if (handles.finalPlotEp +1 - handles.intervalEp - handles.step) < 1
    set(handles.pushbutton24,'Enable','off');                               % Disables button24 (Previous)
else
    set(handles.pushbutton24,'Enable','on');                                % Enables button24 (Previous)
end

% Salva as variáveis handles:
guidata(hObject, handles);  



function edit17_Callback(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit17 as text
%        str2double(get(hObject,'String')) returns contents of edit17 as a double
handles.step = round(str2double(get(hObject,'String')));                    % Define o valor de step (variavel criada em handles)
set(handles.edit17,'String',num2str(handles.step));                         % Atualiza valor no campo edit17
guidata(hObject, handles);                                                  % Salva variavel GUI handles.



% --- Executes during object creation, after setting all properties.
function edit17_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2


% --- Executes on button press in pushbutton26.
function pushbutton26_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Caso a posição atual seja N1 e a anterior seja AWAKE
inicio = handles.initialEp;
fim = handles.numEpoch;
classeA = handles.transitionEpA;
classeB = handles.transitionEpB;
transitionEps = [];
for i=inicio:1:fim-1
    hypA = handles.hypnogram(i);
    hypB = handles.hypnogram(i+1);
    if (hypA == classeA) & (hypB == classeB)
        transitionEps(length(transitionEps)+1) = i;
    end
end
salva_variavel(transitionEps,length(transitionEps),'TransitionEps.txt');
popupmessage('TransitionEps.txt','Transition Epochs');


function edit18_Callback(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit18 as text
%        str2double(get(hObject,'String')) returns contents of edit18 as a double
handles.transitionEpA = round(str2double(get(hObject,'String')));              % Define o valor de finalEp (variavel criada em handles)
set(handles.edit18,'String',num2str(handles.transitionEpA));                   % Atualiza valor no campo edit16
guidata(hObject, handles);                                                  % Salva variavel GUI handles.



% --- Executes during object creation, after setting all properties.
function edit18_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit19_Callback(hObject, eventdata, handles)
% hObject    handle to edit19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit19 as text
%        str2double(get(hObject,'String')) returns contents of edit19 as a double
handles.transitionEpB = round(str2double(get(hObject,'String')));              % Define o valor de finalEp (variavel criada em handles)
set(handles.edit19,'String',num2str(handles.transitionEpB));                   % Atualiza valor no campo edit16
guidata(hObject, handles);                                                  % Salva variavel GUI handles.


% --- Executes during object creation, after setting all properties.
function edit19_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton27.
function pushbutton27_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Teste realizado de acordo com script desenvolvido para Mahalanobis
% Distance, utilizando coeficientes de Fourier.
epWidth = handles.epWidth;
fs = handles.sampleFreq;
i=1;                                                                        % Desnecessário, porém o código abaixo estava em um laço for. AJUSTAR.
epochLim = [((i-1)*epWidth*fs+1) ((i+6)*epWidth*fs)];                 % Limites para a época de transição
epoch = handles.sigPlot(epochLim(1):epochLim(2));                  % Variavel com os valores da época
% Gera o modelo de Mahala e verifica o Mardia's Test
[matriz_alfa matriz_teta] = hipnoWave_MahalaSearch_geraModelo(epoch,fs);
[H_alfa stats] = mardiatest(matriz_alfa);
[H_teta stats] = mardiatest(matriz_teta);
distN = [0 0 0];                                            % Padrão para distribuição normal no Mardia's Test
% Compara os resultados
if (isequal(H_alfa,distN) & isequal(H_teta,distN))
    set(handles.text43,'String','PASSED');
else
    set(handles.text43,'String','FAIL');
end
guidata(hObject, handles);                                                  % Salva variavel GUI handles.


% --- Executes on button press in pushbutton28.
function pushbutton28_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%% ATENÇÃO
% Este algoritmo funcionará apenas com fs=100Hz; duração da época de 30s e
% sinais com 20 épocas. Caso estes parâmetros sejam alterados, haverá erro.
% Em versões futuras, o algoritmo abaixo deve ser adaptado para utilizar os
% "handles." na manipulação das variáveis.
% JÁ ADAPTADO PARA DIFERENTES VALORES, CONFORME HANDLES. ADAPTAR ALGORITMO.
%% Calculo dos coefs significativos
fs = handles.sampleFreq;
m = 400;
% O nível maximo da TWD, jMax é dado por jMax = ceil(log2 (fs*epWidth)). Ou
% seja, o maior inteiro que representa o número de amostras por época. Por
% exemplo, fs=100Hz e epWidth=30s, resulta em um sinal de 3000 amostras.
% Logo, jMax=ceil(11.55)=12. Assim, 2^12 = 4096.
jMax = ceil(log2(fs*handles.epWidth));
jMin = 5;
nome_banco = 'HipnoWave_bestApprox';
% Variavel com os valores da época
variavel = handles.sigPlot;
% Localização do programa para best m-term approximation:
diretorio = 'C:\Dados\Mestrado\Desenvolvimento\Estudos\EEG Analysis and Drowsiness\Testes\09 - BestApprox Physionet\';
    
%% Pré-processamento:    
% Separação das épocas da seleção em arquivos para cada época:
% Define o tamanho, em amostras, de cada época.
samplesEp = handles.epWidth*fs;
% Define os valores para zero-padding:
zeroLength = (pow2(jMax) - samplesEp)/2;
for i=1:handles.intervalEp
    % Leitura de cada época (30s) no total da seleção (10min):
    eDlim = [((i-1)*samplesEp+1) (i*samplesEp)];          % Limites para a época nEpoca.
    epoch = variavel(eDlim(1):eDlim(2));                                    % Variavel com os valores da época D
    % Zero-padding do sinal de entrada: de "samplesEp" para 2^jMax
    sinalFinal = zeros(zeroLength,1);
    sinalFinal(zeroLength+1:samplesEp+zeroLength) = epoch;
    sinalFinal(samplesEp+zeroLength+1:pow2(jMax)) = zeros(zeroLength,1);
    salva_variavel(sinalFinal,length(sinalFinal),[nome_banco '_epoca' num2str(i) '.txt']);
end;

% Cria estrutura de dados para armazenar os coefs signif de cada época
coefsSignif = struct('j11coefs',{},'j11peso',{},'j9coefs',{},'j9peso',{});
% Cria matrizes vazias. 1a coluna = j11; 2a coluna = j9.
pesoAwake = []; 

%% Execução do teste Best Approx Class para cada época:
for i=1:handles.intervalEp
    arquivo_sinal = [nome_banco '_epoca' num2str(i) '.txt'];
    arquivo = fopen('BestApprox11_executa.bat','w');
    % Utiliza o arquivo "sinalHx.txt", gerado anteriormente
    fprintf(arquivo,['"%sBest_HT.exe" %d %d ' arquivo_sinal ' %d "%sBest_HT_thresh0_7j.txt"\n'],diretorio,jMax,jMin,m,diretorio);
    fclose(arquivo);
    !BestApprox11_executa.bat
    %% Indicativo de coeficientes significativos por nível:
    numSign = load('cont_posic_P.txt');                                   % Carrega informação de coefs significativos por nível
    coefsSignif(i).j11coefs = numSign(1);
    coefsSignif(i).j9coefs = numSign(3);
    % Calcula o peso de cada nível, desconsiderando o zero-padding:
    coefsSignif(i).j11peso = (coefsSignif(i).j11coefs/1500)*100;
    coefsSignif(i).j9peso = (coefsSignif(i).j9coefs/375)*100;
    % Apaga o arquivo de lote e o txt contendo o sinal
    delete BestApprox11_executa.bat
    eval(['delete ' arquivo_sinal]);
    
    % Armazena os valores de acordo com a classificação do hipnograma:
    pesoAwake(size(pesoAwake,1)+1,:) = [coefsSignif(i).j11peso coefsSignif(i).j9peso];
end

%% Plot do best m-term approximation
axes(handles.axes14);
% Plot dos valores em formato escada
plot(pesoAwake(:,2),pesoAwake(:,1),'s','MarkerFaceColor',[0.8 0 0])
% Ajuste do gráfico
xlim([0 52]);
ylim([0 9.5]);
grid on;
xlabel('Percentual coefs signif. nível j9')
ylabel('% j11')

