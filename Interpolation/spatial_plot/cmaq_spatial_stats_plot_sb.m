latitude = [33.83062; 34.10002; 34.06659; 34.106678; 34.1365; 34.2431; 34.1326; 34.05977; 33.99958; 33.95507; 34.056416];
longitude = [-117.93845; -117.49201; -118.22688; -117.274063; -117.92391; -117.27235; -118.1272; -117.14731; -117.41601; -118.43049; -117.598216];
locations = ["anaheim", "fontana", "la", "sb", "azusa", "crestline", "pasadena", "redlands", "rubidoux","LAX","ONT"];

% CSV observation import
% Azusa
azusa = readtable('/media/khanh/Seagate Backup Plus Drive1/Shared Drives/Air Quality Modeling and Exposure Lab/AQMD Ozone Project/Evaluation/Stats/PST/CMAQ Eval Stats_9Sites/2017/Azusa_O3_stats.csv');
% Crestline
crestline = readtable('/media/khanh/Seagate Backup Plus Drive1/Shared Drives/Air Quality Modeling and Exposure Lab/AQMD Ozone Project/Evaluation/Stats/PST/CMAQ Eval Stats_9Sites/2017/crestline_O3_stats.csv');
% Fontana
fontana = readtable('/media/khanh/Seagate Backup Plus Drive1/Shared Drives/Air Quality Modeling and Exposure Lab/AQMD Ozone Project/Evaluation/Stats/PST/CMAQ Eval Stats_9Sites/2017/Fontana_O3_stats.csv');
% Los Angeles
la = readtable('/media/khanh/Seagate Backup Plus Drive1/Shared Drives/Air Quality Modeling and Exposure Lab/AQMD Ozone Project/Evaluation/Stats/PST/CMAQ Eval Stats_9Sites/2017/Los_Angeles_O3_stats.csv');
% pasadena
pasadena = readtable('/media/khanh/Seagate Backup Plus Drive1/Shared Drives/Air Quality Modeling and Exposure Lab/AQMD Ozone Project/Evaluation/Stats/PST/CMAQ Eval Stats_9Sites/2017/pasadena_O3_stats.csv');
% redlands
redlands = readtable('/media/khanh/Seagate Backup Plus Drive1/Shared Drives/Air Quality Modeling and Exposure Lab/AQMD Ozone Project/Evaluation/Stats/PST/CMAQ Eval Stats_9Sites/2017/redlands_O3_stats.csv');
% Rubidoux
rubidoux = readtable('/media/khanh/Seagate Backup Plus Drive1/Shared Drives/Air Quality Modeling and Exposure Lab/AQMD Ozone Project/Evaluation/Stats/PST/CMAQ Eval Stats_9Sites/2017/Rubidoux_stats.csv');
% San Bernardino
sb = readtable('/media/khanh/Seagate Backup Plus Drive1/Shared Drives/Air Quality Modeling and Exposure Lab/AQMD Ozone Project/Evaluation/Stats/PST/CMAQ Eval Stats_9Sites/2017/San_Bernardino_O3_stats.csv');
% Anaheim
obs = readtable('/media/khanh/Seagate Backup Plus Drive1/Shared Drives/Air Quality Modeling and Exposure Lab/AQMD Ozone Project/Evaluation/Stats/UTC/CMAQ Eval Stats_9Sites/2017/Anaheim_O3_stats.csv');
anaheim = readtable('/media/khanh/Seagate Backup Plus Drive1/Shared Drives/Air Quality Modeling and Exposure Lab/AQMD Ozone Project/Evaluation/Stats/UTC/CMAQ Eval Stats_9Sites/2017/Anaheim_O3_stats.csv');
obs_date = "";
obs_O3 = [];
m_O3 = [];
azusaO3 = []; fontanaO3 = []; crestlineO3 = []; laO3 = []; pasadenaO3 = []; redlandsO3 = []; sbO3 = []; rubidouxO3 = []; anaheimO3 = [];
vars = [14 15 16 17]; %[RMSE rRMSE MAE MBE]
tit = ["RMSE" "rRMSE" "MAE" "MBE"];
for var=1:length(vars)
% for var=2:3
    for i=1:length(anaheim.Date)
       obs_date(i) =  datestr(anaheim.Date(i));
       obs_O3(i) = anaheim.(vars(var))(i);
       m_O3(i) = obs.(vars(var))(i)*(-1);

       azusaO3(i) = azusa.(vars(var))(i);
       crestlineO3(i) = crestline.(vars(var))(i);
       fontanaO3(i) = fontana.(vars(var))(i);
       laO3(i) = la.(vars(var))(i);
       pasadenaO3(i) = pasadena.(vars(var))(i);
       redlandsO3(i) = redlands.(vars(var))(i);
       rubidouxO3(i) = rubidoux.(vars(var))(i);
       sbO3(i) = sb.(vars(var))(i)*(-1);
       anaheimO3(i) = anaheim.(vars(var))(i);
    end
    if var==4
        anaheimO3 = anaheimO3*(-1);
        azusaO3 = azusaO3*(-1);
        crestlineO3 = crestlineO3*(-1);
        fontanaO3 = fontanaO3*(-1);
        laO3 = laO3*(-1);
        pasadenaO3 = pasadenaO3*(-1);
        redlandsO3 = redlandsO3*(-1);
        rubidouxO3 = rubidouxO3*(-1);
        sbO3 = sbO3*(-1);
        obs_O3 = obs_O3*(-1);
    end
    anaheimO3(anaheimO3==Inf) = NaN;
    azusaO3(azusaO3==Inf) = NaN;
    crestlineO3(crestlineO3==Inf) = NaN;
    fontanaO3(fontanaO3==Inf) = NaN;
    laO3(laO3==Inf) = NaN;
    pasadenaO3(pasadenaO3==Inf) = NaN;
    redlandsO3(redlandsO3==Inf) = NaN;
    rubidouxO3(rubidouxO3==Inf) = NaN;
    sbO3(sbO3==-Inf) = NaN;
    obs_O3(anaheimO3==-Inf) = NaN;
    maxi=max([max(azusaO3), max(anaheimO3), max(crestlineO3), max(fontanaO3), max(laO3), max(pasadenaO3), max(redlandsO3), max(rubidouxO3)]);
    mini=min([min(azusaO3), min(anaheimO3), min(crestlineO3), min(fontanaO3), min(laO3), min(pasadenaO3), min(redlandsO3), min(rubidouxO3)]);
    temp = [anaheimO3; fontanaO3; laO3; sbO3; azusaO3; crestlineO3; pasadenaO3; redlandsO3; rubidouxO3];

    for i=1:length(anaheimO3)
