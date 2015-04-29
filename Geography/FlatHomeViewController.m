//
//  FlatHomeViewController.m
//  Geography
//
//  Created by Omar Rahman on 4/29/15.
//  Copyright (c) 2015 Omar Rahman. All rights reserved.
//

#import "FlatHomeViewController.h"


#import "QuizMapViewController.h"
#import "ExploreMapViewController.h"
#import "QuestionBankTableViewController.h"

#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
alpha:1.0]

@interface FlatHomeViewController ()

@property (nonatomic, strong) ExploreMapViewController *mvc;
@property (nonatomic, strong) QuizMapViewController *qvc;
@property (nonatomic, strong) QuestionBankTableViewController *qbtvc;

@property (nonatomic, strong) UIButton *exploreButton;
@property (nonatomic, strong) UIButton *quizButton;

@end

@implementation FlatHomeViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        
        [self makeExploreButton];
        [self makeQuizButton];
        
        _mvc = [[ExploreMapViewController alloc] init];
        _qbtvc = [[QuestionBankTableViewController alloc] init];
        
    }
    return self;
}

- (void)makeExploreButton
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    self.exploreButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.exploreButton addTarget:self
                           action:@selector(exploreButtonTapped:)
                 forControlEvents:UIControlEventTouchUpInside];
    [self.exploreButton setTitle:@"Explore" forState:UIControlStateNormal];
    self.exploreButton.backgroundColor = UIColorFromRGB(0x9ad1f1);
    self.exploreButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:74.0f];
    [self.exploreButton setTitleColor:UIColorFromRGB(0x5c7d90) forState:UIControlStateNormal];
    self.exploreButton.frame = CGRectMake(0.0, 0.0, screenWidth, screenHeight / 2.0);
    [self.view addSubview:self.exploreButton];
}

- (void)makeQuizButton
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    self.quizButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.quizButton addTarget:self
                           action:@selector(quizButtonTapped:)
                 forControlEvents:UIControlEventTouchUpInside];
    [self.quizButton setTitle:@"Quiz" forState:UIControlStateNormal];
    self.quizButton.backgroundColor = UIColorFromRGB(0xf7f3e8);
    self.quizButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:74.0f];
    [self.quizButton setTitleColor:UIColorFromRGB(0x94918b) forState:UIControlStateNormal];
    self.quizButton.frame = CGRectMake(0.0, screenHeight / 2.0, screenWidth, screenHeight / 2.0);
    [self.view addSubview:self.quizButton];
}

- (IBAction)exploreButtonTapped:(id)sender {
    [self.navigationController pushViewController:self.mvc animated:YES];
}

- (IBAction)quizButtonTapped:(id)sender {
    [self.navigationController pushViewController:self.qbtvc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //NSLog(@"%@", self.view.backgroundColor);
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = YES;
}

@end

