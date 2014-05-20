//
//  StartPageViewController.m
//  StartPage
//
//  Created by Junie Khang on 5/6/14.
//  Copyright (c) 2014 choaterosemaryhall. All rights reserved.
//

#import "StartPageViewController.h"
#import "XIIIOptionsViewController.h"
#import "XIIIStatisticsViewController.h"
#import "XIIISavedGameViewController.h"

@interface StartPageViewController ()

@end

@implementation StartPageViewController

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)NewGame:(id)sender
{
    
}
-(IBAction)Options:(id)sender
{
    XIIIOptionsViewController *OptionsViewController=[[XIIIOptionsViewController alloc]init];
    [self.navigationController pushViewController: OptionsViewController animated:YES];
}
-(IBAction)Statistics:(id)sender
{
    XIIIStatisticsViewController *StatisticsViewController=[[XIIIStatisticsViewController alloc]init];
    [self.navigationController pushViewController: StatisticsViewController animated:YES];
}

@end
