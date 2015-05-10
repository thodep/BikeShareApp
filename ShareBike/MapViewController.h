//
//  MapViewController.h
//  ShareBike
//
//  Created by tho dang on 2015-05-07.
//  Copyright (c) 2015 ThoDang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "StationManager.h"
#import "BikeStations.h"

#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

@interface MapViewController : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate>

@property (nonatomic, strong) MKMapView *mapView;
@property (strong,nonatomic)  CLLocationManager *locationManager;
@property (strong, nonatomic) StationManager *stationManager;
@property(strong,nonatomic)UIButton *goButton;

@property(assign,nonatomic) CLLocation *distance;

-(void) showBikeStation;
@end
