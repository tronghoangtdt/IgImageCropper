//
//  IGViewController.m
//  IGImageCropper
//
//  Created by Arshad on 09/15/2021.
//  Copyright (c) 2021 Arshad. All rights reserved.
//

#import "IGViewController.h"
#import <IGImageCropper/IGCropViewController.h>

@interface IGViewController ()

@end

@implementation IGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    UIImage * im = [UIImage imageNamed:@"22_l"];
    IGCropViewController *vc = [[IGCropViewController alloc] initWithImage:im minimumPortraitZoomScale:4/5 minimumLandScapeZoomScale:1/1.91];
    [self presentViewController:vc animated:YES completion:^{
            
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
