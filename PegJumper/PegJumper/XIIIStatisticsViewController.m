//
//  XIIIStatisticsViewController.m
//  StartPage
//
//  Created by Junie Khang on 5/7/14.
//  Copyright (c) 2014 choaterosemaryhall. All rights reserved.
//

#import "XIIIStatisticsViewController.h"
#import "XIIISavedGameViewController.h"
#import "XIIIStats.h"

@interface XIIIStatisticsViewController ()
@property (weak, nonatomic) IBOutlet UITextField *averageTimeField;
@property (weak, nonatomic) IBOutlet UITextField *winlossField;
@property (weak, nonatomic) IBOutlet UITextField *averagePegField;
@end


@implementation XIIIStatisticsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.averageTimeField.text=[[NSString alloc] initWithFormat:@"%f",[self.stats avgTime]];
        self.winlossField.text=[[NSString alloc] initWithFormat:@"%d/%d",[self.stats wins],[self.stats wins]];
        self.averagePegField.text=[[NSString alloc] initWithFormat:@"%f",[self.stats avgPegs]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(IBAction)SavedGame:(id)sender
{
    XIIISavedGameViewController *SavedGameViewController=[[XIIISavedGameViewController alloc]init];
    [self.navigationController pushViewController: SavedGameViewController animated:YES];
}

-(IBAction)RefreshStatistics:(id)sender
{
    
}
@end
