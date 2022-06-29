% close all;
% clear all;
% cd C:\Users\eduhkan\Documents\Tools\axcel_trunk; % load tools
% setpath; 

sc = 'vr';
if strcmp(sc,'vr')
    Afstr = {'Headset_View\1080p30\30_8000_bytes.csv','Headset_View\1080p30\30_11000_bytes.csv','Headset_View\1080p30\30_13000_bytes.csv','Headset_View\1080p30\30_16000_bytes.csv',...
        'Headset_View\1080p60\60_16000_bytes.csv','Headset_View\1080p60\60_22000_bytes.csv','Headset_View\1080p60\60_25000_bytes.csv','Headset_View\1080p60\60_30000_bytes.csv'};
    Afstr = {'Headset_View\1080p30\30_8000_out_bytes.csv','Headset_View\1080p30\30_11000_out_bytes.csv','Headset_View\1080p30\30_13000_out_bytes.csv','Headset_View\1080p30\30_16000_out_bytes.csv',...
        'Headset_View\1080p60\60_16000_out_bytes.csv','Headset_View\1080p60\60_22000_out_bytes.csv','Headset_View\1080p60\60_25000_out_bytes.csv','Headset_View\1080p60\60_30000_out_bytes.csv'};
    AavgRateMbps =  [8000/1e3 11000/1e3 13000/1e3 16000/1e3 ...
        16000/1e3 22000/1e3 25000/1e3 30000/1e3];
else % cg
    Afstr = {'60_55000_bytes_out.csv','60_61000_bytes_out.csv','60_80000_bytes_out.csv','60_90000_bytes_out.csv'};
    AavgRateMbps =  [55000/1e3 61000/1e3 80000/1e3 90000/1e3];
end

for n=1:length(Afstr)
    fstr=Afstr{n};
    avgRateMbps=AavgRateMbps(n);
    if strcmp(sc,'vr')
        filename = 'C:\Users\eduhkan\Ericsson AB\STAR - XR\Activities\Activity 005- XR traffic model and KPI\VR\Atlantis\';
    else
        filename = 'C:\Users\eduhkan\Ericsson AB\STAR - XR\Activities\Activity 005- XR traffic model and KPI\CG\Atlantis\Microsoft_Forza_Horizon_Racing_4K60p_logs\';
    end
    filename = [filename fstr];
    res= readtable(filename);
    VarNames = res.Properties.VariableNames;
    if not(isempty(strfind(fstr,'_out'))),
        frameSizeB=table2array(res(:,2));
    else
        frameSizeB=table2array(res(:,1));
    end
    
    info = fstr;
    fps = str2num(fstr(strfind(fstr,'1080p')+5:strfind(fstr,'1080p')+6));
    nf = length(frameSizeB);
    frametype = repmat('P',[nf 1]);
    
    infostr = strrep(strrep(info,'\','_'),'.csv','');
    save([ sc '_' infostr],'info','fps','nf','avgRateMbps','frameSizeB','frametype');        
end