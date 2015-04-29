//
//  QuestionBankTableViewController.m
//  Geography
//
//  Created by Omar Rahman on 4/28/15.
//  Copyright (c) 2015 Omar Rahman. All rights reserved.
//

#import "QuestionBankTableViewController.h"
#import "QuestionBankTableViewCell.h"
#import "QuizMapViewController.h"
#import "QuestionBank.h"

#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
alpha:1.0]

@interface QuestionBankTableViewController ()

@property (nonatomic, strong) NSMutableArray *questionBanks;
@property (nonatomic, strong) NSMutableArray *quizMapViewControllers;

@end

@implementation QuestionBankTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorFromRGB(0x62ACD9);
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLineEtched];
    self.title = @"Select a Question Bank";

    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"countries" ofType:@"txt"];
    NSString *fileContents = [NSString stringWithContentsOfFile:filePath
                                                       encoding:NSUTF8StringEncoding
                                                          error:nil];
    NSArray *allCountries = [fileContents componentsSeparatedByString:@"\r\n"];
    
    /*
    for (NSString *country in allCountries) {
        NSLog(@"%@, length: %lu", country, (unsigned long)[country length]);
    }
     */
    
    QuestionBank *all = [[QuestionBank alloc] initWithName:@"All Countries" array:allCountries];
    
    QuestionBank *qb1 = [[QuestionBank alloc] init];
    QuestionBank *qb2 = [[QuestionBank alloc] initWithName:@"Random"
                                                     array:@[@"Denmark", @"Japan", @"Canada"]];
    QuestionBank *qb3 = [[QuestionBank alloc] initWithName:@"South America"
                                                     array:@[@"Mexico",@"Brazil", @"Cuba", @"Guatemala"]];
    self.questionBanks = [[NSMutableArray alloc] initWithArray:@[all, qb1, qb2, qb3]];
    
    [self.tableView registerClass:[QuestionBankTableViewCell class] forCellReuseIdentifier:@"questionBankCell"];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = NO;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.questionBanks count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QuestionBankTableViewCell *cell = (QuestionBankTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"questionBankCell" forIndexPath:indexPath];
    NSString *name = [self.questionBanks[indexPath.row] name];
    cell.questionBankLabel.text = [NSString stringWithFormat:@"%@", name];
    cell.contentView.backgroundColor = UIColorFromRGB(0x62ACD9);
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    QuestionBank *questionBank = [self.questionBanks[indexPath.row] copy];
    QuizMapViewController *qmvc = [[QuizMapViewController alloc] initWithQuestionBank:questionBank];
    [self.navigationController pushViewController:qmvc animated:YES];
}



@end
