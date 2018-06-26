function varargout = ThreshTool(varargin)
% THRESHTOOL M-file for ThreshTool.fig
%      THRESHTOOL, by itself, creates a new THRESHTOOL or raises the existing
%      singleton*.
%
%      H = THRESHTOOL returns the handle to a new THRESHTOOL or the handle to
%      the existing singleton*.
%
%      THRESHTOOL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in THRESHTOOL.M with the given input arguments.
%
%      THRESHTOOL('Property','Value',...) creates a new THRESHTOOL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ThreshTool_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ThreshTool_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
%   É IMPORTANTE DEFINIR O PATH ONDE ESTÁ INSTALADO O THRESHTOOL NAS
%   VARIAVEIS DO WINDOWS... OBSERVAR PARA NAO HAVER OS MESMOS EXECUTAVEIS
%   NA PASTA QUE CONTIVER OS DADOS...
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ThreshTool

% Last Modified by GUIDE v2.5 24-Apr-2012 16:58:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ThreshTool_OpeningFcn, ...
                   'gui_OutputFcn',  @ThreshTool_OutputFcn, ...
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


% --- Executes just before ThreshTool is made visible.
function ThreshTool_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ThreshTool (see VARARGIN)

% Choose default command line output for ThreshTool
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ThreshTool wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ThreshTool_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in radiobutton4.
function radiobutton4_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton4


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Mostra tela para que o usuario escolha o arquivo do sinal:
[filename, pathname] = uigetfile('*.txt', 'Pick an input file');
% Verifica se foi cancelado
if ~isequal(filename,0)
    handles.arquivo = filename;                     % Armazena em handles o nome do arquivo.
    handles.sinal = load([pathname filename]);      % Armazena em handles o sinal.
    handles.eixoX = [0:1:length(handles.sinal)-1];
    axes(handles.axesIn);                           % Seleciona a componente axesIn
    plot(handles.eixoX,handles.sinal,'Color',[0 0 0.6],'LineWidth',1.0);  % Exibe o sinal de entrada
    xlim([0 length(handles.sinal)]);
    
    handles.nBest = length(handles.sinal);
    set(handles.slider36,'Max',length(handles.sinal));  % Atualiza valor máximo de numBest (slider36)
    set(handles.slider36,'Value',handles.nBest);
    set(handles.numBest,'String',handles.nBest);
    set(handles.pushbutton4,'Enable','on');         % Habilita botão 4
    set(handles.pushbutton6,'Enable','off');         % Desabilita botão 6
    set(handles.pushbutton7,'Enable','off');         % Desabilita botão 7
    set(handles.pushbutton8,'Enable','off');         % Desabilita botão 8
end
set(handles.text28,'String',filename);
% Inicializa variáveis do threshold:
handles.j11_thvalue = 0.0;
handles.j10_thvalue = 0.0;
handles.j9_thvalue = 0.0;
handles.j8_thvalue = 0.0;
handles.j7_thvalue = 0.0;
handles.j6_thvalue = 0.0;
handles.j5_thvalue = 0.0;
handles.result_view = -1.0;
guidata(hObject, handles);                          % Salva a variável handles


