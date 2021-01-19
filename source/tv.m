function varargout = tv(varargin)
%PROJETO DE VIABILIZACAO DE CANAL DE TV COM AUXILIO DO MATLAB
%
%FACULDADE DE TECNOLOGIA E CIENCIAS - FTC
%TRABALHO DE CONCLUSAO DO CURSO DE ENGENHARIA ELETRICA COM ENFASE
%EM TELECOMUNICACOES E COMPUTACAO
%ORIENTADOR: PROF. ROBERTO DA COSTA E SILVA
%AUTOR: MARCELO CAMERA OLIVEIRA
%EMAIL: mcelooliveira@gmail.com
%SALVADOR - BAHIA - JANEIRO - 2006

% Begin initialization code
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @tv_OpeningFcn, ...
                   'gui_OutputFcn',  @tv_OutputFcn, ...
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
% End initialization code

function tv_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;
guidata(hObject, handles);

set(handles.uipanel_dados,'Visible','off');
set(handles.uipanel_contornos,'Visible','off');
set(handles.mnu_save,'Enable','off');
set(handles.mnu_edit,'Enable','off');
set(handles.mnu_iniciar,'Enable','off');

global CI02_50_10 CI07_50_10 CI14_50_10 CP02_50_50 CP07_50_50 CP14_50_50
%Carregar as tabelas:
%CURVA D CANAL 2 A 6 (50,10)
CI02_50_10=[355   315   245   185   130    36     7     2
            365   325   250   190   135    47    12     3
            372   332   265   205   146    60    18     4
            380   340   272   210   153    67    24   4.5
            395   358   287   227   172    85    33     7
            420   378   305   245   188   105    43    11
            450   415   345   282   220   129    62    17 ];
%CURVA D CANAL 7 A 13(50,10)
CI07_50_10=[355   315   245   185   130    44    10     2
            360   320   250   190   135    52    15     3
            370   332   260   200   145    65    24     4
            380   340   270   210   150    72    30   4.5
            400   355   285   225   170    90    40     8
            420   378   305   245   190   108    53    14
            450   415   340   280   218   132    73    20 ];
%CURVA D CANAL 14 A 59(50,10)
CI14_50_10=[345   305   230   170   118    36   7.5     2
            345   305   238   180   120    41    13     3
            360   320   250   190   130    52    20     4
            365   325   257   197   140    58    24   4.5
            385   345   277   215 157.5    70    33   7.5
            405   365   295   230   175    88    40    12
            440   400   330   265   205 112.5    52    16 ];
%CURVA D CANAL 2 A 6 (50,50)
CP02_50_50=[290   250   185   130    75    29    10   3.5   0.5
            293   257   190   135    83    38    12   4.5   0.6
            305   265   205   144    97    51    15     6   1.1
            310   275   210   150   105    59    20   7.5   1.5
             35   290   225   170   125    70    29    10   1.8
            360   310   245   185    85  37.5    12    12     2
            400   370   273   215   165   105    57    14     2 ];
%CURVA D CANAL 7 A 13 (50,50)
CP07_50_50=[295   255   185   132    75    35    10   4.5   0.5
            297   260   190   135    85    47    13   5.4     1
            305   270   205   145   102    58    18     7   1.5
            310   280   215   150   109    64    25   8.5   1.6
            335   303   230   170   130    72    35    10   1.7
            345   310   250   187 147.5    91    50    13   1.8
            385   350   295   223   170   111    65    15   1.9 ];
%CURVA D CANAL 14 A 59 (50,50)
CP14_50_50=[265   228   155    90    62    28    10   3.5   0.5
            270   233   160    97    67    32    12   4.5   0.7
            282   245   167   115    72    47  15.5     6   1.3
            290   255   175   124    80    51  20.5   7.2   1.5
            305   270   195   140    90    60    28     9   1.9
            335   285   212   160   120    69    33  11.5     2
            360   330   245   185   148    85    47    14     2 ];

function varargout = tv_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function edit_atcabo_Callback(hObject, eventdata, handles)
atualiza_contorno(hObject, eventdata, handles);

function edit_pot_Callback(hObject, eventdata, handles)
atualiza_contorno(hObject, eventdata, handles);

function edit_pot_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function popup_canal_Callback(hObject, eventdata, handles)
if str2num(get(handles.edit_canal,'String'))>1 && str2num(get(handles.edit_canal,'String'))<14 
    set(handles.popup_canal,'Value',1);
else
    set(handles.popup_canal,'Value',2);
end
atualiza_contorno(hObject, eventdata, handles);

function popup_canal_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function edit_atextras_Callback(hObject, eventdata, handles)
atualiza_contorno(hObject, eventdata, handles);

function edit_atextras_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

