//
//  MapViewController.m
//  Hotels Coding Test
//
//  Created by Caleb Lee on 2015/04/21.
//  Copyright (c) 2015年 Caleb Lee. All rights reserved.
//

#import "MapViewController.h"
#import "HotelAnnotation.h"
#import "HotelManager.h"

@interface MapViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

#define MAP_RADIUS_METERS 15000.0

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setUpMap];
}

- (void)setUpMap {
    // show the region of the map we want to show
    CLLocationCoordinate2D chicagoCoordinates = CLLocationCoordinate2DMake(41.8781136, -87.6297982); // generic values to refer to chicago
    self.mapView.region = MKCoordinateRegionMakeWithDistance(chicagoCoordinates, MAP_RADIUS_METERS, MAP_RADIUS_METERS);
    
    // drop hotel pins
    for (NSInteger i = 0; i < [[HotelManager sharedManager] count]; i++) {
        @autoreleasepool {
            Hotel *hotel = [[HotelManager sharedManager] hotelAtIndex:i];
            HotelAnnotation *annotation = [[HotelAnnotation alloc] initWithHotel:hotel];
            [self.mapView addAnnotation:annotation];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
