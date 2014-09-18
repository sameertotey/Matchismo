//
//  ShowActivityHistoryViewController.m
//  Matchismo
//
//  Created by Sameer Totey on 9/18/14.
//  Copyright (c) 2014 Sameer Totey. All rights reserved.
//

#import "ShowActivityHistoryViewController.h"

@interface ShowActivityHistoryViewController ()

@property (weak, nonatomic) IBOutlet UITextView *historyTextView;

@end

@implementation ShowActivityHistoryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateUI];
    // Do any additional setup after loading the view.
}

- (void)updateUI
{
    self.historyTextView.text = [self.history componentsJoinedByString:@"\n"]; 
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
