function varargout = new_GUI(varargin)
% NEW_GUI MATLAB code for new_GUI.fig
%      NEW_GUI, by itself, creates a new NEW_GUI or raises the existing
%      singleton*.
%
%      H = NEW_GUI returns the handle to a new NEW_GUI or the handle to
%      the existing singleton*.
%
%      NEW_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NEW_GUI.M with the given input arguments.
%
%      NEW_GUI('Property','Value',...) creates a new NEW_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before new_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to new_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help new_GUI

% Last Modified by GUIDE v2.5 10-Oct-2014 18:32:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @new_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @new_GUI_OutputFcn, ...
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


% --- Executes just before new_GUI is made visible.
function new_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to new_GUI (see VARARGIN)

% Choose default command line output for new_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes new_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = new_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in RS_button.
function RS_button_Callback(hObject, eventdata, handles)
% hObject    handle to RS_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
run('record_samples');

% --- Executes on button press in LS_button.
function LS_button_Callback(hObject, eventdata, handles)
% hObject    handle to LS_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global myGlobalVar;
global target_name;
[FileName,PathName, Filterindex] = uigetfile('*.wav','Select the wav file', 'MultiSelect', 'on');
target_name=FileName;
for i=1:length(FileName)
    voice{i}=wavread([PathName FileName{i}]);
end
myGlobalVar=voice;


% --- Executes on button press in TR_button.
function TR_button_Callback(hObject, eventdata, handles)
% hObject    handle to TR_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global myGlobalVar;
global target_name;
voice=myGlobalVar;
disp(target_name);
interval=1000;
width=8000;
for i=1:length(voice)
    new_voice=voice{i};
    count=1;
    for j=1:interval:length(new_voice)-width
        energy(count)=sum(abs(new_voice(j:j+width)));
        count=count+1;
    end
    
    % Find the begin of the voice and transform to mfcc.
    index=0;
    for j=1:length(energy)
        if(energy(j)==max(energy))
            index=j;
            break;
        end
    end
    mfcc_index=floor(index*250*0.9/32);

    mfcc_value{i}=melcepst(voice{i},16000,'M',3);
    for j=1:20
        if(max(abs(mfcc_value{i}(j,:)))<0.1)
            mfcc_index=mfcc_index+1;
            end
    end
    
    %
    % mfcc is one of the feature will be sent to NN
    %
    window=20;
    
    mfcc_1{i}=mfcc_value{i}(mfcc_index:mfcc_index+window-1,:);
    mfcc_2{i}=mfcc_value{i}(mfcc_index+window:mfcc_index+2*window-1,:);
    mfcc_3{i}=mfcc_value{i}(mfcc_index+2*window:mfcc_index+3*window-1,:);
    
    a_1=mfcc_1{i}(:,1);
    a_2=mfcc_2{i}(:,1);
    a_3=mfcc_3{i}(:,1);
    for j=2:3
        a_1=[a_1;mfcc_1{i}(:,j)];
        a_2=[a_2;mfcc_2{i}(:,j)];
        a_3=[a_3;mfcc_3{i}(:,j)];
    end
    mfcc_1{i}=a_1;
    mfcc_2{i}=a_2;
    mfcc_3{i}=a_3;
end

save mfcc_data

% %% 1=W, 2=AH1, 3=N, 4=T, 5=UW1, 6=TH, 7=R, 8=IY1, 9=F, 10=AO1, 11=AY1, 12=V;
% %% 13=S, 14=IH1 15=K, 16=EH1, 17=AH0, 18=EY1
% target=creat_target();
% 
% 
% X=new_abc;
% T=target';
% 
% global m;
% global n;
% m=max(max(abs(X)));
% n=max(max(abs(T)));
% x=X/m;
% t=T/n;
% 
% %% Neuron Network Building
% pr(1:70,1)=-1; 
% pr(1:70,2)=1;
% global bpnet;
% 
% bpnet=newff(pr,[40 10],{'logsig', 'logsig'}, 'traingdx', 'learngdm');
% 
% % Build BPNN, Hidden Nodes:40; Output Nodes:1
% % Atribute of tranferFcn: 'logsig'==sigmoid function for hidden layer;
% % Atribute of tranferFcn: 'logsig'==sigmoid function for output layer;
% % Atribute of trainFcn: 'traingdx' automatic control the learning rate;
% % Atribute of learning: 'learngdm'
% 
% bpnet.trainParam.epochs=1000;% Epochs
% bpnet.trainParam.goal=0.0000001; % goal
% bpnet.trainParam.show=10; % show result at every 100 epochs.
% bpnet.trainParam.lr=0.05; % learning rate=0.05
% 
% 
% bpnet=train(bpnet,x,t); % Training
% %%



% --- Executes on button press in TEST_button.
function TEST_button_Callback(hObject, eventdata, handles)
% hObject    handle to TEST_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
run('test');