% --------------------------------------------------------------------
function mnu_new_Callback(hObject, eventdata, handles)
% Inicializacao de um novo projeto.
% Criando arquivo e definindo suas variáveis.
global tv_file
tv_file = uiputfile('*.mat','Digite o nome do arquivo:');

if ~isequal(tv_file,0)
   estacoes=struct('descricao',{},'latitude',{},'longitude',{},'canal',{},'decalagem',{},'tipo_canal',{},'potencia',{},'azimute',{},'distancia',{},'CPP',{},'CPE',{},'ci',{},'CIE',{},'CIP',{},'cpec',{},'ciec',{},'cipc',{},'cppc',{},'CPE_CIP',{},'CPP_CIE',{},'interferente',{},'fator_correcao',{},'tipo_interferencia',{},'frequencia_video',{},'frequencia_audio',{});
   radial=struct('descricao',{},'cota',{},'azimute',{},'nmr',{},'hnmr',{},'dist_primario',{},'dist_secundario',{},'dist_rural',{},'rug',{});radial_dist={};
   entidade=[];descricao=[];cidade=[];estado=[];latitude=[];longitude=[];
   canal=[];decalagem='Nao';canal_tipo=[1];classe=[1];
   frequencia_video=[];frequencia_som=[];c=[];
   potencia=[];ganho_antena=[];altura_antena=[];hbt=[];
   atenuacao_cabo=[];comprimento_cabo=[];atenuacao_extras=[];
   fator_correcao=0;hnmt=0;cpc=0;rugosidade_terreno=0;
   contorno_primario=0;contorno_secundario=0;contorno_rural=0;
   contorno_protegido=0;CPP=0;
   set(handles.edit_entidade,'String',entidade);
   set(handles.edit_desc,'String',descricao);
   set(handles.edit_cidade,'String',cidade);
   set(handles.edit_estado,'String',estado);
   set(handles.edit_lat_graus,'String',latitude);
   set(handles.edit_lat_min,'String',latitude);
   set(handles.edit_lat_seg,'String',latitude);
   set(handles.edit_long_graus,'String',longitude);
   set(handles.edit_long_min,'String',longitude);
   set(handles.edit_long_seg,'String',longitude);
   set(handles.edit_canal,'String',canal);
   set(handles.uipanel_decalagem,'SelectedObject',handles.radiobutton_dec_nao);
   set(handles.popup_canal,'Value',canal_tipo);
   set(handles.popup_classe,'Value',classe);
   set(handles.edit_frequencia_video,'String',frequencia_video);
   set(handles.edit_frequencia_som,'String',frequencia_som);
   set(handles.edit_pot,'String',num2str(potencia));
   set(handles.edit_ganho_antena,'String',num2str(ganho_antena));
   set(handles.edit_altura_antena,'String',num2str(altura_antena));
   set(handles.edit_hbt,'String',num2str(hbt));
   set(handles.edit_atcabo,'String',num2str(atenuacao_cabo));
   set(handles.edit_compcabo,'String',num2str(comprimento_cabo));
   set(handles.edit_atextras,'String',num2str(atenuacao_extras));
   set(handles.text_fator_correcao,'String',num2str(fator_correcao));
   set(handles.text_protegido,'String',num2str(contorno_protegido));
   set(handles.text_primario,'String',num2str(contorno_primario));
   set(handles.text_secundario,'String',num2str(contorno_secundario));
   set(handles.text_rural,'String',num2str(contorno_rural));
   set(handles.text_CPP,'String',num2str(CPP));
   set(handles.text_cpc,'String',num2str(cpc));
   set(handles.text_hnmt,'String',num2str(hnmt));
   set(handles.text_rug_media,'String',num2str(rugosidade_terreno));
      
   set(handles.mnu_iniciar,'Enable','on');
   set(handles.uipanel_dados,'Visible','on');
   set(handles.uipanel_contornos,'Visible','on');
   set(handles.mnu_save,'Enable','on');
   set(handles.mnu_edit,'Enable','on');
   
   save(tv_file,'estacoes','radial','radial_dist','CPP','cpc','hnmt','entidade','hbt','descricao','cidade','estado','latitude','longitude','canal','decalagem','canal_tipo','classe','frequencia_video','frequencia_som','potencia','ganho_antena','altura_antena','atenuacao_cabo','comprimento_cabo','atenuacao_extras','fator_correcao','contorno_protegido','contorno_primario','contorno_secundario','contorno_rural','rugosidade_terreno','c');
end

% --------------------------------------------------------------------
function mnu_open_Callback(hObject, eventdata, handles)
% Inicializacao de um projeto existente.
% Atualizando variáveis.
global tv_file
tv_file = uigetfile('*.mat','Abrir Projeto');

