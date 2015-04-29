//
//  UIColor+GeographyTheme.h
//  Geography
//
//  Created by Omar Rahman on 4/29/15.
//  Copyright (c) 2015 Omar Rahman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
alpha:1.0]

@interface UIColor (GeographyTheme)

+ (UIColor *)oceanBlueLight;
+ (UIColor *)oceanBlueDark;
+ (UIColor *)mapBeigeLight;
+ (UIColor *)mapBeigeDark;

@end
