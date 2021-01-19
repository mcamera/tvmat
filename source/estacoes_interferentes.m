function varargout = estacoes_interferentes(varargin)
% Begin initialization code
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @estacoes_interferentes_OpeningFcn, ...
                   'gui_OutputFcn',  @estacoes_interferentes_OutputFcn, ...
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

% --- Executes just before estacoes_interferentes is made visible.
function estacoes_interferentes_OpeningFcn(hObject, eventdata, handles, varargin)
global tv_file estacoes

handles.output = hObject;
guidata(hObject, handles);

load(tv_file,'estacoes');
if ~isempty(estacoes)
    set(handles.listbox_estacoes,'String',strvcat(estacoes.descricao));
    set(handles.edit_desc,'String',estacoes(1).descricao);
    set(handles.edit_canal,'String',estacoes(1).canal);
    if estacoes(1).decalagem=='Nao'
        set(handles.uipanel_decalagem,'SelectedObject',handles.radiobutton_dec_nao);
    elseif estacoes(1).decalagem=='+'
        set(handles.uipanel_decalagem,'SelectedObject',handles.radiobutton_dec_mais);
    elseif estacoes(1).decalagem=='-'
        set(handles.uipanel_decalagem,'SelectedObject',handles.radiobutton_dec_menos);    
    end
    set(handles.popupmenu_tipo_canal,'Value',estacoes(1).tipo_canal);
    set(handles.edit_potencia,'String',estacoes(1).potencia);
    set(handles.edit_azimute,'String',estacoes(1).azimute);
    set(handles.text_distancia,'String',estacoes(1).distancia);
    set(handles.text_CPE,'String',estacoes(1).CPE);
    set(handles.text_CIE,'String',estacoes(1).CIE);
    set(handles.text_CIP,'String',estacoes(1).CIP);
    set(handles.text_CPP,'String',estacoes(1).CPP);
    set(handles.text_cpec,'String',estacoes(1).cpec);
    set(handles.text_ciec,'String',estacoes(1).ciec);
    set(handles.text_cipc,'String',estacoes(1).cipc);
    set(handles.text_cppc,'String',estacoes(1).cppc);
    set(handles.text_CPE_CIP,'String',estacoes(1).CPE_CIP);
    set(handles.text_CPP_CIE,'String',estacoes(1).CPP_CIE);
    set(handles.text_fc_estacoes,'String',estacoes(1).fator_correcao);
    set(handles.text_tipo_interferencia,'String',estacoes(1).tipo_interferencia);
    set(handles.text_interfere,'String',estacoes(1).interferente);
    set(handles.edit_lat_graus,'String',num2str(fix(estacoes(1).latitude)));
    set(handles.edit_lat_min,'String',num2str(fix((estacoes(1).latitude-fix(estacoes(1).latitude))*60)));
    set(handles.edit_lat_seg,'String',num2str(fix((((estacoes(1).latitude-fix(estacoes(1).latitude))*60)-fix((estacoes(1).latitude-fix(estacoes(1).latitude))*60))*60)));
    set(handles.edit_long_graus,'String',num2str(fix(estacoes(1).longitude)));
    set(handles.edit_long_min,'String',num2str(fix((estacoes(1).longitude-fix(estacoes(1).longitude))*60)));
    set(handles.edit_long_seg,'String',num2str(fix((((estacoes(1).longitude-fix(estacoes(1).longitude))*60)-fix((estacoes(1).longitude-fix(estacoes(1).longitude))*60))*60)));
else
    set(handles.edit_desc,'Enable','off');
    set(handles.edit_canal,'Enable','off');
    set(handles.radiobutton_dec_nao,'Enable','off');
    set(handles.radiobutton_dec_mais,'Enable','off');
    set(handles.radiobutton_dec_menos,'Enable','off');
    set(handles.popupmenu_tipo_canal,'Enable','off');
    set(handles.edit_lat_graus,'Enable','off');
    set(handles.edit_lat_min,'Enable','off');
    set(handles.edit_lat_seg,'Enable','off');
    set(handles.edit_long_graus,'Enable','off');
    set(handles.edit_long_min,'Enable','off');
    set(handles.edit_long_seg,'Enable','off');
    set(handles.edit_potencia,'Enable','off');
    set(handles.edit_azimute,'Enable','off');
    set(handles.listbox_estacoes,'Enable','off');
    set(handles.pushbutton_aplicar,'Enable','off');
    set(handles.pushbutton_remover,'Enable','off');