if ~isequal(tv_file,0)
    load(tv_file);
    
    set(handles.uipanel_dados,'Visible','on');
    set(handles.uipanel_contornos,'Visible','on');
    set(handles.mnu_save,'Enable','on');
    set(handles.mnu_edit,'Enable','on');
    set(handles.mnu_iniciar,'Enable','on');
        
    set(handles.edit_entidade,'String',entidade);
    set(handles.edit_desc,'String',descricao);
    set(handles.edit_cidade,'String',cidade);
    set(handles.edit_estado,'String',estado);
    set(handles.edit_lat_graus,'String',num2str(fix(latitude)));
    set(handles.edit_lat_min,'String',num2str(fix((latitude-fix(latitude))*60)));
    set(handles.edit_lat_seg,'String',num2str(fix((((latitude-fix(latitude))*60)-fix((latitude-fix(latitude))*60))*60)));
    set(handles.edit_long_graus,'String',num2str(fix(longitude)));
    set(handles.edit_long_min,'String',num2str(fix((longitude-fix(longitude))*60)));
    set(handles.edit_long_seg,'String',num2str(fix((((longitude-fix(longitude))*60)-fix((longitude-fix(longitude))*60))*60)));
    set(handles.edit_canal,'String',num2str(canal));
    if decalagem=='Nao'
        set(handles.uipanel_decalagem,'SelectedObject',handles.radiobutton_dec_nao);
    elseif decalagem=='+'
        set(handles.uipanel_decalagem,'SelectedObject',handles.radiobutton_dec_mais);
    elseif decalagem=='-'
        set(handles.uipanel_decalagem,'SelectedObject',handles.radiobutton_dec_menos);    
    end
    set(handles.popup_canal,'Value',canal_tipo);
    set(handles.popup_classe,'Value',classe);
    set(handles.edit_frequencia_video,'String',frequencia_video);
    set(handles.edit_frequencia_som,'String',frequencia_som);
    set(handles.edit_pot,'String',potencia);
    set(handles.edit_ganho_antena,'String',num2str(ganho_antena));
    set(handles.edit_altura_antena,'String',num2str(altura_antena));
    set(handles.edit_hbt,'String',num2str(hbt));
    set(handles.edit_atcabo,'String',num2str(atenuacao_cabo));
    set(handles.edit_compcabo,'String',num2str(comprimento_cabo));
    set(handles.edit_atextras,'String',num2str(atenuacao_extras));
    set(handles.text_fator_correcao,'String',num2str(fator_correcao));
    set(handles.text_protegido,'String',num2str(contorno_protegido));
    set(handles.text_primario,'String',num2str(contorno_primario));
    set(handles.text_secundario,'String',num2str(contorno_secundario));
    set(handles.text_rural,'String',num2str(contorno_rural));
    set(handles.text_cpc,'String',num2str(cpc));
    set(handles.text_CPP,'String',num2str(CPP));
    set(handles.text_hnmt,'String',num2str(hnmt));
    set(handles.text_rug_media,'String',num2str(rugosidade_terreno));
end

% --------------------------------------------------------------------
function mnu_save_Callback(hObject, eventdata, handles)

global tv_file

entidade=get(handles.edit_entidade,'String');
descricao=get(handles.edit_desc,'String');
cidade=get(handles.edit_cidade,'String');
estado=get(handles.edit_estado,'String');
latitude=str2num(get(handles.edit_lat_graus,'String'))+str2num(get(handles.edit_lat_min,'String'))/60+str2num(get(handles.edit_lat_seg,'String'))/3600;
longitude=str2num(get(handles.edit_long_graus,'String'))+str2num(get(handles.edit_long_min,'String'))/60+str2num(get(handles.edit_long_seg,'String'))/3600;
canal=str2num(get(handles.edit_canal,'String'));
decalagem=get(get(handles.uipanel_decalagem,'SelectedObject'),'string');
canal_tipo=get(handles.popup_canal,'Value');
classe=get(handles.popup_classe,'Value');
frequencia_video=get(handles.edit_frequencia_video,'String');
frequencia_som=get(handles.edit_frequencia_som,'String');
potencia=str2num(get(handles.edit_pot,'String'));
ganho_antena=str2num(get(handles.edit_ganho_antena,'String'));
altura_antena=str2num(get(handles.edit_altura_antena,'String'));
hbt=str2num(get(handles.edit_hbt,'String'));
atenuacao_cabo=str2num(get(handles.edit_atcabo,'String'));
comprimento_cabo=str2num(get(handles.edit_compcabo,'String'));
atenuacao_extras=str2num(get(handles.edit_atextras,'String'));
fator_correcao=str2num(get(handles.text_fator_correcao,'String'));
contorno_protegido=str2num(get(handles.text_protegido,'String'));
contorno_primario=str2num(get(handles.text_primario,'String'));
contorno_secundario=str2num(get(handles.text_secundario,'String'));
contorno_rural=str2num(get(handles.text_rural,'String'));
cpc=str2num(get(handles.text_cpc,'String'));
CPP=str2num(get(handles.text_CPP,'String'));
hnmt=str2num(get(handles.text_hnmt,'String'));
rugosidade_terreno=str2num(get(handles.text_rug_media,'String'));
save(tv_file,'entidade','descricao','cidade','estado','latitude','longitude','canal','decalagem','canal_tipo','classe','frequencia_video','frequencia_som','potencia','ganho_antena','altura_antena','hbt','atenuacao_cabo','comprimento_cabo','atenuacao_extras','fator_correcao','contorno_primario','contorno_secundario','contorno_protegido','contorno_rural','CPP','cpc','hnmt','rugosidade_terreno','-append');

