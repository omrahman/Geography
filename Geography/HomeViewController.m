//
//  HomeViewController.m
//  Geography
//
//  Created by Omar Rahman on 4/28/15.
//  Copyright (c) 2015 Omar Rahman. All rights reserved.
//

#import "HomeViewController.h"
#import "QuizMapViewController.h"
#import "MapViewController.h"

@interface HomeViewController ()

@property (nonatomic, strong) MapViewController *mvc;
@property (nonatomic, strong) QuizMapViewController *qvc;

@end

@implementation HomeViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        _mvc = [[MapViewController alloc] init];
        _mvc.title = @"Explore!";
        _qvc = [[QuizMapViewController alloc] init];
        _qvc.title = @"Quiz!";
    }
    return self;
}

- (IBAction)exploreButton:(id)sender {
    [self.navigationController pushViewController:self.mvc animated:YES];
}

- (IBAction)quizButton:(id)sender {
    [self.navigationController pushViewController:self.qvc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

@end
