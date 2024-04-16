%%% Imagined Speech Pre-processing %%%
close all; clear all; clc

%% Folders
% Uncomment for Traditional Paradigm
% pathi = 'C:\Users\EdgarAguilera\Documents\ParadigmaTradicional\3. Pre-processing\Original'; % Initial folder
% pathf = 'C:\Users\EdgarAguilera\Documents\ParadigmaTradicional\3. Pre-processing';% Final folder

% Uncomment for Experimental Paradigm
pathi = 'C:\Users\EdgarAguilera\Documents\ParadigmaExperimental\2. Pre-processing\Original'; % Initial folder
pathf = 'C:\Users\EdgarAguilera\Documents\ParadigmaExperimental\2. Pre-processing';% Final folder


all_subjects = dir([pathi '\*.set']);

% Initialize EEGLAB
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;


%% Pre-processing
for i=1:length(all_subjects)
    
    % Assign names
    filename = all_subjects(i).name;
    subject = filename(1:end-13);

    % Load Set
    EEG = pop_loadset([pathi '\' filename]); 

    % Re-ref
    EEG = pop_reref( EEG, {'M1', 'M2'} );

    % Filter 1-100Hz
    EEG = pop_eegfiltnew(EEG, 'locutoff',1,'hicutoff',100,'plotfreqz',0);

    % Notch Filter (58-62Hz)
    EEG = pop_eegfiltnew(EEG, 'locutoff',58,'hicutoff',62,'revfilt',1,'plotfreqz',0);

    % ICA
    EEG = pop_runica(EEG, 'icatype', 'runica', 'extended',1,'interrupt','on');

    % ICLABEL 
    EEG = pop_iclabel(EEG, 'default');

    % Remove ICA components
    bad_components = [];
    for i=1:length(EEG.etc.ic_classification.ICLabel.classifications)
        if EEG.etc.ic_classification.ICLabel.classifications(i,1) < 0.6 
            if EEG.etc.ic_classification.ICLabel.classifications(i,1) < 0.1 
                bad_components = [bad_components,i];
            elseif EEG.etc.ic_classification.ICLabel.classifications(i,7) < 0.5
                bad_components = [bad_components,i];              
            end
        end
    end

    % Save Cleaned
    EEG = pop_subcomp( EEG, bad_components, 0);
    EEG.setname= [subject '-Cleaned'];
    pop_saveset(EEG, 'filename', [subject '-Cleaned'], 'filepath', [pathf '\Cleaned']);
    
    % Delete errors for Experimental Paradigm
    if strcmp(subject(1),'s')
        % Drop "Boundary" Events for S6
        if strcmp(subject,'s6')
            EEG = pop_editeventvals( EEG, 'delete', [3 8]); % Delete boundary events
        end
    
        % Drop Spoken Events
        EEG = pop_selectevent( EEG, 'type',{'AVANZAR','DERECHA','IZQUIERDA','RETROCEDER'},'deleteevents','on');
       
        % Rename Error events
        s1_errors = 121; % This event was generated as an error
        if strcmp(subject,'s1')
        EEG = pop_selectevent( EEG, 'event', s1_errors, 'renametype','Error','deleteevents','off','deleteepochs','off','invertepochs','off');
        end
        s3_errors = 34;
        if strcmp(subject,'s3')
             EEG = pop_selectevent( EEG, 'event', s3_errors, 'renametype','Error','deleteevents','off','deleteepochs','off','invertepochs','off');
        end
        s5_errors = 40;
        if strcmp(subject,'s5')
             EEG = pop_selectevent( EEG, 'event', s5_errors, 'renametype','Error','deleteevents','off','deleteepochs','off','invertepochs','off');
        end
        s6_errors = [9, 12, 38, 41, 44, 76];
        s6_errors = s6_errors - 1; % Correct for the missing epoch
        if strcmp(subject,'s6')
             EEG = pop_selectevent( EEG, 'event', s6_errors, 'renametype','Error','deleteevents','off','deleteepochs','off','invertepochs','off');
        end
        s7_errors = [9, 35];
        if strcmp(subject,'s7')
             EEG = pop_selectevent( EEG, 'event', s7_errors, 'renametype','Error','deleteevents','off','deleteepochs','off','invertepochs','off');
        end
        s8_errors = [4, 5, 7, 26, 33, 35, 57, 67, 75, 103, 107];
        if strcmp(subject,'s8')
             EEG = pop_selectevent( EEG, 'event', s8_errors, 'renametype','Error','deleteevents','off','deleteepochs','off','invertepochs','off');
        end
        s10_errors = [8,16,35,44, 62, 63, 66, 77];
        if strcmp(subject,'s10')
             EEG = pop_selectevent( EEG, 'event', s10_errors, 'renametype','Error','deleteevents','off','deleteepochs','off','invertepochs','off');
        end
        s12_errors = 29;
        if strcmp(subject,'s12')
             EEG = pop_selectevent( EEG, 'event', s12_errors, 'renametype','Error','deleteevents','off','deleteepochs','off','invertepochs','off');
        end
        s13_errors = 66;
        if strcmp(subject,'s13')
             EEG = pop_selectevent( EEG, 'event', s13_errors, 'renametype','Error','deleteevents','off','deleteepochs','off','invertepochs','off');
        end
        s14_errors = [20, 51, 81];
        if strcmp(subject,'s14')
             EEG = pop_selectevent( EEG, 'event', s14_errors, 'renametype','Error','deleteevents','off','deleteepochs','off','invertepochs','off');
        end
        s15_errors = [36, 81];
        if strcmp(subject,'s15')
             EEG = pop_selectevent( EEG, 'event', s15_errors, 'renametype','Error','deleteevents','off','deleteepochs','off','invertepochs','off');
        end
    end


    % Extract AVANZAR
    % Uncomment for Traditional Paradigm
    % AVANZAR = pop_epoch( EEG, {  'OVTK_StimulationId_Label_01'  }, [-1         1.4], 'newname', [subject '-AVANZAR'], 'epochinfo', 'yes');
    % Uncomment for Experimental Paradigm
    AVANZAR = pop_epoch( EEG, {  'AVANZAR'  }, [-1         1.4], 'newname', [subject '-AVANZAR'], 'epochinfo', 'yes'); 
    
    AVANZAR.setname= [subject '-AVANZAR'];
    pop_saveset(AVANZAR, 'filename', [subject '-AVANZAR'], 'filepath', [pathf '\AVANZAR']);

    % Extract RETROCEDER
    % Uncomment for Traditional Paradigm
    % RETROCEDER = pop_epoch( EEG, {  'OVTK_StimulationId_Label_02'  }, [-1         1.4], 'newname', [subject '-RETROCEDER'], 'epochinfo', 'yes');
    % Uncomment for Experimental Paradigm
    RETROCEDER = pop_epoch( EEG, {  'RETROCEDER'  }, [-1         1.4], 'newname', [subject '-RETROCEDER'], 'epochinfo', 'yes');
    
    RETROCEDER.setname= [subject '-RETROCEDER'];
    pop_saveset(RETROCEDER, 'filename', [subject '-RETROCEDER'], 'filepath', [pathf '\RETROCEDER']);

    % Extract DERECHA
    % Uncomment for Traditional Paradigm
    % DERECHA = pop_epoch( EEG, {  'OVTK_StimulationId_Label_03'  }, [-1         1.4], 'newname', [subject '-DERECHA'], 'epochinfo', 'yes');
    % Uncomment for Experimental Paradigm
    DERECHA = pop_epoch( EEG, {  'DERECHA'  }, [-1         1.4], 'newname', [subject '-DERECHA'], 'epochinfo', 'yes');
    
    DERECHA.setname= [subject '-DERECHA'];
    pop_saveset(DERECHA, 'filename', [subject '-DERECHA'], 'filepath', [pathf '\DERECHA']);


    % Extract IZQUIERDA
    % Uncomment for Traditional Paradigm
    % IZQUIERDA = pop_epoch( EEG, {  'OVTK_StimulationId_Label_04'  }, [-1         1.4], 'newname', [subject '-IZQUIERDA'], 'epochinfo', 'yes');
    % Uncomment for Experimental Paradigm
    IZQUIERDA = pop_epoch( EEG, {  'IZQUIERDA'  }, [-1         1.4], 'newname', [subject '-IZQUIERDA'], 'epochinfo', 'yes');
    
    IZQUIERDA.setname= [subject '-IZQUIERDA'];
    pop_saveset(IZQUIERDA, 'filename', [subject '-IZQUIERDA'], 'filepath', [pathf '\IZQUIERDA']);
end