function varargout = ortho_guide(varargin)
% ORTHO_GUIDE MATLAB code for ortho_guide.fig
%      ORTHO_GUIDE, by itself, creates a new ORTHO_GUIDE or raises the existing
%      singleton*.
%
%      H = ORTHO_GUIDE returns the handle to a new ORTHO_GUIDE or the handle to
%      the existing singleton*.
%
%      ORTHO_GUIDE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ORTHO_GUIDE.M with the given input arguments.
%
%      ORTHO_GUIDE('Property','Value',...) creates a new ORTHO_GUIDE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ortho_guide_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ortho_guide_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ortho_guide

% Last Modified by GUIDE v2.5 06-Jul-2014 18:41:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ortho_guide_OpeningFcn, ...
                   'gui_OutputFcn',  @ortho_guide_OutputFcn, ...
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


% --- Executes just before ortho_guide is made visible.
function ortho_guide_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ortho_guide (see VARARGIN)

% Choose default command line output for ortho_guide
handles.DTM_Ymax = [];
handles.DTM_Xmin = [];
handles.DTM_D = [];
handles.DTM = [];
handles.io = [];
handles.eo = [];
handles.d = [];
handles.AffCoe = [];
handles.pixelsize = [];
handles.int_method = 'Nearest';
handles.ioindlg = {'0','0','0','0','0'};
handles.eoindlg = {'0','0','0','0','0','0'};
handles.affindlg = {'0','0','0','0','0','0'};
handles.fid4indlg = {'x y i j','x y i j','x y i j','x y i j'};
handles.fid8indlg = {'x y i j','x y i j','x y i j','x y i j','x y i j','x y i j','x y i j','x y i j'};

handles.output = hObject;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ortho_guide wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ortho_guide_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%       FILE MENU      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function image_menu_Callback(hObject, eventdata, handles)
% hObject    handle to image_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------
function load_image_Callback(hObject, eventdata, handles)
% hObject    handle to load_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[imfilename, pathname] = uigetfile({'*.tif;*.jpg;*.png;*.bmp','Image Files (*.tif;*.jpg;*.png;*.bmp)'},'Select Image');
if imfilename == 0
    return
else
    pwt = msgbox('Image is loading, please wait.');
    
    fullpathname = strcat(pathname, imfilename);
    im = imread(fullpathname);

    set(handles.txtbox_groundel,'Enable','on');
    set(handles.interpolation_method,'Enable','on');
    set(handles.ortho,'Enable','on');
    set(handles.camera_orientation_menu,'Enable','on');
    set(handles.dtm_menu,'Enable','on');
    set(handles.manual_input,'Enable','on');
    set(handles.load_image,'Checked','on');
    handles.im = im;
    handles.imfilename = imfilename;
    guidata(hObject,handles);
    
    if ishandle(pwt)
        delete(pwt);
    end
end




% --------------------------------------------------------------------
function save_rec_image_Callback(hObject, eventdata, handles)
% hObject    handle to save_rec_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

imfilename = handles.imfilename;

[filename, pathname] = uiputfile({'*.tif'; '*.jpg'; '*.png'},'Select Save Location',['Ortho_' imfilename]);
if filename == 0
    return
else
    fullpathname = strcat(pathname, filename);
    ortho_im = handles.ortho_im;
    imwrite(ortho_im,fullpathname);
    world_file = handles.world_file;
    
    if ~isempty(strfind(fullpathname, '.tif'))
        
        dlmwrite(strrep(fullpathname, '.tif', '.tfw'),world_file,'precision',12)
        
    elseif ~isempty(strfind(fullpathname, '.jpg'))
        
        dlmwrite(strrep(fullpathname, '.jpg', '.jgw'),world_file,'precision',12)
        
    elseif ~isempty(strfind(fullpathname, '.png'))
        
        dlmwrite(strrep(fullpathname, '.png', '.pgw'),world_file,'precision',12)
        
    end

