//
//  NTSlidingViewController.h
//  NTSlidingViewController
//
//  Created by nonstriater on 14-2-24.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NTSlidingViewController;

@protocol NTSlidingDelegete<NSObject>
@optional
//跳转到目标控制器的代理方法，index从1开始
- (void)slidingCurrentIndex:(NTSlidingViewController *)sliding currentIndex:(NSUInteger)index;
@end

typedef void (^NTTransitionCompleteBlock)(NSUInteger from,NSUInteger to);


@interface NTSlidingViewController : UIViewController

@property (nonatomic, weak) id<NTSlidingDelegete>delegate;
@property(nonatomic,assign) NSUInteger selectedIndex;
//@property (nonatomic,assign) NSUInteger currentIndex;//当前选中的index

@property(nonatomic,strong) UIColor *selectedLabelColor;
@property(nonatomic,strong) UIColor *unselectedLabelColor;
@property(nonatomic,strong) UIView *navigationBarView;

@property (nonatomic,strong) UIScrollView *navigationBarScrollView;
//@property (nonatomic,strong) UIButton *navigationBarPullButton;

@property(nonatomic,strong) NSMutableArray *titles;//array of NSString
@property(nonatomic,strong) NSMutableArray *childControllers;//array of UIViewControllers

@property (nonatomic,strong) void(^pullButtonClickBlock)();

- (instancetype)initSlidingViewControllerWithTitle:(NSString *)title viewController:(UIViewController *)controller;
- (instancetype)initSlidingViewControllerWithTitlesAndControllers:(NSDictionary *)titlesAndControllers;
- (void)addControllerWithTitle:(NSString *)title viewController:(UIViewController *)controller;

- (void)transitionToIndex:(NSUInteger)index;//代码控制跳转到哪个控制器，index从1开始
//- (void)transitionToViewControllerAtIndex:(NSUInteger)index;
//- (void)transitionToViewController:(UIViewController *)controller;
//- (void)transitionToViewController:(UIViewController *)controller complteBlock:(NTTransitionCompleteBlock)block;
@end







