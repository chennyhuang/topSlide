//
//  HZSlidingViewController.m
//  HZSlidingViewController
//
//  Created by huangzhenyu on 14-2-24.
//  Copyright (c) 2014年 huangzhenyu. All rights reserved.

#import "HZSlidingViewController.h"
#define kNavigationBarViewH 44 //顶部分类选择条的高度
#define kButtonMinW 70         //顶部按钮最小宽度
#define kShadowLineW 50        //指示线条的宽度
#define kSelecetedColor ([UIColor colorWithRed:70.0/255.0 green:128.0/255.0 blue:209.0/255.0 alpha:1])
@interface HZSlidingViewController ()<UIScrollViewDelegate>
{
    CGFloat _viewWidth;
    CGFloat _viewHeight;
    CGFloat _buttonWidth;//顶部按钮实际宽度
//    CGFloat _sysNavBarH; //系统导航条高度
//    CGFloat _sysStatusBarH; //系统状态条高度
}
@property (nonatomic,strong) UIView *shadowLine;
@property (nonatomic,strong) UIScrollView *contentScrollview;
@property (nonatomic,assign) CGFloat allButtonWidth;
@end

@implementation HZSlidingViewController

#pragma mark- contrller lifecircle
- (instancetype)initSlidingViewControllerWithTitle:(NSString *)title viewController:(UIViewController *)controller{

    self = [self init];
    if (self) {
        
        [self.titles addObject:title];
        [self.childControllers addObject:controller];
    }
    return  self;
}

- (instancetype)initSlidingViewControllerWithTitlesAndControllers:(NSDictionary *)titlesAndControllers{
    
    if (self = [self init]) {
        
        [titlesAndControllers enumerateKeysAndObjectsUsingBlock:^(id key,id obj,BOOL *stop){
            if ([key isKindOfClass:[NSString class]] && [obj isKindOfClass:[UIViewController class]]) {
                
                [self.titles addObject:key];
                [self.childControllers addObject:obj];
            }
        }];
        
    }
    return self;
}

- (void)addControllerWithTitle:(NSString *)title viewController:(UIViewController *)controller{
    [self.titles addObject:title];
    [self.childControllers addObject:controller];
}

- (void)setTopEdge:(NSUInteger)topEdge{
    _topEdge = topEdge;
    [self viewDidLayoutSubviews];//重新计算frame
}

- (NSMutableArray *)titles
{
    if (!_titles) {
        _titles = [NSMutableArray array];
    }
    return _titles;
}

- (NSMutableArray *)childControllers
{
    if (!_childControllers) {
        _childControllers = [NSMutableArray array];
    }
    return _childControllers;
}

#pragma mark - view lifecircle
- (void)viewDidLoad
{
    [super viewDidLoad];
    _topEdge = 0;
    _viewWidth = self.view.frame.size.width;
    _viewHeight = self.view.frame.size.height;
    _unselectedLabelColor = [UIColor grayColor];
    _selectedLabelColor = kSelecetedColor;
    self.automaticallyAdjustsScrollViewInsets = NO;//设置scrollview内部的控件不自动下拉64像素
    [self.view addSubview:self.navigationBarView];
    [self.view addSubview:self.contentScrollview];
    self.selectedIndex = 0;
}

- (void)viewDidLayoutSubviews{
    //支持横屏
    [super viewDidLayoutSubviews];
    _viewWidth = self.view.frame.size.width;
    _viewHeight = self.view.frame.size.height;
    self.navigationBarView.frame = CGRectMake(0,  _topEdge, _viewWidth, kNavigationBarViewH);
    self.navigationBarScrollView.frame = CGRectMake(0, 0, _viewWidth , kNavigationBarViewH);
    self.contentScrollview.frame = CGRectMake(0, kNavigationBarViewH + _topEdge,_viewWidth  , _viewHeight-kNavigationBarViewH - _topEdge );
    for (int i=0; i<[self.childControllers count]; i++) {
        id obj = [self.childControllers objectAtIndex:i];
        if ([obj isKindOfClass:[UIViewController class]]) {
            UIViewController *controller = (UIViewController *)obj;
            CGFloat scrollWidth = _contentScrollview.frame.size.width;
            CGFloat scrollHeight = _contentScrollview.frame.size.height;
            [controller.view setFrame:CGRectMake(i*scrollWidth, 0, scrollWidth, scrollHeight)];
        }
    }
    _contentScrollview.contentSize = CGSizeMake(_contentScrollview.frame.size.width*[self.titles count], _contentScrollview.frame.size.height);
    //设置contentScrollview的偏移量
    [_contentScrollview setContentOffset:CGPointMake(_selectedIndex *_contentScrollview.frame.size.width, 0) animated:NO];

}

