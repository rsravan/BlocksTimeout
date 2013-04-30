//
//  ViewController.m
//  BlocksTimeout
//
//  Created by SRAVAN on 4/29/13.
//  Copyright (c) 2013 SRAVAN. All rights reserved.
//

#import "ViewController.h"

#import "NSObject+blockTimeout.h"

#import <dispatch/dispatch.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad

{
    dispatch_queue_t queue=dispatch_queue_create("test", NULL);
    [super viewDidLoad];
    [self performOperation:^{ sleep(1);} onqueue:queue withtimeOut:1.0];
    
    [self performOperation:^{ } onqueue:queue withtimeOut:1000];

    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    

    

    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end
