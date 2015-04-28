//
//  QuizMapViewController.m
//  Geography
//
//  Created by Omar Rahman on 4/28/15.
//  Copyright (c) 2015 Omar Rahman. All rights reserved.
//

#import "QuizMapViewController.h"
#import <MapKit/MapKit.h>

@interface QuizMapViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) NSMutableArray *locationStrings;

@property (weak, nonatomic) IBOutlet UILabel *questionLabel;

@end

@implementation QuizMapViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.locationStrings = [[NSMutableArray alloc] initWithArray:@[@"United States", @"China", @"Russia"]];
        self.questionLabel.text = @"Where is ...";
        int randint = arc4random() % [self.locationStrings count];
        NSLog(@"%d", randint);
        NSLog(@"%@", self.locationStrings[randint]);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}



@end
