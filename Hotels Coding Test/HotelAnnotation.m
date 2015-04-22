//
//  HotelAnnotation.m
//  Hotels Coding Test
//
//  Created by Caleb Lee on 2015/04/22.
//  Copyright (c) 2015年 Caleb Lee. All rights reserved.
//

#import "HotelAnnotation.h"

@interface HotelAnnotation ()

@property (nonatomic, readwrite) Hotel *hotel;

@property(nonatomic, readwrite) CLLocationCoordinate2D coordinate;
@property(nonatomic, readwrite, copy) NSString *title;
@property(nonatomic, readwrite, copy) NSString *subtitle;

@end

@implementation HotelAnnotation

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate {
    _coordinate = newCoordinate;
}

- (id)initWithHotel:(Hotel*)hotel {
    if (self = [self init]) {
        self.hotel = hotel;
        self.coordinate = CLLocationCoordinate2DMake(hotel.latitude, hotel.longitude);
        self.title = hotel.name;
        self.subtitle = hotel.streetAddress;
    }
    
    return self;
}

@end
