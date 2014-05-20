//
//  XIIIOptionsViewController.m
//  Peg Jumper
//
//  Created by Adham Meguid on 5/5/14.
//  Copyright (c) 2014 Organization XIII. All rights reserved.
//

#import "XIIIOptionsViewController.h"
#import "XIIIBoardShapeViewController.h"
@interface XIIIOptionsViewController ()

@end

@implementation XIIIOptionsViewController

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
- (IBAction)BoardShape:(id)sender
{
    XIIIBoardShapeViewController *boardShapeViewController = [[XIIIBoardShapeViewController alloc] init];
    
    [self.navigationController pushViewController:boardShapeViewController animated:YES]; //Every view
    //knows its navigation controller
    

}

- (IBAction)mysteryOptions:(id)sender
{
    
}



@end