% --- Executes on slider movement.
function slider15_Callback(hObject, eventdata, handles)
% hObject    handle to slider15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit16_Callback(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit16 as text
%        str2double(get(hObject,'String')) returns contents of edit16 as a double


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


% --- Executes on slider movement.
function slider16_Callback(hObject, eventdata, handles)
% hObject    handle to slider16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit17_Callback(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit17 as text
%        str2double(get(hObject,'String')) returns contents of edit17 as a double


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


% --- Executes on slider movement.
function slider17_Callback(hObject, eventdata, handles)
% hObject    handle to slider17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider17_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit18_Callback(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit18 as text
%        str2double(get(hObject,'String')) returns contents of edit18 as a double


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


% --- Executes on slider movement.
function slider18_Callback(hObject, eventdata, handles)
% hObject    handle to slider18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider18_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit19_Callback(hObject, eventdata, handles)
% hObject    handle to edit19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit19 as text
%        str2double(get(hObject,'String')) returns contents of edit19 as a double


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


% --- Executes on slider movement.
function slider19_Callback(hObject, eventdata, handles)
% hObject    handle to slider19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider19_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit20_Callback(hObject, eventdata, handles)
% hObject    handle to edit20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit20 as text
%        str2double(get(hObject,'String')) returns contents of edit20 as a double


% --- Executes during object creation, after setting all properties.
function edit20_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider20_Callback(hObject, eventdata, handles)
% hObject    handle to slider20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider20_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit21_Callback(hObject, eventdata, handles)
% hObject    handle to edit21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit21 as text
%        str2double(get(hObject,'String')) returns contents of edit21 as a double


% --- Executes during object creation, after setting all properties.
function edit21_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider21_Callback(hObject, eventdata, handles)
% hObject    handle to slider21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider21_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit22_Callback(hObject, eventdata, handles)
% hObject    handle to edit22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit22 as text
%        str2double(get(hObject,'String')) returns contents of edit22 as a double


% --- Executes during object creation, after setting all properties.
function edit22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function numBest_Callback(hObject, eventdata, handles)
% hObject    handle to numBest (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of numBest as text
%        str2double(get(hObject,'String')) returns contents of numBest as a double
handles.nBest = round(str2double(get(hObject,'String')));       % Define o valor de nBest
set(handles.numBest,'String',num2str(handles.nBest));           % Atualiza valor de nBest no campo numBest
set(handles.slider36,'Value',handles.nBest);                    % Atualiza valor do slider36.
guidata(hObject, handles);                                      % Salva variavel GUI handles.


% --- Executes during object creation, after setting all properties.
function numBest_CreateFcn(hObject, eventdata, handles)
% hObject    handle to numBest (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Abre arquivo batch auxiliar, grava chamada do programa e executa;
arquivo = fopen('2_executa.bat','w');
    fprintf(arquivo,'CalcDWT1D.exe 12 5 %s\n',handles.arquivo);
    fclose(arquivo);
    !2_executa
% Leitura dos arquivos gerados
j11 = load('readF_11.dif');
if (abs(min(j11))>max(j11)) 
    handles.j11abs = abs(min(j11));
else
    handles.j11abs = max(j11);
end

j10 = load('readF_10.dif');
if (abs(min(j10))>max(j10)) 
    handles.j10abs = abs(min(j10));
else
    handles.j10abs = max(j10);
end

j9 = load('readF_9.dif');
if (abs(min(j9))>max(j9)) 
    handles.j9abs = abs(min(j9));
else
    handles.j9abs = max(j9);
end

j8 = load('readF_8.dif');
if (abs(min(j8))>max(j8)) 
    handles.j8abs = abs(min(j8));
else
    handles.j8abs = max(j8);
end

j7 = load('readF_7.dif');
if (abs(min(j7))>max(j7)) 
    handles.j7abs = abs(min(j7));
else
    handles.j7abs = max(j7);
end

j6 = load('readF_6.dif');
if (abs(min(j6))>max(j6)) 
    handles.j6abs = abs(min(j6));
else
    handles.j6abs = max(j6);
end

j5 = load('readF_5.dif');
if (abs(min(j5))>max(j5)) 
    handles.j5abs = abs(min(j5));
else
    handles.j5abs = max(j5);
end

% Cria handles para matriz de coeficientes lidos
handles.coefs = [min(j11),max(j11),handles.j11abs;
    min(j10),max(j10),handles.j10abs;
    min(j9),max(j9),handles.j9abs;
    min(j8),max(j8),handles.j8abs;
    min(j7),max(j7),handles.j7abs;
    min(j6),max(j6),handles.j6abs;
    min(j5),max(j5),handles.j5abs];
set(handles.uitable2,'data',handles.coefs);
set(handles.pushbutton6,'Enable','on');     % Habilita botão 06
% Se já existir arquivo de thresholding associado ao sinal, habilita o
% botão para cálculo do BestRepr e thresholding...
if exist([handles.arquivo '_thresholds.txt'],'file')
    set(handles.pushbutton7,'Enable','on');
end
guidata(hObject, handles);      % Salva variavel GUI handles.


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Cria arquivo com os valores de threshold;
arquivo = fopen([handles.arquivo '_thresholds.txt'],'w');
    fprintf(arquivo,'%f\n',handles.j11_thvalue);
    fprintf(arquivo,'%f\n',handles.j10_thvalue);
    fprintf(arquivo,'%f\n',handles.j9_thvalue);
    fprintf(arquivo,'%f\n',handles.j8_thvalue);
    fprintf(arquivo,'%f\n',handles.j7_thvalue);
    fprintf(arquivo,'%f\n',handles.j6_thvalue);
    fprintf(arquivo,'%f\n',handles.j5_thvalue);
    fclose(arquivo);
disp('The threshold file was recorded')
set(handles.pushbutton7,'Enable','on');


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Abre arquivo batch auxiliar, grava chamada do programa e executa;
arquivo = fopen('4_executa.bat','w');
    if (get(handles.radioHard,'Value'))
        fprintf(arquivo,'Best_HT.exe 12 5 %s %d %s\n',handles.arquivo,handles.nBest,[handles.arquivo '_thresholds.txt']);
    else
        fprintf(arquivo,'Best_ST.exe 12 5 %s %d %s\n',handles.arquivo,handles.nBest,[handles.arquivo '_thresholds.txt']);
    end
    fclose(arquivo);
    !4_executa
% Exibição do sinal reconstruído;
if (get(handles.radiobutton10,'Value'))
    sinalReconstr = load('G_inversa.txt');
    coefs_result = load('cont_posic_G.txt');
else 
    sinalReconstr = load('P_inversa.txt');
    coefs_result = load('cont_posic_P.txt');
end
%handles.eixoX = [0:1:length(sinalReconstr)-1];  % Já existe handles.eixoX
axes(handles.axesOut);                           % Seleciona a componente axesOut
plot(handles.eixoX,sinalReconstr,'Color',[0 0.6 0],'LineWidth',1.0);  % Exibe o sinal reconstruído
xlim([0 length(handles.sinal)]);
set(handles.pushbutton8,'Enable','on');         % Habilita botão 8
% Faz a leitura do arquivo "cont_posic.txt" e calcula percentual
coefs_mostra = [coefs_result(1), ((coefs_result(1)/(2^11))*100);
    coefs_result(2), ((coefs_result(2)/(2^10))*100);
    coefs_result(3), ((coefs_result(3)/(2^9))*100);
    coefs_result(4), ((coefs_result(4)/(2^8))*100);
    coefs_result(5), ((coefs_result(5)/(2^7))*100);
    coefs_result(6), ((coefs_result(6)/(2^6))*100);
    coefs_result(7), ((coefs_result(7)/(2^5))*100)];    
set(handles.uitable3,'data',coefs_mostra);
guidata(hObject, handles);      % Salva variavel GUI handles.


% --- Executes on slider movement.
function slider22_Callback(hObject, eventdata, handles)
% hObject    handle to slider22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit24_Callback(hObject, eventdata, handles)
% hObject    handle to edit24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit24 as text
%        str2double(get(hObject,'String')) returns contents of edit24 as a double


% --- Executes during object creation, after setting all properties.
function edit24_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider23_Callback(hObject, eventdata, handles)
% hObject    handle to slider23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider23_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit25_Callback(hObject, eventdata, handles)
% hObject    handle to edit25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit25 as text
%        str2double(get(hObject,'String')) returns contents of edit25 as a double


% --- Executes during object creation, after setting all properties.
function edit25_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider24_Callback(hObject, eventdata, handles)
% hObject    handle to slider24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider24_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit26_Callback(hObject, eventdata, handles)
% hObject    handle to edit26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit26 as text
%        str2double(get(hObject,'String')) returns contents of edit26 as a double


% --- Executes during object creation, after setting all properties.
function edit26_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider25_Callback(hObject, eventdata, handles)
% hObject    handle to slider25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider25_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit27_Callback(hObject, eventdata, handles)
% hObject    handle to edit27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit27 as text
%        str2double(get(hObject,'String')) returns contents of edit27 as a double


% --- Executes during object creation, after setting all properties.
function edit27_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider26_Callback(hObject, eventdata, handles)
% hObject    handle to slider26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider26_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit28_Callback(hObject, eventdata, handles)
% hObject    handle to edit28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit28 as text
%        str2double(get(hObject,'String')) returns contents of edit28 as a double


% --- Executes during object creation, after setting all properties.
function edit28_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider27_Callback(hObject, eventdata, handles)
% hObject    handle to slider27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider27_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit29_Callback(hObject, eventdata, handles)
% hObject    handle to edit29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit29 as text
%        str2double(get(hObject,'String')) returns contents of edit29 as a double


% --- Executes during object creation, after setting all properties.
function edit29_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider28_Callback(hObject, eventdata, handles)
% hObject    handle to slider28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider28_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit30_Callback(hObject, eventdata, handles)
% hObject    handle to edit30 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit30 as text
%        str2double(get(hObject,'String')) returns contents of edit30 as a double


% --- Executes during object creation, after setting all properties.
function edit30_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit30 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Valor iniciais --> EM VERSÃO FUTURA, PERMITIR QUE USUARIO DEFINA
fs = str2double(get(handles.edit_fsample,'String'));
nsample = length(handles.sinal);
XLim = [str2double(get(handles.xFFT_min,'String')) str2double(get(handles.xFFT_max,'String'))];
YLim = [str2double(get(handles.yFFT_min,'String')) str2double(get(handles.yFFT_max,'String'))];
%XLim = [0 50];
%YLim = [0 1];
% Adaptado do script "adaptado_fft_win.m"
    T = 1/fs;                           % Sample time
    L = nsample;                        % Length of signal
    y1 = load('F_inversa.txt');
    if (get(handles.radiobutton10,'Value'))
        y2 = load('G_inversa.txt');
    else
        y2 = load('P_inversa.txt');
    end
    
    % Janelamento - Script criado por Tiago Weber. Adaptado por Tiago da Silveira
    win = 'blackmanharris';             % Define a janela a ser utilizada.
    w = window(win,nsample);
    if (strcmp(win,'hann') | strcmp(win,'ds_hann'))
        w = w'; %the hann window function outputs columns instead of lines
    end
    
    NFFT = 2^nextpow2(L);               % Próxima potência de 2 maior que o número de elementos do sinal de entrada.
    %Y = fft(y,NFFT)/L;                     % Sem o janelamento
    Y1 = fft(y1.*w,NFFT)/L;                   % Com janelamento.
    Y2 = fft(y2.*w,NFFT)/L;                   % Com janelamento.
    handles.valorFreq = fs/2*linspace(0,1,NFFT/2+1);    % Intervalo das frequências no eixo das abscissas.
    % "f" é a metade da frequência de amostragem devido ao Teorema de Nyquist e
    % à simetria da transformada de Fourier.    
    
    axes(handles.axesFFTin);                           % Seleciona a componente axesIn
    stem(handles.valorFreq,2*abs(Y1(1:NFFT/2+1)))        % abs() indica o módulo da componente complexa de frequência. É multiplicado por 2 uma vez que para cada freq existem duas componentes.
    xlabel('Frequência (Hz)')
    %ylabel('Magnitude')
    set(gca,'XLim',XLim,'YLim',YLim)
    grid on
    freq1 = 2*abs(Y1(str2num(get(handles.editFreq1,'String'))));
    freq2 = 2*abs(Y1(str2num(get(handles.editFreq2,'String'))));
    freq3 = 2*abs(Y1(str2num(get(handles.editFreq3,'String'))));
    set(handles.showFreq1,'String',num2str(freq1));            % Freq 4.9805Hz
    set(handles.showFreq2,'String',num2str(freq2));            % Freq 10.0098Hz
    set(handles.showFreq3,'String',num2str(freq3));            % Freq 29.9805Hz

    axes(handles.axesFFTout);                           % Seleciona a componente axesIn
    stem(handles.valorFreq,2*abs(Y2(1:NFFT/2+1)))        % abs() indica o módulo da componente complexa de frequência. É multiplicado por 2 uma vez que para cada freq existem duas componentes.
    xlabel('Frequência (Hz)')
    %ylabel('Magnitude')
    set(gca,'XLim',XLim,'YLim',YLim)
    grid on
    freq1r = 2*abs(Y2(str2num(get(handles.editFreq1,'String'))));
    freq2r = 2*abs(Y2(str2num(get(handles.editFreq2,'String'))));
    freq3r = 2*abs(Y2(str2num(get(handles.editFreq3,'String'))));
    set(handles.showFreq1r,'String',num2str(freq1r));            % Freq 4.9805Hz
    set(handles.showFreq2r,'String',num2str(freq2r));            % Freq 10.0098Hz
    set(handles.showFreq3r,'String',num2str(freq3r));            % Freq 29.9805Hz
    % Calculo do amortecimento das comp. de frequencia (percentual)
    set(handles.damp1,'String',num2str((1-(freq1r/freq1))*100));            % Freq 4.9805Hz
    set(handles.damp2,'String',num2str((1-(freq2r/freq2))*100));            % Freq 10.0098Hz
    set(handles.damp3,'String',num2str((1-(freq3r/freq3))*100));            % Freq 29.9805Hz
    guidata(hObject, handles);


% --- Executes on slider movement.
function slider29_Callback(hObject, eventdata, handles)
% hObject    handle to slider29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.j11_perc = get(hObject,'Value');                            % Define o valor do percentual
handles.j11_thvalue = handles.j11abs*((handles.j11_perc)/100);      % Calcula valor do threshold
set(handles.j11edit,'String',[num2str(handles.j11_perc) '%']);      % Atualiza valor do percentual
set(handles.j11_lambda,'String',num2str(handles.j11_thvalue));      % Atualiza valor do thresholding
guidata(hObject, handles);                                          % Salva variavel GUI handles.

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider29_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider30_Callback(hObject, eventdata, handles)
% hObject    handle to slider30 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.j10_perc = get(hObject,'Value');                            % Define o valor do percentual
handles.j10_thvalue = handles.j10abs*((handles.j10_perc)/100);      % Calcula valor do threshold
set(handles.j10edit,'String',[num2str(handles.j10_perc) '%']);      % Atualiza valor do percentual
set(handles.j10_lambda,'String',num2str(handles.j10_thvalue));      % Atualiza valor do thresholding
guidata(hObject, handles);                                          % Salva variavel GUI handles.

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider30_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider30 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider31_Callback(hObject, eventdata, handles)
% hObject    handle to slider31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.j9_perc = get(hObject,'Value');                            % Define o valor do percentual
handles.j9_thvalue = handles.j9abs*((handles.j9_perc)/100);      % Calcula valor do threshold
set(handles.j9edit,'String',[num2str(handles.j9_perc) '%']);      % Atualiza valor do percentual
set(handles.j9_lambda,'String',num2str(handles.j9_thvalue));      % Atualiza valor do thresholding
guidata(hObject, handles);                                          % Salva variavel GUI handles.

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider31_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider32_Callback(hObject, eventdata, handles)
% hObject    handle to slider32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.j8_perc = get(hObject,'Value');                            % Define o valor do percentual
handles.j8_thvalue = handles.j8abs*((handles.j8_perc)/100);      % Calcula valor do threshold
set(handles.j8edit,'String',[num2str(handles.j8_perc) '%']);      % Atualiza valor do percentual
set(handles.j8_lambda,'String',num2str(handles.j8_thvalue));      % Atualiza valor do thresholding
guidata(hObject, handles);                                          % Salva variavel GUI handles.


% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider32_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider33_Callback(hObject, eventdata, handles)
% hObject    handle to slider33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.j7_perc = get(hObject,'Value');                            % Define o valor do percentual
handles.j7_thvalue = handles.j7abs*((handles.j7_perc)/100);      % Calcula valor do threshold
set(handles.j7edit,'String',[num2str(handles.j7_perc) '%']);      % Atualiza valor do percentual
set(handles.j7_lambda,'String',num2str(handles.j7_thvalue));      % Atualiza valor do thresholding
guidata(hObject, handles);                                          % Salva variavel GUI handles.


% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider33_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider34_Callback(hObject, eventdata, handles)
% hObject    handle to slider34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.j6_perc = get(hObject,'Value');                            % Define o valor do percentual
handles.j6_thvalue = handles.j6abs*((handles.j6_perc)/100);      % Calcula valor do threshold
set(handles.j6edit,'String',[num2str(handles.j6_perc) '%']);      % Atualiza valor do percentual
set(handles.j6_lambda,'String',num2str(handles.j6_thvalue));      % Atualiza valor do thresholding
guidata(hObject, handles);                                          % Salva variavel GUI handles.


% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider34_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider35_Callback(hObject, eventdata, handles)
% hObject    handle to slider35 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.j5_perc = get(hObject,'Value');                            % Define o valor do percentual
handles.j5_thvalue = handles.j5abs*((handles.j5_perc)/100);      % Calcula valor do threshold
set(handles.j5edit,'String',[num2str(handles.j5_perc) '%']);      % Atualiza valor do percentual
set(handles.j5_lambda,'String',num2str(handles.j5_thvalue));      % Atualiza valor do thresholding
guidata(hObject, handles);                                          % Salva variavel GUI handles.


% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider35_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider35 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function j11edit_Callback(hObject, eventdata, handles)
% hObject    handle to j11edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of j11edit as text
%        str2double(get(hObject,'String')) returns contents of j11edit as a double


% --- Executes during object creation, after setting all properties.
function j11edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to j11edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function j10edit_Callback(hObject, eventdata, handles)
% hObject    handle to j10edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of j10edit as text
%        str2double(get(hObject,'String')) returns contents of j10edit as a double


% --- Executes during object creation, after setting all properties.
function j10edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to j10edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit33_Callback(hObject, eventdata, handles)
% hObject    handle to edit33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit33 as text
%        str2double(get(hObject,'String')) returns contents of edit33 as a double


% --- Executes during object creation, after setting all properties.
function edit33_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function j9edit_Callback(hObject, eventdata, handles)
% hObject    handle to j9edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of j9edit as text
%        str2double(get(hObject,'String')) returns contents of j9edit as a double


% --- Executes during object creation, after setting all properties.
function j9edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to j9edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function j8edit_Callback(hObject, eventdata, handles)
% hObject    handle to j8edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of j8edit as text
%        str2double(get(hObject,'String')) returns contents of j8edit as a double


% --- Executes during object creation, after setting all properties.
function j8edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to j8edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function j7edit_Callback(hObject, eventdata, handles)
% hObject    handle to j7edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of j7edit as text
%        str2double(get(hObject,'String')) returns contents of j7edit as a double


% --- Executes during object creation, after setting all properties.
function j7edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to j7edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function j6edit_Callback(hObject, eventdata, handles)
% hObject    handle to j6edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of j6edit as text
%        str2double(get(hObject,'String')) returns contents of j6edit as a double


% --- Executes during object creation, after setting all properties.
function j6edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to j6edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function j5edit_Callback(hObject, eventdata, handles)
% hObject    handle to j5edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of j5edit as text
%        str2double(get(hObject,'String')) returns contents of j5edit as a double


% --- Executes during object creation, after setting all properties.
function j5edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to j5edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function j11_lambda_Callback(hObject, eventdata, handles)
% hObject    handle to j11_lambda (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of j11_lambda as text
%        str2double(get(hObject,'String')) returns contents of j11_lambda as a double


% --- Executes during object creation, after setting all properties.
function j11_lambda_CreateFcn(hObject, eventdata, handles)
% hObject    handle to j11_lambda (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function j10_lambda_Callback(hObject, eventdata, handles)
% hObject    handle to j10_lambda (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of j10_lambda as text
%        str2double(get(hObject,'String')) returns contents of j10_lambda as a double


% --- Executes during object creation, after setting all properties.
function j10_lambda_CreateFcn(hObject, eventdata, handles)
% hObject    handle to j10_lambda (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function j9_lambda_Callback(hObject, eventdata, handles)
% hObject    handle to j9_lambda (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of j9_lambda as text
%        str2double(get(hObject,'String')) returns contents of j9_lambda as a double


% --- Executes during object creation, after setting all properties.
function j9_lambda_CreateFcn(hObject, eventdata, handles)
% hObject    handle to j9_lambda (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function j8_lambda_Callback(hObject, eventdata, handles)
% hObject    handle to j8_lambda (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of j8_lambda as text
%        str2double(get(hObject,'String')) returns contents of j8_lambda as a double


% --- Executes during object creation, after setting all properties.
function j8_lambda_CreateFcn(hObject, eventdata, handles)
% hObject    handle to j8_lambda (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function j7_lambda_Callback(hObject, eventdata, handles)
% hObject    handle to j7_lambda (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of j7_lambda as text
%        str2double(get(hObject,'String')) returns contents of j7_lambda as a double


% --- Executes during object creation, after setting all properties.
function j7_lambda_CreateFcn(hObject, eventdata, handles)
% hObject    handle to j7_lambda (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function j6_lambda_Callback(hObject, eventdata, handles)
% hObject    handle to j6_lambda (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of j6_lambda as text
%        str2double(get(hObject,'String')) returns contents of j6_lambda as a double


% --- Executes during object creation, after setting all properties.
function j6_lambda_CreateFcn(hObject, eventdata, handles)
% hObject    handle to j6_lambda (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function j5_lambda_Callback(hObject, eventdata, handles)
% hObject    handle to j5_lambda (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of j5_lambda as text
%        str2double(get(hObject,'String')) returns contents of j5_lambda as a double


% --- Executes during object creation, after setting all properties.
function j5_lambda_CreateFcn(hObject, eventdata, handles)
% hObject    handle to j5_lambda (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider36_Callback(hObject, eventdata, handles)
% hObject    handle to slider36 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.nBest = round(get(hObject,'Value'));                    % Define o valor de nBest
set(handles.numBest,'String',num2str(handles.nBest));           % Atualiza valor de nBest no campo numBest
guidata(hObject, handles);                                      % Salva variavel GUI handles.


% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider36_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider36 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in radioHard.
function radioHard_Callback(hObject, eventdata, handles)
% hObject    handle to radioHard (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radioHard



function xFFT_min_Callback(hObject, eventdata, handles)
% hObject    handle to xFFT_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of xFFT_min as text
%        str2double(get(hObject,'String')) returns contents of xFFT_min as a double


% --- Executes during object creation, after setting all properties.
function xFFT_min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xFFT_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function yFFT_min_Callback(hObject, eventdata, handles)
% hObject    handle to yFFT_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of yFFT_min as text
%        str2double(get(hObject,'String')) returns contents of yFFT_min as a double


% --- Executes during object creation, after setting all properties.
function yFFT_min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yFFT_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function xFFT_max_Callback(hObject, eventdata, handles)
% hObject    handle to xFFT_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of xFFT_max as text
%        str2double(get(hObject,'String')) returns contents of xFFT_max as a double


% --- Executes during object creation, after setting all properties.
function xFFT_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xFFT_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function yFFT_max_Callback(hObject, eventdata, handles)
% hObject    handle to yFFT_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of yFFT_max as text
%        str2double(get(hObject,'String')) returns contents of yFFT_max as a double


% --- Executes during object creation, after setting all properties.
function yFFT_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yFFT_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function showFreq1_Callback(hObject, eventdata, handles)
% hObject    handle to showFreq1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of showFreq1 as text
%        str2double(get(hObject,'String')) returns contents of showFreq1 as a double


% --- Executes during object creation, after setting all properties.
function showFreq1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to showFreq1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function showFreq2_Callback(hObject, eventdata, handles)
% hObject    handle to showFreq2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of showFreq2 as text
%        str2double(get(hObject,'String')) returns contents of showFreq2 as a double


% --- Executes during object creation, after setting all properties.
function showFreq2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to showFreq2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function showFreq3_Callback(hObject, eventdata, handles)
% hObject    handle to showFreq3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of showFreq3 as text
%        str2double(get(hObject,'String')) returns contents of showFreq3 as a double


% --- Executes during object creation, after setting all properties.
function showFreq3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to showFreq3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function showFreq1r_Callback(hObject, eventdata, handles)
% hObject    handle to showFreq1r (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of showFreq1r as text
%        str2double(get(hObject,'String')) returns contents of showFreq1r as a double


% --- Executes during object creation, after setting all properties.
function showFreq1r_CreateFcn(hObject, eventdata, handles)
% hObject    handle to showFreq1r (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function showFreq2r_Callback(hObject, eventdata, handles)
% hObject    handle to showFreq2r (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of showFreq2r as text
%        str2double(get(hObject,'String')) returns contents of showFreq2r as a double


% --- Executes during object creation, after setting all properties.
function showFreq2r_CreateFcn(hObject, eventdata, handles)
% hObject    handle to showFreq2r (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function showFreq3r_Callback(hObject, eventdata, handles)
% hObject    handle to showFreq3r (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of showFreq3r as text
%        str2double(get(hObject,'String')) returns contents of showFreq3r as a double


% --- Executes during object creation, after setting all properties.
function showFreq3r_CreateFcn(hObject, eventdata, handles)
% hObject    handle to showFreq3r (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editFreq1_Callback(hObject, eventdata, handles)
% hObject    handle to editFreq1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editFreq1 as text
%        str2double(get(hObject,'String')) returns contents of editFreq1 as a double


% --- Executes during object creation, after setting all properties.
function editFreq1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editFreq1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editFreq2_Callback(hObject, eventdata, handles)
% hObject    handle to editFreq2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editFreq2 as text
%        str2double(get(hObject,'String')) returns contents of editFreq2 as a double


% --- Executes during object creation, after setting all properties.
function editFreq2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editFreq2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editFreq3_Callback(hObject, eventdata, handles)
% hObject    handle to editFreq3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editFreq3 as text
%        str2double(get(hObject,'String')) returns contents of editFreq3 as a double


% --- Executes during object creation, after setting all properties.
function editFreq3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editFreq3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
f = figure('MenuBar','none','Position', [100 100 400 200]);
t = uitable('Parent', f, 'Position', [5 5 390 190]);
set(t, 'Data', handles.valorFreq);



function damp1_Callback(hObject, eventdata, handles)
% hObject    handle to damp1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of damp1 as text
%        str2double(get(hObject,'String')) returns contents of damp1 as a double


% --- Executes during object creation, after setting all properties.
function damp1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to damp1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function damp2_Callback(hObject, eventdata, handles)
% hObject    handle to damp2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of damp2 as text
%        str2double(get(hObject,'String')) returns contents of damp2 as a double


% --- Executes during object creation, after setting all properties.
function damp2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to damp2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function damp3_Callback(hObject, eventdata, handles)
% hObject    handle to damp3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of damp3 as text
%        str2double(get(hObject,'String')) returns contents of damp3 as a double


% --- Executes during object creation, after setting all properties.
function damp3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to damp3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when entered data in editable cell(s) in uitable2.
function uitable2_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to uitable2 (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.result_view = (-1)*(handles.result_view);

guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function pushbutton10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function edit_fsample_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fsample (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fsample as text
%        str2double(get(hObject,'String')) returns contents of edit_fsample as a double


% --- Executes during object creation, after setting all properties.
function edit_fsample_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fsample (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function uipanel11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uipanel11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes when selected object is changed in uipanel11.
function uipanel11_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uipanel11 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in radiobutton11.
function radiobutton11_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton11


% --- Executes on button press in radioSoft.
function radioSoft_Callback(hObject, eventdata, handles)
% hObject    handle to radioSoft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radioSoft


% --------------------------------------------------------------------
function uipanel8_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to uipanel8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


