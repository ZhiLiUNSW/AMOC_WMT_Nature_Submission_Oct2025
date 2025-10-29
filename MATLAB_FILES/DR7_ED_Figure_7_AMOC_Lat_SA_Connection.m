%% ########################################################################
%% PLOTTING AMOC STREAMFUNCTION AT INTERMEDIATE LAYER, [ Sv ]
%  SIO Argo  data for 2004-2023, 0-2000 m, annual mean of monthly means
%  Ishiiv731 data for 1980-2023, 0-3000 m, annual mean of monthly means
%  IPAv4     data for 1940-2023, 0-2000 m, annual mean of monthly means
%  IPAv4.2   data for 1940-2023, 0-6000 m, annual mean of monthly means
%  EN4-ESM   data for 1940-2023, 0-5500 m, annual mean of monthly means

% #########################################################################
% #########################################################################


% #########################################################################
% #########################################################################
%% 2. AMOC Upper Limb Strength by Latitude   -  DR7: v1: time series of AMOC 
% #########################################################################
% #########################################################################
clc; clear

% #########################################################################
% #########################################################################
cd('/Users/z5195509/Documents/7_AMOC_Proxy and Variability/8_AMOC_Streamfunction')
load plot_AMOC_Streamfunction_V4_Ensemble_Observations_AMOC-IW_Cells_v2_2_AMOC_IW_v2_12Mon.mat

% #########################################################################  
    % #########################################################################
    % #########################################################################
    % AMOC Upper Limb Strength in Subtropical and Subpolar Latitudes from WMT-Based Streamfunction 
    % 0.05 Density Bin, Maximum in 10N-40N or 40N-65N, 0.1 smooth window 
      for data_num = 1 : size(AMOC_SFygtn_ESM_005_LOW,4)
          for year = 1 : size(AMOC_SFygtn_ESM_005_LOW,3)
              for lat = 1 : size(AMOC_SFygtn_ESM_005_LOW,2)
                  % Upper Limb Strength, within 26.6 <= gamma <= 28.0 at each latitude
                  AMOC_time_upper_005(lat,year,data_num) =  max(max( AMOC_SFygtn_ESM_005_LOW(112:140, lat, year,data_num)))./1e6;  
              end
          end 
      end
      clear year data_num  

      AMOC_time_upper_005(:,:,1) = NaN; % Remove IAPv4 data
      AMOC_time_upper_005        = squeeze(nanmean(AMOC_time_upper_005(:,:,:),3)); % Ensembl Data Mean
    % #########################################################################
    % #########################################################################

      
    % #####################################################################
    % Calculate Lead Correlation
    clear corr_coff_CT pvalue_CT
    p_value_sig = 0.05;
    for lat_s = 56:57
        for i = 56 :1: 180 % 35S - 70N
            disp(['    cal corre. lat#',num2str(i),' lat_s#',num2str(lat_s)])
            % ##########################################################
            if lat_s <= i
                % Leading years: 
                for lead_yrs = 0 : 30
                    [correlation, p_value]=corr(smoothdata(squeeze(AMOC_time_upper_005(lat_s,1:end-lead_yrs))','movmean', 15), smoothdata(squeeze(AMOC_time_upper_005(i,1+lead_yrs:end))','movmean', 15));
                    corr_coff_CT(i,lead_yrs+1,lat_s) = correlation; 
                    if p_value<=p_value_sig
                       p_value=1;
                    else
                       p_value=NaN;
                    end
                    pvalue_CT(i,lead_yrs+1,lat_s)=p_value;  
                    clear correlation p_value
                end
                clear lead_yrs
            else
                corr_coff_CT(i,1:31,lat_s) = NaN;
                pvalue_CT(i,1:31,lat_s)    = NaN; 
            end
            % ##########################################################
        end
    end
    clear i p_value_sig
    corr_coff_CT(corr_coff_CT==0) = NaN;
