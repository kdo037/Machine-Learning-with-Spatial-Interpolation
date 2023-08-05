#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Aug 23 12:28:29 2021

@author: khanh
"""

import numpy as np
import matplotlib.pyplot as plt
import csv
low_memory = False
from sklearn.metrics import r2_score
from mpl_toolkits.axes_grid1 import make_axes_locatable
import geopandas as gpd
from scipy.interpolate import RBFInterpolator

method = 'IDW Interpolation'
# date = []
# hours = []
# ML

wroteName = ["Anaheim","Azusa","Banning","Compton","Fontana","Glendora",
    "Lake Elsinore","LAX","LA North Main St","Mira Loma",
    "Rubidoux",
    "San Gabriel","Santa Clarita","San Bernardino","Upland"]

latitude = [33.83061, 34.13648, 33.92077, 33.90145, 34.10015, 34.14437,
    33.67653, 33.95507, 34.06653, 33.99636,
    33.99952, 
    34.01029, 34.38337, 34.10668, 34.10367]
longitude = [-117.93850, -117.92392, -116.85841, -118.20499, -117.49198, -117.85038,
    -117.33104, -118.43049, -118.22676, -117.49240,
    -117.41595,
    -118.06850, -118.52839, -117.27406, -117.62906]
names = ["Anaheim","Azusa","Banning","Compton","Fontana","Glendora",
    "Lake Elsinore","LAX","LA North Main ST","Mira Loma",
    "Rubidoux",
    "San Gabriel","Santa Clarita","San Bernardino","Upland"]

additional_sites = ['Crestline','La Habra','Long Beach-Signal Hill','Mission Viejo-26081 Via Pera','North Hollywood',
              'Pasadena-S Wilson Avenue','Perris','Pomona','Redlands-Dearborn','Reseda',
              'West Los Angeles-VA Hospital','Winchester-33700 Borel Road']
additional_latitude = [34.24313, 33.92505, 33.79371, 33.63005, 34.18198, 
                       34.13265, 33.78933, 34.06698, 34.05965, 34.19920,
                       34.05109, 33.58302]
additional_longitude = [-117.27230, -117.95259, -118.17102, -117.67588, -118.36304, 
                        -118.12714, -117.22764, -117.75138, -117.14734, -118.53275,
                        -118.45640, -117.07220]
common_d = []
common_t = []

print('Processing data ...')
# Find common date and time for 15 ML sites
for loc in range(0, len(names)):
    lines = []
    with open('ML_results/' + wroteName[loc] + '.csv', 'r', encoding = 'utf-8', errors = 'ignore') as readFile:
        reader = csv.reader(readFile)
        lines = list(reader)
    
    d = []
    t = []  
    temp_d = []
    temp_t = []
    for i in range(1, len(lines)):
        d.append(lines[i][0])
        t.append(lines[i][1])
    if loc == 0:
        common_d = d
        common_t = t
    else:
        for i in range(0, len(common_d)):
            for j in range(0, len(d)):
                if common_d[i] == d[j] and common_t[i] == t[j]:
                    temp_d.append(common_d[i])
                    temp_t.append(common_t[i])
        common_d = temp_d
        common_t = temp_t
    # print(loc)
print('Processing data: completed find common date and time for 15 ML sites')

# Find common date and time for 12 additional sites which use to evaluate
for loc in range(0, len(additional_sites)):
    lines = []
    with open('aqmis/aq/ozone_additional_sites/' + additional_sites[loc] + '.csv', 'r', encoding = 'utf-8', errors = 'ignore') as readFile:
        reader = csv.reader(readFile)
        lines = list(reader)
    d = []
    t = []  
    temp_d = []
    temp_t = []
    for i in range(1, len(lines)):
        d.append(lines[i][1].replace('-', '/'))
        temp = ''
        temp = lines[i][2]
        if len(temp) == 1:
            t.append('0' + temp + ':00:00')
        else:
            t.append(temp + ':00:00')

    for i in range(0, len(common_d)):
        for j in range(0, len(d)):
            if common_d[i] == d[j] and common_t[i] == t[j]:
                temp_d.append(common_d[i])
                temp_t.append(common_t[i])
    common_d = temp_d
    common_t = temp_t
    # print(loc)
print('Processing data: completed find common date and time for 12 additional sites for evaluation')

# Get data for 15 ML sites
d = [[] for _ in range(15)]
t = [[] for _ in range(15)]
o3 = [[] for _ in range(15)]
obs_o3 = [[] for _ in range(15)]

for loc in range(0, len(names)):
    lines = []
    with open('ML_results/' + wroteName[loc] + '.csv', 'r', encoding = 'utf-8', errors = 'ignore') as readFile:
        reader = csv.reader(readFile)
        lines = list(reader)
    temp_d = []
    temp_t = []
    temp_o3 = []
    temp_obs_o3 = []
    for i in range(1, len(lines)):
        temp_d.append(lines[i][0])
        temp_t.append(lines[i][1])
        temp_o3.append(float(lines[i][2]))
        temp_obs_o3.append(float(lines[i][3]))
    for i in range(0, len(common_d)):
        for j in range(0, len(lines)-1):
            if common_d[i] == temp_d[j] and common_t[i] == temp_t[j]:
                d[loc].append(temp_d[j])
                t[loc].append(temp_t[j])
                o3[loc].append(temp_o3[j])
                obs_o3[loc].append(temp_obs_o3[j])
    # print(loc)
print('Processing data: completed get data for 15 ML sites')

# getting data for additional sites
additional_d = [[] for _ in range(12)]
additional_t = [[] for _ in range(12)]
additional_o3 = [[] for _ in range(12)]
for loc in range(0, len(additional_sites)):
    lines = []
    with open('aqmis/aq/ozone_additional_sites/' + additional_sites[loc] + '.csv', 'r', encoding = 'utf-8', errors = 'ignore') as readFile:
        reader = csv.reader(readFile)
        lines = list(reader)
    temp_d = []
    temp_t = []
    temp_o3 = []
    for i in range(1, len(lines)):
        temp_d.append(lines[i][1].replace('-', '/'))
        temp_o3.append(lines[i][3])
        temp = ''
        temp = lines[i][2]
        if len(temp) == 1:
            temp_t.append('0' + temp + ':00:00')
        else:
            temp_t.append(temp + ':00:00')
            
    for i in range(0, len(common_d)):
        for j in range(0, len(lines)-1):
            if common_d[i] == temp_d[j] and common_t[i] == temp_t[j]:
                additional_d[loc].append(temp_d[j])
                additional_t[loc].append(temp_t[j])
                additional_o3[loc].append(float(temp_o3[j]))
    # print(loc)
print('Processing data: completed get data for 12 additinal sistes')

interp_d_data = [[] for _ in range(15)]
interp_t_data = [[] for _ in range(15)]
interp_o3_data = [[] for _ in range(15)]
interp_add_o3_data = [[] for _ in range(15)]
o3_pm = [[] for _ in range(15)]
obs_o3_pm = [[] for _ in range(15)]
add_o3_pm = [[] for _ in range(15)]
print('Interpolating ...')
with open('interp.csv', 'a') as f:
    f.write('Date' + ',' + 'Time' + ',' + 'Latitude' + ',' + 'Longitude' + ',' + 'Ozone')
    f.write('\n')
    for dt in range(0, len(d[0])):
        # if int(t[loc][dt].split(':')[0]) >= 12 and int(t[loc][dt].split(':')[0]) <= 17:
            lat = np.linspace(min(latitude), max(latitude), 50)
            lon = np.linspace(min(longitude), max(longitude), 50)
            interp_o3 = []
            for loc in range(0, len(names)):
                interp_o3.append(float(o3[loc][dt]))
                o3_pm[loc].append(float(o3[loc][dt]))
                obs_o3_pm[loc].append(float(obs_o3[loc][dt]))

            # different interpolation methods      
            lon_range = max(longitude) - min(longitude)
            lat_range = max(latitude) - min(latitude)
            xygrid = np.mgrid[min(longitude):max(longitude):lon_range/50, min(latitude):max(latitude):lat_range/50]
            xflat = xygrid.reshape(2, -1).T
            yflat = RBFInterpolator(np.transpose(np.array([longitude, latitude])), interp_o3, 
                                    kernel='inverse_multiquadric', epsilon=3)(xflat)
            ygrid = yflat.reshape(xygrid.shape[1], xygrid.shape[2])
            
            
            # interpolation using IDW
            
            # get data for additional sites
            add_o3 = []
            x = []
            y = []
            for add_loc in range(0, len(additional_sites)):
                x.append(np.argmin(abs(lon-additional_longitude[add_loc])))
                y.append(np.argmin(abs(lat-additional_latitude[add_loc])))
                # get interpolated data
                interp_add_o3_data[add_loc].append(ygrid[y[add_loc]][x[add_loc]])
                
                add_o3_pm[add_loc].append(float(additional_o3[add_loc][dt]))
                add_o3.append(float(additional_o3[add_loc][dt]))
            
            # find the closest lat and lon upon locations
            x = []
            y = []
            interp_d = []
            interp_t = []
            interp_o3 = []
            for loc in range(0, len(names)):
                x.append(np.argmin(abs(lon-longitude[loc])))
                y.append(np.argmin(abs(lat-latitude[loc])))
                # get interpolated data
                interp_o3_data[loc].append(ygrid[y[loc]][x[loc]])
                interp_d_data[loc].append(d[loc][dt])
                interp_t_data[loc].append(t[loc][dt])
                interp_o3.append(ygrid[y[loc]][x[loc]])
                interp_d.append(d[loc][dt])
                interp_t.append(t[loc][dt])
            
            # find min and max of z for ploting the tight axis
            mini = 1000
            maxi = 0
            for i in range(0, (xygrid.shape[1])):
                for j in range(0, (xygrid.shape[2])):
                    if ygrid[i][j] <= mini:
                        mini = ygrid[i][j]
                    if ygrid[i][j] >= maxi:
                        maxi = ygrid[i][j]
                        
            # kt.write_asc_grid(lat, lon, z, filename="output.asc")
            plt.tight_layout()
            # color_map = plt.imshow(z)
            fig, ax = plt.subplots()
            ax.imshow(ygrid, cmap=plt.cm.Reds, interpolation='none', extent=[min(lon),max(lon),min(lat),max(lat)])
            mesh = ax.pcolormesh(lon,lat,np.array(ygrid)[0:50, 0:50], shading='auto')
            cbar = fig.colorbar(mesh)
            cbar.mappable.set_clim(mini,maxi)
            cbar.remove()
            
            # scatter plot for 15 ML sites
            plt.scatter(longitude, latitude, 50, c=interp_o3)
            plt.xlim([min(lon), max(lon)])
            plt.ylim([min(lat), max(lat)])
            cbar=plt.colorbar()
            cbar.mappable.set_clim(mini,maxi)
            # cbar.remove()
            plt.title(method)
            # plt.savefig(d[loc][dt].split('/')[0] + d[loc][dt].split('/')[1] +d[loc][dt].split('/')[2] + '_' + t[loc][dt] + '.png', dpi = 300)
            plt.close()
            
            #######################################
            # # scatter plot for 12 additional sites
            # plt.scatter(additional_longitude, additional_latitude, 50, c=add_o3, edgecolors='white')
            # # plot location that from the heat map
            # plt.scatter(lon[x], lat[y], 50, color='r')
            
            # # scatter plot for retrieve interpolated z data based on 15 sites lat and lon
            # conc = []
            # for i in range(0, len(interp_o3)):
            #     conc.append(interp_o3[i][0])
            # plt.scatter(lon[x], lat[y], 50, c=conc)
            # plt.xlim([min(lon), max(lon)])
            # plt.ylim([min(lat), max(lat)])
            # ax = plt.gca()
            # divider = make_axes_locatable(ax)
            # cax = divider.append_axes("right", size="5%", pad=0.05)
            # cbar=plt.colorbar(cax=cax)
            # cbar.mappable.set_clim(mini,maxi)
            # # cbar.remove()
            # plt.savefig('test.png', dpi=300)
            # plt.show()
            # ######################################


            # plot with additional 12 sites
            fig, ax = plt.subplots()
            ax.imshow(ygrid, cmap=plt.cm.Reds, interpolation='none', extent=[min(lon),max(lon),min(lat),max(lat)])
            mesh = ax.pcolormesh(lon,lat,np.array(ygrid)[0:50, 0:50], shading='auto')
            cbar = fig.colorbar(mesh)
            cbar.mappable.set_clim(mini,maxi)
            cbar.remove()
            
            # plot shapefile
            shapefile = gpd.read_file('spatial_plot/cb_2018_us_county_20m.shp')
            shapefile.plot(ax = ax, color='none', edgecolor='black')
            plt.xlim(-120, -114)
            plt.ylim(32, 35)
            
            # # scatter plot for retrieve interpolated z data based on 15 sites lat and lon
            # plt.scatter(lon[x], lat[y], 50, c=interp_o3, edgecolors='white')
            # plt.xlim([min(lon), max(lon)])
            # plt.ylim([min(lat), max(lat)])
            
            # scatter plot for 15 ML sites
            plt.scatter(longitude, latitude, 50, c=interp_o3)
            plt.xlim([min(lon), max(lon)])
            plt.ylim([min(lat), max(lat)])
            cbar=plt.colorbar()
            cbar.mappable.set_clim(mini,maxi)
            cbar.remove()
            plt.title(method)

            
            #scatter plot for 12 additional sites
            plt.scatter(additional_longitude, additional_latitude, 50, c=add_o3, edgecolors='white')
            ax = plt.gca()
            divider = make_axes_locatable(ax)
            cax = divider.append_axes("right", size="5%", pad=0.05)
            cbar=plt.colorbar(cax=cax)
            cbar.mappable.set_clim(mini,maxi)
            cbar.set_label('Ozone Concentrations [PPM]')
            fig.subplots_adjust(wspace=0.05, hspace=0.4, right=0.8)   

            plt.savefig(d[loc][dt].split('/')[0] + d[loc][dt].split('/')[1] +d[loc][dt].split('/')[2] + '_' + t[loc][dt][0:2] + '_additional_sites.png', dpi = 300)
            plt.close()
print('Interpolating: completed')

                        
# scatter plots for interp O3 from idw and observed O3      
print('Plotiing scatter plots ...')
for i in range(0, len(names)):
    
    x = interp_o3_data[i]
    y = obs_o3_pm[i]
    r2 = r2_score(x,y)
    corr_matrix = np.corrcoef(x,y)
    corr = corr_matrix[0,1]
    r2 = corr**2
    # calculate trendline
    z = np.polyfit(x,y,1)
    p = np.poly1d(z)
    plt.plot(x,p(x),"r--")
    ax = plt.axis()
    # the line equation
    print ("y=%.6fx+(%.6f)"%(z[0],z[1]))
    # plt.text(0,130, r'y='+str(z[0])+'x + '+str(z[1]))
    
    # plot 1:1 line
    xx = [min(ax), max(ax)]
    yy = [min(ax), max(ax)]
    plt.plot(xx,yy,"k")
    plt.axis('square')
    plt.scatter(interp_o3_data[i], obs_o3_pm[i], alpha = 0.5)
    plt.xlabel('Interp ML O3')
    plt.ylabel('Observed O3')
    plt.title(names[i])
    
    plt.text(min(ax)+0.001,max(ax)-0.005, "y = %.3fx+%.3f"%(z[0],z[1]))
    plt.text(min(ax)+0.001,max(ax)-0.01, r'$R^2$ = ' + "%.3f"%r2)
    plt.xlim((min(ax), max(ax)))
    plt.ylim((min(ax),max(ax)))
    plt.title(method)
        
    plt.savefig('scatter ' + names[i], dpi = 300)
    plt.close()
print('Plotiing scatter plots: completed')

# write csv file out for ML sites (Date, time, ML interp, Obs)
print('Writing CSV outputs for ML sites ...')
for i  in range(0, len(names)):
    with open(names[i] + '.csv', 'a') as f:
        f.write('Date' + ',' + 'Time' + ',' + 'Ozone_ML_sites' + ',' + 'Ozone_Observe')
        f.write('\n')
        for j in range(0, len(interp_o3_data[i])):
            f.write(interp_d_data[i][j] + ',' + interp_t_data[i][j] + ','
                    + str(interp_o3_data[i][j]) + ',' + str(obs_o3_pm[i][j]) + '\n')
print('Writing CSV outputs for ML sites: completed')

# scatter plots for interp additional O3 from IDW and observed O3 from addtionial sites
print('Plotting scatter plots for additional O3 from IDW and observed O3 from addtionial sites ...')
for i in range(0, len(additional_sites)):
    
    x = interp_add_o3_data[i]
    y = add_o3_pm[i]
    r2 = r2_score(x,y)
    corr_matrix = np.corrcoef(x,y)
    corr = corr_matrix[0,1]
    r2 = corr**2
    # calculate trendline 
    z = np.polyfit(x,y,1)
    p = np.poly1d(z)
    plt.plot(x,p(x),"r--")
    ax = plt.axis()
    # the line equation
    print ("y=%.6fx+(%.6f)"%(z[0],z[1]))
    # plt.text(0,130, r'y='+str(z[0])+'x + '+str(z[1]))
    
    # plot 1:1 line
    xx = [min(ax), max(ax)]
    yy = [min(ax), max(ax)]
    plt.plot(xx,yy,"k")
    
    
    plt.scatter(interp_add_o3_data[i], add_o3_pm[i], alpha = 0.5)
    plt.xlabel('Interp O3 for Additional Sites')
    plt.ylabel('Actual O3 from Additional Sites')
    plt.title(additional_sites[i])
    plt.axis('square')
    plt.xlim((min(ax), max(ax)))
    plt.ylim((min(ax),max(ax)))
    plt.text(min(ax)+0.001,max(ax)-0.005, "y = %.3fx+%.3f"%(z[0],z[1]))
    plt.text(min(ax)+0.001,max(ax)-0.01, r'$R^2$ = ' + "%.3f"%r2)
    plt.title(method)
    
    plt.savefig('scatter ' + additional_sites[i], dpi = 300)
    plt.close()
print('Plotting scatter plots for additional O3 from IDW and observed O3 from addtionial sites: completed')

# write csv file out for additional sites (Date, time, ML interp, Obs)
print('Writting CSV outputs for addtional sites ...')
for i  in range(0, len(additional_sites)):
    with open(additional_sites[i] + '.csv', 'a') as f:
        f.write('Date' + ',' + 'Time' + ',' + 'Ozone_ML_addtional_sites' + ',' + 'Ozone_Observe')
        f.write('\n')
        for j in range(0, len(interp_o3_data[i])):
            f.write(interp_d_data[i][j] + ',' + interp_t_data[i][j] + ','
                    + str(interp_add_o3_data[i][j]) + ',' + str(add_o3_pm[i][j]) + '\n')
print('Writting CSV outputs for addtional sites: completed')
print('IDW Interplation Successfully')