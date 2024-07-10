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
file_path_ref = fullfile(root_dir, "Subject_001-RestingState_1min.EDF");
[seeg_info_ref, seeg_data_ref] = edfread(file_path_ref);
% disp(seeg_info)
file_path_sig = fullfile(root_dir, "Subject_001_task_1min.EDF");
[seeg_info_sig, seeg_data_sig] = edfread(file_path_sig);

params.Fs = seeg_info_ref.samples(1)/seeg_info_ref.duration;
nCh = seeg_info_ref.ns;
time_seg = 30; %for a 10 sec segment

% TODO: get all of the channels

Num_samples=time_seg*params.Fs;
temp_data_ref = zeros(nCh, round(Num_samples));
temp_data_sig = zeros(nCh, round(Num_samples));
for i=1:Num_samples+1
        temp_data_ref(:,i)=seeg_data_ref(:,i+round(time_seg*params.Fs));
        temp_data_sig(:,i)=seeg_data_sig(:,i+round(time_seg*params.Fs));
end

%% Create covariance matrices

% Reference Covariance matrix
temp_data_ref_mean_centered = temp_data_ref - mean(temp_data_ref, 2);
covR = temp_data_ref_mean_centered*temp_data_ref_mean_centered' / (size(temp_data_ref_mean_centered,2)-1);

% Signal Covariance matrix
temp_data_sig_mean_centered = temp_data_sig - mean(temp_data_sig, 2);
covS = temp_data_sig_mean_centered*temp_data_sig_mean_centered' / (size(temp_data_sig_mean_centered,2)-1);


%% Generalized Eigendecomposition

[W,L] = eig(covS, covR);
[eigvals, sidx] = sort(diag(L),'descend');
eigvecs = W(:, sidx);

%% Plotting:

% TODO: plot all channels first 30 sec, then covariance matrices

T = 1/params.Fs;
[~,L] = size(temp_data_ref);
t = (0:L-1)*T(1);
figure(1)
subplot(2,2,1)
plot(t,temp_data_ref(1,:))
xlabel("time (sec)")
ylabel("Amp (uV)")
title(seeg_info_ref.label(1)+" raw - Resting state epoch")

subplot(2,2,2)
plot(t,temp_data_sig(1,:))
xlabel("time (sec)")
ylabel("Amp (uV)")
title(seeg_info_ref.label(1)+" raw - Task epoch")