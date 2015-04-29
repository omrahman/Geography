//
//  PointAnnotationWithPlacemark.h
//  Geography
//
//  Created by Omar Rahman on 4/28/15.
//  Copyright (c) 2015 Omar Rahman. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface PointAnnotationWithPlacemark : MKPointAnnotation

@property (nonatomic) CLPlacemark *placemark;

@end
