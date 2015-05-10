//
//  MapViewController.m
//  ShareBike
//
//  Created by tho dang on 2015-05-07.
//  Copyright (c) 2015 ThoDang. All rights reserved.
//

#import "MapViewController.h"
//#import "BikeStations.h"
@interface MapViewController ()

@end

@implementation MapViewController

    //get the custom pin to show on the map
-(MKAnnotationView*)mapView:(MKMapView*)theMapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    static NSString *reuseID=@"reuseID";
    // if no pin can be dequeued then we create one
    MKAnnotationView *view=[theMapView dequeueReusableAnnotationViewWithIdentifier:reuseID];
    
    
    if(!view) {
        view=[[MKPinAnnotationView alloc] initWithAnnotation:annotation
                                             reuseIdentifier:reuseID];
        view.canShowCallout=YES;
        
        // Add a detail disclosure button to the RIGHT callout for what and how to add it in 
        UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        rightButton.frame=CGRectMake(0, 0, 23, 23);
        view.rightCalloutAccessoryView = rightButton;
        
        //Add an image to the left call out
        UIImageView *iconView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Bicycle-50"]];
        iconView.frame=CGRectMake(0, 0, 23, 23);
        view.leftCalloutAccessoryView=iconView;
        
    }
    view.image=[UIImage imageNamed:@"pin"];
    view.annotation=annotation;
    return view;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Creat button to go to the Nearest Station
    UIButton *goButton = [[UIButton alloc] initWithFrame:CGRectMake(70,560, 250, 35)];
    goButton.backgroundColor=[UIColor redColor];
    [goButton addTarget:self action:@ selector(showBikeStation) forControlEvents:UIControlEventTouchUpInside];
    [goButton setTitle:@"Nearest Station" forState:UIControlStateNormal];
    [self.view addSubview:goButton];
    
    
    
    // Set Map View Size 
    self.mapView = [[MKMapView alloc] initWithFrame: CGRectMake( 0, 0,self.view.frame.size.width ,550)];
    
    self.mapView.delegate = self;
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    if(IS_OS_8_OR_LATER)
    {
        [self.locationManager requestWhenInUseAuthorization];
        [self.locationManager requestAlwaysAuthorization];
        
    }
    [self.locationManager startUpdatingLocation];
    
    self.mapView.showsUserLocation = YES;
    self.mapView.showsPointsOfInterest = YES;
    
    [self.view addSubview:self.mapView];
    
    
    self.stationManager = [[StationManager alloc]init];
    
    //iterating each station and add annotation(pins)to map 
    
    [self.stationManager getAllStations:^(NSArray *stations) {
        for (BikeStations* bikeStations in stations) {
            [self.mapView addAnnotation:bikeStations];
            
        }
        
    
        
        //Method to zoom the BikeShare Locations
        MKMapRect zoomRect = MKMapRectNull;
        for (id <MKAnnotation> annotation in self.mapView.annotations)
        {
            MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
            MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0, 0);
            if (MKMapRectIsNull(zoomRect))
            {
                zoomRect = pointRect;
            } else
            {
                zoomRect = MKMapRectUnion(zoomRect, pointRect);
            }
        }
        [self.mapView setVisibleMapRect:zoomRect animated:YES];

    }];
    
    
    }

//When tap on the annotation pin , you can launch the map of that location

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    id <MKAnnotation> annotation = view.annotation;
    CLLocationCoordinate2D coordinate = [annotation coordinate];
    MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:coordinate addressDictionary:nil];
    MKMapItem *mapitem = [[MKMapItem alloc] initWithPlacemark:placemark];
    mapitem.name = annotation.title;
    [mapitem openInMapsWithLaunchOptions:nil];
}
-(void) showBikeStation{
    
    //develop a method For Loop to compare NSArray bike stations (lat, lonng coord to your current location )
double nearestLat = 43.648093;
double nearestLng = -79.384789;
    
    CLLocationCoordinate2D coord2 = CLLocationCoordinate2DMake(nearestLat,nearestLng);
    
    MKPlacemark *placeMark = [[MKPlacemark alloc] initWithCoordinate:coord2 addressDictionary:nil];
    MKMapItem *destination =  [[MKMapItem alloc] initWithPlacemark:placeMark];
    [destination openInMapsWithLaunchOptions:@{MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeWalking}];
    NSLog(@"Hello\tWorld\n\n");
    
 
    

    

    

}


@end
