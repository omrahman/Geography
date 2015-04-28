//
//  WikipediaHelper.m
//  Geography
//
//  Created by Omar Rahman on 4/22/15.
//  Copyright (c) 2015 Omar Rahman. All rights reserved.
//

#import "WikipediaHelper.h"

@implementation WikipediaHelper

+ (NSURL *)makeURLFromPlacemark:(CLPlacemark *)placemark
{
    
    NSString *ocean = [placemark ocean];
    NSString *country = [placemark country];
    NSString *city = [placemark locality];
    
    NSString *base = @"http://en.wikipedia.org/wiki/";
    NSString *query;
    
    if (country) {
        query = [base stringByAppendingString:country];
    } else if (ocean) {
        query = [base stringByAppendingString:ocean];
    }
    
    NSString *newQuery = [query stringByReplacingOccurrencesOfString:@" " withString:@"_"];
    NSLog(@"%@", query);
    NSURL *URL = [NSURL URLWithString:newQuery];
    return URL;
}

@end
