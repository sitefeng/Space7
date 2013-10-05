//
//  AboutSceneViewController.m
//  Space7
//
//  Created by Si Te Feng on 2013-10-04.
//  Copyright (c) 2013 Si Te Feng. All rights reserved.
//

#import "AboutSceneViewController.h"

@interface AboutSceneViewController ()

@end

@implementation AboutSceneViewController

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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewDidLoad];
    //descriptionScrollView= [[UIScrollView alloc]initWithFrame: CGRectMake(0, 0, 200, 200)];]\
    
    [descriptionScroll setEditable:NO];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc {
    [descriptionScroll release];
    [aboutVIew release];
    [descriptionScroll release];
    [super dealloc];
}
- (void)viewDidUnload {
    [aboutVIew release];
    aboutVIew = nil;
    [descriptionScroll release];
    descriptionScroll = nil;
    [super viewDidUnload];
}
@end
