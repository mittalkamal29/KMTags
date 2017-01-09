//
//  ViewController.m
//  KMTags
//
//  Created by Kamal MIttal on 26/03/16.
//  Copyright © 2016 _. All rights reserved.
//

#import "ViewController.h"
#import "FilterTagView.h"

@interface ViewController () <FilterTagViewDelegate>
@property (nonatomic, weak) IBOutlet FilterTagView *tagview;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *fliterheight;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.tagview.backgroundColor = [UIColor clearColor];
    [self.tagview setTags:@[@"Kamal",@"Mittal",@"Alwar",@"IOS",@"Xcode",@"Kamal",@"Mittal",@"Alwar",@"IOS",@"Xcode",@"Kamal",@"Mittal",@"Alwar",@"IOS",@"Xcode",@"Kamal",@"Mittal",@"Alwar",@"IOS",@"Xcode",@"Kamal",@"Mittal",@"Alwar",@"IOS",@"Xcode",@"Kamal",@"Mittal",@"Alwar",@"IOS",@"Xcode",@"Kamal",@"Mittal",@"Alwar",@"IOS",@"Xcode",@"Kamal",@"Mittal",@"Alwar",@"IOS",@"Xcode"]];
    [self.tagview setSeelctedTags:@[@"Alwar"]];
    //self.tagview.backgroundColor = [UIColor grayColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) removedTag:(NSString *)tag fromIndex:(NSInteger)index {
    NSLog(@"%@ : Index %ld",tag,(long)index);
}

-(void) finalheightOfView:(float) height {
    self.fliterheight.constant = height;
    [self.view layoutIfNeeded];
    NSLog(@"%f",height);
}


@end