-(UIView *)navigationBarView{
    if (!_navigationBarView) {
        _navigationBarView = [[UIView alloc] initWithFrame:CGRectMake(0, _topEdge, _viewWidth, kNavigationBarViewH)];
        _navigationBarView.backgroundColor = [UIColor whiteColor];
        [_navigationBarView addSubview:self.navigationBarScrollView];
    }
    return _navigationBarView;
}

- (UIScrollView *)navigationBarScrollView
{
    if (!_navigationBarScrollView) {
        _navigationBarScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, _viewWidth , kNavigationBarViewH)];
        NSUInteger itemCount = [self.titles count];
        CGFloat buttonWidth = _viewWidth/itemCount;
        if (buttonWidth < kButtonMinW) {
            buttonWidth = kButtonMinW;
        }
        _buttonWidth = buttonWidth;
        self.allButtonWidth = buttonWidth * itemCount;
        _navigationBarScrollView.showsHorizontalScrollIndicator = NO;
        _navigationBarScrollView.contentSize = CGSizeMake(self.allButtonWidth, kNavigationBarViewH);
        
        for (int i=0; i<itemCount; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitleColor:self.unselectedLabelColor forState:UIControlStateNormal];
            [button setTitleColor:self.selectedLabelColor forState:UIControlStateSelected];
            [button.titleLabel setFont:[UIFont systemFontOfSize:13.0]];
            [button.titleLabel setTextAlignment:NSTextAlignmentCenter];
            [button setTitle:self.titles[i] forState:UIControlStateNormal];
            [button setContentEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
            button.tag = i;
            [button addTarget:self action:@selector(navigationBarButtonItemClicked:) forControlEvents:UIControlEventTouchUpInside];
            button.frame = CGRectMake(i*buttonWidth, 0, buttonWidth, kNavigationBarViewH);
            [_navigationBarScrollView addSubview:button];
            if (i==0) {
                [button setTitleColor:self.selectedLabelColor forState:UIControlStateNormal];
            }
        }
        self.shadowLine = [[UIView alloc] initWithFrame:CGRectMake((_buttonWidth - kShadowLineW)*0.5, kNavigationBarViewH - 3, kShadowLineW, 3)];
        self.shadowLine.backgroundColor = kSelecetedColor;
        [_navigationBarScrollView addSubview:self.shadowLine];
    }
    _navigationBarScrollView.scrollsToTop = NO;
    return _navigationBarScrollView;
}

- (UIScrollView *)contentScrollview
{
    if (!_contentScrollview) {
        _contentScrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kNavigationBarViewH + _topEdge,_viewWidth  , _viewHeight-kNavigationBarViewH - _topEdge)];
        _contentScrollview.backgroundColor = [UIColor whiteColor];
        _contentScrollview.pagingEnabled = YES;
        _contentScrollview.alwaysBounceHorizontal = YES;
        _contentScrollview.contentSize = CGSizeMake(_contentScrollview.frame.size.width*[self.titles count], _contentScrollview.frame.size.height);
        _contentScrollview.delegate = self;
        
        for (int i=0; i<[self.childControllers count]; i++) {
            id obj = [self.childControllers objectAtIndex:i];
            if ([obj isKindOfClass:[UIViewController class]]) {
                UIViewController *controller = (UIViewController *)obj;
                [self addChildViewController:controller];
                CGFloat scrollWidth = _contentScrollview.frame.size.width;
                CGFloat scrollHeight = _contentScrollview.frame.size.height;
                [controller.view setFrame:CGRectMake(i*scrollWidth, 0, scrollWidth, scrollHeight)];
                [_contentScrollview addSubview:controller.view];
            }
        }
    }
    _contentScrollview.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    _contentScrollview.showsHorizontalScrollIndicator = NO;
    _contentScrollview.scrollsToTop = NO;
    return _contentScrollview;
}

