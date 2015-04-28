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

@interface QuestionBankTableViewController ()

@property (nonatomic, strong) NSMutableArray *questionBanks;
@property (nonatomic, strong) NSMutableArray *quizMapViewControllers;

@end

@implementation QuestionBankTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    QuestionBank *qb1 = [[QuestionBank alloc] init];
    QuestionBank *qb2 = [[QuestionBank alloc] initWithName:@"Random"
                                                     array:@[@"Denmark", @"Japan", @"Canada"]];
    QuestionBank *qb3 = [[QuestionBank alloc] initWithName:@"South America"
                                                     array:@[@"Mexico",@"Brazil", @"Cuba", @"Guatemala"]];
    self.questionBanks = [[NSMutableArray alloc] initWithArray:@[qb1, qb2, qb3]];
    
    [self.tableView registerClass:[QuestionBankTableViewCell class] forCellReuseIdentifier:@"questionBankCell"];
    
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
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    QuestionBank *questionBank = self.questionBanks[indexPath.row];
    QuizMapViewController *qmvc = [[QuizMapViewController alloc] initWithQuestionBank:questionBank];
    
    qmvc.questionBank = self.questionBanks[indexPath.row];
    [self.navigationController pushViewController:qmvc animated:YES];
}

@end
