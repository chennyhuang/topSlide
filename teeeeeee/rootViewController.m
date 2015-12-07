//
//  rootViewController.m
//  teeeeeee
//
//  Created by huangzhenyu on 15/4/2.
//  Copyright (c) 2015年 eamon. All rights reserved.
//

#import "rootViewController.h"
#import "pushViewController.h"

#define appWidth   [[UIScreen mainScreen] bounds].size.width
@interface rootViewController ()
- (IBAction)click:(id)sender;

@end

@implementation rootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)click:(id)sender {
    pushViewController *vc = [[pushViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
