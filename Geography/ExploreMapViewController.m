//
//  MapViewController.m
//  Geography
//
//  Created by Omar Rahman on 4/15/15.
//  Copyright (c) 2015 Omar Rahman. All rights reserved.
//

#import "ExploreMapViewController.h"
#import "MapKit/MapKit.h"
#import "WebViewController.h"
#import "WikipediaHelper.h"
#import "PointAnnotationWithPlacemark.h"

@interface ExploreMapViewController ()

@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation ExploreMapViewController 

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
}

- (void)loadView
{
    CGRect bounds = [[UIScreen mainScreen] bounds];
    MKMapView *mapView = [[MKMapView alloc] initWithFrame:bounds];
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(handleGesture:)];
    lpgr.minimumPressDuration = 0.5;
    [mapView addGestureRecognizer:lpgr];
    self.mapView = mapView;
    self.mapView.delegate = self;
    self.view = mapView;
    self.title = @"Explore";
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
    [geocoder reverseGeocodeLocation:coordinate
                   completionHandler:^(NSArray *placemarks, NSError *error)
    {
        CLPlacemark *placemark = placemarks[0];
        [self logPlacemark:placemark];
        
        PointAnnotationWithPlacemark *ptAnnot = [[PointAnnotationWithPlacemark alloc] init];
        ptAnnot.coordinate = touchMapCoordinate;
        ptAnnot.title = [placemark country];
        ptAnnot.placemark = placemark;
        
        [self.mapView addAnnotation:ptAnnot];
    }];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView
            viewForAnnotation:(id<MKAnnotation>)annotation
{
    NSString *identifier = @"pinAnnotation";
    MKPinAnnotationView *pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    
    if (!pinView) {
        pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        pinView.animatesDrop = YES;
        pinView.canShowCallout = YES;
        pinView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    }
    
    return pinView;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    WebViewController *wvc = [[WebViewController alloc] init];
    CLPlacemark *placemark = ((PointAnnotationWithPlacemark *)view.annotation).placemark;
    wvc.URL = [WikipediaHelper makeURLFromPlacemark:placemark];
    [self.navigationController pushViewController:wvc animated:YES];
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
