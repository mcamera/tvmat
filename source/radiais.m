function varargout = radiais(varargin)
% Begin initialization code
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @radiais_OpeningFcn, ...
                   'gui_OutputFcn',  @radiais_OutputFcn, ...
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

function radiais_OpeningFcn(hObject, eventdata, handles, varargin)
global tv_file

handles.output = hObject;
guidata(hObject, handles);

load(tv_file,'-regexp','radial');
if ~isempty(radial_dist)
    set(handles.edit_radial_dist,'String',num2str(radial_dist));
end
if ~isempty(radial)
    set(handles.listbox_radial,'String',strvcat(radial.descricao));
    set(handles.edit_descricao,'String',radial(1).descricao);
    set(handles.edit_cota,'String',num2str(radial(1).cota));
    set(handles.edit_azimute,'String',num2str(radial(1).azimute));
    set(handles.text_nmr,'String',num2str(radial(1).nmr));
    set(handles.text_hnmr,'String',num2str(radial(1).hnmr));
    set(handles.text_rug,'String',num2str(radial(1).rug));    
    set(handles.text_contorno_primario,'String',num2str(radial(1).dist_primario));
    set(handles.text_contorno_secundario,'String',num2str(radial(1).dist_secundario));
    set(handles.text_contorno_rural,'String',num2str(radial(1).dist_rural));  
else
    set(handles.edit_descricao,'Enable','off');
    set(handles.edit_cota,'Enable','off');
    set(handles.edit_azimute,'Enable','off');
    set(handles.listbox_radial,'Enable','off');
    set(handles.pushbutton_remover,'Enable','off');
    set(handles.pushbutton_plotar,'Enable','off');
end
    
function varargout = radiais_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function pushbutton_aplicar_Callback(hObject, eventdata, handles)
global tv_file radial radial_dist
save(tv_file,'-regexp','radial','-append');
clear radial radial_dist;
close;

function pushbutton_cancelar_Callback(hObject, eventdata, handles)
clear radial radial_dist;
close;

function pushbutton_adicionar_Callback(hObject, eventdata, handles)
global radial
if isempty(get(handles.listbox_radial,'String'))
    radial(1).descricao='Radial1';
    radial(1).cota='';
    radial(1).azimute='';
    radial(1).nmr='';
    radial(1).rug='';
    radial(1).hnmr='';
    radial(1).dist_primario='';
    radial(1).dist_secundario='';
    radial(1).dist_rural='';
    set(handles.edit_descricao,'String','Radial1','Enable','on');
    set(handles.listbox_radial,'String','Radial1','Value',1,'Enable','on');  
    set(handles.edit_cota,'Enable','on');
    set(handles.edit_azimute,'Enable','on');
    set(handles.pushbutton_aplicar,'Enable','on');
    set(handles.pushbutton_remover,'Enable','on');
    set(handles.pushbutton_plotar,'Enable','on');
    numradiais=1;
else
    [numradiais,temp]=size(get(handles.listbox_radial,'String'));
    numradiais=numradiais+1;
    set(handles.listbox_radial,'String', strvcat(char(get(handles.listbox_radial,'String')),strcat('Radial',num2str(numradiais))),'Value',numradiais);
    radial(numradiais).descricao=strcat('Radial',num2str(numradiais));
    set(handles.edit_descricao,'String',radial(numradiais).descricao);
    set(handles.edit_cota,'String','');
    set(handles.edit_azimute,'String','');
    set(handles.text_nmr,'String','');
    set(handles.text_hnmr,'String','');
    set(handles.text_rug,'String','');
    set(handles.text_contorno_primario,'String','');
    set(handles.text_contorno_secundario,'String','');
    set(handles.text_contorno_rural,'String','');
end

function pushbutton_remover_Callback(hObject, eventdata, handles)
global radial
entries = cellstr(get(handles.listbox_radial,'String'));
value   = uint8(get(handles.listbox_radial,'Value'));

entries(value) = [];radial(value)= [];
if isempty(entries)
   nentries=0;
else
    nentries = size(entries,1);    
end
if value > nentries
    value = value-1;
    set(handles.listbox_radial,'Value',value);
end
set(handles.listbox_radial,'String',entries);
if nentries==0
    set(handles.listbox_radial,'Value',0,'Enable','off');
    set(handles.pushbutton_remover,'Enable','off');
    set(handles.pushbutton_plotar,'Enable','off');
    set(handles.edit_descricao,'String','','Enable','off');
    set(handles.edit_cota,'String','','Enable','off');
    set(handles.edit_azimute,'String','','Enable','off');
    set(handles.text_nmr,'String','');
    set(handles.text_hnmr,'String','');
    set(handles.text_rug,'String','');
    set(handles.text_contorno_primario,'String','');
    set(handles.text_contorno_secundario,'String','');
    set(handles.text_contorno_rural,'String','');
end
listbox_radial_Callback(hObject, eventdata, handles);

function listbox_radial_Callback(hObject, eventdata, handles)
global radial
if ~isempty(get(handles.listbox_radial,'String'))
    set(handles.edit_descricao,'String',radial(get(handles.listbox_radial,'Value')).descricao);
    set(handles.edit_cota,'String',num2str(radial(get(handles.listbox_radial,'Value')).cota));
    set(handles.edit_azimute,'String',num2str(radial(get(handles.listbox_radial,'Value')).azimute));
    set(handles.text_nmr,'String',num2str(radial(get(handles.listbox_radial,'Value')).nmr));
    set(handles.text_hnmr,'String',num2str(radial(get(handles.listbox_radial,'Value')).hnmr));
    set(handles.text_rug,'String',num2str(radial(get(handles.listbox_radial,'Value')).rug));
    set(handles.text_contorno_primario,'String',num2str(radial(get(handles.listbox_radial,'Value')).dist_primario));
    set(handles.text_contorno_secundario,'String',num2str(radial(get(handles.listbox_radial,'Value')).dist_secundario));
    set(handles.text_contorno_rural,'String',num2str(radial(get(handles.listbox_radial,'Value')).dist_rural));
