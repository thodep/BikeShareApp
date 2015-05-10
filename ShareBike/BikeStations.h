//
//  BikeStations.h
//  ShareBike
//
//  Created by tho dang on 2015-05-07.
//  Copyright (c) 2015 ThoDang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface BikeStations : NSObject<MKAnnotation>

@property(nonatomic,readwrite)CLLocationCoordinate2D coordinate;

//title is the text that is displayed inside the callout box which is showed once you tap on a pin
//should of put subtitle as property so it will  show up on the pin ...

@property (nonatomic,copy)  NSString *title;
@property (nonatomic, readwrite, copy) NSString *subtitle;
@property (nonatomic,strong)  NSNumber *availableDocks;
@property (nonatomic,strong)  NSNumber *availableBikes;


@end
