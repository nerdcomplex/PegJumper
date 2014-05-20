//
//  XIIIBoardShapeViewController.m
//  Peg Jumper
//
//  Created by Adham Meguid on 5/7/14.
//  Copyright (c) 2014 Organization XIII. All rights reserved.
//

#import "XIIIBoardShapeViewController.h"

@implementation XIIIBoardShapeViewController;
@synthesize imageView = mImageView;

//@interface XIIIBoardShapeViewController ()

//@end


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
    
    NSAssert(self.imageView, @"self.imageView is nil. Check your IBOutlet connections");
    UIImage* image1 = [UIImage imageNamed:@"triangle"];
    UIImage* image2 = [UIImage imageNamed:@"plus"];
    
    NSAssert(image1, @"image is nil. Check that you added the image to your bundle and that the filename above matches the name of you image.");
    self.imageView.backgroundColor = [UIColor whiteColor];
    self.imageView.clipsToBounds = YES;
    self.imageView.image = image1;
    self.imageView.image = image2;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
