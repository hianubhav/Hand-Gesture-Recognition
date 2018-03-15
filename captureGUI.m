function varargout = captureGUI(varargin)
% CAPTUREGUI MATLAB code for captureGUI.fig
%      CAPTUREGUI, by itself, creates a new CAPTUREGUI or raises the existing
%      singleton*.
%
%      H = CAPTUREGUI returns the handle to a new CAPTUREGUI or the handle to
%      the existing singleton*.
%
%      CAPTUREGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CAPTUREGUI.M with the given input arguments.
%
%      CAPTUREGUI('Property','Value',...) creates a new CAPTUREGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before captureGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to captureGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help captureGUI

% Last Modified by GUIDE v2.5 31-Mar-2016 01:28:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @captureGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @captureGUI_OutputFcn, ...
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


% --- Executes just before captureGUI is made visible.
function captureGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to captureGUI (see VARARGIN)

% Choose default command line output for captureGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes captureGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = captureGUI_OutputFcn(hObject, eventdata, handles) 
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
hi = imagesc(I)
colormap gray
% Turn the handlevisibility off so that we don't inadvertently plot into the axes again
% Also, make the axes invisible
set(ha,'handlevisibility','off', ...
            'visible','off')
%To adjust transparency of background image.
set(hi,'alphadata',.7)
%------------------------------------------

% --- Executes on button press in pbPreview.
function pbPreview_Callback(hObject, eventdata, handles)
% hObject    handle to pbPreview (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% choose which webcam (winvideo-1) and which  mode (YUY2_176x144)
global vid
%vid = videoinput('winvideo', 1, 'YUY2_176x144');
vid = videoinput('winvideo');
src=getselectedsource(vid);
% only capture one frame per trigger, we are not recording a video
vid.FramesPerTrigger = 1;
% output would image in RGB color space
vid.ReturnedColorspace = 'rgb';
% tell matlab to start the webcam on user request, not automatically
triggerconfig(vid, 'manual');
% we need this to know the image height and width
vidRes = get(vid, 'VideoResolution');
% image width
imWidth = vidRes(1);
% image height
imHeight = vidRes(2);
% number of bands of our image (should be 3 because it's RGB)
nBands = get(vid, 'NumberOfBands');
% create an empty image container and show it on axPreview
hImage = image(zeros(imHeight, imWidth, nBands), 'parent', handles.axPreview);
% begin the webcam preview
preview(vid, hImage);


% --- Executes on button press in pbCapture.
function pbCapture_Callback(hObject, eventdata, handles)
% hObject    handle to pbCapture (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global vid
% prepare for capturing the image preview
start(vid); 
% pause for 3 seconds to give our webcam a "warm-up" time
pause(1); 
% do capture!
trigger(vid);
% stop the preview
stoppreview(vid);
% get the captured image data and save it on capt1 variable
capt1 = getdata(vid);
% capt1=imcrop(capt1,[0 207 352 720]);
% now write capt1 into file named captured.png
imwrite(capt1, 'frame.png');
imshow(capt1);
% just dialog that we are done capturing
warndlg('Image captured!');