- (void)transitionToIndex:(NSUInteger)index
{
    self.selectedIndex = index;
}

- (void)navigationBarButtonItemClicked:(UIButton *)button{
    self.selectedIndex = button.tag;
}

- (void)setSelectedIndex:(NSUInteger)index{
    //设置点击状态栏tableview滚动到顶部
    for (int i= 0; i<[self.childControllers count]; i++) {
        id obj = [self.childControllers objectAtIndex:i];
        if (i == index) {//设置当前的控制器，如果是tableview，设置scrollsToTop为YES
            if ([obj isKindOfClass:[UITableViewController class]]) {
                UITableViewController *vc = (UITableViewController *)obj;
                vc.tableView.scrollsToTop = YES;
            }
        } else {
            if ([obj isKindOfClass:[UITableViewController class]]) {
                UITableViewController *vc = (UITableViewController *)obj;
                vc.tableView.scrollsToTop = NO;
            }
        }
    }
    //改变按钮颜色
    if (index != _selectedIndex) {
        UIButton *origin;
        UIButton *currentButton;
        for (id view in _navigationBarScrollView.subviews) {
            if ([view isKindOfClass:[UIButton class]]) {
                UIButton *button = (UIButton *)view;
                if (button.tag == index) {
                    currentButton = button;
                }
                if (button.tag == _selectedIndex) {
                    origin = button;
                }
            }
        }
        [origin setTitleColor:self.unselectedLabelColor forState:UIControlStateNormal];
        [currentButton setTitleColor:self.selectedLabelColor forState:UIControlStateNormal];
        _selectedIndex = index;
    }
    [self transitionToViewControllerAtIndex:index];
}


- (void)transitionToViewControllerAtIndex:(NSUInteger)index{

    if ([_delegate respondsToSelector:@selector(slidingCurrentIndex:currentIndex:)]) {
        [_delegate slidingCurrentIndex:self currentIndex:(_selectedIndex)];
    }
    
    //设置contentScrollview的偏移量
    [_contentScrollview setContentOffset:CGPointMake(index *_contentScrollview.frame.size.width, 0) animated:YES];
    
    //设置顶部 navigationBarScrollView 偏移量
    id obj = self.navigationBarScrollView.subviews[index];
    UIButton *selectButton;
    if ([obj isKindOfClass:[UIButton class]]) {
      selectButton = obj;
    }
    CGFloat navBarScrollViewWidth = _navigationBarScrollView.frame.size.width;
    if (self.allButtonWidth > navBarScrollViewWidth) {//存在偏移可能性
        CGFloat offset;
        CGFloat minOffset = 0;//最小偏移
        CGFloat maxOffset = self.allButtonWidth - navBarScrollViewWidth;//最大偏移
        CGFloat delt = selectButton.center.x - navBarScrollViewWidth * 0.5;
        if (delt < 0) {
            offset = minOffset;
        } else if (delt >= 0 && delt < maxOffset) {
            offset = delt;
        } else if (delt >= maxOffset) {
            offset = maxOffset;
        }
        [_navigationBarScrollView setContentOffset:CGPointMake(offset, 0) animated:YES];
    }
}

- (void)transitionToViewController:(UIViewController *)controller{
    [self transitionToViewControllerAtIndex:[self.childControllers indexOfObject:controller]];
}

#pragma mark - scrollView delegate
//手停止拖拽scrollview，等到scrollview静止的瞬间调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //fmod-》求余数
    if (0==fmod(scrollView.contentOffset.x,scrollView.frame.size.width)){
        self.selectedIndex =  scrollView.contentOffset.x/scrollView.frame.size.width;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat contentOffsetX = scrollView.contentOffset.x;
    if (contentOffsetX < 0) {
        contentOffsetX = 0;
    }
    if (contentOffsetX > scrollView.contentSize.width - _viewWidth) {
        contentOffsetX = scrollView.contentSize.width - _viewWidth;
    }

    CGFloat ratio = self.navigationBarScrollView.contentSize.width/scrollView.contentSize.width;
    CGRect shadowRect = self.shadowLine.frame;
    shadowRect.origin.x = contentOffsetX*ratio  + (_buttonWidth - kShadowLineW)*0.5;
    self.shadowLine.frame = shadowRect;
}
@end
