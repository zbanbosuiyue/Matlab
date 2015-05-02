function varargout = test(varargin)
% TEST MATLAB code for test.fig
%      TEST, by itself, creates a new TEST or raises the existing
%      singleton*.
%
%      H = TEST returns the handle to a new TEST or the handle to
%      the existing singleton*.
%
%      TEST('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TEST.M with the given input arguments.
%
%      TEST('Property','Value',...) creates a new TEST or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before test_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to test_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help test

% Last Modified by GUIDE v2.5 22-Oct-2014 16:02:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @test_OpeningFcn, ...
                   'gui_OutputFcn',  @test_OutputFcn, ...
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


% --- Executes just before test is made visible.
function test_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to test (see VARARGIN)

% Choose default command line output for test
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes test wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = test_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in record.
function record_Callback(hObject, eventdata, handles)
% hObject    handle to record (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global bpnet1;
set(hObject,'String','Begin.');
set(hObject,'String','Please Speak one word in two seconds.');
recObj = audiorecorder(16000,16,1);
recordblocking(recObj,2);
rawData=getaudiodata(recObj);
set(hObject,'String','Finished.');
plot(rawData);
sound(rawData,16000);

interval=1000;
width=8000;
count=1;
new_voice=rawData;

for j=1:interval:length(new_voice)-width
    energy(count)=sum(abs(new_voice(j:j+width)));
    count=count+1;
end
index=0;
for j=1:length(energy)
    if(energy(j)==max(energy))
        index=j;
        break;
    end
end
mfcc_index=floor(index*40/32);
disp(mfcc_index);

mfcc_value=melcepst(new_voice,16000,'M',6);


mfcc_1=mfcc_value(mfcc_index:mfcc_index+9,1);
mfcc_2=mfcc_value(mfcc_index:mfcc_index+9,2);
mfcc_3=mfcc_value(mfcc_index:mfcc_index+9,3);
mfcc_4=mfcc_value(mfcc_index:mfcc_index+9,4);
mfcc_5=mfcc_value(mfcc_index:mfcc_index+9,5);
mfcc_6=mfcc_value(mfcc_index:mfcc_index+9,6);


set(hObject,'String','Finished.');
pause(2);

P=[mfcc_1;mfcc_2;mfcc_3;mfcc_4;mfcc_5;mfcc_6];
plot(P);
p=P
r=sim(bpnet1,p);
R=r';
display(R);
index=find(R==max(R));
set(handles.show,'String',index);
set(hObject,'String','Test again?');
save test 

function show_Callback(hObject, eventdata, handles)
% hObject    handle to show (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of show as text
%        str2double(get(hObject,'String')) returns contents of show as a double


% --- Executes during object creation, after setting all properties.
function show_CreateFcn(hObject, eventdata, handles)
% hObject    handle to show (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
