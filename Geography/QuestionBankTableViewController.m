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

@end

@implementation QuestionBankTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    QuestionBank *qb = [[QuestionBank alloc] init];
    self.questionBanks = [[NSMutableArray alloc] initWithArray:@[qb]];
    
    [self.tableView registerClass:[QuestionBankTableViewCell class] forCellReuseIdentifier:@"questionBankCell"];
    
    
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.questionBanks count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QuestionBankTableViewCell *cell = (QuestionBankTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"questionBankCell" forIndexPath:indexPath];

    cell.questionBankLabel.text = [NSString stringWithFormat:@"Question Bank %ld", (long)indexPath.row + 1];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    QuizMapViewController *qmvc = [[QuizMapViewController alloc] init];
    qmvc.questionBank = self.questionBanks[indexPath.row];
    [self.navigationController pushViewController:qmvc animated:YES];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
