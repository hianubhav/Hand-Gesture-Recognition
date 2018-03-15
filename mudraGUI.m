function varargout = mudraGUI(varargin)
% MUDRAGUI MATLAB code for mudraGUI.fig
%      MUDRAGUI, by itself, creates a new MUDRAGUI or raises the existing
%      singleton*.
%
%      H = MUDRAGUI returns the handle to a new MUDRAGUI or the handle to
%      the existing singleton*.
%
%      MUDRAGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MUDRAGUI.M with the given input arguments.
%
%      MUDRAGUI('Property','Value',...) creates a new MUDRAGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mudraGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to mudraGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mudraGUI

% Last Modified by GUIDE v2.5 31-Mar-2016 01:09:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mudraGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @mudraGUI_OutputFcn, ...
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


% --- Executes just before mudraGUI is made visible.
function mudraGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mudraGUI (see VARARGIN)

% Choose default command line output for mudraGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes mudraGUI wait for user response (see UIRESUME)
% uiwait(handles.Mudra);


% --- Outputs from this function are returned to the command line.
function varargout = mudraGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%-------------Code for background--------------
% This creates the 'background' axes
ha = axes('units','normalized', ...
            'position',[0 0 1 1]);
% Move the background axes to the bottom
uistack(ha,'bottom');
% Load in a background image and display it using the correct colors
% The image used below, is in the Image Processing Toolbox.  If you do not have %access to this toolbox, you can use another image file instead.
I=imread('matrix.jpg');
hi = imagesc(I);
colormap gray
% Turn the handlevisibility off so that we don't inadvertently plot into the axes again
% Also, make the axes invisible
set(ha,'handlevisibility','off', ...
            'visible','off')
%To adjust transparency of background image.
set(hi,'alphadata',.7)
%------------------------------------------

% --- Executes on button press in browse.
function browse_Callback(hObject, eventdata, handles)
global frame ctrue 
ctrue=0;
frame=browse;
warning('off', 'Images:initSize:adjustingMag');
% hObject    handle to browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in capture.
function capture_Callback(hObject, eventdata, handles)
global ctrue
ctrue = 1;
captureGUI;

% hObject    handle to capture (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in featureVisualization.
function featureVisualization_Callback(hObject, eventdata, handles)
global frame ctrue 
if(ctrue==1)
    frame=imread('frame.png');
end
frame=resize(frame);
frame = 255 * uint8(frame);
assignin('base','imgtest',frame);
figure,imshow(frame);
%extractGesture(frame);
% hObject    handle to featureVisualization (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in handGestureRecognition.
function handGestureRecognition_Callback(hObject, eventdata, handles)
global frame;
image2vectorSample(frame);
load('sample3.mat');
assignin('base','inptvctr',temp);
output=myNeuralNetworkFunction1(double(temp));
output
[v,idx]=max(output);
prob_vector=v
output=idx
% hObject    handle to handGestureRecognition (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in viewSourceCode.
function viewSourceCode_Callback(hObject, eventdata, handles)
show_sourcecode;
% hObject    handle to viewSourceCode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in readMe.
function readMe_Callback(hObject, eventdata, handles)
show_readme;
% hObject    handle to readMe (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in exitButton.
function exitButton_Callback(hObject, eventdata, handles)
close(mudraGUI);
% hObject    handle to exitButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
