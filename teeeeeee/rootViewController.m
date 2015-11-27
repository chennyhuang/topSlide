//
//  rootViewController.m
//  teeeeeee
//
//  Created by huangzhenyu on 15/4/2.
//  Copyright (c) 2015年 eamon. All rights reserved.
//

#import "rootViewController.h"
//#import "NTSlidingViewController.h"
#import "TableViewController.h"
#import "SlideViewController.h"

@interface rootViewController ()<NTSlidingDelegete>
- (IBAction)click:(id)sender;

@end

@implementation rootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)click:(id)sender {
//    UIViewController *vc1 = [[UIViewController alloc] init];
//    vc1.view.backgroundColor = [UIColor redColor];
//    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
//    label1.font = [UIFont systemFontOfSize:30];
//    label1.text = @"1";
//    [vc1.view addSubview:label1];
    TableViewController *vc1 = [[TableViewController alloc] initWithStyle:UITableViewStylePlain];
    
    
//    UIViewController *vc2 = [[UIViewController alloc] init];
//    vc2.view.backgroundColor  = [UIColor blueColor];
//    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
//    label2.font = [UIFont systemFontOfSize:30];
//    label2.text = @"2";
//    [vc2.view addSubview:label2];
    TableViewController *vc2 = [[TableViewController alloc] initWithStyle:UITableViewStylePlain];
    
    UIViewController *vc3 = [[UIViewController alloc] init];
    vc3.view.backgroundColor = [UIColor grayColor];
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 100, 100)];
    label3.font = [UIFont systemFontOfSize:30];
    label3.text = @"3";
    label3.backgroundColor = [UIColor blueColor];
    [vc3.view addSubview:label3];
    
    UIViewController *vc4 = [[UIViewController alloc] init];
    vc4.view.backgroundColor = [UIColor brownColor];
    UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    label4.font = [UIFont systemFontOfSize:30];
    label4.text = @"4";
    [vc4.view addSubview:label4];
    
    UIViewController *vc5 = [[UIViewController alloc] init];
    vc5.view.backgroundColor = [UIColor lightGrayColor];
    UILabel *label5 = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    label5.font = [UIFont systemFontOfSize:30];
    label5.text = @"5";
    [vc5.view addSubview:label5];
    
    UIViewController *vc6 = [[UIViewController alloc] init];
    vc6.view.backgroundColor = [UIColor darkGrayColor];
    UILabel *label6 = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    label6.font = [UIFont systemFontOfSize:30];
    label6.text = @"6";
    [vc6.view addSubview:label6];
    
    UIViewController *vc7 = [[UIViewController alloc] init];
    vc7.view.backgroundColor = [UIColor brownColor];
    UILabel *label7 = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    label7.font = [UIFont systemFontOfSize:30];
    label7.text = @"7";
    [vc7.view addSubview:label7];
    
    UIViewController *vc8 = [[UIViewController alloc] init];
    vc8.view.backgroundColor = [UIColor redColor];
    UILabel *label8 = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    label8.font = [UIFont systemFontOfSize:30];
    label8.text = @"8";
    [vc8.view addSubview:label8];
    
    UIViewController *vc9 = [[UIViewController alloc] init];
    vc9.view.backgroundColor = [UIColor lightGrayColor];
    UILabel *label9 = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    label9.font = [UIFont systemFontOfSize:30];
    label9.text = @"9";
    [vc9.view addSubview:label9];
    
    
    SlideViewController *slideVc = [[SlideViewController alloc] initSlidingViewControllerWithTitle:@"首页" viewController:vc1];
    slideVc.delegate = self;
    [slideVc addControllerWithTitle:@"足球" viewController:vc2];
    [slideVc addControllerWithTitle:@"轻松一刻" viewController:vc3];
    [slideVc addControllerWithTitle:@"测试测试" viewController:vc4];
//    [slideVc addControllerWithTitle:@"55" viewController:vc5];
//    [slideVc addControllerWithTitle:@"VC6" viewController:vc6];
//    [slideVc addControllerWithTitle:@"VC7" viewController:vc7];
//    [slideVc addControllerWithTitle:@"VC8" viewController:vc8];
//    [slideVc addControllerWithTitle:@"VC9" viewController:vc9];
    
    [self.navigationController pushViewController:slideVc animated:YES];

}

//
- (void)slidingCurrentIndex:(NTSlidingViewController *)sliding currentIndex:(NSUInteger)index
{
    NSLog(@"slidingCurrentIndex -- %i",index);
}
@end
