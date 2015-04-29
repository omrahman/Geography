//
//  FlatHomeViewController.m
//  Geography
//
//  Created by Omar Rahman on 4/29/15.
//  Copyright (c) 2015 Omar Rahman. All rights reserved.
//

#import "HomeViewController.h"


#import "QuizMapViewController.h"
#import "ExploreMapViewController.h"
#import "QuestionBankTableViewController.h"
#import "UIColor+GeographyTheme.h"

@interface HomeViewController ()

@property (nonatomic, strong) ExploreMapViewController *mvc;
@property (nonatomic, strong) QuizMapViewController *qvc;
@property (nonatomic, strong) QuestionBankTableViewController *qbtvc;

@property (nonatomic, strong) UIButton *exploreButton;
@property (nonatomic, strong) UIButton *quizButton;

@end

@implementation HomeViewController

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
    self.exploreButton.backgroundColor = [UIColor oceanBlueLight];
    self.exploreButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:74.0f];
    [self.exploreButton setTitleColor:[UIColor oceanBlueDark] forState:UIControlStateNormal];
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
    self.quizButton.backgroundColor = [UIColor mapBeigeLight];
    self.quizButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:74.0f];
    [self.quizButton setTitleColor:[UIColor mapBeigeDark] forState:UIControlStateNormal];
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
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = YES;
    UIBarButtonItem *newBackButton =
    [[UIBarButtonItem alloc] initWithTitle:@""
                                     style:UIBarButtonItemStylePlain
                                    target:nil
                                    action:nil];
    [self.navigationItem setBackBarButtonItem:newBackButton];
}

@end

