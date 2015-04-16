//
//  MapViewController.m
//  Geography
//
//  Created by Omar Rahman on 4/15/15.
//  Copyright (c) 2015 Omar Rahman. All rights reserved.
//

#import "MapViewController.h"
#import "MapKit/MapKit.h"

@interface MapViewController ()

@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)loadView {
    CGRect bounds = [[UIScreen mainScreen] bounds];
    MKMapView *mapView = [[MKMapView alloc] initWithFrame:bounds];
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(handleGesture:)];
    lpgr.minimumPressDuration = 0.5;  //user must press for 2 seconds
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
                                                    selector:@selector(handleTimer:)
                                                    userInfo:gestureRecognizer
                                                     repeats:NO];
        return;
    } else if (gestureRecognizer.state == UIGestureRecognizerStateCancelled ||
               gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        [self.timer invalidate];
        self.timer = nil;
        
    }
}

- (void)handleTimer:(NSTimer *)timer {
    
    UIGestureRecognizer *gestureRecognizer = (UIGestureRecognizer *)timer.userInfo;
    [self addAnnotation:gestureRecognizer];
    
}

- (void)addAnnotation:(UIGestureRecognizer *)gestureRecognizer {
    CGPoint touchPoint = [gestureRecognizer locationInView:self.mapView];
    
    
    CLLocationCoordinate2D touchMapCoordinate =
    [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];
    CLLocation *coordinate = [[CLLocation alloc] initWithLatitude:touchMapCoordinate.latitude
                                                        longitude:touchMapCoordinate.longitude];
    
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:coordinate completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error) {
            NSLog(@"ERROR");
        }
        CLPlacemark *placemark;
        if ([placemarks count]) {
            placemark = placemarks[0];
        } else {
            NSLog(@"ERROR");
        }
        
        NSLog(@"%@", placemark);
        NSString *country = [placemark country];
        NSString *locality = [placemark locality];
        NSLog(@"%@, %@", locality, country);
        MKPointAnnotation *pointAnnotation = [[MKPointAnnotation alloc] init];
        pointAnnotation.coordinate = touchMapCoordinate;
        pointAnnotation.title = country;
        
        [self.mapView addAnnotation:pointAnnotation];

    }];
    
    }

@end
