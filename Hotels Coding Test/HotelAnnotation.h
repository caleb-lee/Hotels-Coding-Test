//
//  HotelAnnotation.h
//  Hotels Coding Test
//
//  Created by Caleb Lee on 2015/04/22.
//  Copyright (c) 2015年 Caleb Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "Hotel.h"

@interface HotelAnnotation : NSObject <MKAnnotation>

// pulls the coordinate data, title (hotel name), and subtitle (distance away + price) from the hotel object
- (id)initWithHotel:(Hotel*)hotel;
@property (nonatomic, readonly) Hotel *hotel;

// to conform to the MKAnnotation protocol
- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate;
@property(nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property(nonatomic, readonly, copy) NSString *title;
@property(nonatomic, readonly, copy) NSString *subtitle;


@end
