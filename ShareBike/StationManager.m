//
//  StationManager.m
//  ShareBike
//
//  Created by tho dang on 2015-05-07.
//  Copyright (c) 2015 ThoDang. All rights reserved.
//

#import "StationManager.h"

@implementation StationManager
- (instancetype)init
{
    self = [super init];
    if (self) {
        _http = [[HTTPCommunication alloc]init];
   
    }
    return self;
}
    

//parsing data method
- (void)getAllStations:(void(^)(NSArray *stations))success{
    
    NSURL *url = [NSURL URLWithString:@"http://www.bikesharetoronto.com/stations/json"];
    
    //run the httpcommunication url request method
    
    [_http retrieveURL:url successBlock:^(NSData *response){
        
        NSError *error = nil;
        
        NSDictionary *data = [NSJSONSerialization JSONObjectWithData:response options:0 error:&error];
        
        if (!error) {
            NSArray *bikeStations=data[@"stationBeanList"];
            
            self.listOfBikeStations = [[NSMutableArray alloc]init];
            for (NSDictionary *dict in bikeStations) {
                
                
                NSString *title=dict[@"stationName"];
                NSNumber *longitude = dict[@"longitude"];
                NSNumber *latitude = dict[@"latitude"];
                NSNumber *availableDocks=dict[@"availableDocks"];
                NSNumber *availableBikes=dict[@"availableBikes"];
                
                
                
                BikeStations *bikeStation = [[BikeStations alloc]init];
                
                bikeStation.title = [NSString stringWithFormat:@"%@ (Bikes:%@, Docks:%@)", title, availableBikes, availableDocks];
                
                //is this another one to get the data from URL ? ask Yung if i do this , then all the lines above are useless
                bikeStation.subtitle = [NSString stringWithFormat:@"Available Bikes: %@", [availableBikes stringValue]];
                bikeStation.coordinate = CLLocationCoordinate2DMake([latitude doubleValue], [longitude doubleValue]);
              
            
                [self.listOfBikeStations addObject:bikeStation];
              //  NSLog(@"%@",bikeStation.title); optional to put in , only use to check if information is passed on to console
            }
            if (success) {
                success(self.listOfBikeStations);
            }
        }

        
    }];
    
}
@end