end

function listbox_radial_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function edit_descricao_Callback(hObject, eventdata, handles)
global radial
radial(get(handles.listbox_radial,'value')).descricao=get(hObject,'String');
set(handles.listbox_radial,'String',strvcat(radial.descricao));

function edit_descricao_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function edit_cota_Callback(hObject, eventdata, handles)
global radial radial_dist
radial(get(handles.listbox_radial,'value')).cota=str2num(get(hObject,'String'));
%Calcula a NMR:
if isempty(radial_dist)
    return
end
%Limita o vetor distancia entre 3 e 15km:
n=length(radial_dist);
for i=1:n
    if radial_dist(i)<=3
        w=i;
    end
    if i>1
        if radial_dist(i-1)<15
            k=i;
        end
    end
end
if ~exist('w') || radial_dist(w)<3
    uiwait(errordlg('Impossível calcular a NMR. O vetor distancia é inferior a 3km.','Erro!'));
    return
end
if ~isempty(w) && exist('w')
    y=k;
    %Limita a radial para no caso do comprimento dela ser inferior a K
    if y>length(radial(get(handles.listbox_radial,'value')).cota)
        y=length(radial(get(handles.listbox_radial,'value')).cota);
    end
    if w>length(radial(get(handles.listbox_radial,'value')).cota)
        errordlg('Esta cota está fora dos parametros!','Erro!');
        return
    end            
    radlim=radial(get(handles.listbox_radial,'value')).cota(w:y);%vetor radial limitado entre 3 e 15km
    radial(get(handles.listbox_radial,'value')).nmr=sum(radlim)/length(radlim);%somatório das radiais / total de radiais
    set(handles.text_nmr,'String',radial(get(handles.listbox_radial,'value')).nmr);
else
    errordlg('Esta cota está fora do padrão!','Erro!');
end

%Calcula a rugosidade:
inter=radial_dist(2)-radial_dist(1);
for i=1:n
 if radial_dist(i)<=10
   u=i;
   end
   if i>1
      if radial_dist(i-1)<50
         v=i;
      end
   end
end
if radial_dist(u)<10
    errordlg('Impossível calcular a rugosidade. O vetor distancia é inferior a 10km.','Erro!');
    return
end
if v>length(str2num(get(handles.edit_cota,'String')))
    v=length(str2num(get(handles.edit_cota,'String')));
end

yl=radial(get(handles.listbox_radial,'value')).cota(u:v);
xlc=radial_dist(u:v);
ylc=sort(yl);
comp=inter*length(yl)-inter;
d10=0.1*comp;

for i=1:length(yl)-1
    if xlc(i+1)-xlc(1)<=d10
        h10=ylc(i+1);
    end
    if xlc(length(yl))-xlc(length(yl)-i)<=d10
        h90=ylc(length(yl)-i);
    end
end
radial(get(handles.listbox_radial,'value')).rug=h90-h10;
set(handles.text_rug,'String',radial(get(handles.listbox_radial,'value')).rug);

function edit_cota_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function edit_azimute_Callback(hObject, eventdata, handles)
global radial
radial(get(handles.listbox_radial,'value')).azimute=str2num(get(hObject,'String'));

function edit_azimute_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function pushbutton_plotar_Callback(hObject, eventdata, handles)
dist=str2num(get(handles.edit_radial_dist,'String'));
cota=str2num(get(handles.edit_cota,'String'));
ncota=length(cota);
ndist=length(dist);
if ncota>ndist
    errordlg('A quantidade de cotas é superior a quantidade de valores da distancia!','Erro!');
    set(handles.edit_cota,'String','');
else
    axes(handles.grafico);
    plot(dist(1:ncota),cota);
    grid on;
    title(get(handles.edit_descricao,'String'));    
end

function pushbutton_importar_Callback(hObject, eventdata, handles)
tv_file_temp = uigetfile('*.mat','Importar Radiais');

if ~isequal(tv_file_temp,0)
    load(tv_file_temp,'-regexp','radial');
else
    return
end
if ~isempty(radial_dist)
    set(handles.edit_radial_dist,'String',num2str(radial_dist));
end
if ~isempty(radial)
    set(handles.listbox_radial,'String',strvcat(radial.descricao));
    set(handles.edit_descricao,'Enable','on');
    set(handles.edit_cota,'Enable','on');
    set(handles.edit_azimute,'Enable','on');
    set(handles.listbox_radial,'Enable','on');
    set(handles.pushbutton_remover,'Enable','on');
    set(handles.pushbutton_plotar,'Enable','on');
    set(handles.edit_descricao,'String',radial(1).descricao);
    set(handles.edit_cota,'String',num2str(radial(1).cota));
    set(handles.edit_azimute,'String',num2str(radial(1).azimute));
    set(handles.text_nmr,'String',num2str(radial(1).nmr));
    set(handles.text_rug,'String',num2str(radial(1).rug));
    set(handles.text_hnmr,'String',num2str(radial(1).hnmr));
    set(handles.text_contorno_primario,'String',num2str(radial(1).dist_primario));
    set(handles.text_contorno_secundario,'String',num2str(radial(1).dist_secundario));
    set(handles.text_contorno_rural,'String',num2str(radial(1).dist_rural));
end

function edit_radial_dist_Callback(hObject, eventdata, handles)
global radial_dist
radial_dist=str2num(get(hObject,'String'));
