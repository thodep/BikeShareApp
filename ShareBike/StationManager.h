//
//  StationManager.h
//  ShareBike
//
//  Created by tho dang on 2015-05-07.
//  Copyright (c) 2015 ThoDang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "HTTPCommunication.h"
#import "BikeStations.h"

@interface StationManager : NSObject

@property(strong,nonatomic)  HTTPCommunication *http;
@property(strong, nonatomic) NSMutableArray *listOfBikeStations;


- (void)getAllStations:(void(^)(NSArray *stations))success;

@end
