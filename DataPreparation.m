%%% Data Preparation %%%
close all; clear all; clc

%% Folders
% Uncomment for Traditional Paradigm
% pathi = 'C:\Users\EdgarAguilera\Documents\ParadigmaTradicional\2. Adding Events'; % Initial folder
% pathf = 'C:\Users\EdgarAguilera\Documents\ParadigmaTradicional\3. Pre-processing';% Final folder
% all_subjects = dir([pathi '\*.edf']);

% Uncomment for Experimental Paradigm
% pathi = 'C:\Users\EdgarAguilera\Documents\ParadigmaExperimental\1. Data Records'; % Initial folder
% pathf = 'C:\Users\EdgarAguilera\Documents\ParadigmaExperimental\2. Pre-processing';% Final folder
% all_subjects = dir([pathi '\*.xdf']);

% Initialize EEGLAB
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;

%% Prepare Data
for i=1:length(all_subjects)
    % Assign names
    filename = all_subjects(i).name;
    subject = filename(1:end-4);

    % Load Signal
    % Uncomment for Traditional Paradigm
    % EEG = pop_biosig([pathi '\' filename]); % uncomment for EDF (Traditional)
    % Uncomment for Experimental Paradigm
    % EEG = pop_loadxdf([pathi '\' filename]); 

    % Set properties
    EEG.setname= [subject '-Original'];
    EEG.subject = subject(2:end);
   

    % Remove Gyros
    EEG = pop_select( EEG, 'rmchannel',{'Gyro 1','Gyro 2','Gyro 3'});
    
    % Add channel locations
    EEG = pop_editset(EEG, 'chanlocs', 'C:\\Users\\EdgarAguilera\\Documents\\ParadigmaTradicional\\mBrain_24ch_locations.txt');
    
    % Remove last epoch for S1 (registered by error)
    

    % Save original set
    pop_newset(ALLEEG, EEG, CURRENTSET, 'setname', [subject '-Original']);
    pop_saveset(EEG, 'filename', [subject '-Original'], 'filepath', [pathf '\Original']);

end

%% Now manually remove segments

% Recommended segments to delete:
% Experimental Paradigm - S6: 21.4s - 24.4s
% Experimental Paradigm - S6: 34.5s - 35.5s