end

function varargout = estacoes_interferentes_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function edit_desc_Callback(hObject, eventdata, handles)
global estacoes
estacoes(get(handles.listbox_estacoes,'value')).descricao=get(hObject,'String');
set(handles.listbox_estacoes,'String',strvcat(estacoes.descricao));

function edit_desc_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function edit_canal_Callback(hObject, eventdata, handles)
global estacoes
x=get(handles.listbox_estacoes,'Value');
if ~isempty(get(handles.edit_canal,'String'))
    if str2num(get(handles.edit_canal,'String'))>=2 && str2num(get(handles.edit_canal,'String'))<=6 
        set(handles.popupmenu_tipo_canal,'Value',1);
        estacoes(get(handles.listbox_estacoes,'value')).cp=58;
        estacoes(get(handles.listbox_estacoes,'value')).canal=str2num(get(hObject,'String'));
    elseif str2num(get(handles.edit_canal,'String'))>=7 && str2num(get(handles.edit_canal,'String'))<=13 
        set(handles.popupmenu_tipo_canal,'Value',1);
        estacoes(get(handles.listbox_estacoes,'value')).cp=64;
        estacoes(get(handles.listbox_estacoes,'value')).canal=str2num(get(hObject,'String'));    
    elseif str2num(get(handles.edit_canal,'String'))>=14 && str2num(get(handles.edit_canal,'String'))<=59 
        set(handles.popupmenu_tipo_canal,'Value',2);
        estacoes(get(handles.listbox_estacoes,'value')).cp=70;
        estacoes(get(handles.listbox_estacoes,'value')).canal=str2num(get(hObject,'String'));
    else
        uiwait(errordlg('Canal Inválido. (2 a 59)','Erro!'));
        set(handles.edit_canal,'String','');
    end
    estacoes(x).tipo_canal=get(handles.popupmenu_tipo_canal,'Value');
    atualiza_contorno_estacoes(hObject, eventdata, handles);
else
    estacoes(x).canal=[];
end

