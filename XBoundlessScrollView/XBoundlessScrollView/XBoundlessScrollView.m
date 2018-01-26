//
//  XBoundlessScrollView.m
//  XBoundlessScrollView
//
//  Created by LiX i n long on 2018/1/25.
//  Copyright © 2018年 LiX i n long. All rights reserved.
//

#import "XBoundlessScrollView.h"

#define kSelfWidth self.frame.size.width
#define kSelfHeight self.frame.size.height

#define doubleEqual(doubleA, doubleB)     (fabs((doubleA) - (doubleB)) <= pow(10, -4))

@interface XBoundlessScrollView()<UIScrollViewDelegate>

@property (nonatomic) NSInteger currentIndex;
@property (nonatomic, strong) NSTimer *scrollTimer;

@end

@implementation XBoundlessScrollView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self baseInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self baseInit];
    }
    return self;
}

- (void)baseInit
{
    self.bounces = NO;
    self.pagingEnabled = YES;
    [self setValue:self forKey:@"delegate"];
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    [self setContentOffset:CGPointMake(kSelfWidth, 0)];
    self.scrollInterval = 3.f;
}

- (void)setShowViews:(NSArray *)showViews
{
    _showViews = showViews;
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if (!showViews.count) {
        return;
    }
    [showViews enumerateObjectsUsingBlock:^(UIView *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSInteger index = idx + 1;
        if (index == showViews.count && index != 1) {
            index = 0;
        }
        obj.frame = CGRectMake(kSelfWidth * index, 0, kSelfWidth, kSelfHeight);
        obj.userInteractionEnabled = YES;
        [self addSubview:obj];
    }];
    self.contentSize = CGSizeMake(kSelfWidth * 3, 0);
    [self setContentOffset:CGPointMake(kSelfWidth, 0)];
    self.scrollEnabled = showViews.count != 1;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
    [self addGestureRecognizer:tap];
    self.currentIndex = 0;
    [self resetTimer];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.showViews.count != 2) {
        return;
    }
    UIView *subView = [self.showViews objectAtIndex:[self realIndex:self.currentIndex + 1]];
    CGFloat x = 0;
    if (scrollView.contentOffset.x > scrollView.frame.size.width) {
        x = kSelfWidth * 2;
    }
    if (!doubleEqual(x, subView.frame.origin.x)) {
        CGRect frame = scrollView.bounds;
        frame.origin.x = x;
        subView.frame = frame;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidChanged:scrollView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self scrollViewDidChanged:scrollView];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.scrollTimer setFireDate:[NSDate distantFuture]];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self.scrollTimer setFireDate:[NSDate dateWithTimeIntervalSinceNow:self.scrollInterval]];
}

#pragma mark - action

- (void)tapClick
{
    if (self.boundlessBlock) {
        self.boundlessBlock(CHDLQBoundlessBlockTypeClick, self.currentIndex);
    }
}

#pragma mark - setter

- (void)setScrollInterval:(NSTimeInterval)scrollInterval
{
    _scrollInterval = scrollInterval;
    [self resetTimer];
}

- (void)setCurrentIndex:(NSInteger)currentIndex
{
    NSInteger realIndex = [self realIndex:currentIndex];
    if (_currentIndex == realIndex) {
        return;
    }
    _currentIndex = realIndex;
    for (int i = 0; i < 3; i++) {
        [self bringShowViewToFront:i];
    }
}

#pragma mark - private

- (void)resetTimer
{
    [self.scrollTimer invalidate];
    self.scrollTimer = nil;
    if (self.subviews.count < 2 || self.scrollInterval <= 0) {
        return;
    }
    __weak typeof(self) weakself = self;
    self.scrollTimer = [NSTimer scheduledTimerWithTimeInterval:self.scrollInterval repeats:YES block:^(NSTimer * _Nonnull timer) {
        __strong typeof(weakself) strongself = weakself;
        CGPoint point = strongself.contentOffset;
        point.x += kSelfWidth;
        [strongself setContentOffset:point animated:YES];
    }];
    [[NSRunLoop mainRunLoop] addTimer:self.scrollTimer forMode:NSRunLoopCommonModes];
}

- (void)scrollViewDidChanged:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    self.currentIndex = self.currentIndex + index - 1;
    [scrollView setContentOffset:CGPointMake(kSelfWidth, 0)];
    if (self.boundlessBlock) {
        self.boundlessBlock(CHDLQBoundlessBlockTypeScroll, self.currentIndex);
    }
}

- (void)bringShowViewToFront:(NSInteger)result
{
    NSInteger realIndex = [self realIndex:self.currentIndex + result - 1];
    UIView *showView = [self.showViews objectAtIndex:realIndex];
    CGRect frame = showView.frame;
    frame.origin.x = frame.size.width * result;
    showView.frame = frame;
    [self bringSubviewToFront:showView];
}

- (NSInteger)realIndex:(NSInteger)index
{
    NSInteger realIndex = index;
    if (realIndex < 0) {
        realIndex = self.showViews.count - 1;
    } else if (realIndex > self.showViews.count - 1) {
        realIndex = 0;
    }
    return realIndex;
}


@end
