#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon May 25 10:47:31 2020

@author: khanh
"""
import numpy as np
import matplotlib.pyplot as plt
low_memory = False
from sklearn.ensemble import RandomForestRegressor
from sklearn.metrics import r2_score
import pandas as pd

def outlier(input_data):
    
    import numpy as np
    anomalies = []
    ind = []

    # Set upper and lower limit to 3 standard deviation
    input_data_std = np.std(input_data)
    input_data_mean = np.mean(input_data)
    anomaly_cut_off = input_data_std * 3
    
    lower_limit  = input_data_mean - anomaly_cut_off 
    upper_limit = input_data_mean + anomaly_cut_off
    # Generate outliers
    count = 0;
    for outlier in input_data:
        if outlier > upper_limit or outlier < lower_limit:
            anomalies.append(outlier)
            ind.append(count)
        count += 1;
    return anomalies, ind;

dates = []
hours = []
# ML
names = ['azusa','compton','glendora','sb','la_northMainSt',
        'la_lax','sanGabriel','santaClarita','anaheim','banning',
        'lakeElsinore','miraLoma','rubidoux','fontana','upland']
wroteName = ['Azusa','Compton','Glendora','San Bernardino','LA North Main St',
        'LAX','San Gabriel','Santa Clarita','Anaheim','Banning',
        'Lake Elsinore','Mira Loma','Rubidoux','Fontana','Upland']
total_features = ['ozone', 'no', 'no2', 'RH', 'TEMP', 'WINDIR', 'WINDSPEED']

iterate = 1
sum_rsq = 0
for loc in range(0, len(names)):
    for i in range(0,iterate):
        location = wroteName[loc]
        features = pd.read_csv("ML_data/valid_data/training/fill_" + names[loc] + ".csv")
        test_features = pd.read_csv("ML_data/valid_data/testing/fill_" + names[loc] + ".csv")
        dates = test_features.date
        hours = test_features.time
        training_results = np.array(features['ozone' + '_' + names[loc]])
        features = features.drop('ozone' + '_' + names[loc],axis = 1)
        features = features.drop('date', axis = 1)
        features = features.drop('time', axis = 1)
        # features = features.drop('WINDSPEED' + '_' + names[loc], axis = 1)
        # features = features.drop('WINDIR_azusa', axis = 1)
        # features = features.drop('WINDSPEED_azusa', axis = 1)
        # features = features.drop('temperature', axis = 1)
        # features = features.drop('RH', axis = 1)    
    
        
        features_list = list(features.columns)
        training_data = np.array(features)
        
        # test_results = np.array(test_features['ozone'])
        # test_features = test_features.drop('ozone', axis = 1)
        actual_results = test_features.iloc[:,2]
        test_features = test_features.drop('ozone' + '_' + names[loc], axis = 1)
        test_features = test_features.drop('date', axis = 1)
        test_features = test_features.drop('time', axis = 1)
        # test_features = test_features.drop('WINDSPEED' + '_' + names[loc], axis = 1)
        # test_features = test_features.drop('WINDIR_azusa', axis = 1)
        # test_features = test_features.drop('WINDSPEED_azusa', axis = 1)
        # test_features = test_features.drop('temperature', axis = 1)
        # test_features = test_features.drop('RH', axis = 1)    
    
        test_features_list = list(test_features.columns)
        test_data = np.array(test_features)
        
        est = RandomForestRegressor(n_estimators=32,
                                    max_features='auto',
                                    max_depth=None,
                                    min_samples_split=2,
                                    min_samples_leaf=8,
                                    min_weight_fraction_leaf=0,
                                    max_leaf_nodes=None,
                                    n_jobs=-1)
        
        est.fit(training_data,training_results)
        predicted_results = est.predict(test_data)
        
    # plt.scatter(predicted_results, actual_results)
    # remove outliers
    [ab, ind] = outlier(actual_results)
    x = []
    y = []
    d = []
    h = []
    
    for i in range(0, len(actual_results)):
        if i not in ind:
            x.append(actual_results[i])
            y.append(predicted_results[i])
            d.append(dates[i])
            h.append(hours[i])
    r2 = r2_score(x,y)
    plt.plot(x,y,'o')
    # calculate trendline
    z = np.polyfit(x,y,1)
    p = np.poly1d(z)
    plt.plot(x,p(x),"r--")
    ax = plt.axis()
    # the line equation
    print ("y=%.6fx+(%.6f)"%(z[0],z[1]))
    # plt.text(0,130, r'y='+str(z[0])+'x + '+str(z[1]))
    
    # plot 1:1 line
    xx = [0, max(ax)]
    yy = [0, max(ax)]
    plt.plot(xx,yy,"k")
    
    plt.text(0+0.005,max(ax)-0.01, "y = %.3fx+%.3f"%(z[0],z[1]))
    plt.text(0+0.005,max(ax)-0.02, r'$R^2$ = ' + "%.3f"%r2)
    plt.xlim((0, max(ax)))
    plt.ylim((0,max(ax)))
    plt.xlabel('Actual 2020 Ozone Conc.')
    plt.ylabel('ML Predicted 2020 Ozone Conc.')
    plt.title("ML's Prediction of 2020 Ozone Conc. " + wroteName[loc])
    plt.savefig('ML 2020 Ozone' + wroteName[loc], format='jpeg')
    
    # write the header
    with open(location+'.csv', 'a') as f:
        f.write('Date'+','+'Time'+','+'ML_ozone_2020'+','+'actual_ozone_2020')
        f.write('\n')
    with open(location+'.csv', 'a') as f:
        for i in range(0,len(h)):
            f.write(str(d[i])+','+str(h[i])+','+str(y[i])+','+str(x[i])+'\n')
    plt.close()





        
        
        
        
        
        
        