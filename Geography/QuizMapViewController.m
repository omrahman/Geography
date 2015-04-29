//
//  QuizMapViewController.m
//  Geography
//
//  Created by Omar Rahman on 4/28/15.
//  Copyright (c) 2015 Omar Rahman. All rights reserved.
//

#import "QuizMapViewController.h"
#import "QuestionBank.h"
#import <MapKit/MapKit.h>
#import <QuartzCore/QuartzCore.h>

#define CORRECT_ANSWER_REWARD 5
#define INCORRECT_ANSWER_PENALTY 1
#define SKIPPED_ANSWER_PENALTY 2

@interface QuizMapViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) NSString *currentQuestion;
@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;
@property (nonatomic) NSInteger score;
@property (nonatomic) BOOL gameOver;
@property (nonatomic) BOOL paused;

@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *alertLabel;
@property (weak, nonatomic) IBOutlet UIButton *skipButtonLabel;

@end

@implementation QuizMapViewController

- (IBAction)skipButton:(id)sender {
    
    // User hit "Next"
    if (self.paused) {
        self.paused = NO;
        [self.skipButtonLabel setTitle:@"Skip" forState:UIControlStateNormal];
        [self changeQuestion];

    }
    // User hit "Skip"
    else {
        self.paused = YES;
        self.skipButtonLabel.enabled = NO;
        [self.skipButtonLabel setTitle:@"Next" forState:UIControlStateNormal];
        self.score -= SKIPPED_ANSWER_PENALTY;
        [self updateScore];
        [self moveToRegion:self.currentQuestion];
        self.skipButtonLabel.enabled = YES;
    }
}

- (void)moveToRegion:(NSString *)address {
    CLGeocoder* gc = [[CLGeocoder alloc] init];
    [gc geocodeAddressString:address completionHandler:^(NSArray *placemarks, NSError *error)
    {
        NSLog(@"Found %lu results for %@", [placemarks count], address);
        if ([placemarks count] > 0)
        {
            // get the first one
            CLPlacemark* mark = (CLPlacemark*)[placemarks objectAtIndex:0];
            
            double lat = mark.location.coordinate.latitude;
            double lng = mark.location.coordinate.longitude;
            
            MKCoordinateRegion newRegion;
            
            newRegion.center.latitude     = lat;
            newRegion.center.longitude    = lng;
            newRegion.span.latitudeDelta  = 10;
            newRegion.span.longitudeDelta = 10;
            
            [self.mapView setRegion:newRegion animated:YES];
        }
    }];
}

- (instancetype)initWithQuestionBank:(QuestionBank *)questionBank {
    self = [super init];
    if (self) {
        self.questionBank = questionBank;
        NSString *question = [self.questionBank randomQuestion];
        self.currentQuestion = question;
        self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
        self.questionBank.delegate = self;
        self.score = 0;
        self.gameOver = NO;
        self.paused = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    self.alertLabel.alpha = 0;
    
    self.scoreLabel.text = [NSString stringWithFormat:@" Score: %ld ", self.score];
    self.scoreLabel.layer.backgroundColor = [UIColor whiteColor].CGColor;
    self.scoreLabel.layer.borderColor = [UIColor blackColor].CGColor;
    self.scoreLabel.layer.borderWidth = 1.0;
    
    self.questionLabel.text = self.currentQuestion;
    self.questionLabel.layer.backgroundColor = [UIColor whiteColor].CGColor;
    self.questionLabel.layer.borderColor = [UIColor blackColor].CGColor;
    self.questionLabel.layer.borderWidth = 1.0;
    
    self.skipButtonLabel.layer.backgroundColor = [UIColor whiteColor].CGColor;
    self.skipButtonLabel.layer.borderColor = [UIColor blackColor].CGColor;
    self.skipButtonLabel.layer.borderWidth = 1.0;
    [self.skipButtonLabel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.mapView addGestureRecognizer:self.tapGestureRecognizer];
}

- (void)changeQuestion {
    NSString *question = [self.questionBank randomQuestion];
    self.currentQuestion = question;
    self.questionLabel.text = question;
}

- (void)handleGesture:(UIGestureRecognizer *)gestureRecognizer {
    if (self.gameOver || self.paused) {
        return;
    }
    CGPoint touchPoint = [self.tapGestureRecognizer locationInView:self.mapView];
    CLLocationCoordinate2D touchMapCoordinate =
    [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];
    CLLocation *coordinate = [[CLLocation alloc] initWithLatitude:touchMapCoordinate.latitude
                                                        longitude:touchMapCoordinate.longitude];
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:coordinate completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error) { NSLog(@"ERROR"); }
        
        CLPlacemark *placemark = placemarks[0];
        if ([self.currentQuestion isEqualToString:[placemark country]]) {
            self.alertLabel.textColor = [UIColor greenColor];
            self.alertLabel.text = @"Correct!";
            self.score += CORRECT_ANSWER_REWARD;
            [self changeQuestion];
        } else {
            self.alertLabel.textColor = [UIColor redColor];
            self.alertLabel.text = @"Wrong!";
            self.score -= INCORRECT_ANSWER_PENALTY;
        }
        [self fadein];
        [self updateScore];
        self.skipButtonLabel.enabled = YES;
    }];
}

- (void)updateScore {
    self.scoreLabel.text = [NSString stringWithFormat:@" Score: %ld ", self.score];
}

- (void)questionBankEmpty {
    self.gameOver = YES;
    self.questionLabel.text = @"";
    self.skipButtonLabel.hidden = YES;
    NSString *messageString = [NSString stringWithFormat:@"Your final score is %ld", self.score];
         
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Game over!"
                                                   message:messageString
                                                  delegate:self
                                         cancelButtonTitle:@"OK"
                                         otherButtonTitles:nil];
    [alert show];
}

- (void)fadein {
    self.alertLabel.alpha = 0;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0];
    self.alertLabel.alpha = 1;
    
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    [UIView commitAnimations];
}


- (void)animationDidStop:(NSString *)animationID
               finished:(NSNumber *)finished
                context:(void *)context {
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    self.alertLabel.alpha = 0;
    [UIView commitAnimations];
    
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