% #########################################################################
% #########################################################################

      
% #########################################################################
% #########################################################################
cd('/Users/z5195509/Documents/7_AMOC_Proxy and Variability/9_AMOC_SAMBA/')
    % SAMOC Data Analysis Script
    % Loads and plots time series of Meridional Overturning Circulation (MOC) data
    % from the South Atlantic at 34.5°S
    % Loads daily data, computes monthly averages, and plots time series
    filename = 'Upper_Abyssal_Transport_Anomalies.txt';

    % Read the data - skip header lines (start with %) and load numeric data
    fid = fopen(filename, 'rt');
    % Skip header lines
    while true
        line = fgetl(fid);
        if ~contains(line, '%')
            fseek(fid, -numel(line)-2, 'cof');
            break;
        end
    end

    % Read numeric data
    data = textscan(fid, '%f %f %f %f %f %f %f');
    fclose(fid);

    % Extract variables
    year = data{1};
    month = data{2};
    day = data{3};
    hour = data{4};
    minute = data{5};
    upper_cell = data{6};    % Upper-cell transport anomaly (Sv)
    abyssal_cell = data{7};  % Abyssal-cell transport anomaly (Sv)

    % Create datetime array
    dates = datetime(year, month, day, hour, minute, zeros(size(year)));
    time_daily_samba = (2013+252/365.25 :1/365.25: 2017+195/365.25)';
    
    % Calculate monthly averages
    % Create year-month groups
    [yearMonth, ~, group] = unique([year, month], 'rows');

    % Initialize monthly arrays
    monthly_dates = datetime(yearMonth(:,1), yearMonth(:,2), ones(size(yearMonth,1),1));
    monthly_upper = zeros(size(yearMonth,1),1);
    monthly_abyssal = zeros(size(yearMonth,1),1);

    % Calculate means for each month
    for i = 1:size(yearMonth,1)
        idx = group == i;
        monthly_upper(i) = mean(upper_cell(idx), 'omitnan');
        monthly_abyssal(i) = mean(abyssal_cell(idx), 'omitnan');
    end
% #########################################################################
% #########################################################################


%% #########################################################################
% #########################################################################
   figure('Color',[1 1 1]);  %create a new figure of white color background
   ixs = 0.04; ixe = 0.05;  ixd = 0.06; ixw = (1-ixs-ixe-1*ixd)/2;
   iys = 0.10; iye = 0.10;  iyd = 0.06; iyw = (1-iys-iye-0*iyd)/1;
   pos{11}  = [ixs+0.0*ixw+0.0*ixd   iys+0*iyw+0*iyd  1.2*ixw iyw]; 
   pos{21}  = [ixs+1.2*ixw+1.0*ixd   iys+0*iyw+0*iyd  0.8*ixw iyw]; 
   
% ######################################################################### 
    clear color color0 
    color0=cbrewer('div', 'RdBu', 40,'pchip');
    color0=color0(size(color0,1):-1:1,:);
% #########################################################################
  


