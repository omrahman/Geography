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

@interface QuizMapViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) NSString *currentQuestion;
@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;
@property (nonatomic) NSInteger score;
@property (nonatomic) BOOL gameOver;

@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *alertLabel;

@end

@implementation QuizMapViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.currentQuestion = @"";
        self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
        self.questionBank = [[QuestionBank alloc] init];
        self.questionBank.delegate = self;
        self.score = 0;
        self.gameOver = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.alertLabel.alpha = 0;
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", self.score];
    self.scoreLabel.layer.backgroundColor = [UIColor whiteColor].CGColor;
    self.scoreLabel.layer.borderColor = [UIColor blackColor].CGColor;
    self.scoreLabel.layer.borderWidth = 1.0;
    
    self.questionLabel.layer.backgroundColor = [UIColor whiteColor].CGColor;
    self.questionLabel.layer.borderColor = [UIColor blackColor].CGColor;
    self.questionLabel.layer.borderWidth = 1.0;
    
    [self.mapView addGestureRecognizer:self.tapGestureRecognizer];
    [self changeQuestion];

}

- (void)changeQuestion {
    NSString *question = [self.questionBank randomQuestion];
    self.currentQuestion = question;
    self.questionLabel.text = question;
}

- (void)handleGesture:(UIGestureRecognizer *)gestureRecognizer {
    if (self.gameOver) {
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
            self.alertLabel.text = @"Correct!";
            self.score++;
            [self changeQuestion];
        } else {
            self.alertLabel.text = @"Wrong!";
            self.score--;
        }
        [self fadein];
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", self.score];
    }];
}

- (void)questionBankEmpty {
    self.gameOver = YES;
    self.questionLabel.text = @"";
    NSString *messageString = [NSString stringWithFormat:@"That's all! Your final score is %ld", self.score];
         
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

@end
