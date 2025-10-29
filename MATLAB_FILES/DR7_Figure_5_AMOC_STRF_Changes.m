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
%% #########################################################################
% #########################################################################
%  Plotting Figure 4: AMOC-Gamma Streamfuction Trends -- v1: linear trends from 1960 to 2023
clc;clear

% IAP LON&LAT GRIDS
  lon_IAP(:,1)       = (-179:  1: 180); % After [-179 180] to Fit AMOC Mask
  lat_IAP(:,1)       = (-89.5: 1: 89.5);
  dep_IAP(  1:204,1) = (  5: 10: 2035)';
  dep_IAP(205:284,1) = (2050:50: 6000)';
 
  lon_IAP            = double(lon_IAP);
  lat_IAP            = double(lat_IAP);
  dep_IAP            = double(dep_IAP);
  
  
% #########################################################################
% ######################################################################### 
% 3. AMOC-G Streamfunction Changes
clear AMOC*
cd('/Users/z5195509/Documents/7_AMOC_Proxy and Variability/8_AMOC_Streamfunction/')
load plot_AMOC_Streamfunction_V4_Ensemble_Observations_AMOC-IW_Cells_v2_3_AMOC_Decomposition_005Bin.mat
AMOC_SFygtn_ESM_005_LOW    (AMOC_SFygtn_ESM_005_LOW    ==0) = NaN;
AMOC_SFygtn_F_ESM_005_LOW  (AMOC_SFygtn_F_ESM_005_LOW  ==0) = NaN;
AMOC_SFygtn_N_ESM_005_LOW  (AMOC_SFygtn_N_ESM_005_LOW  ==0) = NaN;
AMOC_SFygtn_V_ESM_005_LOW  (AMOC_SFygtn_V_ESM_005_LOW  ==0) = NaN;
AMOC_SFygtn_dM_ESM_005_LOW (AMOC_SFygtn_dM_ESM_005_LOW ==0) = NaN;

AMOC_SFygtn_F_ESM_005_LOW   = nanmean(AMOC_SFygtn_F_ESM_005_LOW(:,:,:,2:5),4);
AMOC_SFygtn_Sub_ESM_005_LOW = nanmean(AMOC_SFygtn_N_ESM_005_LOW(:,:,:,2:5),4) + nanmean(AMOC_SFygtn_V_ESM_005_LOW(:,:,:,2:5),4) + nanmean(AMOC_SFygtn_dM_ESM_005_LOW(:,:,:,2:5),4);