%     for i=1:5
        s2 = shaperead('dc33871f-031d-4dc2-bec7-f43f2f02e99e202044-1-h8gavz.0eutq.shp');
        plot([s2.X],[s2.Y],'k','LineWidth',2);
        hold on
        s1 = shaperead('cb_2018_us_county_20m.shp');
        plot([s1.X],[s1.Y],'k')
        xlim([-120, -114.8])
        ylim([32.5, 35.3])
%         scatter(longitude(1:3),latitude(1:3),50,temp(1:3,i),'filled');
%         hold on
%         scatter(longitude(5:9),latitude(5:9),50,temp(5:9,i),'filled');
        s=scatter(longitude(1:9),latitude(1:9),50,temp(1:9,i),'filled');
        if var == 4
            cb = colorbar; colormap(flipud(brewermap([],'RdBu')));s.MarkerEdgeColor='k'; s.MarkerEdgeAlpha=0.3;
        else
            cb = colorbar; colormap('jet');s.MarkerEdgeColor='k'; s.MarkerEdgeAlpha=0.3;
        end
        %colormap(bluewhitered);
        ylabel(cb, tit(var));
        caxis([mini,maxi]);
        if var == 2
            caxis([mini,0.7])
        end
        pause(0.01)
        xlabel(obs_date(i))
        title(tit(var)+' of Model and Observation for $O_{3}$', 'Interpreter','latex')
        fname = '/home/khanh/Temp/CMAQ_paper/plots/';
    %     print -depsc2 -painters pst_date_time(i).eps
%         saveas(gcf, fullfile(fname, tit(var)+ ' '+ obs_date(i)),'epsc')
        exportgraphics(gcf, fullfile(fname, tit(var)+ ' '+ obs_date(i)+'.jpg'),'Resolution',500)
        hold off
    end
end