switch get(handles.edit_canal,'String')
    case '',estacoes(x).frequencia_video=0;estacoes(x).frequencia_audio=0;
    case '2',estacoes(x).frequencia_video=55.25;estacoes(x).frequencia_audio=59.75;
    case '3',estacoes(x).frequencia_video=61.25;estacoes(x).frequencia_audio=65.75;
    case '4',estacoes(x).frequencia_video=67.25;estacoes(x).frequencia_audio=71.75;
    case '5',estacoes(x).frequencia_video=77.25;estacoes(x).frequencia_audio=81.75;
    case '6',estacoes(x).frequencia_video=83.25;estacoes(x).frequencia_audio=87.75;
    case '7',estacoes(x).frequencia_video=175.25;estacoes(x).frequencia_audio=179.75;
    case '8',estacoes(x).frequencia_video=181.25;estacoes(x).frequencia_audio=185.75;
    case '9',estacoes(x).frequencia_video=187.25;estacoes(x).frequencia_audio=191.75;
    case '10',estacoes(x).frequencia_video=193.25;estacoes(x).frequencia_audio=197.75;
    case '11',estacoes(x).frequencia_video=199.25;estacoes(x).frequencia_audio=203.75;
    case '12',estacoes(x).frequencia_video=205.25;estacoes(x).frequencia_audio=209.75;
    case '13',estacoes(x).frequencia_video=211.25;estacoes(x).frequencia_audio=215.75;
    case '14',estacoes(x).frequencia_video=471.25;estacoes(x).frequencia_audio=475.75;
    case '15',estacoes(x).frequencia_video=477.25;estacoes(x).frequencia_audio=481.75;
    case '16',estacoes(x).frequencia_video=483.25;estacoes(x).frequencia_audio=487.75;
    case '17',estacoes(x).frequencia_video=489.25;estacoes(x).frequencia_audio=493.75;
    case '18',estacoes(x).frequencia_video=495.25;estacoes(x).frequencia_audio=499.75;
    case '19',estacoes(x).frequencia_video=501.25;estacoes(x).frequencia_audio=505.75;
    case '20',estacoes(x).frequencia_video=507.25;estacoes(x).frequencia_audio=511.75;
    case '21',estacoes(x).frequencia_video=513.25;estacoes(x).frequencia_audio=517.75;
    case '22',estacoes(x).frequencia_video=519.25;estacoes(x).frequencia_audio=523.75;
    case '23',estacoes(x).frequencia_video=525.25;estacoes(x).frequencia_audio=529.75;
    case '24',estacoes(x).frequencia_video=531.25;estacoes(x).frequencia_audio=535.75;
    case '25',estacoes(x).frequencia_video=537.25;estacoes(x).frequencia_audio=541.75;
    case '26',estacoes(x).frequencia_video=543.25;estacoes(x).frequencia_audio=547.75;
    case '27',estacoes(x).frequencia_video=549.25;estacoes(x).frequencia_audio=553.75;
    case '28',estacoes(x).frequencia_video=555.25;estacoes(x).frequencia_audio=559.75;
    case '29',estacoes(x).frequencia_video=561.25;estacoes(x).frequencia_audio=565.75;
    case '30',estacoes(x).frequencia_video=567.25;estacoes(x).frequencia_audio=571.75;
    case '31',estacoes(x).frequencia_video=573.25;estacoes(x).frequencia_audio=577.75;
    case '32',estacoes(x).frequencia_video=579.25;estacoes(x).frequencia_audio=583.75;
    case '33',estacoes(x).frequencia_video=585.25;estacoes(x).frequencia_audio=589.75;
    case '34',estacoes(x).frequencia_video=591.25;estacoes(x).frequencia_audio=595.75;
    case '35',estacoes(x).frequencia_video=597.25;estacoes(x).frequencia_audio=601.75;
    case '36',estacoes(x).frequencia_video=603.25;estacoes(x).frequencia_audio=607.75;
    case '37',estacoes(x).frequencia_video=609.25;estacoes(x).frequencia_audio=613.75;
    case '38',estacoes(x).frequencia_video=615.25;estacoes(x).frequencia_audio=619.75;
    case '39',estacoes(x).frequencia_video=621.25;estacoes(x).frequencia_audio=625.75;
    case '40',estacoes(x).frequencia_video=627.25;estacoes(x).frequencia_audio=631.75;
    case '41',estacoes(x).frequencia_video=633.25;estacoes(x).frequencia_audio=637.75;
    case '42',estacoes(x).frequencia_video=639.25;estacoes(x).frequencia_audio=643.75;
    case '43',estacoes(x).frequencia_video=645.25;estacoes(x).frequencia_audio=649.75;
    case '44',estacoes(x).frequencia_video=651.25;estacoes(x).frequencia_audio=655.75;
    case '45',estacoes(x).frequencia_video=657.25;estacoes(x).frequencia_audio=661.75;
    case '46',estacoes(x).frequencia_video=663.25;estacoes(x).frequencia_audio=667.75;
    case '47',estacoes(x).frequencia_video=669.25;estacoes(x).frequencia_audio=673.75;
    case '48',estacoes(x).frequencia_video=675.25;estacoes(x).frequencia_audio=679.75;
    case '49',estacoes(x).frequencia_video=681.25;estacoes(x).frequencia_audio=685.75;
    case '50',estacoes(x).frequencia_video=687.25;estacoes(x).frequencia_audio=691.75;
    case '51',estacoes(x).frequencia_video=693.25;estacoes(x).frequencia_audio=697.75;
    case '52',estacoes(x).frequencia_video=699.25;estacoes(x).frequencia_audio=703.75;
    case '53',estacoes(x).frequencia_video=705.25;estacoes(x).frequencia_audio=709.75;
    case '54',estacoes(x).frequencia_video=711.25;estacoes(x).frequencia_audio=715.75;
    case '55',estacoes(x).frequencia_video=717.25;estacoes(x).frequencia_audio=721.75;
    case '56',estacoes(x).frequencia_video=723.25;estacoes(x).frequencia_audio=727.75;
    case '57',estacoes(x).frequencia_video=729.25;estacoes(x).frequencia_audio=733.75;
    case '58',estacoes(x).frequencia_video=735.25;estacoes(x).frequencia_audio=739.75;
    case '59',estacoes(x).frequencia_video=741.25;estacoes(x).frequencia_audio=745.75;
end
    