% --------------------------------------------------------------------

function edit_compcabo_Callback(hObject, eventdata, handles)
atualiza_contorno(hObject, eventdata, handles);

function edit_compcabo_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function edit_ganho_antena_Callback(hObject, eventdata, handles)
atualiza_contorno(hObject, eventdata, handles);

function atualiza_contorno(hObject, eventdata, handles)
if ~isempty(get(handles.edit_pot,'String')) | ~isempty(get(handles.edit_ganho_antena,'String')) | ~isempty(get(handles.edit_atcabo,'String')) | ~isempty(get(handles.edit_atextras,'String')) | ~isempty(get(handles.edit_compcabo,'String'))
    %fc=10*log(P/1kW) + Gant - comp.*(atenuacao_cabo/100) - atenuacoes_extras
    fator_correcao=10*log10(str2num(get(handles.edit_pot,'String'))/1000)+str2num(get(handles.edit_ganho_antena,'String'))-str2num(get(handles.edit_compcabo,'String'))*str2num(get(handles.edit_atcabo,'String'))/100-str2num(get(handles.edit_atextras,'String'));
else
    fator_correcao=0;
end
if str2num(get(handles.edit_canal,'String')) >= 2 & str2num(get(handles.edit_canal,'String')) <= 6 & get(handles.popup_canal,'Value') == 1
    contorno_protegido=58;
    contorno_primario=74;
    contorno_secundario=68;
    contorno_rural=54;
elseif str2num(get(handles.edit_canal,'String')) >= 7 & str2num(get(handles.edit_canal,'String')) <= 13 & get(handles.popup_canal,'Value') == 1
    contorno_protegido=64;
    contorno_primario=77;
    contorno_secundario=71;
    contorno_rural=60;
else
    contorno_protegido=70;
    contorno_primario=80;
    contorno_secundario=74;
    contorno_rural=70;
    set(handles.popup_canal,'Value',2);
end
set(handles.text_fator_correcao,'String',fator_correcao);
set(handles.text_protegido,'String',contorno_protegido);
set(handles.text_primario,'String',contorno_primario);
set(handles.text_secundario,'String',contorno_secundario);
set(handles.text_rural,'String',contorno_rural);
    
function edit_canal_Callback(hObject, eventdata, handles)

if str2num(get(handles.edit_canal,'String'))>1 && str2num(get(handles.edit_canal,'String'))<14 
    set(handles.popup_canal,'Value',1);
elseif str2num(get(handles.edit_canal,'String'))==37
    errordlg('Canal reservado ao Serviço de Radioastronomia. Erro!');
    set(handles.edit_canal,'String','');
    set(handles.edit_frequencia_video,'String','');
    set(handles.edit_frequencia_som,'String','');    
    return
elseif str2num(get(handles.edit_canal,'String'))>13 && str2num(get(handles.edit_canal,'String'))<=59 && str2num(get(handles.edit_canal,'String'))~=37
    set(handles.popup_canal,'Value',2);
else
    uiwait(errordlg('Canal Inválido. (2 a 59)','Erro!'));
    set(handles.edit_canal,'String','');
end
atualiza_contorno(hObject, eventdata, handles);