% #########################################################################
subplot('position',pos{11})
    % #####################################################################
    % AMOC 26N Max, 15-Year Running Mean
    AMOC_time_26N_max_ESM_005(:,1) = NaN; % remove IAPv4
    AMOC_main(:,1)       = smoothdata(nanmean(AMOC_time_26N_max_ESM_005(:,1:5),2),'movmean', 15)'; 
    AMOC_edge(:,1)       = smoothdata(nanmean(AMOC_time_26N_max_ESM_005(:,1:5),2),'LOWESS',  15)'; 
    AMOC_main(1:8)       = NaN;
    AMOC_main(end-6:end) = AMOC_edge(end-6:end,1); clear AMOC_edge
    
    line_ESM_26N          = plot(time_ann_IAP,AMOC_main);                 
    set(line_ESM_26N,'color',[0.850, 0.325, 0.098],'LineWidth',4.5,'linestyle','-');
    clear AMOC_main AMOC_edge
    % #####################################################################
    
    
    % #########################################################################
    % 50S - Equator, Atlantic Basin
    % AMOC Upper Limb Strength in (Subtropical Latitudes, Intermediate Water Layer) 
    % Maximum streamfunction within each lat
    clear color color0 
    color0=slanCM('Greys',95);
    color0=color0(size(color0,1):-1:1,:);
    count_color = 1;
    lat_itvl = 4;
    for lat = 41: lat_itvl: 90 % 50S - Eq., in grey colors
       %AMOC_time_upper_005_5N  = squeeze(nanmean(AMOC_time_upper_005( lat:lat+0,:),1))';
        for year = 1:size(AMOC_time_upper_005,2)
            AMOC_time_upper_005_5N(year,1)  = max(squeeze(AMOC_time_upper_005( lat:lat+lat_itvl,year)));
        end
        AMOC_main(:,1)       = smoothdata(AMOC_time_upper_005_5N,'movmean', 15)'; 
        AMOC_edge(:,1)       = smoothdata(AMOC_time_upper_005_5N,'LOWESS',  15)'; 
        AMOC_main(1:8)       = NaN;
        
        hold on
        line_IW_LAT_SH       = plot(time_ann_IAP,AMOC_main);    
        set(line_IW_LAT_SH,'color',color0(count_color + 45,:),'LineWidth',1.2,'linestyle','-');
        clear AMOC_main AMOC_edge
        count_color = count_color + lat_itvl;
    end
    clear count_color lat
    hold on
    for year = 1:size(AMOC_time_upper_005,2)
        AMOC_time_upper_005_5N(year,1)  = max(squeeze(AMOC_time_upper_005( 41:41+lat_itvl,year)));
    end
    AMOC_main(:,1)         = smoothdata(AMOC_time_upper_005_5N,'movmean', 15);
    AMOC_edge(:,1)         = smoothdata(AMOC_time_upper_005_5N,'LOWESS',  15);
    AMOC_main(1:8)         = NaN;
    line_IW_LAT_SH          = plot(time_ann_IAP,AMOC_main);
    set(line_IW_LAT_SH,'color',color0(51,:),'LineWidth',1.2,'linestyle','-');
    clear AMOC_main AMOC_edge
    
    % SAMOC at 34.5S
    hold on
    AMOC_main(:,1)         = smoothdata(squeeze(nanmean(AMOC_time_upper_005(56,:),1)),'movmean', 15);
    AMOC_edge(:,1)         = smoothdata(squeeze(nanmean(AMOC_time_upper_005(56,:),1)),'LOWESS',  15);
    AMOC_main(1:8)         = NaN;
    line_IW_LAT_345S       = plot(time_ann_IAP,AMOC_main);   
    set(line_IW_LAT_345S,'color',[0.466, 0.674, 0.188],'LineWidth',6.5,'linestyle','-');
    clear AMOC_main AMOC_edge
    % #####################################################################

    
    % #####################################################################
    % Equator - 60N, North Atlantic
    % AMOC Upper Limb Strength in (Subtropical Latitudes, Intermediate Water Layer) 
    % Maximum streamfunction within each lat
    clear color color0 
    color0=slanCM('RdBu',120);
    color0=color0(size(color0,1):-1:1,:);
    
    % Equator - 26N
    count_color = 1;
    lat_itvl = 3;
    for lat = 91: lat_itvl: 116 % Eq-26N in blue colors
        for year = 1:size(AMOC_time_upper_005,2)
            AMOC_time_upper_005_5N(year,1)  = max(squeeze(AMOC_time_upper_005( lat:lat+lat_itvl,year)));
        end
        AMOC_main(:,1)         = smoothdata(AMOC_time_upper_005_5N,'movmean', 15)'; 
        AMOC_edge(:,1)         = smoothdata(AMOC_time_upper_005_5N,'LOWESS',  15)'; 
        AMOC_main(1:8)         = NaN;
        
        hold on
        line_IW_LAT_NT         = plot(time_ann_IAP,AMOC_main);    
        set(line_IW_LAT_NT,'color',color0(count_color + 35,:),'LineWidth',1.2,'linestyle','-');
        clear AMOC_main AMOC_edge
        count_color = count_color + lat_itvl;
    end
    clear count_color lat
    hold on
    for year = 1:size(AMOC_time_upper_005,2)
        AMOC_time_upper_005_5N(year,1)  = max(squeeze(AMOC_time_upper_005( 91:91+lat_itvl,year)));
    end
    AMOC_main(:,1)         = smoothdata(AMOC_time_upper_005_5N,'movmean', 15);
    AMOC_edge(:,1)         = smoothdata(AMOC_time_upper_005_5N,'LOWESS',  15);
    AMOC_main(1:8)         = NaN;
    line_IW_LAT_NT         = plot(time_ann_IAP,AMOC_main);
    set(line_IW_LAT_NT,'color',color0(35,:),'LineWidth',1.2,'linestyle','-');
    clear AMOC_main AMOC_edge
    % #####################################################################
    
    
    % #####################################################################
    % 26N - 60N
    count_color = 1;
    lat_itvl = 2;
    for lat = 117: lat_itvl: 148 % 26N - 60N in red colors
        for year = 1:size(AMOC_time_upper_005,2)
            AMOC_time_upper_005_5N(year,1)  = max(squeeze(AMOC_time_upper_005( lat:lat+lat_itvl,year)));
        end
        AMOC_main(:,1)         = smoothdata(AMOC_time_upper_005_5N,'movmean', 15)'; 
        AMOC_edge(:,1)         = smoothdata(AMOC_time_upper_005_5N,'LOWESS',  15)'; 
        AMOC_main(1:8)         = NaN;
        
        hold on
        line_IW_LAT_NS         = plot(time_ann_IAP,AMOC_main);    
        set(line_IW_LAT_NS,'color',color0(count_color + 60,:),'LineWidth',1.2,'linestyle','-');
        clear AMOC_main AMOC_edge
        count_color = count_color + lat_itvl;
    end
    clear count_color lat
    hold on
    hold on
    for year = 1:size(AMOC_time_upper_005,2)
        AMOC_time_upper_005_5N(year,1)  = max(squeeze(AMOC_time_upper_005( 148:148+lat_itvl,year)));
    end
    AMOC_main(:,1)         = smoothdata(AMOC_time_upper_005_5N,'movmean', 15);
    AMOC_edge(:,1)         = smoothdata(AMOC_time_upper_005_5N,'LOWESS',  15);
    AMOC_main(1:8)         = NaN;
    line_IW_LAT_NS         = plot(time_ann_IAP,AMOC_main);
    set(line_IW_LAT_NS,'color',color0(90,:),'LineWidth',1.2,'linestyle','-');
    clear AMOC_main AMOC_edge
    % #####################################################################
    
    

    % #####################################################################
    % #####################################################################
    % Hydrographic Sections at 25N, Atkinson at al. (2012)
    % Intermediate 0-1100 m integration
    bar_25N_1957=errorbar((1957+ 9/12)',18.0, 2.9);
    set(bar_25N_1957,'color',[1.0 0.75 0.8], 'LineWidth', 2.0,'linestyle','-');
    hold on
    bar_25N_1981=errorbar((1981+ 7/12)',17.6, 2.9);
    set(bar_25N_1981,'color',[1.0 0.75 0.8], 'LineWidth', 2.0);
    hold on
    bar_25N_1992=errorbar((1992+ 6/12)',18.6, 2.9);
    set(bar_25N_1992,'color',[1.0 0.75 0.8], 'LineWidth', 2.0);
    hold on
    bar_25N_1998=errorbar((1998+ 1/12)',16.8, 2.9);
    set(bar_25N_1998,'color',[1.0 0.75 0.8], 'LineWidth', 2.0);
    hold on
    bar_25N_2004=errorbar((2004+ 3/12)',16.1, 2.9);
    set(bar_25N_2004,'color',[1.0 0.75 0.8], 'LineWidth', 2.0);
 
    hold on
    line_25N_1957=plot((1957+ 9/12)',18.0,'s','MarkerSize',18,'MarkerFaceColor', [1.0 0.75 0.8], 'MarkerEdgeColor', [1.0 0.75 0.8]);
    set(line_25N_1957,'color',[1.0 0.75 0.8], 'LineWidth', 3.0);
    hold on   
    line_25N_1981=plot((1981+ 7/12)',17.6,'s','MarkerSize',18,'MarkerFaceColor', [1.0 0.75 0.8], 'MarkerEdgeColor', [1.0 0.75 0.8]);
    set(line_25N_1981,'color',[1.0 0.75 0.8], 'LineWidth', 3.0);
    hold on
    line_25N_1992=plot((1992+ 6/12)',18.6,'s','MarkerSize',18,'MarkerFaceColor', [1.0 0.75 0.8], 'MarkerEdgeColor', [1.0 0.75 0.8]);
    set(line_25N_1992,'color',[1.0 0.75 0.8], 'LineWidth', 3.0);
    hold on
    line_25N_1998=plot((1998+ 1/12)',16.8,'s','MarkerSize',18,'MarkerFaceColor', [1.0 0.75 0.8], 'MarkerEdgeColor', [1.0 0.75 0.8]);
    set(line_25N_1998,'color',[1.0 0.75 0.8], 'LineWidth', 3.0);
    hold on
    line_25N_2004=plot((2004+ 3/12)',16.1,'s','MarkerSize',18,'MarkerFaceColor', [1.0 0.75 0.8], 'MarkerEdgeColor', [1.0 0.75 0.8]);
    set(line_25N_2004,'color',[1.0 0.75 0.8], 'LineWidth', 3.0);
    % #####################################################################  
    % #####################################################################
    
  

    % #####################################################################
    % #####################################################################
    % Satellite Altimetary AMOC from Frajka-Williams 2015 ['http://dx.doi.org/10.1002/2015GL063220']
    hold on
    line_FW2015           = plot(tme_AMOC_FW2015,AMOC_FW2015);
    set(line_FW2015,'color',[0.694, 0.384, 0.556],'LineWidth',  4.5,'linestyle','-');
    clear recon dates AMOC_FW2015 tme_AMOC_FW2015
    % #####################################################################
    % #####################################################################
    

    
    % #####################################################################
    % #####################################################################
    % RAPID AMOC (CORRECTED USING IW LAYER DENSITY)
    hold on
    line_RAPID=plot(decimal_year(2:3:end-2,1),amoc_sigma_mon_corr);
    set(line_RAPID,'color',[0.1, 0.1, 0.1],'LineWidth',  4.0,'linestyle','-'); 
    % #####################################################################
    % #####################################################################
    
    
    % #####################################################################
    % #####################################################################
    % OSNAP AMOC
    hold on
    line_OSNAP             = plot(tme_OSNAP,MOC_OSNAP_Mon);
    set(line_OSNAP,'color',[0.6, 0.6, 0.6],'LineWidth',  5.0,'linestyle','-');
    clear  MOC_OSNAP_Mon
    % #####################################################################
    % #####################################################################

    
    % #####################################################################
    % #####################################################################
    % SAMBA AMOC
    hold on
    % daily
    AMOC_time_SAMBA(:,1)         = runmean((upper_cell+17.3),540); % 3-yearrunning mean
    AMOC_time_SAMBA(1:10,1)      = NaN;
    AMOC_time_SAMBA(end-610:end) = NaN;    
    line_SAMBA                   = plot(time_daily_samba, AMOC_time_SAMBA);
    set(line_SAMBA,'color',[0.929, 0.694, 0.125],'LineWidth',  2.5,'linestyle','-');
    % #####################################################################
    % #####################################################################
    
    
    
    % #####################################################################
    % #####################################################################
    % AMOC Upper Limb, Subtropical Lat, Ensemble Mean
    AMOC_time_subtropical_IW_005(:,1) = NaN; % Remove IAPv4
    hold on
    AMOC_main(:,1)         = smoothdata(nanmean(AMOC_time_subtropical_IW_005(:,1:5),2),'movmean', 15)'; 
    AMOC_edge(:,1)         = smoothdata(nanmean(AMOC_time_subtropical_IW_005(:,1:5),2),'LOWESS',  15)'; 
    AMOC_main(1:8)         = NaN;
    AMOC_main(end-6:end)   = AMOC_edge(end-6:end,1); clear AMOC_edge
    line_ESM_STIW          = plot(time_ann_IAP,AMOC_main);    
    set(line_ESM_STIW,'color',[0    , 0.447, 0.741],'LineWidth',7.5,'linestyle','-');
    clear AMOC_main AMOC_edge
    
    
    % AMOC Subpolar, Ensemble Mean
    AMOC_time_subpolar_DW_005(:,1) = NaN; % Remove IAPv4
    hold on
    AMOC_main(:,1)         = smoothdata(nanmean(AMOC_time_subpolar_DW_005(:,1:5),2),'movmean', 15)'; 
    AMOC_edge(:,1)         = smoothdata(nanmean(AMOC_time_subpolar_DW_005(:,1:5),2),'LOWESS',  15)'; 
    AMOC_main(1:8)         = NaN;
    AMOC_main(end-6:end)   = AMOC_edge(end-6:end,1); clear AMOC_edge
    line_ESM_SPDW          = plot(time_ann_IAP,AMOC_main);    
    set(line_ESM_SPDW,'color',[0.301, 0.745, 0.933],'LineWidth',7.5,'linestyle','-');
    clear AMOC_main AMOC_edge
    
 
    % AMOC 26N Max, 15-Year Running Mean
    AMOC_time_26N_max_ESM_005(:,1) = NaN; % remove IAPv4
    hold on
    AMOC_main(:,1)         = smoothdata(nanmean(AMOC_time_26N_max_ESM_005(:,1:5),2),'movmean', 15)'; 
    AMOC_edge(:,1)         = smoothdata(nanmean(AMOC_time_26N_max_ESM_005(:,1:5),2),'LOWESS',  15)'; 
    AMOC_main(1:8)         = NaN;
    AMOC_main(end-6:end)   = AMOC_edge(end-6:end,1); clear AMOC_edge
    line_ESM_26N           = plot(time_ann_IAP,AMOC_main);                 
    set(line_ESM_26N,'color',[0.850, 0.325, 0.098],'LineWidth',8.5,'linestyle','-');
    clear AMOC_main AMOC_edge
    % #####################################################################
    % #####################################################################
    
    
    
    % #####################################################################
    % #####################################################################
    % Hydrographic Sections at 25N, Kanzow at al. (2010)
    % Maximum streamfunction
    hold on
    line_25Nmax_1957=plot((1957+ 9/12)',20.1,'^','MarkerSize',20,'MarkerFaceColor', [0.494, 0.184, 0.556], 'MarkerEdgeColor', [0.494, 0.184, 0.556]);
    set(line_25Nmax_1957,'color',[0.494, 0.184, 0.556], 'LineWidth', 3.5);
    hold on   
    line_25Nmax_1981=plot((1981+ 7/12)',17.3,'^','MarkerSize',20,'MarkerFaceColor', [0.494, 0.184, 0.556], 'MarkerEdgeColor', [0.494, 0.184, 0.556]);
    set(line_25Nmax_1981,'color',[0.494, 0.184, 0.556], 'LineWidth', 3.5);
    hold on
    line_25Nmax_1992=plot((1992+ 6/12)',18.6,'^','MarkerSize',20,'MarkerFaceColor', [0.494, 0.184, 0.556], 'MarkerEdgeColor', [0.494, 0.184, 0.556]);
    set(line_25Nmax_1992,'color',[0.494, 0.184, 0.556], 'LineWidth', 3.5);
    hold on
    line_25Nmax_1998=plot((1998+ 1/12)',18.1,'^','MarkerSize',20,'MarkerFaceColor', [0.494, 0.184, 0.556], 'MarkerEdgeColor', [0.494, 0.184, 0.556]);
    set(line_25Nmax_1998,'color',[0.494, 0.184, 0.556], 'LineWidth', 3.5);
    hold on
    line_25Nmax_2004=plot((2004+ 3/12)',17.5,'^','MarkerSize',20,'MarkerFaceColor', [0.494, 0.184, 0.556], 'MarkerEdgeColor', [0.494, 0.184, 0.556]);
    set(line_25Nmax_2004,'color',[0.494, 0.184, 0.556], 'LineWidth', 3.5);
    % #####################################################################  
    % #####################################################################
    
    
    
    % #####################################################################    
    leg=legend([line_ESM_26N line_ESM_STIW line_ESM_SPDW line_IW_LAT_345S line_IW_LAT_SH line_IW_LAT_NT line_IW_LAT_NS line_RAPID line_SAMBA line_OSNAP line_FW2015 line_25N_1957 line_25Nmax_1957],...
                  'AMOC at 26\circN',...
                  'AMOC (max. 10\circN - 40\circN)',...
                  'AMOC (max. 40\circN - 60\circN)',...
                  'AMOC at 34.5\circS',...
                  'AMOC by lat. (50\circS  - Eq.)',...
                  'AMOC by lat. (Eq.    - 26\circN)',...
                  'AMOC by lat. (26\circN - 60\circN)',...
                  'RAPID 26\circN array',...
                  'SAMBA 34.5\circS array',...
                  'OSNAP subpolar array',...
                  'Satellite altimetry',...
                  'Hydrographic at 25\circN',...
                  'Max. streamf. at 25\circN',...
                  'Location','northeast','fontsize',15,'Orientation','vertical','NumColumns',1); %line_IW_IAPv4 'AMOC-upper limb, IAPv4',...
    set(leg,'fontsize',15)
    hold on
    %title(leg,'AMOC Strength','fontsize',20','color','k')
    legend('boxoff')
    % #####################################################################

   
    % ###################################################################
    % Add an arrow annotation [x_start x_end] and [y_start y_end]
    text(2023.8,19.4,'50\circS','fontsize',19,'Color', [0.1, 0.1, 0.1])
    text(2023.8,16.7,'34.5\circS','fontsize',19,'Color', [0.466, 0.674, 0.188])
    text(2023.8,15.5,'26\circN','fontsize',19,'Color', [0.9, 0.3, 0.3])
    text(2023.8,11.8,'60\circN','fontsize',19,'Color', [0.1, 0.1, 0.1])
    % ###################################################################  
    
    
   
    xlim([1948 2030])
    set(gca,'XTick',1950:10:2020)
    set(gca,'XTickLabel',{'1950','1960','1970','1980','1990','2000','2010','2020'},'fontsize',22)
    %ylim([11.3 29.0]);
    ylim([11.3 29.3]);
    set(gca,'YTick',12:2:30)
    set(gca,'YTickLabel',{'12','14','16','18','20','22','24','26','28','30'},'fontsize',22)
    grid off
    set(gca,'GridColor',[.8 .8 .8],'GridAlpha',0.2,'GridLineStyle','-')
    ylabel('[ Sv ]','color','k','fontsize',22) % left y-axis
    xlabel(' Year ','color','k','fontsize',22) 
    title('a. Time evolution of reconstructed AMOC strength','color','k','fontsize',24) 
% ######################################################################### 
% #########################################################################



% #########################################################################
% #########################################################################
subplot('position',pos{21})
    imagesc((1:1:31)',lat_IAP,smooth2a(nanmean(corr_coff_CT(:,:,56:57),3),0,0),'AlphaData',~isnan(nanmean(corr_coff_CT(:,:,56:57),3)));

    % #########################################################################
    % Dots for significance
    pvalue = pvalue_CT(:,:,56);
    for i=1:31
        for j=1:180
            if pvalue(j,i) ~= 1
               hold on
               plot(i,lat_IAP(j),'-k+','LineWidth',2.5,'MarkerSize',15,'MarkerEdgeColor','[0.3, 0.3, 0.3]','MarkerFaceColor','[.3 .3 .3]')
            end
        end
    end
    % ######################################################################### 

    
    % #####################################################################
    % Contours of max correlation
    hold on
    [C_max,h_max] = contour((1:1:31)',lat_IAP,smooth2a(nanmean(corr_coff_CT(:,:,56:57),3),1,1),[0.7 0.7],'linestyle','-');
    set(h_max,'color',[0    , 0.447, 0.741],'LineWidth',3);
    v0=[];
    clabel(C_max,h_max,v0,'labelspacing',3000,'fontsize',16,'color','k')
    % #####################################################################
    
    
    % #########################################################################
    % #########################################################################
    % Lines for 8-year propagation
    corr_coff = smooth2a(nanmean(corr_coff_CT(:,:,56:57),3),0,0);
    for i = 1 :8: 31-8
        lat_1 = find(corr_coff(:,i)   == max(corr_coff(:,i)));
        lat_2 = find(corr_coff(:,i+8) == max(corr_coff(:,i+8)));

        hold on 
        plot(i:i+8,lat_IAP(lat_1):((lat_IAP(lat_2)-lat_IAP(lat_1)))./8:lat_IAP(lat_2),'color',[0.929, 0.694, 0.125],'linewidth',3.5,'linestyle','--')
    end
    
    lat_1 = find(corr_coff(:,25)   == max(corr_coff(:,25)));
    lat_2 = find(corr_coff(:,31) == max(corr_coff(:,31)));
    hold on 
    plot(25:31,lat_IAP(lat_1):((lat_IAP(lat_2)-lat_IAP(lat_1)))./6:lat_IAP(lat_2),'color',[0.929, 0.694, 0.125],'linewidth',3.5,'linestyle','--')
    
    text(  9,     lat_IAP( 98),'>','fontsize',30,'Rotation',  -55,'color',[0.929, 0.694, 0.125]);
    text( 16.9,   lat_IAP(125),'>','fontsize',30,'Rotation',  -50,'color',[0.929, 0.694, 0.125]);
    text( 24,     lat_IAP(144),'>','fontsize',30,'Rotation',  -40,'color',[0.929, 0.694, 0.125]);
    text( 30.23,  lat_IAP(152)+0.7,'>','fontsize',30,'Rotation',  -25,'color',[0.929, 0.694, 0.125]);
    % #########################################################################
    % #########################################################################
        

    xlim([0.5 31.5])
    set(gca,'XTick',1:5:31)
    set(gca,'XTickLabel',{'0','5','10','15','20','25','30'},'fontsize',22)
    ylim([-35 70])
    set(gca,'YTick',-40:10:60)
    set(gca,'YTickLabel',{'40\circS','30\circS','20\circS','10\circS','0','10\circN','20\circN','30\circN','40\circN','50\circN','60\circN'},'fontsize',22)
    grid off
    set(gca,'GridColor',[.8 .8 .8],'GridAlpha',0.2,'GridLineStyle','-')
    ylabel(' Latitude ','color','k','fontsize',22) % left y-axis
    xlabel(' Lagged years','color','k','fontsize',22) 
    title('b. Lagged correlation with AMOC at 34.5\circS','color','k','fontsize',24)
       
    clear color color0 
    color0=cbrewer('div', 'RdBu', 50,'pchip');
    color0=color0(size(color0,1)-4:-1:1+4,:);
    colormap(gca,color0)
    caxis([-1 1]);  

hBar21 = colorbar('EastOutside');
get(hBar21, 'Position') ;
set(hBar21, 'Position', [ixs+2*ixw+1*ixd+0.010 iys+0.2*iyw+0*iyd 0.013 0.6*iyw+0*iyd]);
set(hBar21,'ytick',-1:0.5:1,'yticklabel',{'-1','0.5','0','0.5','1'},'fontsize',21,'FontName','Arial','LineWidth',1.2,'TickLength',0.045);
%ylabel(hBar21, '[ Sv ]','rotation',90);
      
    
% #########################################################################
cd('/Users/z5195509/Documents/7_AMOC_Proxy and Variability/8_AMOC_Streamfunction/')
% #########################################################################
% #########################################################################



