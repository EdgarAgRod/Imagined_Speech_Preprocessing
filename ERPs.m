%%% ERP %%%
close all; clear all; clc

%% Folder
% Uncomment for Traditional Paradigm
% pathi = 'C:\Users\EdgarAguilera\Documents\ParadigmaTradicional\3. Pre-processing'; % Initial folder

% Uncomment for Experimental Paradigm
% pathi = 'C:\Users\EdgarAguilera\Documents\ParadigmaExperimental\2. Pre-processing'; % Initial folder

cd(pathi);
% Initialize EEGLAB
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;

%% ERP
files_AVANZAR = dir([pathi '\AVANZAR\*.set']);
commands = cell(1,length(files_AVANZAR)*4); 

%% Commands List
A = 4; R = 5; D = 6; I = 7; % Starting index for each class

for i=1 : length(files_AVANZAR)
    % AVANZAR
    commands{1, i} = cell(1,8);
    temp = {'index',A,...
        'load',[pathi '\AVANZAR\S' num2str(i) '-AVANZAR.set'],...
        'subject',['S' num2str(i)],'condition','AVANZAR'}; 
    commands{1,i} = temp;
    A = A+4;

    % RETROCEDER
    commands{1, i+length(files_AVANZAR)} = cell(1,8);
    temp = {'index',R,...
        'load',[pathi '\RETROCEDER\S' num2str(i) '-RETROCEDER.set'],...
        'subject',['S' num2str(i)],'condition','RETROCEDER'}; 
    commands{1,i+length(files_AVANZAR)} = temp;
    R = R+4;

    % DERECHA
    commands{1, i+length(files_AVANZAR)*2} = cell(1,8);
    temp = {'index',D,...
        'load',[pathi '\DERECHA\S' num2str(i) '-DERECHA.set'],...
        'subject',['S' num2str(i)],'condition','DERECHA'}; 
    commands{1,i+length(files_AVANZAR)*2} = temp;
    D = D+4;

    % IZQUIERDA
    commands{1, i+length(files_AVANZAR)*3} = cell(1,8);
    temp = {'index',I,...
        'load',[pathi '\IZQUIERDA\S' num2str(i) '-IZQUIERDA.set'],...
        'subject',['S' num2str(i)],'condition','IZQUIERDA'}; 
    commands{1,i+length(files_AVANZAR)*3} = temp;
    I = I+4;
end


%% Make ERP Study
% Uncomment for Traditional Paradigm
% [STUDY, ALLEEG] = std_editset( STUDY, ALLEEG, 'name','TraditionalParadigmERPs','updatedat','off', 'commands', commands );

% Uncomment for Experimental Paradigm
% [STUDY, ALLEEG] = std_editset( STUDY, ALLEEG, 'name','ExperimentalParadigmERPs','updatedat','off', 'commands', commands );

%% Plot ERP Study
[STUDY, ALLEEG] = std_precomp(STUDY, ALLEEG, 'channels', 'interp', 'on', 'recompute','on','erp','on');
tmpchanlocs = ALLEEG(1).chanlocs; 
std_erpplot(STUDY,ALLEEG, ...
    'channels',{ tmpchanlocs.labels }, ...
    'plotsubjects', 'on', 'design', 1 ,'averagechan', 'on');

%% Save ERP Study
% Uncomment for Traditional Paradigm
% [STUDY, ALLEEG] = pop_savestudy( STUDY, ALLEEG, 'filepath', pathi, 'filename', 'TP_ERPs'); 

% Uncomment for Experimental Paradigm
% [STUDY, ALLEEG] = pop_savestudy( STUDY, ALLEEG, 'filepath', pathi, 'filename', 'EP_ERPs');