switch get(handles.edit_canal,'String')
    case '', frequencia_video=0;frequencia_som=0;    
    case '2', frequencia_video=55.25;frequencia_som=59.75;
    case '3', frequencia_video=61.25;frequencia_som=65.75;
    case '4', frequencia_video=67.25;frequencia_som=71.75;
    case '5', frequencia_video=77.25;frequencia_som=81.75;
    case '6', frequencia_video=83.25;frequencia_som=87.75;
    case '7', frequencia_video=175.25;frequencia_som=179.75;
    case '8', frequencia_video=181.25;frequencia_som=185.75;
    case '9', frequencia_video=187.25;frequencia_som=191.75;
    case '10', frequencia_video=193.25;frequencia_som=197.75;
    case '11', frequencia_video=199.25;frequencia_som=203.75;
    case '12', frequencia_video=205.25;frequencia_som=209.75;
    case '13', frequencia_video=211.25;frequencia_som=215.75;
    case '14', frequencia_video=471.25;frequencia_som=475.75;
    case '15', frequencia_video=477.25;frequencia_som=481.75;
    case '16', frequencia_video=483.25;frequencia_som=487.75;
    case '17', frequencia_video=489.25;frequencia_som=493.75;
    case '18', frequencia_video=495.25;frequencia_som=499.75;
    case '19', frequencia_video=501.25;frequencia_som=505.75;
    case '20', frequencia_video=507.25;frequencia_som=511.75;
    case '21', frequencia_video=513.25;frequencia_som=517.75;
    case '22', frequencia_video=519.25;frequencia_som=523.75;
    case '23', frequencia_video=525.25;frequencia_som=529.75;
    case '24', frequencia_video=531.25;frequencia_som=535.75;
    case '25', frequencia_video=537.25;frequencia_som=541.75;
    case '26', frequencia_video=543.25;frequencia_som=547.75;
    case '27', frequencia_video=549.25;frequencia_som=553.75;
    case '28', frequencia_video=555.25;frequencia_som=559.75;
    case '29', frequencia_video=561.25;frequencia_som=565.75;
    case '30', frequencia_video=567.25;frequencia_som=571.75;
    case '31', frequencia_video=573.25;frequencia_som=577.75;
    case '32', frequencia_video=579.25;frequencia_som=583.75;
    case '33', frequencia_video=585.25;frequencia_som=589.75;
    case '34', frequencia_video=591.25;frequencia_som=595.75;
    case '35', frequencia_video=597.25;frequencia_som=601.75;
    case '36', frequencia_video=603.25;frequencia_som=607.75;
    case '38', frequencia_video=615.25;frequencia_som=619.75;
    case '39', frequencia_video=621.25;frequencia_som=625.75;
    case '40', frequencia_video=627.25;frequencia_som=631.75;
    case '41', frequencia_video=633.25;frequencia_som=637.75;
    case '42', frequencia_video=639.25;frequencia_som=643.75;
    case '43', frequencia_video=645.25;frequencia_som=649.75;
    case '44', frequencia_video=651.25;frequencia_som=655.75;
    case '45', frequencia_video=657.25;frequencia_som=661.75;
    case '46', frequencia_video=663.25;frequencia_som=667.75;
    case '47', frequencia_video=669.25;frequencia_som=673.75;
    case '48', frequencia_video=675.25;frequencia_som=679.75;
    case '49', frequencia_video=681.25;frequencia_som=685.75;
    case '50', frequencia_video=687.25;frequencia_som=691.75;
    case '51', frequencia_video=693.25;frequencia_som=697.75;
    case '52', frequencia_video=699.25;frequencia_som=703.75;
    case '53', frequencia_video=705.25;frequencia_som=709.75;
    case '54', frequencia_video=711.25;frequencia_som=715.75;
    case '55', frequencia_video=717.25;frequencia_som=721.75;
    case '56', frequencia_video=723.25;frequencia_som=727.75;
    case '57', frequencia_video=729.25;frequencia_som=733.75;
    case '58', frequencia_video=735.25;frequencia_som=739.75;
    case '59', frequencia_video=741.25;frequencia_som=745.75;
end
set(handles.edit_frequencia_video,'String',frequencia_video);
set(handles.edit_frequencia_som,'String',frequencia_som);

function edit_desc_Callback(hObject, eventdata, handles)

% --------------------------------------------------------------------
function mnu_iniciar_Callback(hObject, eventdata, handles)
global tv_file y CI02_50_10 CI07_50_10 CI14_50_10 CP02_50_50 CP07_50_50 CP14_50_50 rc_rug estacoes hnmt CP CI contorno_protegido fator_correcao

%Salvando projeto antes de executar:
mnu_save_Callback(hObject, eventdata, handles);
%Verificação das variáveis. - RADIAIS:
load(tv_file);
if isempty(radial) | isempty(radial_dist)
    uiwait(errordlg('As radiais não foram editadas. Por favor entre com as radiais e tente novamente.','Erro!'));
    return
else
    numradiais=length(radial);
    %Verifica se existem as cotas e nmrs:
    for i=1:numradiais
        if isempty(radial(numradiais).cota)
            uiwait(errordlg('Algumas cotas não foram definidas!','Erro!'));
            return
        end
        if isempty(radial(numradiais).nmr)
            uiwait(errordlg('Algumas NMRs não foram definidas! Favor editar as cotas novamente','Erro!'));
            return  
        end
        if isempty(radial(numradiais).rug)
            uiwait(errordlg('Algumas rugosidades não foram definidas! Favor editar as cotas novamente','Erro!'));
            return  
        end        
    end
    %Calcula as HNMRs e Rugosidade média
    nmt=0;rugosidade_terreno=0;
    for i=1:numradiais
        %HNMR=HBT+HT-NMR
        if ~isempty(altura_antena)
            if ~isempty(hbt)
                radial(i).hnmr=hbt+altura_antena-radial(i).nmr;
            else
                errordlg('A altura da base da torre não foi definida!','Erro!');
                return
            end
        else
            errordlg('A altura da antena não foi definida!','Erro!');
            return
        end
        nmt=nmt+radial(i).nmr;
        rugosidade_terreno=rugosidade_terreno+radial(i).rug;
    end
