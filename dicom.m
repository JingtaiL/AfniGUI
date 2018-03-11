function varargout = dicom(varargin)
% DICOM MATLAB code for dicom.fig
%      DICOM, by itself, creates a new DICOM or raises the existing
%      singleton*.
%
%      H = DICOM returns the handle to a new DICOM or the handle to
%      the existing singleton*.
%
%      DICOM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DICOM.M with the given input arguments.
%
%      DICOM('Property','Value',...) creates a new DICOM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before dicom_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to dicom_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help dicom

% Last Modified by GUIDE v2.5 06-Dec-2015 14:28:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @dicom_OpeningFcn, ...
                   'gui_OutputFcn',  @dicom_OutputFcn, ...
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


% --- Executes just before dicom is made visible.
function dicom_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to dicom (see VARARGIN)

% Choose default command line output for dicom
handles.output = hObject;
axes(handles.axes1);
imshow('logo.png');
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes dicom wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = dicom_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in nii_checkbox1.
function nii_checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to nii_checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of nii_checkbox1

    


function input_edit1_Callback(hObject, eventdata, handles)
% hObject    handle to input_edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of input_edit1 as text
%        str2double(get(hObject,'String')) returns contents of input_edit1 as a double


% --- Executes during object creation, after setting all properties.
function input_edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input_edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function name_edit2_Callback(hObject, eventdata, handles)
% hObject    handle to name_edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of name_edit2 as text
%        str2double(get(hObject,'String')) returns contents of name_edit2 as a double


% --- Executes during object creation, after setting all properties.
function name_edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to name_edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in generate_pushbutton1.
function generate_pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to generate_pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

nii=get(handles.nii_checkbox1,'Value');
infile=get(handles.input_edit1,'String');
output=get(handles.name_edit2,'String');
loop=get(handles.loop_checkbox2,'Value');
parent=get(handles.parent_edit3,'String');

if loop==1
    if nii==1
        fprintf('This line of command is generated for converting DICOM format to NIFTI format for multiple folders, ');
        fprintf('please check your directory to find the generated "Dicom2Nii.txt" file. \n');
        if exist('Dicom2Nii.txt','file')
            warningMessage=sprintf('Warning: file does exist:\n%s','Dicom2Nii')
            uiwait(msgbox(warningMessage));
        else
            fid=fopen('Dicom2Nii.txt','a+');
            fprintf (fid,'#!/bin/tcsh\n');
            fprintf (fid,'mkdir %s\n',output);
            fprintf (fid,'foreach ser (%s)\n',parent);
            fprintf (fid,'  cd ./${ser}\n'); 
            fprintf (fid,'  echo "**** Converting DICOM data for ""${ser}"" ****"\n');
            fprintf(fid,'  Dimon -infile_pattern ''%s'' -gert_create_dataset -gert_write_as_nifti -dicom_org\n',...
            infile);
            fprintf(fid,'  mv OutBrick_run*.nii ../%s\n',output);
            fprintf (fid,'  cd ..\n');
            fprintf (fid,'end\n');
            fclose(fid);
        end
    else
        fprintf('This line of command is generated for converting DICOM format to BRIK/HEAD format for multiple folders, ');
        fprintf('please check your directory to find the generated "Dicom2Afni.txt" file. \n');
         if exist('Dicom2Afni.txt','file')
            warningMessage=sprintf('Warning: file does exist:\n%s','Dicom2Afni')
            uiwait(msgbox(warningMessage));
        else
            fid=fopen('Dicom2Afni.txt','a+');
            fprintf (fid,'#!/bin/tcsh\n');
            fprintf (fid,'mkdir %s\n',output);
            fprintf (fid,'foreach ser (%s)\n',parent);
            fprintf (fid,'  cd ./${ser}\n'); 
            fprintf (fid,'  echo "**** Converting DICOM data for ""${ser}"" ****"\n');
            fprintf(fid,'  Dimon -infile_pattern ''%s'' -gert_create_dataset -dicom_org\n',...
            infile);
            fprintf(fid,'  mv OutBrick_run* ../%s\n',output);
            fprintf (fid,'  cd ..\n');
            fprintf (fid,'end\n');
            fclose(fid);
         end
    end
else
    if nii==1
        fprintf('This line of command is generated for converting DICOM format to NIFTI format, ');
        fprintf('please copy it to your unix command line: \n');
        fprintf('\nDimon -infile_pattern ''%s'' -gert_create_dataset -dicom_org -gert_write_as_nifti -gert_to3d_prefix %s\n',...
            infile,output);
    else
        fprintf('This line of command is generated for converting DICOM format to BRIK/HEAD format, ');
        fprintf('please copy it to your unix command line: \n');
        fprintf('\nDimon -infile_pattern ''%s'' -gert_create_dataset -dicom_org -gert_to3d_prefix %s\n',...
            infile,output);
    end
