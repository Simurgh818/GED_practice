%%
% Generalized Eigendecomposition (GED) Practice
%
%
% Sina Dabiri (sdabiri@emory.edu)
%% Preprocessing
% 1- epoching? 30 sec ?
% 2- Bandpass filtering: 2-300 Hz?
% 3- Baseline correction: high pass filtering to remove DC shift
% 4- GED calculation
% 5- Visualization and plotting


% a clear MATLAB workspace is a clear mental workspace
close all; clear, clc

%define root dir (where project data is) and sessions of interest:
root_dir='C:\Users\sinad\OneDrive - Emory University\Dr.Drane\Cognitive Mapping\Subject01';
file_path = fullfile(root_dir, "Subject_001-RestingState.EDF");
[seeg_info, seeg_data] = edfread(file_path);
% disp(seeg_info)

params.Fs = seeg_info.samples(1)/seeg_info.duration;
nCh = seeg_info.ns;
time_seg = 30; %for a 10 sec segment

Num_samples=time_seg*params.Fs;
temp_data = zeros(round(Num_samples),1);
for i=1:Num_samples+1
        temp_data(i)=seeg_data(1,i+round(time_seg*params.Fs));
end

T = 1/params.Fs;
[L,~] = size(temp_data);
t = (0:L-1)*T(1);
figure(1)
subplot(2,2,1)
plot(t,temp_data)
xlabel("time (sec)")
ylabel("Amp (uV)")
title(seeg_info.label(1)+" raw")