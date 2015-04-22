//
//  MapViewController.m
//  Geography
//
//  Created by Omar Rahman on 4/15/15.
//  Copyright (c) 2015 Omar Rahman. All rights reserved.
//

#import "MapViewController.h"
#import "MapKit/MapKit.h"
#import "WebViewController.h"

@interface MapViewController ()

@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation MapViewController

- (void)loadView
{
    CGRect bounds = [[UIScreen mainScreen] bounds];
    MKMapView *mapView = [[MKMapView alloc] initWithFrame:bounds];
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(handleGesture:)];
    lpgr.minimumPressDuration = 0.5;
    [mapView addGestureRecognizer:lpgr];
    self.mapView = mapView;
    self.view = mapView;
    
}

- (void)handleGesture:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        if (self.timer) {
            [self.timer invalidate];
            self.timer = nil;
        }
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.0
                                                      target:self
                                                    selector:@selector(handleGestureTimer:)
                                                    userInfo:gestureRecognizer
                                                     repeats:NO];
        return;
    } else if (gestureRecognizer.state == UIGestureRecognizerStateCancelled ||
               gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        [self.timer invalidate];
        self.timer = nil;
        
    }
}

- (void)handleGestureTimer:(NSTimer *)timer
{
    UIGestureRecognizer *gestureRecognizer = (UIGestureRecognizer *)timer.userInfo;
    [self makeAndAddAnnotation:gestureRecognizer];
}

- (void)makeAndAddAnnotation:(UIGestureRecognizer *)gestureRecognizer
{
    CGPoint touchPoint = [gestureRecognizer locationInView:self.mapView];
    CLLocationCoordinate2D touchMapCoordinate =
    [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];
    CLLocation *coordinate = [[CLLocation alloc] initWithLatitude:touchMapCoordinate.latitude
                                                        longitude:touchMapCoordinate.longitude];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:coordinate completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error) { NSLog(@"ERROR"); }
        
        CLPlacemark *placemark = placemarks[0];
        [self logPlacemark:placemark];
        
        MKPointAnnotation *pointAnnotation = [[MKPointAnnotation alloc] init];
        pointAnnotation.coordinate = touchMapCoordinate;
        pointAnnotation.title = [placemark country];
        
        [self.mapView addAnnotation:pointAnnotation];
        
        
        WebViewController *wvc = [[WebViewController alloc] init];
        NSString *base = @"http://en.wikipedia.org/wiki/";
        NSString *country = [placemark country];
        NSString *query = [base stringByAppendingString:country];
        NSString *newQuery = [query stringByReplacingOccurrencesOfString:@" " withString:@"_"];
        NSLog(@"%@", query);
        NSURL *URL = [NSURL URLWithString:newQuery];
        wvc.URL = URL;
        [self.navigationController pushViewController:wvc animated:YES];
        
    }];

}

- (void)logPlacemark:(CLPlacemark *)placemark
{
    NSString *country = [placemark country];
    NSString *administrativeArea = [placemark administrativeArea];
    NSString *locality = [placemark locality];
    NSString *ocean = [placemark ocean];
    NSArray *areasOfInterest = [placemark areasOfInterest];
    
    for (NSObject *area in areasOfInterest) {
        NSLog(@"%@", area);
    }
    
    NSLog(@"%@", ocean);
    NSLog(@"%@", administrativeArea);
    NSLog(@"%@, %@", locality, country);
}

@end