end
nmt=nmt/numradiais;rugosidade_terreno=rugosidade_terreno/numradiais;
set(handles.text_rug_media,'String',num2str(rugosidade_terreno));
hnmt=hbt+altura_antena-nmt;
%limita hnmt para interpolação:
if hnmt<30
    hnmt=30;
elseif hnmt>1000
    hnmt=1000;
end
set(handles.text_hnmt,'String',num2str(hnmt));

%Calcula os contornos interferentes possíveis da proponente:
H=[ 30 50 100 150 300 500 1000 ];E=[ -15 -10 0 10 20 40 60 80 ];
if isempty(canal)
    errordlg('O canal não foi definido!','Erro!');
    return
end
if isempty(fator_correcao)
    errordlg('O fator de correção não foi calculado!','Erro!');
    return
end
if (canal>=2 & canal<=6)
    CP=CP02_50_50;CI=CI02_50_10;c=1.9;
    CIP_cocanal=13-fator_correcao;%Co-canal sem decalagem    
    CIP_cocanal_dec=30-fator_correcao;%Co-canal com decalagem
    CIP_adj_sup=70-fator_correcao;%Canal adjacente superior
    CIP_adj_inf=64-fator_correcao;%Canal adjacente inferior
    CIP_osc=0;CIP_freq_aud=0;CIP_freq_vid=0;CIP_fi=0;
elseif (canal>=7 & canal<=13)
    CP=CP07_50_50;CI=CI07_50_10;c=2.5;
    CIP_cocanal=19-fator_correcao;%Co-canal sem decalagem
    CIP_cocanal_dec=36-fator_correcao;%Co-canal com decalagem
    CIP_adj_sup=76-fator_correcao;%Canal adjacente superior
    CIP_adj_inf=70-fator_correcao;%Canal adjacente inferior
    CIP_osc=0;CIP_freq_aud=0;CIP_freq_vid=0;CIP_fi=0;
elseif (canal>=14 & canal<=59)
    CP=CP14_50_50;CI=CI14_50_10;c=4.8;
    CIP_cocanal=25-fator_correcao;%Co-canal sem decalagem
    CIP_cocanal_dec=42-fator_correcao;%Co-canal com decalagem
    CIP_adj_sup=82-fator_correcao;%Canal adjacente superior
    CIP_adj_inf=76-fator_correcao;%Canal adjacente inferior
    CIP_osc=76-fator_correcao;%Oscilador Local
    CIP_freq_aud=76-fator_correcao;%Frequencia Imagem de Áudio
    CIP_freq_vid=67-fator_correcao;%Frequencia Imagem de Vídeo
    CIP_fi=82-fator_correcao;%Batimento de FI
else
    errordlg('Número de canal Inválido','Erro!');
    return
end

%Cacula os contornos primários, secundários e rurais de cada radial:
H=[ 30 50 100 150 300 500 1000 ];E=[ -15 -10 0 10 20 40 60 80 100 ];

for i=1:numradiais    
    radial(i).dist_primario=interp2(E,H,CP,(contorno_primario-fator_correcao),radial(i).hnmr);
    radial(i).dist_secundario=interp2(E,H,CP,(contorno_secundario-fator_correcao),radial(i).hnmr);
    radial(i).dist_rural=interp2(E,H,CP,(contorno_rural-fator_correcao),radial(i).hnmr);
end
cpc=contorno_protegido-fator_correcao;
%limita cpc
if cpc>100
    cpc=100;
elseif cpc<-15
    cpc=-15;
end
CPP=interp2(E,H,CP,cpc,hnmt);
set(handles.text_cpc,'String',num2str(cpc));
set(handles.text_CPP,'String',num2str(CPP));
rc_rug=0;
%Estações:
if isempty(estacoes)
    errordlg('As estações ainda não foram definidas.','Erro!');
    return
end
numestacoes=length(estacoes);
for i=1:numestacoes
    %Calcula a distancia das estacoes:
    if ~isempty(estacoes(numestacoes).latitude) && ~isempty(estacoes(numestacoes).longitude) && ~isempty(latitude) && ~isempty(longitude)
        estacoes(numestacoes).distancia=111.1775*(acos(sin(latitude*pi/180)*sin(estacoes(numestacoes).latitude*pi/180)+cos(latitude*pi/180)*cos(estacoes(numestacoes).latitude*pi/180)*cos((longitude-estacoes(numestacoes).longitude)*pi/180))/pi*180);
    else
        errordlg('Algumas coordenadas não foram definidas!','Erro!');
        return
    end
    estacoes(i).CPP=CPP;
    estacoes(i).cppc=cpc;