function edit_canal_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function edit_potencia_Callback(hObject, eventdata, handles)
global estacoes
estacoes(get(handles.listbox_estacoes,'value')).potencia=str2num(get(hObject,'String'));
atualiza_contorno_estacoes(hObject, eventdata, handles);

function edit_potencia_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function edit_azimute_Callback(hObject, eventdata, handles)
global estacoes
estacoes(get(handles.listbox_estacoes,'value')).azimute=str2num(get(hObject,'String'));

function edit_azimute_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function popupmenu_tipo_canal_Callback(hObject, eventdata, handles)
global estacoes
if str2num(get(handles.edit_canal,'String'))>1 && str2num(get(handles.edit_canal,'String'))<14 
    set(handles.popupmenu_tipo_canal,'Value',1);
else
    set(handles.popupmenu_tipo_canal,'Value',2);
end
estacoes(get(handles.listbox_estacoes,'value')).tipo_canal=get(hObject,'value');
atualiza_contorno_estacoes(hObject, eventdata, handles);

function popupmenu_tipo_canal_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function pushbutton_aplicar_Callback(hObject, eventdata, handles)
global tv_file estacoes
save(tv_file,'estacoes','-append');
clear estacoes;
close;

function pushbutton_remover_Callback(hObject, eventdata, handles)
global estacoes
entries = cellstr(get(handles.listbox_estacoes,'String'));
value   = uint8(get(handles.listbox_estacoes,'Value'));
entries(value) = [];estacoes(value)= [];
if isempty(entries)
   nentries=0;
else
    nentries = size(entries,1);    
end
if value > nentries
    value = value-1;
    set(handles.listbox_estacoes,'Value',value)
end
set(handles.listbox_estacoes,'String',entries)
if nentries==0
    set(handles.listbox_estacoes,'Value',0)
    set(handles.pushbutton_remover,'Enable','off')
    set(handles.edit_desc,'String','');
    set(handles.edit_canal,'String','');
    set(handles.popupmenu_tipo_canal,'Value',1);
    set(handles.edit_potencia,'String','');
    set(handles.edit_azimute,'String','');
    set(handles.text_distancia,'String','');
    set(handles.text_CPE,'String','');
    set(handles.text_CIE,'String','');
    set(handles.text_CIP,'String','');
    set(handles.text_CPP,'String','');
    set(handles.text_cpec,'String','');
    set(handles.text_ciec,'String','');
    set(handles.text_cipc,'String','');
    set(handles.text_cppc,'String','');
    set(handles.text_CPE_CIP,'String','');
    set(handles.text_CPP_CIE,'String','');
    set(handles.text_fc_estacoes,'String','');
    set(handles.text_tipo_interferencia,'String','');
    set(handles.text_interfere,'String','');
    set(handles.text_tipo_interferencia,'String','');
    set(handles.edit_lat_graus,'String','');
    set(handles.edit_lat_min,'String','');
    set(handles.edit_lat_seg,'String','');
    set(handles.edit_long_graus,'String','');
    set(handles.edit_long_min,'String','');
    set(handles.edit_long_seg,'String','');
    set(handles.edit_desc,'Enable','off');
    set(handles.edit_canal,'Enable','off');
    set(handles.radiobutton_dec_nao,'Enable','off');
    set(handles.radiobutton_dec_mais,'Enable','off');
    set(handles.radiobutton_dec_menos,'Enable','off');
    set(handles.popupmenu_tipo_canal,'Enable','off');
    set(handles.edit_lat_graus,'Enable','off');
    set(handles.edit_lat_min,'Enable','off');
    set(handles.edit_lat_seg,'Enable','off');
    set(handles.edit_long_graus,'Enable','off');
    set(handles.edit_long_min,'Enable','off');
    set(handles.edit_long_seg,'Enable','off');
    set(handles.popupmenu_tipo_canal,'Enable','off');
    set(handles.edit_potencia,'Enable','off');
    set(handles.edit_azimute,'Enable','off');
    set(handles.listbox_estacoes,'Enable','off');
end
listbox_estacoes_Callback(hObject, eventdata, handles)

function pushbutton_importar_Callback(hObject, eventdata, handles)
global estacoes
tv_file_temp = uigetfile('*.mat','Importar Estações');

if ~isequal(tv_file_temp,0)
    load(tv_file_temp,'estacoes');
else
    return
