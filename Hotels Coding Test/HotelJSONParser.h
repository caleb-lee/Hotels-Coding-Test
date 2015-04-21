//
//  HotelJSONParser.h
//  Hotels Coding Test
//
//  Created by Caleb Lee on 2015/04/21.
//  Copyright (c) 2015年 Caleb Lee. All rights reserved.
//

// The purpose of this class is to parse hotel JSON sourced from ~somewhere~
//  (in this case, the file is local, but the class could be modified to source from online)
//  into an NSDictionary

#import <Foundation/Foundation.h>

@interface HotelJSONParser : NSObject

- (NSArray*)readJSONHotels;

@end
