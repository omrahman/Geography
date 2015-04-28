//
//  HomeViewController.m
//  Geography
//
//  Created by Omar Rahman on 4/28/15.
//  Copyright (c) 2015 Omar Rahman. All rights reserved.
//

#import "HomeViewController.h"
#import "QuizMapViewController.h"
#import "ExploreMapViewController.h"
#import "QuestionBankTableViewController.h"

@interface HomeViewController ()

@property (nonatomic, strong) ExploreMapViewController *mvc;
@property (nonatomic, strong) QuizMapViewController *qvc;
@property (nonatomic, strong) QuestionBankTableViewController *qbtvc;

@end

@implementation HomeViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        _mvc = [[ExploreMapViewController alloc] init];
        _mvc.title = @"Explore";
        _qbtvc = [[QuestionBankTableViewController alloc] init];
        _qbtvc.title = @"Select a question bank";

    }
    return self;
}

- (IBAction)exploreButton:(id)sender {
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController pushViewController:self.mvc animated:YES];
}

- (IBAction)quizButton:(id)sender {
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController pushViewController:self.qbtvc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = YES;
}

@end