end
if ~isempty(estacoes)
    set(handles.edit_desc,'Enable','on');
    set(handles.edit_canal,'Enable','on');
    set(handles.radiobutton_dec_nao,'Enable','on');
    set(handles.radiobutton_dec_mais,'Enable','on');
    set(handles.radiobutton_dec_menos,'Enable','on');
    set(handles.popupmenu_tipo_canal,'Enable','on');
    set(handles.edit_lat_graus,'Enable','on');
    set(handles.edit_lat_min,'Enable','on');
    set(handles.edit_lat_seg,'Enable','on');
    set(handles.edit_long_graus,'Enable','on');
    set(handles.edit_long_min,'Enable','on');
    set(handles.edit_long_seg,'Enable','on');
    set(handles.edit_potencia,'Enable','on');
    set(handles.edit_azimute,'Enable','on');
    set(handles.listbox_estacoes,'Enable','on');
    set(handles.pushbutton_aplicar,'Enable','on');
    set(handles.pushbutton_remover,'Enable','on');
    set(handles.listbox_estacoes,'String',strvcat(estacoes.descricao));
    set(handles.edit_desc,'String',estacoes(1).descricao);
    set(handles.edit_canal,'String',estacoes(1).canal);
    set(handles.popupmenu_tipo_canal,'Value',estacoes(1).tipo_canal);
    set(handles.edit_potencia,'String',estacoes(1).potencia);
    set(handles.edit_azimute,'String',estacoes(1).azimute);
    set(handles.text_distancia,'String',estacoes(1).distancia);
    set(handles.text_CPE,'String',estacoes(1).CPE);
    set(handles.text_CIE,'String',estacoes(1).CIE);
    set(handles.text_CIP,'String',estacoes(1).CIP);
    set(handles.text_CPP,'String',estacoes(1).CPP);
    set(handles.text_cpec,'String',estacoes(1).cpec);
    set(handles.text_ciec,'String',estacoes(1).ciec);
    set(handles.text_cipc,'String',estacoes(1).cipc);
    set(handles.text_cppc,'String',estacoes(1).cppc);
    set(handles.text_CPE_CIP,'String',estacoes(1).CPE_CIP);
    set(handles.text_CPP_CIE,'String',estacoes(1).CPP_CIE);
    set(handles.text_fc_estacoes,'String',estacoes(1).fator_correcao);
    set(handles.text_tipo_interferencia,'String',estacoes(1).tipo_interferencia);
    set(handles.text_interfere,'String',estacoes(1).interferente);
    set(handles.edit_lat_graus,'String',num2str(fix(estacoes(1).latitude)));
    set(handles.edit_lat_min,'String',num2str(fix((estacoes(1).latitude-fix(estacoes(1).latitude))*60)));
    set(handles.edit_lat_seg,'String',num2str(fix((((estacoes(1).latitude-fix(estacoes(1).latitude))*60)-fix((estacoes(1).latitude-fix(estacoes(1).latitude))*60))*60)));
    set(handles.edit_long_graus,'String',num2str(fix(estacoes(1).longitude)));
    set(handles.edit_long_min,'String',num2str(fix((estacoes(1).longitude-fix(estacoes(1).longitude))*60)));
    set(handles.edit_long_seg,'String',num2str(fix((((estacoes(1).longitude-fix(estacoes(1).longitude))*60)-fix((estacoes(1).longitude-fix(estacoes(1).longitude))*60))*60)));
end

function listbox_estacoes_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function listbox_estacoes_Callback(hObject, eventdata, handles)
global estacoes