% #########################################################################
% Calculate linear trend of AMOC streamfunction
% Trend from 1960 to 2023
for i = 1 : size(AMOC_SFygtn_F_ESM_005_LOW,1)
    disp(['AMOC trend# lon#',num2str(i),' #ESM'])
    for j = 1 : size(AMOC_SFygtn_F_ESM_005_LOW,2)
        % Air-Sea Flux
        p1                    = polyfit(21:size(AMOC_SFygtn_F_ESM_005_LOW,3),squeeze(AMOC_SFygtn_F_ESM_005_LOW(i,j,21:end))',1);
        AMOCyg_F_trend(i,j)   = p1(1,1); clear p1
        % Neutral Mixing
        p1                    = polyfit(21:size(AMOC_SFygtn_Sub_ESM_005_LOW,3),squeeze(AMOC_SFygtn_Sub_ESM_005_LOW(i,j,21:end))',1);
        AMOCyg_Sub_trend(i,j) = p1(1,1); clear p1
    end
end
clear i j 
AMOCyg_F_trend  (AMOCyg_F_trend  ==0) = NaN;
AMOCyg_Sub_trend(AMOCyg_Sub_trend==0) = NaN;
clear AMOC_SFyg*
% #########################################################################
% #########################################################################

  
% #########################################################################
% #########################################################################
% 3. Plotting dT/dz, and dS/dz Changes - IAPv4.2, EN4-ESM. SIO Argo, Ishii
time_ann(:,1) = (1940 :1: 2023)';
cd('/Users/z5195509/Documents/7_AMOC_Proxy and Variability/6_TS_Stratification_Changes/')


% #########################################################################
% #########################################################################
% 1. IAPv4.2
load(['cal_TS_Stratification_dTSdZ_DRv5_ESM_v1_2_IAPv42_TSG_500m_Ann_19402023.mat'],...
      'gamma_ATL_ann','CT_ATL_ann','SA_ATL_ann','dep_IAP','lon_IAP','lat_IAP','time_ann')

    gamma_ATL_clim(:,:,1) = squeeze(nanmean(nanmean(gamma_ATL_ann(:,:,1:11,65:84),4),3));
    SA_ATL_ann_100m(:,:,:)= squeeze(nanmean(SA_ATL_ann(:,:,1:11,:),3));
    dCT_ATL_ann (:,:,:,1) = squeeze((CT_ATL_ann(:,:,1,:) - CT_ATL_ann(:,:,11,:))./100);
    dSA_ATL_ann (:,:,:,1) = squeeze((SA_ATL_ann(:,:,1,:) - SA_ATL_ann(:,:,11,:))./100);
    clear CT_ATL_ann gamma_ATL_ann SA_ATL_ann
% #########################################################################


% #########################################################################
% 2. Ishii
load(['cal_TS_Stratification_dTSdZ_DRv5_ESM_v1_3_ISHII_TSG_500m_Ann_19552023.mat'],...
      'gamma_ATL_ann','CT_ATL_ann','SA_ATL_ann','dep_Ishii','lon_Ishii','lat_Ishii','time_ann')

    gamma_ATL_clim(:, 1:180,      2) = squeeze(nanmean(nanmean(gamma_ATL_ann(:,:,1:11,50:69),4),3)); 
    SA_ATL_ann_100m(:,1:180,16:84,2) = squeeze(nanmean(SA_ATL_ann(:,:,1:11,:),3));
    dCT_ATL_ann   (:, 1:180,16:84,2) = squeeze((CT_ATL_ann(:,:,1,:) - CT_ATL_ann(:,:,11,:))./100);
    dSA_ATL_ann   (:, 1:180,16:84,2) = squeeze((SA_ATL_ann(:,:,1,:) - SA_ATL_ann(:,:,11,:))./100);
    clear CT_ATL_ann gamma_ATL_ann SA_ATL_ann
% #########################################################################
    
    
% #########################################################################
% 3. EN4-ESM
load(['cal_TS_Stratification_dTSdZ_DRv5_ESM_v1_4_EN4_TSG_500m_Ann_19402023.mat'],...
      'gamma_ATL_ann','CT_ATL_ann','SA_ATL_ann','depth10','lon_EN4','lat_EN4','time_ann')

    gamma_ATL_clim(:, 8:180,     3) = squeeze(nanmean(nanmean(gamma_ATL_ann(:,:,1:11,65:84),4),3)); 
    SA_ATL_ann_100m(:,8:180,1:84,3) = squeeze(nanmean(SA_ATL_ann(:,:,1:11,:),3));
    dCT_ATL_ann   (:, 8:180,1:84,3) = squeeze((CT_ATL_ann(:,:,1,:) - CT_ATL_ann(:,:,11,:))./100);   
    dSA_ATL_ann   (:, 8:180,1:84,3) = squeeze((SA_ATL_ann(:,:,1,:) - SA_ATL_ann(:,:,11,:))./100);
    clear CT_ATL_ann gamma_ATL_ann SA_ATL_ann
% #########################################################################


% #########################################################################
% 4. SIO RG-Argo
load(['cal_TS_Stratification_dTSdZ_DRv5_ESM_v1_5_Argo_TSG_500m_Ann_20042023.mat'],...
      'gamma_ATL_ann','CT_ATL_ann','SA_ATL_ann','depth10','lon_RGArgo','lat_RGArgo','time_ann')

    gamma_ATL_clim(:, 26:170,      4) = squeeze(nanmean(nanmean(gamma_ATL_ann(:,:,1:11,:),4),3)); 
    SA_ATL_ann_100m(:,26:170,65:84,4) = squeeze(nanmean(SA_ATL_ann(:,:,1:11,:),3));
    dCT_ATL_ann   (:, 26:170,65:84,4) = squeeze((CT_ATL_ann(:,:,1,:) - CT_ATL_ann(:,:,11,:))./100);   
    dSA_ATL_ann   (:, 26:170,65:84,4) = squeeze((SA_ATL_ann(:,:,1,:) - SA_ATL_ann(:,:,11,:))./100);
    clear CT_ATL_ann gamma_ATL_ann SA_ATL_ann
% #########################################################################


% #########################################################################
gamma_ATL_clim(gamma_ATL_clim==0) = NaN;
SA_ATL_ann_100m(SA_ATL_ann_100m==0) = NaN;
dCT_ATL_ann   (dCT_ATL_ann   ==0) = NaN;
dSA_ATL_ann   (dSA_ATL_ann   ==0) = NaN;

% ESM
gamma_ATL_clim = nanmean(gamma_ATL_clim,3);
SA_ATL_ann_100m= nanmean(SA_ATL_ann_100m,4);
dCT_ATL_ann    = nanmean(dCT_ATL_ann,   4);
dSA_ATL_ann    = nanmean(dSA_ATL_ann,   4);
% #########################################################################
% #########################################################################

% Linear Trend from 1960 to 2023
for i=1:size(dCT_ATL_ann,1)
    disp(['dTS_dZ trend# lon#',num2str(i),' #ESM'])
    for j=1:size(dCT_ATL_ann,2)
        % 1960-2023
        p1=polyfit(21:size(dCT_ATL_ann,3),squeeze(dCT_ATL_ann(i,j,21:end))',1);
        dCT_ATL_trend(i,j)=p1(1);
        clear p1
        
        % 1960-2023
        p1=polyfit(21:size(dSA_ATL_ann,3),squeeze(dSA_ATL_ann(i,j,21:end))',1);
        dSA_ATL_trend(i,j)=p1(1);
        clear p1
        
        % 1960-2023
        p1=polyfit(21:size(SA_ATL_ann_100m,3),squeeze(SA_ATL_ann_100m(i,j,21:end))',1);
        SA_100m_trend(i,j)=p1(1);
        clear p1
    end
end
clear i j time mld0

cd('/Users/z5195509/Documents/7_AMOC_Proxy and Variability/8_AMOC_Streamfunction/')
% #########################################################################
% #########################################################################
  
  
  
  
%% #########################################################################
% #########################################################################
   figure('Color',[1 1 1]);  %create a new figure of white color background
   ixs = 0.04; ixe = 0.02;  ixd = 0.055; ixw = (1-ixs-ixe-2*ixd)/3;
   iys = 0.10; iye = 0.10;  iyd = 0.060; iyw = (1-iys-iye-1*iyd)/2;

   pos{11}    = [ixs+0*ixw+0*ixd     iys+0*iyw+0*iyd     ixw      2.0*iyw+1*iyd]; 
   
   pos{1211}  = [ixs+1*ixw+1.1*ixd   iys+1.6*iyw+1*iyd   0.86*ixw 0.4*iyw];
   pos{1212}  = [ixs+1*ixw+1.1*ixd   iys+1.0*iyw+1*iyd   0.86*ixw 0.6*iyw];
   
   pos{1221}  = [ixs+1*ixw+1.1*ixd   iys+0.6*iyw+0*iyd   0.86*ixw 0.4*iyw];
   pos{1222}  = [ixs+1*ixw+1.1*ixd   iys+0.0*iyw+0*iyd   0.86*ixw 0.6*iyw];
   
   pos{131}   = [ixs+1.91*ixw+2*ixd  iys+1.0*iyw+1*iyd   1.10*ixw 0.9*iyw]; 
   pos{132}   = [ixs+1.91*ixw+2*ixd  iys+0.0*iyw+0*iyd   1.10*ixw 0.9*iyw]; 

   ixw./iyw
   
% ######################################################################### 
    clear color color0 
    color0=cbrewer('div', 'RdBu', 40,'pchip');
    color0=color0(size(color0,1):-1:1,:);
% #########################################################################



% #########################################################################
% #########################################################################
% 1. AMOC Upper Limb Strength by Latitude 
% #########################################################################
cd('/Users/z5195509/Documents/7_AMOC_Proxy and Variability/8_AMOC_Streamfunction')
load('plot_AMOC_Streamfunction_V4_Ensemble_Observations_AMOC-IW_Cells_v2_2_AMOC_IW_v2_12Mon.mat',...
     'amoc_sigma_mon_corr','AMOC_SFygt_WOA_005_LOW')
load('plot_AMOC_Streamfunction_V4_Ensemble_Observations_AMOC-IW_Cells_v2_3_AMOC_Decomposition_005Bin.mat',...
     'AMOC_SFygtn_ESM_005_LOW','AMOC_SFygtn_F_ESM_005_LOW','AMOC_SFygtn_N_ESM_005_LOW','AMOC_SFygtn_V_ESM_005_LOW','AMOC_SFygtn_dM_ESM_005_LOW')
AMOC_SFygtn_Sub_ESM_005_LOW = AMOC_SFygtn_N_ESM_005_LOW + AMOC_SFygtn_V_ESM_005_LOW + AMOC_SFygtn_dM_ESM_005_LOW;
clear AMOC_SFygtn_N_ESM_005_LOW  AMOC_SFygtn_V_ESM_005_LOW  AMOC_SFygtn_dM_ESM_005_LOW
% #########################################################################


% #########################################################################
subplot('position',pos{11})
    % #####################################################################
    % RAPID At 26N
    line_LAT_ESM_26N  = plot(26.5,nanmean(amoc_sigma_mon_corr(:),1),'^','MarkerSize',25,'MarkerFaceColor', [0.494, 0.184, 0.556], 'MarkerFaceColor', [0.494, 0.184, 0.556]); 
    % set(line_LAT_ESM_26N,'color',[0.494, 0.184, 0.556],'LineWidth',2.0);
    % #####################################################################
          

    % #########################################################################
    % #########################################################################
    % AMOC Upper Limb Strength across Atlantic Latitudes from WMT-Based Streamfunction 
    % 0.05 Density Bin, Maximum in 10N-40N or 40N-65N, 0.1 smooth window 
      for data_num = 1 : size(AMOC_SFygtn_ESM_005_LOW,4)
          for year = 1 : size(AMOC_SFygtn_ESM_005_LOW,3)
              for lat = 1 : size(AMOC_SFygtn_ESM_005_LOW,2)
                  if sum(isnan(AMOC_SFygtn_ESM_005_LOW(:,lat,year,data_num)) == 0) >= 1 
                     % Upper Limb Strength, within 26.6 <= gamma <= 28.0 at each latitude
                     AMOC_time_upper_005    (lat,year,data_num)  = max(max( AMOC_SFygtn_ESM_005_LOW(112:140, lat, year,data_num)))./1e6;  

                     max_temp = find( AMOC_SFygtn_ESM_005_LOW(:,lat, year,data_num) == max(max( AMOC_SFygtn_ESM_005_LOW(112:140, lat, year,data_num))) );
                     AMOC_time_upper_005_F  (lat,year,data_num)  = AMOC_SFygtn_F_ESM_005_LOW  (max_temp,lat,year,data_num)./1e6;
                     AMOC_time_upper_005_Sub(lat,year,data_num)  = AMOC_SFygtn_Sub_ESM_005_LOW(max_temp,lat,year,data_num)./1e6;
                  else
                     AMOC_time_upper_005    (lat,year,data_num)  = NaN;  
                     AMOC_time_upper_005_F  (lat,year,data_num)  = NaN;
                     AMOC_time_upper_005_Sub(lat,year,data_num)  = NaN;  
                  end
              end
          end 
      end
      clear year data_num  
    % #########################################################################
    % #########################################################################


    % #####################################################################
    % #####################################################################
    % Uncertainty Range
    % Climatology strength during 1960-1980
    AMOC_time_upper_005_clim      = squeeze(nanmean(AMOC_time_upper_005(:,21:41,2:5),2));
    % Standard deviation
        for lat_num = 1:length(lat_IAP)
            hold on

            AMOC_time(:,1) = squeeze(AMOC_time_upper_005_clim(lat_num,:))';
            count=1;
            AMOC_time_noNaN(1,1) = NaN; 
            for k=1:size(AMOC_time,1)
                if isnan(AMOC_time(k,1))==0
                   AMOC_time_noNaN(count,1) = AMOC_time(k,1);
                   count=count+1;
                end
            end
            clear count k AMOC_time
            bar_std_ESM = std(AMOC_time_noNaN(:,1),1,1);
            clear AMOC_time_noNaN

            bar_LAT_ESM_6080  = errorbar(lat_IAP(lat_num),nanmean(AMOC_time_upper_005_clim(lat_num,:),2), bar_std_ESM); clear bar_std_ESM
            set(bar_LAT_ESM_6080,'color',[.9 .9 .9],'LineWidth',1.0,'linestyle','-');
        end
        clear lat_num 
        
        
    % Climatology strength during 1980-2000
    AMOC_time_upper_005_clim      = squeeze(nanmean(AMOC_time_upper_005(:,41:61,2:5),2));
    % Standard deviation
        for lat_num = 1:length(lat_IAP)
            hold on

            AMOC_time(:,1) = squeeze(AMOC_time_upper_005_clim(lat_num,:))';
            count=1;
            AMOC_time_noNaN(1,1) = NaN; 
            for k=1:size(AMOC_time,1)
                if isnan(AMOC_time(k,1))==0
                   AMOC_time_noNaN(count,1) = AMOC_time(k,1);
                   count=count+1;
                end
            end
            clear count k AMOC_time
            bar_std_ESM = std(AMOC_time_noNaN(:,1),1,1);
            clear AMOC_time_noNaN

            bar_LAT_ESM_8000  = errorbar(lat_IAP(lat_num),nanmean(AMOC_time_upper_005_clim(lat_num,:),2), bar_std_ESM); clear bar_std_ESM
            set(bar_LAT_ESM_8000,'color',[.9 .8 .8],'LineWidth',1.0,'linestyle','-');
        end
        clear lat_num 
        
        
    % Climatology strength during 2004-2023
    AMOC_time_upper_005_clim      = squeeze(nanmean(AMOC_time_upper_005(:,65:end,2:5),2));
    % Standard deviation
        for lat_num = 1:length(lat_IAP)
            hold on

            AMOC_time(:,1) = squeeze(AMOC_time_upper_005_clim(lat_num,:))';
            count=1;
            AMOC_time_noNaN(1,1) = NaN; 
            for k=1:size(AMOC_time,1)
                if isnan(AMOC_time(k,1))==0
                   AMOC_time_noNaN(count,1) = AMOC_time(k,1);
                   count=count+1;
                end
            end
            clear count k AMOC_time
            bar_std_ESM = std(AMOC_time_noNaN(:,1),1,1);
            clear AMOC_time_noNaN

            bar_LAT_ESM_0423  = errorbar(lat_IAP(lat_num),nanmean(AMOC_time_upper_005_clim(lat_num,:),2), bar_std_ESM); clear bar_std_ESM
            set(bar_LAT_ESM_0423,'color',[.6 .8 .9],'LineWidth',1.0,'linestyle','-');
        end
        clear lat_num 
    % #####################################################################
    % #####################################################################  
        
    
    
    % #####################################################################
    % #####################################################################
    % Mean AMOC upper limb strength decomposition
    % Climatology strength during 1980-2000
    % Air-Sea
    hold on
    AMOC_time_upper_005_clim_F    = squeeze(nanmean(nanmean(AMOC_time_upper_005_F(:,41:61,2:5),3),2));
    line_LAT_ESM_8000_F           = plot(lat_IAP,AMOC_time_upper_005_clim_F);    
    set(line_LAT_ESM_8000_F,'color',[0.9, 0.4, 0.4],'LineWidth',2.0,'linestyle','-');
    hold on
    AMOC_time_upper_005_clim_F    = squeeze(nanmean(nanmean(AMOC_time_upper_005_F(:,65:end,2:5),3),2));
    line_LAT_ESM_0423_F           = plot(lat_IAP,AMOC_time_upper_005_clim_F);    
    set(line_LAT_ESM_0423_F,'color',[0    , 0.447, 0.741],'LineWidth',2.0,'linestyle','-');
    
    % Subsurface
    hold on
    AMOC_time_upper_005_clim_Sub  = squeeze(nanmean(nanmean(AMOC_time_upper_005_Sub(:,41:61,2:5),3),2));
    line_LAT_ESM_8000_Sub         = plot(lat_IAP,AMOC_time_upper_005_clim_Sub);    
    set(line_LAT_ESM_8000_Sub,'color',[0.9, 0.4, 0.4],'LineWidth',2.0,'linestyle','--');
    hold on
    AMOC_time_upper_005_clim_Sub  = squeeze(nanmean(nanmean(AMOC_time_upper_005_Sub(:,65:end,2:5),3),2));
    line_LAT_ESM_0423_Sub         = plot(lat_IAP,AMOC_time_upper_005_clim_Sub);    
    set(line_LAT_ESM_0423_Sub,'color',[0    , 0.447, 0.741],'LineWidth',2.0,'linestyle','--');
    % #####################################################################
    % #####################################################################
    
    
    
    % #####################################################################
    % #####################################################################
    % Mean AMOC upper limb strength
    % Climatology strength during 1960-1980
    AMOC_time_upper_005_clim      = squeeze(nanmean(AMOC_time_upper_005(:,21:41,2:5),2));
    % Ensemble mean 
    for lat_num = 1:length(lat_IAP)
        hold on
        line_LAT_ESM_6080 = plot(lat_IAP(lat_num)-0.5: lat_IAP(lat_num)+0.5,nanmean(AMOC_time_upper_005_clim(lat_num,:),2).*ones(length(lat_IAP(lat_num)-0.5: lat_IAP(lat_num)+0.5),1));    
        set(line_LAT_ESM_6080,'color',[0.6, 0.6, 0.6],'LineWidth',16.0,'linestyle','-');
    end
    clear lat_num AMOC_time_upper_005_clim
    
    
    % Climatology strength during 1980-2000
    AMOC_time_upper_005_clim      = squeeze(nanmean(AMOC_time_upper_005(:,41:61,2:5),2));
    % Ensemble mean 
    for lat_num = 1:length(lat_IAP)
        hold on
        line_LAT_ESM_8000 = plot(lat_IAP(lat_num)-0.5: lat_IAP(lat_num)+0.5,nanmean(AMOC_time_upper_005_clim(lat_num,:),2).*ones(length(lat_IAP(lat_num)-0.5: lat_IAP(lat_num)+0.5),1));    
        set(line_LAT_ESM_8000,'color',[0.9, 0.4, 0.4],'LineWidth',16.0,'linestyle','-');
    end
    clear lat_num AMOC_time_upper_005_clim
    
    
    % Climatology strength during 2004-2023
    AMOC_time_upper_005_clim      = squeeze(nanmean(AMOC_time_upper_005(:,65:end,2:5),2));
    % Ensemble mean 
    for lat_num = 1:length(lat_IAP)
        hold on
        line_LAT_ESM_0423 = plot(lat_IAP(lat_num)-0.5: lat_IAP(lat_num)+0.5,nanmean(AMOC_time_upper_005_clim(lat_num,:),2).*ones(length(lat_IAP(lat_num)-0.5: lat_IAP(lat_num)+0.5),1));    
        set(line_LAT_ESM_0423,'color',[0    , 0.447, 0.741],'LineWidth',16.0,'linestyle','-');
    end
    clear lat_num AMOC_time_upper_005_clim
    % #####################################################################
    % #####################################################################
    
    

    % #####################################################################
    % RAPID At 26N
    line_LAT_ESM_26N  = plot(26.5,nanmean(amoc_sigma_mon_corr(:),1),'^','MarkerSize',25,'MarkerFaceColor', [0.494, 0.184, 0.556], 'MarkerEdgeColor', [0.494, 0.184, 0.556]); 
    % #####################################################################
        
    
    % #####################################################################
    % OSNAP AMOC
    cd('/Users/z5195509/Documents/7_AMOC_Proxy and Variability/9_AMOC_Subpolar_OSNAP/')
    MOC_OSNAP_Mon  = ncread('OSNAP_MOC_MHT_MFT_TimeSeries_201408_202006_2023.nc','MOC_ALL');
    hold on
    line_LAT_ESM_53N  = plot(53,nanmean(MOC_OSNAP_Mon(:),1),'^','MarkerSize',25,'MarkerFaceColor', [0.466, 0.674, 0.188], 'MarkerEdgeColor', [0.466, 0.674, 0.188]);    
    % #####################################################################

    
    % #####################################################################
    % SAMBA SAMOC % Kersale et al. (2020): The time-mean meridional volume transport from September 2013 to July 2017 is 17.3 ± 5.0 sverdrup (Sv) northward in the upper cell (time mean ± bias; 1 Sv = 10 6 m3 s?
    hold on
    line_LAT_ESM_34S  = plot(-34.5,17.3,'^','MarkerSize',25,'MarkerFaceColor', [0.929, 0.694, 0.125], 'MarkerEdgeColor', [0.929, 0.694, 0.125]);    
    % #####################################################################
    
  
    % #####################################################################    
    leg=legend([line_LAT_ESM_6080 line_LAT_ESM_8000 line_LAT_ESM_0423 line_LAT_ESM_8000_F line_LAT_ESM_8000_Sub line_LAT_ESM_0423_F line_LAT_ESM_0423_Sub line_LAT_ESM_34S line_LAT_ESM_26N line_LAT_ESM_53N],...
                  'Upper limb, 1960-1980',...
                  'Upper limb, 1980-2000',...
                  'Upper limb, 2004-2023',...
                  'Air-sea flux, 1980-2000',...
                  'Subsurface, 1980-2000',...
                  'Air-sea flux,       2004-2023',...
                  'Subsurface,       2004-2023',...
                  'SAMBA 34.5\circS, 2013-2017',...
                  'RAPID   26\circN,    2004-2023',...
                  'OSNAP array,    2014-2020',...
                  'Location','southwest','fontsize',14,'Orientation','vertical','NumColumns',2); %line_IW_IAPv4 'AMOC-upper limb, IAPv4',...
    set(leg,'fontsize',14)
    hold on
    %title(leg,'AMOC Strength','fontsize',20','color','k')
    legend('boxoff')
    % #####################################################################

      
    xlim([-40 68])
    set(gca,'XTick',-60:20:80)
    set(gca,'XTickLabel',{'60\circS','40\circS','20\circS','0','20\circN','40\circN','60\circN'},'FontSize',18)
    ylim([-4 30])
    set(gca,'YTick',0:5:25)
    set(gca,'YTickLabel',{'0','5','10','15','20','25'},'FontSize',18)
    set(gca,'tickdir','in','box','on')
    grid off
    set(gca,'GridColor',[.8 .8 .8],'GridAlpha',0.2,'GridLineStyle','-')

    ylabel('[ Sv ]','color','k','fontsize',18) % left y-axis
    xlabel(' Latitude ','color','k','fontsize',18) 
    title('a. AMOC upper limb strength','fontsize',22,'FontWeight','bold')
% #########################################################################
% #########################################################################




% #########################################################################
% #########################################################################
% % 3. AMOC-G Streamfunction Changes
% #########################################################################
% #########################################################################
subplot('position',pos{1211})
      imagesc(lat_IAP,dens_rag(1:end),smooth2a(AMOCyg_F_trend./1e6,2,1),...
                                             'AlphaData',~isnan(AMOCyg_F_trend));
      % ###################################################################
      % Contours
      hold on 
      [C012,h012]=contour(lat_IAP,dens_rag_005(1:end),nanmean(AMOCyg_ESM_005(:,:,2:5),3)./1e6,[-2 -2],'k-');
      set(h012,'color',[.2 .4 .6],'linewidth',1.5);
      v012=-2;
      clabel(C012,h012,v012,'labelspacing',300,'fontsize',14,'color',[.2 .2 .2])   
      
      hold on 
      [C02,h02]=contour(lat_IAP,dens_rag_005(1:end),nanmean(AMOCyg_ESM_005(:,:,2:5),3)./1e6,[9 9],'k-');
      set(h02,'color',[0.929, 0.694, 0.125],'linewidth',1.5);
      v02 = 9;
      clabel(C02,h02,v02,'labelspacing',500,'fontsize',14,'color',[.2 .2 .2])   
      hold on 
      [C03,h03]=contour(lat_IAP,dens_rag_005(1:end),nanmean(AMOCyg_ESM_005(:,:,2:5),3)./1e6,[2 2],'k-');
      set(h03,'color',[.8 .3 .3],'linewidth',1.5);
      v03=2;
      clabel(C03,h03,v03,'labelspacing',800,'fontsize',14,'color',[.2 .2 .2])    
      % ###################################################################
          

      
      xlim([-40 68])
      ylim([22.5 26.5])
      set(gca,'XTick',-60:20:60)
      set(gca,'XTickLabel',[],'FontSize',18)
      set(gca,'YTick',21:1:28.5)
      set(gca,'YTickLabel',{'21','22','23','24','25','26','27','28'},'FontSize',16)
      set(gca,'tickdir','in','box','on')
      grid off
      set(gca,'GridColor',[.8 .8 .8],'GridAlpha',0.2,'GridLineStyle','-')
      colormap(gca,color0)
      caxis([-0.10 0.10]);  
%       ylabel('Neutral density [ kg m^{-3} ]                                       ','color','k','fontsize',18) % left y-axis
      %xlabel(' Latitude ','color','k','fontsize',18) 
      title('b. Air-sea flux term trend','fontsize',22,'FontWeight','bold')
      
      % ################################################################### 
      % Only show top, left, and right boundaries
      set(gca,'box','off')              % remove full box
    % set(gca,'XAxisLocation','bottom') % keep bottom x-axis ticks
      set(gca,'YAxisLocation','left')   % keep left y-axis ticks
      set(gca,'XAxisLocation','top')
      % To re-draw only vertical axis lines:
      ax = gca;
      ax.XColor = 'k';  % show x-axis ticks and labels
      ax.YColor = 'k';  % show y-axis ticks and labels
      
      yl = ylim;              % current y-axis limits
      xl = xlim;              % current x-axis limits
      hold on
      line_bond_r1 = plot([xl(2) xl(2)], yl, 'k','linewidth',1.5);   % vertical line at right edge
      % ################################################################### 
      
      
subplot('position',pos{1212})
      imagesc(lat_IAP,dens_rag(1:end),smooth2a(AMOCyg_F_trend./1e6,2,1),...
                                             'AlphaData',~isnan(AMOCyg_F_trend));
      % ###################################################################
      % Contours
      hold on 
      [C012,h012]=contour(lat_IAP,dens_rag_005(1:end),nanmean(AMOCyg_ESM_005(:,:,2:5),3)./1e6,[-2 -2],'k-');
      set(h012,'color',[.2 .4 .6],'linewidth',1.5);
      v012=-2;
      clabel(C012,h012,v012,'labelspacing',300,'fontsize',14,'color',[.2 .2 .2])   
      
      hold on 
      [C02,h02]=contour(lat_IAP,dens_rag_005(116:end),nanmean(AMOCyg_ESM_005(116:end,:,2:5),3)./1e6,[9 9],'k-');
      set(h02,'color',[.8 .3 .3],'linewidth',2.5);
      v02 = 9;
      clabel(C02,h02,v02,'labelspacing',500,'fontsize',14,'color',[.2 .2 .2])  
      hold on 
      [C02,h02]=contour(lat_IAP,dens_rag_005(1:114),nanmean(AMOCyg_ESM_005(1:114,:,2:5),3)./1e6,[9 9],'k-');
      set(h02,'color',[0.929, 0.694, 0.125],'linewidth',1.5);
      v02 = 9;
      clabel(C02,h02,v02,'labelspacing',500,'fontsize',14,'color',[.2 .2 .2])  
      hold on 
      [C03,h03]=contour(lat_IAP,dens_rag_005(1:end),nanmean(AMOCyg_ESM_005(:,:,2:5),3)./1e6,[2 2],'k-');
      set(h03,'color',[.8 .3 .3],'linewidth',1.5);
      v03=2;
      clabel(C03,h03,v03,'labelspacing',800,'fontsize',14,'color',[.2 .2 .2])   
      % ###################################################################
          

      % ###################################################################
      % Subtropical Cell: MW
      dens_rag_01 = (21.1:0.1:28.9)';
      % 26N
      hold on
      line_UP_26N_tri  = plot(26,28.3,'^','MarkerSize',13,'MarkerFaceColor', [0.494, 0.184, 0.556], 'MarkerEdgeColor', [0.494, 0.184, 0.556]);
      set(line_UP_26N_tri,'color',[0.1, 0.1, 0.1], 'LineWidth', 1.5);
      text(29.5,28.24, '26\circN','fontsize',14,'FontWeight','normal'); 
    
      % 34.5S
      hold on
      line_UP_345S_tri  = plot(-34.5,28.3,'^','MarkerSize',13,'MarkerFaceColor', [0.929, 0.694, 0.125], 'MarkerEdgeColor', [0.929, 0.694, 0.125]);
      set(line_UP_345S_tri,'color',[0.1, 0.1, 0.1], 'LineWidth', 1.5);
      text(-31.5,28.24, '34.5\circS','fontsize',14,'FontWeight','normal'); 
      
      % 53N
      hold on
      line_UP_53N_tri  = plot(53,28.3,'^','MarkerSize',13,'MarkerFaceColor', [0.466, 0.674, 0.188], 'MarkerEdgeColor', [0.466, 0.674, 0.188]);
      set(line_UP_26N_tri,'color',[0.1, 0.1, 0.1], 'LineWidth', 1.5);
      text(56.0,28.24, '53\circN','fontsize',14,'FontWeight','normal'); 
      % ###################################################################
      
      
      % ################################################################### 
      % Density/depth with the max stremfunction
      cd('/Users/z5195509/Documents/7_AMOC_Proxy and Variability/8_AMOC_Streamfunction/')
      load('plot_AMOC_Streamfunction_V4_Ensemble_Observations_AMOC-IW_Cells_v2_3_AMOC_Decomposition_005Bin.mat','AMOC_SFygtn_ESM_005_LOW')
      AMOC_SFygtn_ESM_005_LOW (AMOC_SFygtn_ESM_005_LOW    ==0) = NaN;
      % 1980-2000
      AMOC_ESM_005 = nanmean(nanmean(AMOC_SFygtn_ESM_005_LOW(:,:,41:61,2:5),4),3)./1e6;
      for lat_num = 28:2:160%length(lat_IAP)
          if  sum(isnan(AMOC_ESM_005(:,lat_num))==0) >=1
              max_temp  =  find(AMOC_ESM_005(:,lat_num) == max(AMOC_ESM_005(112:140,lat_num)));
              hold on  
              line_max_strf =plot(lat_IAP(lat_num),dens_rag_005(max_temp,1),'-+','MarkerSize',9);
              set(line_max_strf,'color',[.9 .4 .4], 'LineWidth', 2.5);
              clear max_temp
          end
      end
      clear lat_num AMOC_density_max_strf_ESM_20042023 AMOC_ESM_005
      
      % 2004-2023
      AMOC_ESM_005 = nanmean(nanmean(AMOC_SFygtn_ESM_005_LOW(:,:,65:84,2:5),4),3)./1e6;
      for lat_num = 28:2:160%length(lat_IAP)
          if  sum(isnan(AMOC_ESM_005(:,lat_num))==0) >=1
              max_temp  =  find(AMOC_ESM_005(:,lat_num) == max(AMOC_ESM_005(112:140,lat_num)));
              hold on  
              line_max_strf =plot(lat_IAP(lat_num),dens_rag_005(max_temp,1),'-+','MarkerSize',10);
              set(line_max_strf,'color',[0    , 0.447, 0.741], 'LineWidth', 2.5);
              clear max_temp
          end
      end
      clear lat_num AMOC_density_max_strf_ESM_20042023 AMOC_ESM_005
      % ################################################################### 
      
      
      xlim([-40 68])
      ylim([26.5 28.3])
      set(gca,'XTick',-60:20:60)
      set(gca,'XTickLabel',[],'FontSize',18)
      set(gca,'YTick',26.5:0.5:28.5)
      set(gca,'YTickLabel',{'26.5','27','27.5','28','28.5'},'FontSize',16)
      set(gca,'tickdir','in','box','on')
      grid off
      set(gca,'GridColor',[.8 .8 .8],'GridAlpha',0.2,'GridLineStyle','-')
      colormap(gca,color0)
      caxis([-0.10 0.10]); 
      
      ylabel('                              Neutral density [ kg m^{-3} ]','color','k','fontsize',16) % left y-axis

      text(69,27.0,'[ Sv yr^{-1} ]','fontsize',16,'FontName','Arial')
      
      % ################################################################### 
      % Only show bottom, left, and right boundaries
      set(gca,'box','off')              % remove full box
      set(gca,'XAxisLocation','bottom') % keep bottom x-axis ticks
      set(gca,'YAxisLocation','left')   % keep left y-axis ticks

      % To re-draw only vertical axis lines:
      ax = gca;
      ax.XColor = 'k';  % show x-axis ticks and labels
      ax.YColor = 'k';  % show y-axis ticks and labels
      
      yl = ylim;              % current y-axis limits
      xl = xlim;              % current x-axis limits
      hold on
      line_bond_r2 = plot([xl(2) xl(2)], yl, 'k','linewidth',1.5);   % vertical line at right edge
      % ################################################################### 
% #########################################################################
% #########################################################################    
      


% #########################################################################
% #########################################################################
subplot('position',pos{1221})
      imagesc(lat_IAP,dens_rag(1:end),smooth2a(AMOCyg_Sub_trend./1e6,2,1),...
                                             'AlphaData',~isnan(AMOCyg_Sub_trend));      
      % ###################################################################
      % Contours
      hold on 
      [C012,h012]=contour(lat_IAP,dens_rag_005(1:end),nanmean(AMOCyg_ESM_005(:,:,2:5),3)./1e6,[-2 -2],'k-');
      set(h012,'color',[.2 .4 .6],'linewidth',1.5);
      v012=-2;
      clabel(C012,h012,v012,'labelspacing',300,'fontsize',14,'color',[.2 .2 .2])   
      
      hold on 
      [C02,h02]=contour(lat_IAP,dens_rag_005(1:end),nanmean(AMOCyg_ESM_005(:,:,2:5),3)./1e6,[9 9],'k-');
      set(h02,'color',[0.929, 0.694, 0.125],'linewidth',1.5);
      v02 = 9;
      clabel(C02,h02,v02,'labelspacing',500,'fontsize',14,'color',[.2 .2 .2])   
      hold on 
      [C03,h03]=contour(lat_IAP,dens_rag_005(1:end),nanmean(AMOCyg_ESM_005(:,:,2:5),3)./1e6,[2 2],'k-');
      set(h03,'color',[.8 .3 .3],'linewidth',1.5);
      v03=2;
      clabel(C03,h03,v03,'labelspacing',800,'fontsize',14,'color',[.2 .2 .2])    
      % ###################################################################
               
      
      xlim([-40 68])
      ylim([22.5 26.5])
      set(gca,'XTick',-60:20:60)
      set(gca,'XTickLabel',[],'FontSize',18)
      set(gca,'YTick',21:1:28.5)
      set(gca,'YTickLabel',{'21','22','23','24','25','26','27','28'},'FontSize',16)
      set(gca,'tickdir','in','box','on')
      grid off
      set(gca,'GridColor',[.8 .8 .8],'GridAlpha',0.2,'GridLineStyle','-')
      colormap(gca,color0)
      caxis([-0.10 0.10]); 
     %ylabel('Neutral density [ kg m^{-3} ]','color','k','fontsize',18) % left y-axis
     %xlabel(' Latitude ','color','k','fontsize',18) 
      title('c. Mixing and volume term trend','fontsize',22,'FontWeight','bold')
      
      
      % ################################################################### 
      % Only show top, left, and right boundaries
      set(gca,'box','off')              % remove full box
    % set(gca,'XAxisLocation','bottom') % keep bottom x-axis ticks
      set(gca,'YAxisLocation','left')   % keep left y-axis ticks
      set(gca,'XAxisLocation','top')
      % To re-draw only vertical axis lines:
      ax = gca;
      ax.XColor = 'k';  % show x-axis ticks and labels
      ax.YColor = 'k';  % show y-axis ticks and labels
      
      yl = ylim;              % current y-axis limits
      xl = xlim;              % current x-axis limits
      hold on
      line_bond_r1 = plot([xl(2) xl(2)], yl, 'k','linewidth',1.5);   % vertical line at right edge
      % ################################################################### 
      
      
subplot('position',pos{1222})
      imagesc(lat_IAP,dens_rag(1:end),smooth2a(AMOCyg_Sub_trend./1e6,2,1),...
                                             'AlphaData',~isnan(AMOCyg_Sub_trend));
      % ###################################################################
      % Contours 
      hold on 
      [C012,h012]=contour(lat_IAP,dens_rag_005(1:end),nanmean(AMOCyg_ESM_005(:,:,2:5),3)./1e6,[-2 -2],'k-');
      set(h012,'color',[.2 .4 .6],'linewidth',1.5);
      v012=-2;
      clabel(C012,h012,v012,'labelspacing',300,'fontsize',14,'color',[.2 .2 .2])   
      
      hold on 
      [C02,h02]=contour(lat_IAP,dens_rag_005(116:end),nanmean(AMOCyg_ESM_005(116:end,:,2:5),3)./1e6,[9 9],'k-');
      set(h02,'color',[.8 .3 .3],'linewidth',2.5);
      v02 = 9;
      clabel(C02,h02,v02,'labelspacing',500,'fontsize',14,'color',[.2 .2 .2])  
      hold on 
      [C02,h02]=contour(lat_IAP,dens_rag_005(1:114),nanmean(AMOCyg_ESM_005(1:114,:,2:5),3)./1e6,[9 9],'k-');
      set(h02,'color',[0.929, 0.694, 0.125],'linewidth',1.5);
      v02 = 9;
      clabel(C02,h02,v02,'labelspacing',500,'fontsize',14,'color',[.2 .2 .2])  
      hold on 
      [C03,h03]=contour(lat_IAP,dens_rag_005(1:end),nanmean(AMOCyg_ESM_005(:,:,2:5),3)./1e6,[2 2],'k-');
      set(h03,'color',[.8 .3 .3],'linewidth',1.5);
      v03=2;
      clabel(C03,h03,v03,'labelspacing',800,'fontsize',14,'color',[.2 .2 .2])   
      % ###################################################################
               

      % ###################################################################
      % 26N
      hold on
      line_UP_26N_tri  = plot(26,28.3,'^','MarkerSize',13,'MarkerFaceColor', [0.494, 0.184, 0.556], 'MarkerEdgeColor', [0.494, 0.184, 0.556]);
      set(line_UP_26N_tri,'color',[0.1, 0.1, 0.1], 'LineWidth', 1.5);
      text(29.5,28.24, '26\circN','fontsize',14,'FontWeight','normal'); 
    
      % 34.5S
      hold on
      line_UP_345S_tri  = plot(-34.5,28.3,'^','MarkerSize',13,'MarkerFaceColor', [0.929, 0.694, 0.125], 'MarkerEdgeColor', [0.929, 0.694, 0.125]);
      set(line_UP_345S_tri,'color',[0.1, 0.1, 0.1], 'LineWidth', 1.5);
      text(-31.5,28.24, '34.5\circS','fontsize',14,'FontWeight','normal'); 
      
      % 53N
      hold on
      line_UP_53N_tri  = plot(53,28.3,'^','MarkerSize',13,'MarkerFaceColor', [0.466, 0.674, 0.188], 'MarkerEdgeColor', [0.466, 0.674, 0.188]);
      set(line_UP_26N_tri,'color',[0.1, 0.1, 0.1], 'LineWidth', 1.5);
      text(56.0,28.24, '53\circN','fontsize',14,'FontWeight','normal'); 
      % ###################################################################
      
      
      % ################################################################### 
      % Density/depth with the max stremfunction
      cd('/Users/z5195509/Documents/7_AMOC_Proxy and Variability/8_AMOC_Streamfunction/')
      load('plot_AMOC_Streamfunction_V4_Ensemble_Observations_AMOC-IW_Cells_v2_3_AMOC_Decomposition_005Bin.mat','AMOC_SFygtn_ESM_005_LOW')
      AMOC_SFygtn_ESM_005_LOW (AMOC_SFygtn_ESM_005_LOW    ==0) = NaN;
      % 1980-2000
      AMOC_ESM_005 = nanmean(nanmean(AMOC_SFygtn_ESM_005_LOW(:,:,41:61,2:5),4),3)./1e6;
      for lat_num = 28:2:160%length(lat_IAP)
          if  sum(isnan(AMOC_ESM_005(:,lat_num))==0) >=1
              max_temp  =  find(AMOC_ESM_005(:,lat_num) == max(AMOC_ESM_005(112:140,lat_num)));
              hold on  
              line_max_strf =plot(lat_IAP(lat_num),dens_rag_005(max_temp,1),'-+','MarkerSize',9);
              set(line_max_strf,'color',[.9 .4 .4], 'LineWidth', 2.5);
              clear max_temp
          end
      end
      clear lat_num AMOC_density_max_strf_ESM_20042023 AMOC_ESM_005
      
      % 2004-2023
      AMOC_ESM_005 = nanmean(nanmean(AMOC_SFygtn_ESM_005_LOW(:,:,65:84,2:5),4),3)./1e6;
      for lat_num = 28:2:160%length(lat_IAP)
          if  sum(isnan(AMOC_ESM_005(:,lat_num))==0) >=1
              max_temp  =  find(AMOC_ESM_005(:,lat_num) == max(AMOC_ESM_005(112:140,lat_num)));
              hold on  
              line_max_strf =plot(lat_IAP(lat_num),dens_rag_005(max_temp,1),'-+','MarkerSize',10);
              set(line_max_strf,'color',[0    , 0.447, 0.741], 'LineWidth', 2.5);
              clear max_temp
          end
      end
      clear lat_num AMOC_density_max_strf_ESM_20042023 AMOC_ESM_005
      % ################################################################### 
      
      
      xlim([-40 68])
      ylim([26.5 28.3])
      set(gca,'XTick',-60:20:60)
      set(gca,'XTickLabel',{'60\circS','40\circS','20\circS','0','20\circN','40\circN','60\circN'},'FontSize',18)
      set(gca,'YTick',26.5:0.5:28.5)
      set(gca,'YTickLabel',{'26.5','27','27.5','28','28.5'},'FontSize',16)
      set(gca,'tickdir','in','box','on')
      grid off
      set(gca,'GridColor',[.8 .8 .8],'GridAlpha',0.2,'GridLineStyle','-')
      colormap(gca,color0)
      caxis([-0.10 0.10]); 
      ylabel('                              Neutral density [ kg m^{-3} ]','color','k','fontsize',16) % left y-axis
     %ylabel('Neutral density [ kg m^{-3} ]','color','k','fontsize',18) % left y-axis
      xlabel(' Latitude ','color','k','fontsize',18) 
     %title('d. Meso. mixing changes','fontsize',20,'FontWeight','bold')   
     
     
      % ################################################################### 
      % Only show bottom, left, and right boundaries
      set(gca,'box','off')              % remove full box
      set(gca,'XAxisLocation','bottom') % keep bottom x-axis ticks
      set(gca,'YAxisLocation','left')   % keep left y-axis ticks

      % To re-draw only vertical axis lines:
      ax = gca;
      ax.XColor = 'k';  % show x-axis ticks and labels
      ax.YColor = 'k';  % show y-axis ticks and labels
      
      yl = ylim;              % current y-axis limits
      xl = xlim;              % current x-axis limits
      hold on
      line_bond_r2 = plot([xl(2) xl(2)], yl, 'k','linewidth',1.5);   % vertical line at right edge
      % ################################################################### 
% #########################################################################
% #########################################################################

          
      hBar21 = colorbar('EastOutside');
      get(hBar21, 'Position') ;
      set(hBar21, 'Position', [ixs+1.86*ixw+1.1*ixd+0.008 iys+0.65*iyw+0*iyd 0.008 0.7*iyw+1*iyd]);
      set(hBar21,'ytick',-0.1:0.05:0.1,'yticklabel',{'<-0.1','-0.05','0','0.05','>0.1'},'fontsize',16,'FontName','Arial','LineWidth',1.2,'TickLength',0.043);
      
% #########################################################################
% #########################################################################




% #########################################################################
% #########################################################################
% 3. PLOTTING dT/dZ and -dS/dZ  - v2: Rectangular Projection
    
   ixs = 0.04; ixe = 0.02;  ixd = 0.055; ixw = (1-ixs-ixe-2*ixd)/3;
   iys = 0.10; iye = 0.10;  iyd = 0.060; iyw = (1-iys-iye-1*iyd)/2;
   pos{11}   = [ixs+0*ixw+0*ixd  iys+0*iyw+0*iyd   ixw 2.0*iyw+1*iyd]; 
   
   pos{1211}  = [ixs+1*ixw+1.1*ixd  iys+1.6*iyw+1*iyd   0.85*ixw 0.4*iyw];
   pos{1212}  = [ixs+1*ixw+1.1*ixd  iys+1.0*iyw+1*iyd   0.85*ixw 0.6*iyw];
   
   pos{1221}  = [ixs+1*ixw+1.1*ixd  iys+0.6*iyw+0*iyd   0.85*ixw 0.4*iyw];
   pos{1222}  = [ixs+1*ixw+1.1*ixd  iys+0.0*iyw+0*iyd   0.85*ixw 0.6*iyw];
   
   pos{131}  = [ixs+2.0*ixw+2*ixd  iys+1.0*iyw+1*iyd  0.86*ixw 1*iyw]; 
   pos{132}  = [ixs+2.0*ixw+2*ixd  iys+0.0*iyw+0*iyd  0.86*ixw 1*iyw];      


    clear color color0 
    color=cbrewer('div', 'PuOr', 46,'pchip');
    color0(1:40,:)=color(43:-1:4,:);
    
subplot('position',pos{131})
        m_proj('miller','lon',[-70 15],'lat',[35.5 77]);  
        m_pcolor(lon_IAP,lat_IAP,dCT_ATL_trend'.*100);
        shading flat
        
        
        % #################################################################
        % Neutral Density                 #######################
        hold on
        [C123,h123]=m_contour(lon_IAP,lat_IAP,gamma_ATL_clim',[26.6 26.6],'color',[0.5, 0.5, 0.5],'linewidth',2.5);
        v123=26.5;
        clabel(C123,h123,v123,'labelspacing', 1000,'fontsize',14,'color',[.2 .2 .2])
        hold on
        [C14,h14]  =m_contour(lon_IAP,lat_IAP,gamma_ATL_clim',[27.3 27.3],'color',[0.4, 0.4, 0.4],'linewidth',3.0);
        v14=27.2;
        clabel(C14,h14,v14,   'labelspacing', 1000,'fontsize',14,'color',[.2 .2 .2])
        hold on
        [C15,h15]  =m_contour(lon_IAP,lat_IAP,gamma_ATL_clim',[27.6 27.6],'color',[0.3, 0.3, 0.3],'linewidth',3.5);
        v15=27.6;
        clabel(C15,h15,v15,   'labelspacing',1000,'fontsize',14,'color',[.2 .2 .2])
        % #################################################################
        
        
        hold on
        m_grid('box','on','tickdir','in','linestyle','none','LineWidth',1.5,'ticklen',0.01,'fontsize',16,...
                    'xticklabels',[],'xaxislocation','bottom','xtick',[-180:20:180],'Rotation',0,...
                    'yaxislocation','left','ytick',[-80:10:80]);
        m_coast('patch',[0.6 0.6 0.6],'edgecolor',[0.4 0.4 0.4]); 
        
        hold on;
        colormap(gca,color0)
        caxis([-0.020 0.020]);
        
        title('d. Trend of dT/dz','fontsize',22,'FontWeight','bold')
        grid on
        
        hBar31 = colorbar('EastOutside');
        get(hBar31, 'Position') ;
        set(hBar31, 'Position', [ixs+2.86*ixw+2*ixd++0.008 iys+1.2*iyw+1*iyd 0.008 0.6*iyw]);
        set(hBar31,'ytick',-0.02:0.01:0.02,'yticklabel',{'<-2','-1','0','1','>2'},'fontsize',16,'FontName','Arial','LineWidth',1.2,'TickLength',0.057);
        ylabel(hBar31, '[ 10^{-2} \circC m^{-1} per century]','rotation',90,'fontsize',16);
        
% #########################################################################



% #########################################################################      
subplot('position',pos{132})
        m_proj('miller','lon',[-70 15],'lat',[35.5 77]); 
        m_pcolor(lon_IAP,lat_IAP,-dSA_ATL_trend'.*100);
        shading flat
        
        
        % #################################################################
        % Neutral Density                 #######################
        hold on
        [C123,h123]=m_contour(lon_IAP,lat_IAP,gamma_ATL_clim',[26.6 26.6],'color',[0.5, 0.5, 0.5],'linewidth',2.5);
        v123=26.5;
        clabel(C123,h123,v123,'labelspacing', 1000,'fontsize',14,'color',[.2 .2 .2])
        hold on
        [C14,h14]  =m_contour(lon_IAP,lat_IAP,gamma_ATL_clim',[27.3 27.3],'color',[0.4, 0.4, 0.4],'linewidth',3.0);
        v14=27.2;
        clabel(C14,h14,v14,   'labelspacing', 1000,'fontsize',14,'color',[.2 .2 .2])
        hold on
        [C15,h15]  =m_contour(lon_IAP,lat_IAP,gamma_ATL_clim',[27.6 27.6],'color',[0.3, 0.3, 0.3],'linewidth',3.5);
        v15=27.6;
        clabel(C15,h15,v15,   'labelspacing',1000,'fontsize',14,'color',[.2 .2 .2])
        % #################################################################
        
        
        hold on
        m_grid('box','on','tickdir','in','linestyle','none','LineWidth',1.5,'ticklen',0.01,'fontsize',16,...
                    'xaxislocation','bottom','xtick',[-180:20:180],'Rotation',0,...
                    'yaxislocation','left','ytick',[-80:10:80]);
        m_coast('patch',[0.6 0.6 0.6],'edgecolor',[0.4 0.4 0.4]); 
        
        hold on;
        colormap(gca,color0)
        caxis([-0.0026 0.0026]);
       
        title('e. Trend of -dS/dz','fontsize',22,'FontWeight','bold')
        xlabel('Latitude','fontsize',18,'FontWeight','normal')

        hBar32 = colorbar('EastOutside');
        get(hBar32, 'Position') ;
        set(hBar32, 'Position', [ixs+2.86*ixw+2*ixd++0.008 iys+0.2*iyw+0*iyd 0.008 0.6*iyw]);
        set(hBar32,'ytick',-0.002:0.001:0.002,'yticklabel',{'<-2','-1','0','1','>2'},'fontsize',16,'FontName','Arial','LineWidth',1.2,'TickLength',0.057);
        ylabel(hBar32, '[ 10^{-3} g kg^{-3} m^{-1} per century]','rotation',90,'fontsize',16);
        
% #########################################################################
% #########################################################################

cd('/Users/z5195509/Documents/7_AMOC_Proxy and Variability/8_AMOC_Streamfunction')

% #########################################################################  
% #########################################################################