end



% --- Executes on button press in loop_checkbox2.
function loop_checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to loop_checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of loop_checkbox2



function parent_edit3_Callback(hObject, eventdata, handles)
% hObject    handle to parent_edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of parent_edit3 as text
%        str2double(get(hObject,'String')) returns contents of parent_edit3 as a double


% --- Executes during object creation, after setting all properties.
function parent_edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to parent_edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in OpenAfni_pushbutton2.
function OpenAfni_pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to OpenAfni_pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disp('AFNI is openning......');
[status,cmdout]=unix('csh -c "afni &"');
cmdout;


% --- Executes on button press in UberSub_pushbutton3.
function UberSub_pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to UberSub_pushbutton3 (see GCBO)
disp('Uber_Subject.py is openning......');
[status,cmdout]=unix('csh -c "uber_subject.py"');
cmdout;
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in info_pushbutton4.
function info_pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to info_pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disp('This script is generated to help you to extract useful information such as TR, slice numbers from data...');
disp('You can input your file name from "*MRDC" in "Local Variables" portion...');
disp('Kind remind: don''t forget to append ".BRIK" to your data name (if using AFNI format)...');
fprintf('Copy this line of script to your command window and execute it to see the magic:\n');
fprintf('\n');
infile=get(handles.input_edit1,'String');
fprintf('3dinfo -prefix -n4 -tr -ad3 -space -orient -is_oblique -slice_timing -hdr -echo_edu %s -history\n',...
    infile);


% --- Executes on button press in outlier_pushbutton5.
function outlier_pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to outlier_pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disp ('This script is generated to find out outliers after executing 3dToutcount command...');
prompt=' what threshold(fraction) you want to set? ';
thres=input(prompt);
fprintf('\n1deval -a outcount_rall.1D -expr ''t*step(a-%0.2f)'' | grep -v ''0''\n',thres);

% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in outlier_plot_pushbutton6.
function outlier_plot_pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to outlier_plot_pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disp ('This script is generated to find out outliers visually...');
prompt1=' how many TRs? ';
prompt2=' what threshold(fraction) you want to set? ';
thres=input(prompt2);
TR=input(prompt1);
fprintf('\n1dplot -one ''1D: %d@%0.2f'' outcount_rall.1D\n',TR,thres);


% --- Executes on button press in despike_pushbutton7.
function despike_pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to despike_pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disp ('This script is generated to remove spikes and help you to visualize the differences after despiking via AFNI...');
prompt1= ' provide prefix for the despiked data: ';
prompt2= ' provide data name you want to despike (format: name+orig): ';
prompt3= ' provide prefix for spikiness-saved data: ';
fprintf('\n');
pre=input(prompt1,'s');
data=input(prompt2,'s');
save=input(prompt3,'s');
fprintf('\n3dDespike -prefix %s -ssave %s %s\n',pre,save,data);
fprintf('\n');
fprintf(' A second approach to remove spikes : add "-CENSORTR 2:37 5: 128 " to your 3dDeconvolve, 2: run number; 37: volume number.\n');
fprintf(' To view "spikiness" for each voxel as an overlay, go to  http://psych290z.wikispaces.com/Lab+1-+AFNI \n');


% --- Executes on button press in afni2nii_pushbutton8.
function afni2nii_pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to afni2nii_pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disp('Actually this script is not used to check normalization result in AFNI, instead it will convert afni format to nii format');
fprintf('I realized it is better to use SPM to check normalization result, so use SPM!\n');
fprintf('\n 3dAFNItoNIFTI -prefix outputname.nii -verb input.BRIK\n');

% --- Executes on selection change in tta2mni_listbox2.
function tta2mni_listbox2_Callback(hObject, eventdata, handles)
% hObject    handle to tta2mni_listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns tta2mni_listbox2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from tta2mni_listbox2
option=get(handles.tta2mni_listbox2,'Value');
if (option==1)
    fprintf('3dWarp -tta2mni -prefix newdata.mni inputdata.tlrc\n');
elseif (option==2)
    fprintf('3dWarp -mni2tta -prefix newdata.tlrc inputdata.mni\n');
