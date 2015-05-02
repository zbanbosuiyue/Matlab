function varargout = GUI_file(varargin)
% GUI_FILE MATLAB code for GUI_file.fig
%      GUI_FILE, by itself, creates a new GUI_FILE or raises the existing
%      singleton*.
%
%      H = GUI_FILE returns the handle to a new GUI_FILE or the handle to
%      the existing singleton*.
%
%      GUI_FILE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_FILE.M with the given input arguments.
%
%      GUI_FILE('Property','Value',...) creates a new GUI_FILE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_file_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_file_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_file

% Last Modified by GUIDE v2.5 10-Oct-2014 16:20:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_file_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_file_OutputFcn, ...
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


% --- Executes just before GUI_file is made visible.
function GUI_file_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_file (see VARARGIN)

% Choose default command line output for GUI_file
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_file wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_file_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in RecordButton.
function RecordButton_Callback(hObject, eventdata, handles)
% hObject    handle to RecordButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% Step 1. Record sample voice
recObj = audiorecorder(16000,16,1);             % audiorecorder(Fs,nBits,nChannels)
disp('Please speaking.')
set(handles.textShowMessage,'String','Please Speaking');
recordblocking(recObj,2);
disp('End of recording.');
set(handles.textShowMessage,'String','Finished');
rawSignal = getaudiodata(recObj);
axes(handles.axes1);
plot(rawSignal);
sound(rawSignal,16000);
save GUI_OUT

% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1


% --- Executes during object creation, after setting all properties.
function textShowMessage_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textShowMessage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

