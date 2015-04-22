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
#import <SDWebImage/UIImageView+WebCache.h>


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

// hide the status bar for the map view controller; it looks better
- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)setUpMap {
    // show the region of the map we want to show
    CLLocationCoordinate2D chicagoCoordinates = CLLocationCoordinate2DMake(41.8781136, -87.6297982); // generic values to refer to chicago
    self.mapView.region = MKCoordinateRegionMakeWithDistance(chicagoCoordinates, MAP_RADIUS_METERS, MAP_RADIUS_METERS);
    
    // drop hotel pins
    for (NSInteger i = 0; i < [[HotelManager sharedManager] count]; i++) {
        Hotel *hotel = [[HotelManager sharedManager] hotelAtIndex:i];
        
        // use an autorelease pool so the annotations get released as the loop goes on instead of at the end
        @autoreleasepool {
            HotelAnnotation *annotation = [[HotelAnnotation alloc] initWithHotel:hotel];
            [self.mapView addAnnotation:annotation];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma Mark - MKMapViewDelegate
- (MKAnnotationView*)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    // make and add a left accessory view to the callout if we're using a hotel annotation
    if ([annotation isKindOfClass:[HotelAnnotation class]]) {
        HotelAnnotation *hotelAnnotation = (HotelAnnotation*)annotation;
        
        static NSString *customPinAnnotation = @"customPinAnnotation";
        MKPinAnnotationView *pin = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:customPinAnnotation];
        
        if (pin == nil)
            pin = [[MKPinAnnotationView alloc] initWithAnnotation:hotelAnnotation reuseIdentifier:customPinAnnotation];
        
        pin.canShowCallout = YES;
        
        pin.leftCalloutAccessoryView = [self prepareCalloutAccessoryViewFromAnnotation:hotelAnnotation];
        
        return pin;
    }
    
    return nil;
}

- (UIView*)prepareCalloutAccessoryViewFromAnnotation:(HotelAnnotation*)annotation {
    // make thumbnail view
    // thumbnails are all 120x90; halve that because accessory views are tiny
    UIImageView *thumbnailView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 60.0, 45.0)];
    
    // set the thumbnail image asyncrhonously
    [thumbnailView sd_setImageWithURL:[NSURL URLWithString:annotation.hotel.thumbnailURL]];
    
    return thumbnailView;
}

@end
