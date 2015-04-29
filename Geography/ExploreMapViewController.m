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

@interface ExploreMapViewController ()

@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation ExploreMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Explore";
}

- (void)viewWillAppear:(BOOL)animated {
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
        
        // When creating a custom MKPointAnnotation/MKPinPointAnnotation, make sure we have a reference
        // to its placemark
        
        [self.mapView addAnnotation:pointAnnotation];
        
        WebViewController *wvc = [[WebViewController alloc] init];
        wvc.title = @"Wikipedia";
        wvc.URL = [WikipediaHelper makeURLFromPlacemark:placemark];
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