if ~isempty(get(handles.listbox_estacoes,'String'))
    x=get(handles.listbox_estacoes,'Value');
    set(handles.edit_desc,'String',estacoes(x).descricao);
    set(handles.edit_canal,'String',estacoes(x).canal);
    if estacoes(x).decalagem=='Nao'
        set(handles.uipanel_decalagem,'SelectedObject',handles.radiobutton_dec_nao);
    elseif estacoes(x).decalagem=='+'
        set(handles.uipanel_decalagem,'SelectedObject',handles.radiobutton_dec_mais);
    elseif estacoes(x).decalagem=='-'
        set(handles.uipanel_decalagem,'SelectedObject',handles.radiobutton_dec_menos);    
    end
    set(handles.popupmenu_tipo_canal,'Value',estacoes(x).tipo_canal);
    set(handles.edit_potencia,'String',estacoes(x).potencia);
    set(handles.edit_azimute,'String',estacoes(x).azimute);
    set(handles.text_distancia,'String',estacoes(x).distancia);
    set(handles.text_fc_estacoes,'String',estacoes(x).fator_correcao);
    set(handles.text_CPE,'String',estacoes(x).CPE);
    set(handles.text_CIE,'String',estacoes(x).CIE);
    set(handles.text_CIP,'String',estacoes(x).CIP);
    set(handles.text_CPP,'String',estacoes(x).CPP);
    set(handles.text_cpec,'String',estacoes(x).cpec);
    set(handles.text_ciec,'String',estacoes(x).ciec);
    set(handles.text_cipc,'String',estacoes(x).cipc);
    set(handles.text_cppc,'String',estacoes(x).cppc);
    set(handles.text_CPE_CIP,'String',estacoes(x).CPE_CIP);
    set(handles.text_CPP_CIE,'String',estacoes(x).CPP_CIE);
    set(handles.text_tipo_interferencia,'String',estacoes(x).tipo_interferencia);
    set(handles.text_interfere,'String',estacoes(x).interferente);
    set(handles.edit_lat_graus,'String',num2str(fix(estacoes(x).latitude)));
    set(handles.edit_lat_min,'String',num2str(fix((estacoes(x).latitude-fix(estacoes(x).latitude))*60)));
    set(handles.edit_lat_seg,'String',num2str(fix((((estacoes(x).latitude-fix(estacoes(x).latitude))*60)-fix((estacoes(x).latitude-fix(estacoes(x).latitude))*60))*60)));
    set(handles.edit_long_graus,'String',num2str(fix(estacoes(x).longitude)));
    set(handles.edit_long_min,'String',num2str(fix((estacoes(x).longitude-fix(estacoes(x).longitude))*60)));
    set(handles.edit_long_seg,'String',num2str(fix((((estacoes(x).longitude-fix(estacoes(x).longitude))*60)-fix((estacoes(x).longitude-fix(estacoes(x).longitude))*60))*60)));
end

function pushbutton_adicionar_Callback(hObject, eventdata, handles)
global estacoes

if isempty(get(handles.listbox_estacoes,'String'))
    estacoes(1).descricao='Estação1';estacoes(1).canal='';
    set(handles.uipanel_decalagem,'SelectedObject',handles.radiobutton_dec_nao);
    estacoes(1).decalagem='Nao';estacoes(1).tipo_canal=1;
    estacoes(1).potencia='';estacoes(1).azimute='';
    estacoes(1).distancia='';estacoes(1).ci='';estacoes(1).cppc=''
    estacoes(1).CIP='';estacoes(1).cpec='';estacoes(1).ciec='';
    estacoes(1).cipc='';estacoes(1).interferente='';estacoes(1).CPE_CIP='';
    estacoes(1).CPP_CIE='';estacoes(1).fator_correcao='';
    estacoes(1).tipo_interferencia='';estacoes(1).interferente='';
    set(handles.edit_desc,'String','Estação1','Enable','on');
    set(handles.text_tipo_interferencia,'String','');
    set(handles.listbox_estacoes,'String','Estação1','Value',1,'Enable','on');
    set(handles.text_fc_estacoes,'String',estacoes(1).fator_correcao);
    set(handles.text_CIP,'String',estacoes(1).CIP);
    set(handles.text_CPP,'String',estacoes(1).CPP);
    set(handles.text_cpec,'String',estacoes(1).cpec);
    set(handles.text_ciec,'String',estacoes(1).ciec);
    set(handles.text_cipc,'String',estacoes(1).cipc);
    set(handles.text_cppc,'String',estacoes(1).cppc);
    set(handles.text_CPE_CIP,'String',estacoes(1).CPE_CIP);
    set(handles.text_CPP_CIE,'String',estacoes(1).CPP_CIE);
    set(handles.text_tipo_interferencia,'String',estacoes(1).tipo_interferencia);
    set(handles.text_interfere,'String',estacoes(1).interferente);
    set(handles.edit_canal,'Enable','on');
    set(handles.radiobutton_dec_nao,'Enable','on');
    set(handles.radiobutton_dec_mais,'Enable','on');
    set(handles.radiobutton_dec_menos,'Enable','on');
    set(handles.popupmenu_tipo_canal,'Enable','on');
    set(handles.edit_lat_graus,'Enable','on','String','');
    set(handles.edit_lat_min,'Enable','on','String','');
    set(handles.edit_lat_seg,'Enable','on','String','');
    set(handles.edit_long_graus,'Enable','on','String','');
    set(handles.edit_long_min,'Enable','on','String','');
    set(handles.edit_long_seg,'Enable','on','String','');
    set(handles.edit_potencia,'Enable','on');
    set(handles.edit_azimute,'Enable','on');
    set(handles.pushbutton_aplicar,'Enable','on');
    set(handles.pushbutton_remover,'Enable','on');
    numestacoes=1;
