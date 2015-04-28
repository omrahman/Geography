//
//  WikipediaHelper.h
//  Geography
//
//  Created by Omar Rahman on 4/22/15.
//  Copyright (c) 2015 Omar Rahman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MapKit/MapKit.h"

@interface WikipediaHelper : NSObject

+ (NSURL *)makeURLFromPlacemark:(CLPlacemark *)placemark;

@end
