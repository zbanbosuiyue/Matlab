function varargout = record_samples(varargin)
% RECORD_SAMPLES MATLAB code for record_samples.fig
%      RECORD_SAMPLES, by itself, creates a new RECORD_SAMPLES or raises the existing
%      singleton*.
%
%      H = RECORD_SAMPLES returns the handle to a new RECORD_SAMPLES or the handle to
%      the existing singleton*.
%
%      RECORD_SAMPLES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RECORD_SAMPLES.M with the given input arguments.
%
%      RECORD_SAMPLES('Property','Value',...) creates a new RECORD_SAMPLES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before record_samples_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to record_samples_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help record_samples

% Last Modified by GUIDE v2.5 10-Oct-2014 21:27:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @record_samples_OpeningFcn, ...
                   'gui_OutputFcn',  @record_samples_OutputFcn, ...
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


% --- Executes just before record_samples is made visible.
function record_samples_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to record_samples (see VARARGIN)

% Choose default command line output for record_samples
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes record_samples wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = record_samples_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function word_in_edit_Callback(hObject, eventdata, handles)
% hObject    handle to word_in_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of word_in_edit as text
%        str2double(get(hObject,'String')) returns contents of word_in_edit as a double



% --- Executes during object creation, after setting all properties.
function word_in_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to word_in_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.



% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'),...
    get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'String',{'3';'5';'10';'15'});


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get Repeat times
v_num=get(handles.popupmenu1,'Value');
switch v_num
    case 1
        repeat=3;
    case 2
        repeat=5;
    case 3
        repeat=10;
    case 4
        repeat=15;
end

% Get Target Value
target=get(handles.word_in_edit,'String');
if isempty(target)
    error('We need words to be input.');
end
path='wav/';
name=target;

t=0:1000/16000:2000;
t=t(1:32000)';
count=1;

% Recording
recObj = audiorecorder(16000,16,1);
for i=1:repeat
    set(handles.display_text,'String','Please Speak one word in two seconds.');
    recordblocking(recObj,2);
    rawData=getaudiodata(recObj);
    set(handles.display_text,'String','Finished.');
    plot(t,rawData);
    wavwrite(rawData,16000,8,[path name '_' int2str(count)]);
    pause(2);
    set(handles.display_text,'String','Play back.');
    sound(rawData,16000);
    pause(2);
    count=count+1;
end
disp(target);



function display_text_Callback(hObject, eventdata, handles)
% hObject    handle to display_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of display_text as text
%        str2double(get(hObject,'String')) returns contents of display_text as a double


% --- Executes during object creation, after setting all properties.


function display_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to display_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