else
    [numestacoes,temp]=size(get(handles.listbox_estacoes,'String'));
    numestacoes=numestacoes+1;
    set(handles.listbox_estacoes,'String', strvcat(char(get(handles.listbox_estacoes,'String')),strcat('Estação',num2str(numestacoes))),'Value',numestacoes);
    estacoes(numestacoes).descricao=strcat('Estação',num2str(numestacoes));
    estacoes(numestacoes).tipo_canal=1;
    set(handles.uipanel_decalagem,'SelectedObject',handles.radiobutton_dec_nao);
    estacoes(numestacoes).decalagem='Nao';
    set(handles.edit_desc,'String',estacoes(numestacoes).descricao);
    set(handles.edit_canal,'String','');
    set(handles.popupmenu_tipo_canal,'Value',1);
    set(handles.edit_lat_graus,'String','');
    set(handles.edit_lat_min,'String','');
    set(handles.edit_lat_seg,'String','');
    set(handles.edit_long_graus,'String','');
    set(handles.edit_long_min,'String','');
    set(handles.edit_long_seg,'String','');
    set(handles.edit_potencia,'String','');
    set(handles.edit_azimute,'String','');
    set(handles.text_distancia,'String','');
    set(handles.text_CPE,'String','');
    set(handles.text_CIE,'String','');
    set(handles.text_CIP,'String','');
    set(handles.text_CPP,'String','');
    set(handles.text_cpec,'String','');
    set(handles.text_ciec,'String','');
    set(handles.text_cipc,'String','');
    set(handles.text_cppc,'String','');
    set(handles.text_fc_estacoes,'String','');
    set(handles.text_CPE_CIP,'String','');
    set(handles.text_CPP_CIE,'String','');
    set(handles.text_tipo_interferencia,'String','');
    set(handles.text_interfere,'String','');    
end

function atualiza_contorno_estacoes(hObject, eventdata, handles)
global estacoes CP02_50_50 CP07_50_50 CP14_50_50

if ~isempty(get(handles.edit_potencia,'String'))
    %fc=10*log(P/1kW)
    estacoes(get(handles.listbox_estacoes,'Value')).fator_correcao=10*log10(str2num(get(handles.edit_potencia,'String'))/1000);
else
    estacoes(get(handles.listbox_estacoes,'Value')).fator_correcao=0;
end
H=[ 30 50 100 150 300 500 1000 ];E=[ -15 -10 0 10 20 40 60 80 100];

if str2num(get(handles.edit_canal,'String')) >= 2 & str2num(get(handles.edit_canal,'String')) <= 6 & get(handles.popupmenu_tipo_canal,'Value') == 1
    estacoes(get(handles.listbox_estacoes,'Value')).cpec=58-estacoes(get(handles.listbox_estacoes,'Value')).fator_correcao;
    estacoes(get(handles.listbox_estacoes,'Value')).CPE=interp2(E,H,CP02_50_50,(estacoes(get(handles.listbox_estacoes,'Value')).cpec),150);
    estacoes(get(handles.listbox_estacoes,'Value')).ci='CI02_50_10';
elseif str2num(get(handles.edit_canal,'String')) >= 7 & str2num(get(handles.edit_canal,'String')) <= 13 & get(handles.popupmenu_tipo_canal,'Value') == 1
    estacoes(get(handles.listbox_estacoes,'Value')).cpec=64-estacoes(get(handles.listbox_estacoes,'Value')).fator_correcao;
    estacoes(get(handles.listbox_estacoes,'Value')).CPE=interp2(E,H,CP07_50_50,(estacoes(get(handles.listbox_estacoes,'Value')).cpec),150);
    estacoes(get(handles.listbox_estacoes,'Value')).ci='CI07_50_10';