end

for y=1:numestacoes
    %Verifica o tipo de possíveis interferencias:
    if ~isempty(estacoes(y).canal)
        %VHF e UHF
        if canal==estacoes(y).canal
            if estacoes(y).decalagem=='Nao'
                estacoes(y).tipo_interferencia='Co-canal';
                estacoes(y).cipc=CIP_cocanal;
                estacoes(y).rp=-45;
                func_cip(hObject, eventdata, handles);
                func_cie(hObject, eventdata, handles);  
            else
                estacoes(y).tipo_interferencia='Co-canal com decalagem';
                estacoes(y).cipc=CIP_cocanal_dec;
                estacoes(y).rp=-28;
                func_cip(hObject, eventdata, handles);
                func_cie(hObject, eventdata, handles);              
            end
        elseif canal==(estacoes(y).canal-1)
            estacoes(y).tipo_interferencia='Canal adjacente +1';
            estacoes(y).cipc=CIP_adj_sup;
            estacoes(y).rp=12;
            func_cip(hObject, eventdata, handles);
            func_cie(hObject, eventdata, handles);
        elseif canal==(estacoes(y).canal+1)
            estacoes(y).tipo_interferencia='Canal adjacente -1';
            estacoes(y).cipc=CIP_adj_inf;
            estacoes(y).rp=6;
            func_cip(hObject, eventdata, handles);
            func_cie(hObject, eventdata, handles);
        
        %UHF    
        elseif estacoes(y).tipo_canal==2 && canal==(estacoes(y).canal-15)
            estacoes(y).tipo_interferencia='Frequencia imagem de vídeo';
            estacoes(y).cipc=CIP_freq_vid;
            estacoes(y).rp=-3;
            func_cip(hObject, eventdata, handles);
            func_cie(hObject, eventdata, handles);
        elseif estacoes(y).tipo_canal==2 && canal==(estacoes(y).canal-14)
            estacoes(y).tipo_interferencia='Frequencia imagem de audio';
            estacoes(y).cipc=CIP_freq_aud;
            estacoes(y).rp=6;
            func_cip(hObject, eventdata, handles);
            func_cie(hObject, eventdata, handles);
        elseif estacoes(y).tipo_canal==2 && canal==(estacoes(y).canal-7) || canal==(estacoes(y).canal+7)
            estacoes(y).tipo_interferencia='Oscilador Local';
            estacoes(y).cipc=CIP_osc;
            estacoes(y).rp=6;
            func_cip(hObject, eventdata, handles);
            func_cie(hObject, eventdata, handles);
        elseif estacoes(y).tipo_canal==2 && canal==(estacoes(y).canal-8) || canal==(estacoes(y).canal+8)
            estacoes(y).tipo_interferencia='Batimento de FI.';
            estacoes(y).cipc=CIP_fi;
            estacoes(y).rp=12;
            func_cip(hObject, eventdata, handles);
            func_cie(hObject, eventdata, handles);            
        else
            estacoes(y).tipo_interferencia='Não interfere.';
        end
    else
        errordlg('Algum canal das estações não foram definidos.','Erro!');
        return
    end
end

%verifica se há interferencias:
for y=1:numestacoes
    estacoes(y).CPP=CPP;estacoes(y).cppc=cpc;
    estacoes(y).CPE_CIP=estacoes(y).CPE+estacoes(y).CIP;
    estacoes(y).CPP_CIE=estacoes(y).CPP+estacoes(y).CIE;
    %PROPONENTE -> EXISTENTE
    if estacoes(y).CPE_CIP>estacoes(y).distancia
        rc_rug=0;t=1;
        if rugosidade_terreno>50
            rc_rug=c-0.03*rugosidade_terreno*(1+str2num(frequencia_video)/300);
            func_cip(hObject, eventdata, handles);
            estacoes(y).CPE_CIP=estacoes(y).CPE+estacoes(y).CIP;
        end
        if estacoes(y).CPE_CIP>estacoes(y).distancia
            t=1;
        else
            estacoes(y).interferente='VIÁVEL (CORRIGIDO)';t=2;
        end
        if estacoes(y).CPP_CIE>estacoes(y).distancia
            rc_rug=0;
            if rugosidade_terreno>50
                rc_rug=c-0.03*rugosidade_terreno*(1+str2num(frequencia_video)/300);
                func_cpp(hObject, eventdata, handles);
                estacoes(y).CPP_CIE=estacoes(y).CPP+estacoes(y).CIE;
            end
        end
        if estacoes(y).CPP_CIE>estacoes(y).distancia
            if t==1
                estacoes(y).interferente='INVIÁVEL: P <=> E';
            else
                estacoes(y).interferente='INVIÁVEL: P <- E';
            end
        else
            if t==1
                estacoes(y).interferente='INVIÁVEL: P -> E';
            else
                estacoes(y).interferente='VIÁVEL (CORRIGIDO)';
            end
        end
    %EXISTENTE -> PROPONENTE
    elseif estacoes(y).CPP_CIE>estacoes(y).distancia
        rc_rug=0;
        if rugosidade_terreno>50
            rc_rug=c-0.03*rugosidade_terreno*(1+str2num(frequencia_video)/300);
            estacoes(y).CPP=CPP;estacoes(y).cppc=cpc;
            func_cpp(hObject, eventdata, handles);
            estacoes(y).CPP_CIE=estacoes(y).CPP+estacoes(y).CIE;
        end
        if estacoes(y).CPP_CIE>estacoes(y).distancia
            estacoes(y).interferente='INVIÁVEL: P <- E';
        else
            estacoes(y).interferente='VIÁVEL (CORRIGIDO)';
        end
    else
        estacoes(y).interferente='VIÁVEL';
    end
