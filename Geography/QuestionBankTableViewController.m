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
#import "UIColor+GeographyTheme.h"
#import "QuestionBank.h"

@interface QuestionBankTableViewController ()

@property (nonatomic, strong) NSMutableArray *questionBanks;
@property (nonatomic, strong) NSMutableArray *quizMapViewControllers;

@end

@implementation QuestionBankTableViewController

- (void)loadView {
    [super loadView];
    UIBarButtonItem *newBackButton =
    [[UIBarButtonItem alloc] initWithTitle:@""
                                     style:UIBarButtonItemStylePlain
                                    target:nil
                                    action:nil];
    [self.navigationItem setBackBarButtonItem:newBackButton];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    

    self.title = @"Select a Question Bank";

    // Opens a text file and reads in countries as NSString * line by line into an array
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"countries" ofType:@"txt"];
    NSString *fileContents = [NSString stringWithContentsOfFile:filePath
                                                       encoding:NSUTF8StringEncoding
                                                          error:nil];
    NSArray *allCountries = [fileContents componentsSeparatedByString:@"\r\n"];
    
    // Hardcoded example country banks
    NSArray *africaBank = @[@"Morocco", @"Egypt", @"Nigeria", @"South Africa",
                            @"Ethiopia", @"Kenya"];
    NSArray *europeBank = @[@"Denmark", @"Germany", @"Austria", @"Italy", @"France",
                            @"Spain", @"Greece", @"Sweden", @"Finland"];
    NSArray *southAmericaBank = @[@"Peru",@"Brazil", @"Paraguay", @"Argentina"];
    
    QuestionBank *qb0 = [[QuestionBank alloc] initWithName:@"World"
                                                     array:allCountries
                                                  bankType:kCountryBank];
    
    QuestionBank *qb1 = [[QuestionBank alloc] initWithName:@"Africa" array:africaBank
                                                  bankType:kCountryBank];
    
    QuestionBank *qb2 = [[QuestionBank alloc] initWithName:@"Europe"
                                                     array:europeBank
                                                  bankType:kCountryBank];
    
    QuestionBank *qb3 = [[QuestionBank alloc] initWithName:@"South America"
                                                     array:southAmericaBank
                                                  bankType:kCountryBank];
    
    // Ideally, we'd have a separate function that constructs this array of
    // questionBanks, but for now just have it hardcoded; not difficult to fix
    self.questionBanks = [[NSMutableArray alloc] initWithArray:@[qb0, qb1, qb2, qb3]];
    
    [self.tableView registerClass:[QuestionBankTableViewCell class] forCellReuseIdentifier:@"questionBankCell"];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = NO;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    NSInteger numRows = [self.questionBanks count];
    
    // Color the background appropriately as rows alternate colors
    if (numRows % 2 == 0) {
        self.tableView.backgroundColor = [UIColor mapBeigeLight];
    } else {
        self.tableView.backgroundColor = [UIColor oceanBlueLight];
    }
    return numRows;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QuestionBankTableViewCell *cell = (QuestionBankTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"questionBankCell" forIndexPath:indexPath];
    NSString *name = [self.questionBanks[indexPath.row] name];
    cell.questionBankLabel.text = [NSString stringWithFormat:@"%@", name];
    
    // Some silly alternating coloring of cells
    if (indexPath.row % 2) {
        // Blue
        cell.questionBankLabel.textColor = [UIColor oceanBlueDark];
        cell.contentView.backgroundColor = [UIColor oceanBlueLight];
    } else {
        // Beige
        cell.questionBankLabel.textColor = [UIColor mapBeigeDark];
        cell.contentView.backgroundColor = [UIColor mapBeigeLight];
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
