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
seeg_data = edfread(file_path);
disp(seeg_data)

% params.Fs = seeg_data.Duration