end

save(tv_file,'c','radial','estacoes','cpc','CPP','CIP_cocanal','CIP_cocanal_dec','CIP_adj_sup','CIP_adj_inf','CIP_osc','CIP_freq_aud','CIP_freq_vid','CIP_fi','rugosidade_terreno','-append');
clear estacoes radial;
estacoes_interferentes;

function func_cpp(hObject, eventdata, handles)
global y rc_rug hnmt CP estacoes
H=[ 30 50 100 150 300 500 1000 ];E=[ -15 -10 0 10 20 40 60 80 100 ];
estacoes(y).cppc=estacoes(y).cppc-rc_rug;
%limita cpc
if estacoes(y).cppc>100
    estacoes(y).cppc=100;
elseif estacoes(y).cppc<-15
    estacoes(y).cppc=-15;
end
estacoes(y).CPP=interp2(E,H,CP,estacoes(y).cppc,hnmt);

function func_cip(hObject, eventdata, handles)
global y estacoes hnmt rc_rug CI
E=[ -15 -10 0 10 20 40 60 80 ];H=[ 30 50 100 150 300 500 1000 ];
estacoes(y).cipc=estacoes(y).cipc-rc_rug;
if estacoes(y).cipc>80
    estacoes(y).cipc=80;
elseif estacoes(y).cipc<-15
    estacoes(y).cipc=-15;
end
estacoes(y).CIP=interp2(E,H,CI,estacoes(y).cipc,hnmt);

function func_cie(hObject, eventdata, handles)
global y estacoes CI02_50_10 CI07_50_10 CI14_50_10
E=[ -15 -10 0 10 20 40 60 80 ];H=[ 30 50 100 150 300 500 1000 ];
estacoes(y).ciec=estacoes(y).cpec+estacoes(y).rp;
if estacoes(y).ciec>80
    estacoes(y).ciec=80;
elseif estacoes(y).ciec<-15
    estacoes(y).ciec=-15;
end
estacoes(y).CIE=interp2(E,H,eval(estacoes(y).ci),estacoes(y).ciec,150);

function edit_entidade_Callback(hObject, eventdata, handles)
function edit_entidade_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
function edit_cidade_Callback(hObject, eventdata, handles)
function edit_cidade_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
function edit_estado_Callback(hObject, eventdata, handles)
function edit_estado_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
function edit_frequencia_video_Callback(hObject, eventdata, handles)
function edit_frequencia_video_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
function edit_frequencia_som_Callback(hObject, eventdata, handles)
function edit_frequencia_som_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
function popup_classe_Callback(hObject, eventdata, handles)
function popup_classe_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
function edit_lat_graus_Callback(hObject, eventdata, handles)
function edit_lat_graus_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
function edit_lat_min_Callback(hObject, eventdata, handles)
function edit_lat_min_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
function edit_lat_seg_Callback(hObject, eventdata, handles)
function edit_lat_seg_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
function edit_altura_antena_Callback(hObject, eventdata, handles)
function edit_altura_antena_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
function edit_hbt_Callback(hObject, eventdata, handles)
function edit_hbt_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
function edit_long_graus_Callback(hObject, eventdata, handles)
function edit_long_graus_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
function edit_long_min_Callback(hObject, eventdata, handles)
function edit_long_min_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
function edit_long_seg_Callback(hObject, eventdata, handles)
function edit_long_seg_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
function uipanel_decalagem_SelectionChangeFcn(hObject, eventdata, handles)
function mnu_about_Callback(hObject, eventdata, handles)
sobre;
function mnu_estacoes_Callback(hObject, eventdata, handles)
mnu_save_Callback(hObject, eventdata, handles);
estacoes_interferentes;
function mnu_radiais_Callback(hObject, eventdata, handles)
mnu_save_Callback(hObject, eventdata, handles);
radiais;