else
    estacoes(get(handles.listbox_estacoes,'Value')).cpec=70-estacoes(get(handles.listbox_estacoes,'Value')).fator_correcao;    
    estacoes(get(handles.listbox_estacoes,'Value')).CPE=interp2(E,H,CP14_50_50,(estacoes(get(handles.listbox_estacoes,'Value')).cpec),150);
    estacoes(get(handles.listbox_estacoes,'Value')).ci='CI14_50_10';
end

if estacoes(get(handles.listbox_estacoes,'Value')).cpec>100
    estacoes(get(handles.listbox_estacoes,'Value')).cpec=100;
elseif estacoes(get(handles.listbox_estacoes,'Value')).cpec<-15
    estacoes(get(handles.listbox_estacoes,'Value')).cpec=-15;
end

set(handles.text_fc_estacoes,'String',estacoes(get(handles.listbox_estacoes,'Value')).fator_correcao);
set(handles.text_CPE,'String',estacoes(get(handles.listbox_estacoes,'Value')).CPE);
set(handles.text_cpec,'String',estacoes(get(handles.listbox_estacoes,'Value')).cpec);


function salva_coordenadas(hObject, eventdata, handles)
global estacoes
if ~isempty(get(handles.edit_lat_graus,'String')) && ~isempty(get(handles.edit_lat_min,'String')) && ~isempty(get(handles.edit_lat_seg,'String'))
    estacoes(get(handles.listbox_estacoes,'Value')).latitude=str2num(get(handles.edit_lat_graus,'String'))+str2num(get(handles.edit_lat_min,'String'))/60+str2num(get(handles.edit_lat_seg,'String'))/3600;
end
if ~isempty(get(handles.edit_long_graus,'String')) && ~isempty(get(handles.edit_long_min,'String')) && ~isempty(get(handles.edit_long_seg,'String'))
    estacoes(get(handles.listbox_estacoes,'Value')).longitude=str2num(get(handles.edit_long_graus,'String'))+str2num(get(handles.edit_long_min,'String'))/60+str2num(get(handles.edit_long_seg,'String'))/3600;
end

function calcula_distancia(hObject, eventdata, handles)
global tv_file estacoes
load(tv_file,'latitude','longitude');
x=get(handles.listbox_estacoes,'Value');
if ~isempty(estacoes(x).latitude) && ~isempty(estacoes(x).longitude) && ~isempty(latitude) && ~isempty(longitude)
estacoes(x).distancia=111.1775*(acos(sin(latitude*pi/180)*sin(estacoes(x).latitude*pi/180)+cos(latitude*pi/180)*cos(estacoes(x).latitude*pi/180)*cos((longitude-estacoes(x).longitude)*pi/180))/pi*180);
set(handles.text_distancia,'String',estacoes(x).distancia);
end

function edit_lat_graus_Callback(hObject, eventdata, handles)
salva_coordenadas(hObject, eventdata, handles);
calcula_distancia(hObject, eventdata, handles);

function edit_lat_graus_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function edit_lat_min_Callback(hObject, eventdata, handles)
salva_coordenadas(hObject, eventdata, handles);
calcula_distancia(hObject, eventdata, handles);

function edit_lat_min_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function edit_lat_seg_Callback(hObject, eventdata, handles)
salva_coordenadas(hObject, eventdata, handles);
calcula_distancia(hObject, eventdata, handles);

function edit_lat_seg_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function edit_long_graus_Callback(hObject, eventdata, handles)
salva_coordenadas(handles, eventdata, handles);
calcula_distancia(hObject, eventdata, handles);

function edit_long_graus_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function edit_long_min_Callback(hObject, eventdata, handles)
salva_coordenadas(handles, eventdata, handles);
calcula_distancia(hObject, eventdata, handles);

function edit_long_min_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function edit_long_seg_Callback(hObject, eventdata, handles)
salva_coordenadas(handles, eventdata, handles);
calcula_distancia(hObject, eventdata, handles);

function edit_long_seg_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function pushbutton_cancelar_Callback(hObject, eventdata, handles)
clear estacoes;
close;

function uipanel_decalagem_SelectionChangeFcn(hObject, eventdata, handles)
global estacoes
estacoes(get(handles.listbox_estacoes,'Value')).decalagem=get(get(handles.uipanel_decalagem,'SelectedObject'),'string');
