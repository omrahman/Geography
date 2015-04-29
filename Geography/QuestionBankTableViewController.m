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
    
    self.view.backgroundColor = UIColorFromRGB(0x9ad1f1);
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
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
    
    QuestionBank *all = [[QuestionBank alloc] initWithName:@"World" array:allCountries];
    QuestionBank *qb1 = [[QuestionBank alloc] initWithName:@"Africa" array:@[@"Morocco", @"Egypt",
                                                                             @"Nigeria", @"South Africa",
                                                                             @"Ethiopia", @"Kenya"]];
    QuestionBank *qb2 = [[QuestionBank alloc] initWithName:@"Europe"
                                                     array:@[@"Denmark", @"Germany", @"Austria", @"Italy", @"France",
                                                             @"Spain", @"Greece", @"Sweden", @"Finland"]];
    QuestionBank *qb3 = [[QuestionBank alloc] initWithName:@"South America"
                                                     array:@[@"Peru",@"Brazil", @"Paraguay", @"Argentina"]];
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
    NSLog(@"numberOfRowsInSection requested");
    NSInteger n = [self.questionBanks count];
    if (n % 2 == 0) {
        self.view.backgroundColor = UIColorFromRGB(0xf7f3e8);
    } else {
        self.view.backgroundColor = UIColorFromRGB(0x9ad1f1);
    }
    return [self.questionBanks count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QuestionBankTableViewCell *cell = (QuestionBankTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"questionBankCell" forIndexPath:indexPath];
    NSString *name = [self.questionBanks[indexPath.row] name];
    cell.questionBankLabel.text = [NSString stringWithFormat:@"%@", name];
    if (indexPath.row % 2) {
        // Blue
        cell.questionBankLabel.textColor = UIColorFromRGB(0x5c7d90);
        cell.contentView.backgroundColor = UIColorFromRGB(0x9ad1f1);
    } else {
        // Beige
        cell.questionBankLabel.textColor = UIColorFromRGB(0x94918b);
        cell.contentView.backgroundColor = UIColorFromRGB(0xf7f3e8);
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    QuestionBank *questionBank = [self.questionBanks[indexPath.row] copy];
    QuizMapViewController *qmvc = [[QuizMapViewController alloc] initWithQuestionBank:questionBank];
    [self.navigationController pushViewController:qmvc animated:YES];
}



@end
