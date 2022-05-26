//
//  AZLViewController.m
//  AZLExtend
//
//  Created by azusalee on 03/25/2020.
//  Copyright (c) 2020 azusalee. All rights reserved.
//

#import "AZLViewController.h"
#import <AZLExtend/AZLExtend.h>
#import <objc/runtime.h>

@interface AZLViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation AZLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIImage *image = [UIImage imageNamed:@"test_image"];
    self.imageView.image = [image azl_imageFromBoxBlur:0.5];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
