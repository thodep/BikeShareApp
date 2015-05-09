//
//  ViewController.m
//  ShareBike
//
//  Created by tho dang on 2015-05-07.
//  Copyright (c) 2015 ThoDang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib
    self.stationManager = [[StationManager alloc]init];
    
    
    [self.stationManager getAllStations:^(NSArray *stations) {
        for (BikeStations* bikeStations in stations) {
               NSLog(@"%f, %f",bikeStations.coordinate.latitude, bikeStations.coordinate.longitude );
        }
        
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