elseif (option==3)
    fprintf('This sample script is generated to warp +tlrc results back to +orig space...\n');
    fprintf('cat_matvec subj1_anat+tlrc::WARP_DATA > tlrc_xform.1D\n');
    fprintf('3dWarp -matvec_out2in tlrc_xform.1D -prefix group_warped+tlrc -gridset subj1_epi+orig -cubic group_data+tlrc\n');
    fprintf('3drefit -view orig group_warped+tlrc\n');
end
    

% --- Executes during object creation, after setting all properties.
function tta2mni_listbox2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tta2mni_listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in maskoverlap_pushbutton11.
function maskoverlap_pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to maskoverlap_pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
A=get(handles.input_edit1,'String');
B=get(handles.name_edit2,'String');
fprintf('This script is generated to compute overlaps between A and B masks...\n');
fprintf('Use "local variables" to input the names of masks you want to compare...\n');
fprintf('\n3dABoverlap -no_automask %s+tlrc %s+tlrc | & tee out.mask_overlap.txt\n',A,B);


% --- Executes on button press in int_mask_pushbutton12.
function int_mask_pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to int_mask_pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
input=get(handles.input_edit1,'String');
output=get(handles.name_edit2,'String');
fprintf('Generate scripts for creating intersection mask, use "Local" to input data file names (use regualr expression,indicate which space) and give output name...\n');
fprintf('\n3dmask_tool -input %s.HEAD -prefix %s -frac 1\n',input,output); 


% --- Executes on button press in unionmask_pushbutton13.
function unionmask_pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to unionmask_pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
input=get(handles.input_edit1,'String');
output=get(handles.name_edit2,'String');
fprintf('Generate scripts for creating union mask, use "Local" to input data file names (use regualr expression,indicate which space) and give output names...\n');
fprintf('\n3dmask_tool -input %s.HEAD -prefix %s -frac 0\n',input,output); 


% --- Executes on button press in ss_review_pushbutton14.
function ss_review_pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to ss_review_pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fprintf('This script is generating a table from @ss_review_basic output files across subjects...\n');
fprintf('\ngen_ss_review_table.py -tablefile review_table.xls -infiles group.*/subj.*/*.results/out.ss_review.*\n');


% --- Executes on button press in mask_activation_pushbutton16.
function mask_activation_pushbutton16_Callback(hObject, eventdata, handles)
% hObject    handle to mask_activation_pushbutton16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fprintf('Before running this script, make sure the Clust_mask+tlrc.HEAD/BRIK files are existed\n')
fprintf('find "/path/to/dir" -type f -exec echo Found file {} \n');
fprintf('\n');
prompt1=' Which cluster you want to save (ordered by size)? ';
cluster=input(prompt1);
fprintf('3dmaskave -mask Clust_mask+tlrc.HEAD''<%d> mydataset+tlrc.HEAD\n',cluster);



% --- Executes on button press in Single_ROI_pushbutton17.
function Single_ROI_pushbutton17_Callback(hObject, eventdata, handles)
% hObject    handle to Single_ROI_pushbutton17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fprintf('If you want to use template brain (e.g. Colin27 template) as base image, use `@GetAfniBin`/TT_N27+tlrc.HEAD as input data\n');
rsize=' Input the radius size: ';
xcor=' x coordinate: ';
ycor=' y coordinate: ';
zcor=' z coordinate: ';
infile=' Your input data: ';
output=' Your output name: ';
pro1=input(rsize);
rsqr=pro1^2;
pro2=input(xcor);
pro3=input(ycor);
pro4=input(zcor);
pro5=input(infile,'s');
pro6=input(output,'s');
fprintf('3dcalc -LPI -a %s -expr ''step(%d-(x-(%d))*(x-(%d))-(y-(%d))*(y-(%d))-(z-(%d))*(z-(%d)))'' -prefix %s\n',pro5,rsqr,pro2,pro2,...
    pro3,pro3,pro4,pro4,pro6);

% --- Executes on button press in Multiple_ROI_pushbutton19.
function Multiple_ROI_pushbutton19_Callback(hObject, eventdata, handles)
% hObject    handle to Multiple_ROI_pushbutton19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fprintf('Before applying this script, saving your coordinates into a 1D file.\n');
infile=' Your input data (name+orig/tlrc): ';
output=' Your output name: ';
r=' Input your radius size: ';
dfile=' Your coordinates-saved file: ';
infile=input(infile,'s');
outfile=input(output,'s');
rsize=input(r);
filename=input(dfile,'s');
fprintf('3dUndump -prefix %s -orient LPI -master %s.HEAD -srad %d -xyz %s\n',outfile,infile,rsize,filename);

% --- Executes on button press in Atlas_pushbutton20.
function Atlas_pushbutton20_Callback(hObject, eventdata, handles)
% hObject    handle to Atlas_pushbutton20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1