dtmfilename = handles.dtmfilename;
iofilename = handles.iofilename;
eofilename = handles.eofilename;
DTM = handles.DTM;
d = handles.d;
int_method = handles.int_method;
AffCoe = handles.AffCoe;
io = handles.io;
eo = handles.eo;
pixelsize = handles.pixelsize;
    if (size(DTM,2) == 3)
        DTM_Xmin = min(DTM(:,1));
        DTM_Ymax = max(DTM(:,2));
        DTM_Xmax = max(DTM(:,1));
        DTM_Ymin = min(DTM(:,2));
        DTM_D = [];

    else
        DTM_D = handles.DTM_D;
        DTM_Xmin = handles.DTM_Xmin;
        DTM_Ymax = handles.DTM_Ymax;
        DTM_Xmax = (size(DTM,2)-1)*DTM_D + DTM_Xmin;
        DTM_Ymin = DTM_Ymax - (size(DTM,1)-1)*DTM_D;

    end


    if ~isempty(strfind(filename, '.tif'))

        save_georef([pathname 'Georeferencing Results for ' strrep(filename, '.tif', '.txt')],...
            imfilename,dtmfilename,iofilename,eofilename,DTM_Xmin,DTM_Ymax,DTM_Xmax,DTM_Ymin,DTM_D,d,int_method,AffCoe,io,eo,pixelsize)

    elseif ~isempty(strfind(filename, '.jpg'))

        save_georef([pathname 'Georeferencing Results for ' strrep(filename, '.jpg', '.txt')],...
            imfilename,dtmfilename,iofilename,eofilename,DTM_Xmin,DTM_Ymax,DTM_Xmax,DTM_Ymin,DTM_D,d,int_method,AffCoe,io,eo,pixelsize)
    elseif ~isempty(strfind(filename, '.png'))

        save_georef([pathname 'Georeferencing Results for ' strrep(filename, '.png', '.txt')],...
            imfilename,dtmfilename,iofilename,eofilename,DTM_Xmin,DTM_Ymax,DTM_Xmax,DTM_Ymin,DTM_D,d,int_method,AffCoe,io,eo,pixelsize)
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%       CAMERA MENU      %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function camera_orientation_menu_Callback(hObject, eventdata, handles)
% hObject    handle to camera_orientation_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------
function load_io_Callback(hObject, eventdata, handles)
% hObject    handle to load_io (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[iofilename, pathname] = uigetfile({'*.txt'},'Select Interior Orientation');
if iofilename == 0
    return
else
    
    fullpathname = strcat(pathname, iofilename);
    file = (fullpathname);
    fid = fopen(file);
    data = textscan(fid,('%s %f %f'),'delimiter',' ');
    fdata = [data{1,2} data{1,3}];
    
    choice = questdlg('Please select source image type.','Image Type','Digital','Analog','Analog');
	switch choice
        case 'Digital' %Affine coe calculation for digital image

            image_type=1;
            
            x = inputdlg('Enter sensor pixel size(mm):',...
             'Pixel Size');
            if isempty(x)

                msgbox('Pixel size not selected.')
                return
            
            elseif isempty(str2num(x{:}))

                msgbox('Pixel size not selected.')
                return
            
            else
                
                im = handles.im;
                pixelsize = (str2num(x{:}));
                AffCoe = [1/pixelsize ; 0 ; size(im,2)/2 ; 0 ; -1/pixelsize ; size(im,1)/2];

                handles.AffCoe = AffCoe;
                handles.pixelsize = pixelsize;
    
            end

        case 'Analog'

            image_type=2;
    end
    
    if image_type == 1 %Interior orientation for digital image

        io = fdata(1:5,1);
        
        handles.io = io;
        handles.iofilename = iofilename;
        guidata(hObject,handles);
        
    elseif image_type == 2 %Interior orientation for analog image
        
        if isnan(sum(fdata(6:11,1))) %Affine coe check

            io = fdata(1:5,1);
            
            if size(fdata,1) == 19 %4 fiducials, affine calculation
                
                xy = fdata(12:15,:);
                ij =fdata(16:19,:);
                [AffCoe,so,Residuals,CoeError] = affine_trans(ij,xy);

            elseif size(fdata,1) == 27 %8 fiducials, affine calculation
                
                xy = fdata(12:19,:);
                ij =fdata(20:27,:);
                [AffCoe,so,Residuals,CoeError] = affine_trans(ij,xy);

            end
            
            handles.AffCoe = AffCoe;
            handles.so = so;
            handles.Residuals = Residuals;
            handles.CoeError = CoeError;
            handles.io = io;
            handles.iofilename = iofilename;
            guidata(hObject,handles);

            set(handles.save_affine, 'Enable', 'on');
            msgbox('Affine Coefficients have been calculated.')
            
        else
            
            fdata = data{1,2}; %Affine coe exists in the txt
            io = fdata(1:5,1);
            AffCoe=fdata(6:11,1);

            handles.AffCoe = AffCoe;
            handles.io = io;
            handles.iofilename = iofilename;
            guidata(hObject,handles);
        end
    end
    set(handles.load_io,'Checked','on');
end


% --------------------------------------------------------------------
function load_eo_Callback(hObject, eventdata, handles)
% hObject    handle to load_eo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[eofilename, pathname] = uigetfile({'*.txt'},'Select Exterior Orientation');
if eofilename == 0
    return
else
    fullpathname = strcat(pathname, eofilename);
    file = (fullpathname);
    fid = fopen(file);
    data = textscan(fid,('%s %f'),'delimiter',' ');
    eo = data{1,2};
    fclose(fid);
    
    set(handles.load_eo,'Checked','on');
    handles.eo = eo;
    handles.eofilename = eofilename;
    guidata(hObject,handles);

end

% --------------------------------------------------------------------
function save_affine_Callback(hObject, eventdata, handles)
% hObject    handle to save_affine (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename, pathname]=uiputfile({'*.txt'},'Select Save Location','Affine Transformation Results');
if filename == 0
    return
else
    AffCoe = handles.AffCoe;
    CoeError = handles.CoeError;
    so = handles.so;
    Residuals = handles.Residuals;
    
    save_affine(strcat(pathname, filename),AffCoe,CoeError,so,Residuals)
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%       DTM MENU      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function dtm_menu_Callback(hObject, eventdata, handles)
% hObject    handle to dtm_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------
function load_dtm_Callback(hObject, eventdata, handles)
% hObject    handle to load_dtm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[dtmfilename, pathname] = uigetfile({'*.txt'},'Select DTM');
if dtmfilename == 0
    return
else
    pwt = msgbox('DTM is loading, please wait.');
        
    fullpathname = strcat(pathname, dtmfilename);
    DTM = load(fullpathname);

    handles.DTM = DTM;
    handles.dtmfilename = dtmfilename;
    guidata(hObject,handles);
    
    if (size(DTM,2) == 3)
        set(handles.txtbox_dtm_ymax,'Enable','off');
        set(handles.txtbox_dtm_xmin,'Enable','off');
        set(handles.txtbox_dtm_d,'Enable','off');


        DTM_Ymax = 0;
        DTM_Xmin = 0;
        DTM_D = 0;

        handles.DTM_Ymax = DTM_Ymax;
        handles.DTM_Xmin = DTM_Xmin;
        handles.DTM_D = DTM_D;
        guidata(hObject,handles);
    else
        set(handles.txtbox_dtm_ymax,'Enable','on');
        set(handles.txtbox_dtm_xmin,'Enable','on');
        set(handles.txtbox_dtm_d,'Enable','on');
    end
    
    if ishandle(pwt)
        delete(pwt);
    end
    
	set(handles.show_dtm,'Enable','on');
    set(handles.load_dtm,'Checked','on');
end

% --------------------------------------------------------------------
function show_dtm_Callback(hObject, eventdata, handles)
% hObject    handle to show_dtm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
DTM = handles.DTM;
if (size(DTM,2) == 3)    
    dt = delaunay(DTM(:,1),DTM(:,2));
    figure;
    trisurf(dt, DTM(:,1), DTM(:,2), DTM(:,3));
else
	DTM_Ymax = handles.DTM_Ymax;
	DTM_Xmin = handles.DTM_Xmin;
    DTM_D = handles.DTM_D;
    
    if isempty(DTM_Ymax) || isempty(DTM_Xmin) || isempty(DTM_D)
        msgbox('Please input DTM information first.')
    else
        for j = 1:size(DTM,2)    
            x(j,1) = DTM_Xmin + DTM_D*j - DTM_D;
        end


        for i = 1:size(DTM,1)

            xyz(size(DTM,2)*i+1-size(DTM,2):i*size(DTM,2),1) = x;    
            xyz(size(DTM,2)*i+1-size(DTM,2):i*size(DTM,2),2) = DTM_Ymax - DTM_D*i + DTM_D;
            xyz(size(DTM,2)*i+1-size(DTM,2):i*size(DTM,2),3) = DTM(i,:)';

        end
        dt = delaunay(xyz(:,1),xyz(:,2));
        figure;
        trisurf(dt, xyz(:,1), xyz(:,2), xyz(:,3));
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%% MANUAL INPUT MENU  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function manual_input_Callback(hObject, eventdata, handles)
% hObject    handle to manual_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function manual_io_Callback(hObject, eventdata, handles)
% hObject    handle to manual_io (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

ioindlg = handles.ioindlg;
x = inputdlg({'xo(mm):','yo(mm):','c(mm):','k1:','k2:'},...
    'Interior Orientation',[1 36],ioindlg);

if isempty(x)

	return
            
else
                
	io(1,1) = str2num(x{1,1});
	io(2,1) = str2num(x{2,1});
	io(3,1) = str2num(x{3,1});
	io(4,1) = str2num(x{4,1});
	io(5,1) = str2num(x{5,1});
                
	handles.io = io;
    handles.ioindlg = {num2str(io(1,1)),num2str(io(2,1)),num2str(io(3,1)),num2str(io(4,1)),num2str(io(5,1))};
    handles.iofilename = 'Manual input';
	guidata(hObject,handles);
end

% --------------------------------------------------------------------
function manual_eo_Callback(hObject, eventdata, handles)
% hObject    handle to manual_eo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

eoindlg = handles.eoindlg;
x = inputdlg({'X(m):','Y(m):','Z(m):','omega(deg):','phi(deg):','kappa(deg):'},...
    'Exterior Orientation',[1 36],eoindlg);

if isempty(x)
    
	return
            
else
                
	eo(1,1) = str2num(x{1,1});
	eo(2,1) = str2num(x{2,1});
	eo(3,1) = str2num(x{3,1});
	eo(4,1) = str2num(x{4,1});
	eo(5,1) = str2num(x{5,1});
    eo(6,1) = str2num(x{6,1});  
    
	handles.eo = eo;
    handles.eoindlg = {num2str(eo(1,1)),num2str(eo(2,1)),num2str(eo(3,1)),num2str(eo(4,1)),num2str(eo(5,1)),num2str(eo(6,1))};
    handles.eofilename = 'Manual input';
	guidata(hObject,handles);
end
% --------------------------------------------------------------------
function manual_affine_Callback(hObject, eventdata, handles)
% hObject    handle to manual_affine (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

affindlg = handles.affindlg;
x = inputdlg({'a1:','b1:','dx:','a2:','b2:','dy:'},...
    'Affine Coefficients',[1 36],affindlg);

if isempty(x)

	return
            
else
                
	AffCoe(1,1) = str2num(x{1,1});
	AffCoe(2,1) = str2num(x{2,1});
	AffCoe(3,1) = str2num(x{3,1});
	AffCoe(4,1) = str2num(x{4,1});
	AffCoe(5,1) = str2num(x{5,1});
    AffCoe(6,1) = str2num(x{6,1});  
    
    handles.AffCoe = AffCoe;
    handles.affindlg = {num2str(AffCoe(1,1)),num2str(AffCoe(2,1)),num2str(AffCoe(3,1)),num2str(AffCoe(4,1)),num2str(AffCoe(5,1)),num2str(AffCoe(6,1))};
	guidata(hObject,handles);
end

% --------------------------------------------------------------------
function manual_fiducials_Callback(hObject, eventdata, handles)
% hObject    handle to manual_fiducials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


choice = questdlg('Please select the number of fiducial points.','Fiducials','4 points','8 points','4 points');
	switch choice
        case '4 points'
            
            fid4indlg = handles.fid4indlg;
            x = inputdlg({'P1(mm,pixels):','P2(mm,pixels):','P3(mm,pixels):','P4(mm,pixels):'},...
                'Fiducials',[1 36],fid4indlg);

            if isempty(x)

                return
                
            elseif isempty(str2num(x{1,:})) || isempty(str2num(x{2,:})) || isempty(str2num(x{3,:})) || isempty(str2num(x{4,:}))

                return
                
            else
                
                xyij4(1,:) = str2num(x{1});
                xyij4(2,:) = str2num(x{2});
                xyij4(3,:) = str2num(x{3});
                xyij4(4,:) = str2num(x{4});
                
                [AffCoe,so,Residuals,CoeError] = affine_trans(xyij4(:,3:4),xyij4(:,1:2));
                msgbox('Affine Coefficients have been calculated.')
                
                handles.AffCoe = AffCoe;
                handles.so = so;
                handles.Residuals = Residuals;
                handles.CoeError = CoeError;
                handles.fid4indlg = {num2str(xyij4(1,:)),num2str(xyij4(2,:)),num2str(xyij4(3,:)),num2str(xyij4(4,:))};
                guidata(hObject,handles);

                set(handles.save_affine, 'Enable', 'on');
            end 
            
        case '8 points'
            
            fid8indlg = handles.fid8indlg;
            x = inputdlg({'P1(mm,pixels):','P2(mm,pixels):','P3(mm,pixels):','P4(mm,pixels):','P5(mm,pixels):','P6(mm,pixels):','P7(mm,pixels):','P8(mm,pixels):'},...
                'Fiducials',[1 36],fid8indlg);
            
            if isempty(x)

                return
                
            elseif isempty(str2num(x{1,:})) || isempty(str2num(x{2,:})) || isempty(str2num(x{3,:})) || isempty(str2num(x{4,:})) || isempty(str2num(x{5,:})) || isempty(str2num(x{6,:})) || isempty(str2num(x{7,:})) || isempty(str2num(x{8,:}))

                return
                
            else
                
                xyij8(1,:) = str2num(x{1});
                xyij8(2,:) = str2num(x{2});
                xyij8(3,:) = str2num(x{3});
                xyij8(4,:) = str2num(x{4});
                xyij8(5,:) = str2num(x{5});
                xyij8(6,:) = str2num(x{6});
                xyij8(7,:) = str2num(x{7});
                xyij8(8,:) = str2num(x{8});
                
                [AffCoe,so,Residuals,CoeError] = affine_trans(xyij8(:,3:4),xyij8(:,1:2));
                msgbox('Affine Coefficients have been calculated.')
                
                handles.AffCoe = AffCoe;
                handles.so = so;
                handles.Residuals = Residuals;
                handles.CoeError = CoeError;
                handles.fid8indlg = {num2str(xyij8(1,:)),num2str(xyij8(2,:)),num2str(xyij8(3,:)),num2str(xyij8(4,:)),num2str(xyij8(5,:)),num2str(xyij8(6,:)),num2str(xyij8(7,:)),num2str(xyij8(8,:))};
                guidata(hObject,handles);

                set(handles.save_affine, 'Enable', 'on');
            end          
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%       POP-UP MENUS     %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Executes on selection change in interpolation_method.
function interpolation_method_Callback(hObject, eventdata, handles)
% hObject    handle to interpolation_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns interpolation_method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from interpolation_method

contents = (get(hObject,'Value'));

if contents == 1
    int_method = 'Nearest';
elseif contents == 2
    int_method = 'Bilinear';
elseif contents == 3
    int_method = 'Bicubic';
end

handles.int_method = int_method;
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function interpolation_method_CreateFcn(hObject, eventdata, handles)
% hObject    handle to interpolation_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%       TXTBOX MENUS     %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function txtbox_groundel_Callback(hObject, eventdata, handles)
% hObject    handle to txtbox_groundel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtbox_groundel as text
%        str2double(get(hObject,'String')) returns contents of txtbox_groundel as a double

d = str2double(get(hObject,'String'));
handles.d = d;
guidata(hObject,handles);
% --- Executes during object creation, after setting all properties.
function txtbox_groundel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtbox_groundel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function txtbox_dtm_d_Callback(hObject, eventdata, handles)
% hObject    handle to txtbox_dtm_d (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtbox_dtm_d as text
%        str2double(get(hObject,'String')) returns contents of txtbox_dtm_d as a double

DTM_D = str2double(get(hObject,'String'));
handles.DTM_D = DTM_D;
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function txtbox_dtm_d_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtbox_dtm_d (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function txtbox_dtm_xmin_Callback(hObject, eventdata, handles)
% hObject    handle to txtbox_dtm_xmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtbox_dtm_xmin as text
%        str2double(get(hObject,'String')) returns contents of txtbox_dtm_xmin as a double

DTM_Xmin = str2double(get(hObject,'String'));
handles.DTM_Xmin = DTM_Xmin;
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function txtbox_dtm_xmin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtbox_dtm_xmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function txtbox_dtm_ymax_Callback(hObject, eventdata, handles)
% hObject    handle to txtbox_dtm_ymax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtbox_dtm_ymax as text
%        str2double(get(hObject,'String')) returns contents of txtbox_dtm_ymax as a double

DTM_Ymax = str2double(get(hObject,'String'));
handles.DTM_Ymax = DTM_Ymax;
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function txtbox_dtm_ymax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtbox_dtm_ymax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%       BUTTONS      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in ortho.
function ortho_Callback(hObject, eventdata, handles)
% hObject    handle to ortho (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


im = handles.im;
DTM = handles.DTM;
io = handles.io;
eo = handles.eo;
d = handles.d;
AffCoe = handles.AffCoe;
DTM_Ymax = handles.DTM_Ymax;
DTM_Xmin = handles.DTM_Xmin;
DTM_D = handles.DTM_D;
int_method = handles.int_method;

if isempty(DTM) || isempty(io) || isempty(eo) || isempty(d) || isempty(AffCoe) || isempty(DTM_Ymax) || isempty(DTM_Xmin) || isempty(DTM_D)
	
    msgbox('Not enough data.','','error')
	return
    
else
    
    [world_file,ortho_im] = orthorectification(im,DTM,io,eo,d,AffCoe,DTM_Ymax,DTM_Xmin,DTM_D,int_method);

    if isempty(world_file) || isempty(ortho_im)
        return
    else
        handles.world_file = world_file;
        handles.ortho_im = ortho_im;
        guidata(hObject,handles);

        set(handles.save_rec_image,'Enable','on');
    end
end
