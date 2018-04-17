//
//  YXScrollPhotoView.m
//  YXProgressHUD
//
//  Created by Color on 2018/4/16.
//  Copyright © 2018年 ColorBlue. All rights reserved.
//

#import "YXScrollPhotoView.h"

@implementation YXScrollPhotoView

-(instancetype)initWithFrame:(CGRect)frame imgUrls:(NSArray *)imgUrls
{
    self = [super initWithFrame:frame];

    if (self) {
        [self initSubViews];
        _currentPage = 0;
        _imgUrls = imgUrls;
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.leftView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    self.centerView.frame = CGRectMake(self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height);
    self.rightView.frame = CGRectMake(self.bounds.size.width*2, 0, self.bounds.size.width, self.bounds.size.height);
    [self.scrollView setContentOffset:CGPointMake(self.bounds.size.width, 0)];
    [self setupValues];
 
}

-(void)setupValues{
    
    _pageControl.numberOfPages = self.imgUrls.count;
    _pageControl.currentPage = self.currentPage;
    self.scrollView.frame = self.bounds;
    self.leftView.image =  [UIImage imageNamed:_imgUrls[[self backNumWithCurrentPage:(_currentPage - 1)]]];
    self.centerView.image = [UIImage imageNamed:_imgUrls[[self backNumWithCurrentPage:_currentPage]]];
    self.rightView.image =  [UIImage imageNamed:_imgUrls[[self backNumWithCurrentPage:(_currentPage + 1)]]];
    
}

-(void)initSubViews{
 
    [self addSubview:self.scrollView];
    [self.scrollView addSubview:self.leftView];
    [self.scrollView addSubview:self.centerView];
    [self.scrollView addSubview:self.rightView];
    [self addSubview:self.pageControl];
    self.scrollView.pagingEnabled = YES;
    
    self.scrollView.delegate = self;
    
    [self setupTimer];
    
}


-(void)setupTimer{
    __block typeof(self)weakSelf = self;
    _timer = [NSTimer scheduledTimerWithTimeInterval:2 repeats:YES block:^(NSTimer * _Nonnull timer) {
        
        [weakSelf.scrollView setContentOffset:CGPointMake(weakSelf.bounds.size.width * 2, 0) animated:YES];
    }];
    
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    
}
#pragma mark - scro
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_timer invalidate];
}


-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self updateValues];
    
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    [self setupTimer];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self updateValues];
}

#pragma mark - private method


-(void)updateValues{
    
    if (self.scrollView.contentOffset.x > self.frame.size.width) {
        _currentPage++ ;
    }else if (self.scrollView.contentOffset.x == 0)
    {
        _currentPage--;
    }else
    {
        return;
    }
    _currentPage = [self backNumWithCurrentPage:_currentPage];
    self.pageControl.currentPage = _currentPage;
    [self setupValues];
    self.scrollView.contentOffset = CGPointMake(self.frame.size.width, 0);
    
}

-(NSInteger)backNumWithCurrentPage:(NSInteger )page{
    
    if (page < 0) {
        return self.imgUrls.count - 1;
    }
    
    if (page > self.imgUrls.count - 1) {
        return 0;
    }
    
    return page;
}

#pragma mark - events
-(void)clickBtn{
    NSLog(@"点击了第几个图片%ld",(long)_currentPage);
    if (self.delegate && [self.delegate respondsToSelector:@selector(scrollView:clickIndex:)]) {
        [self.delegate scrollView:self clickIndex:_currentPage];
    }
}

#pragma mark - setter

-(void)setImgUrls:(NSArray *)imgUrls
{
    if (_imgUrls.count <=  0) {
        return;
    }
    _imgUrls = imgUrls;
    [self layoutSubviews];
}

#pragma mark - lazy

-(UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}
-(UIImageView *)leftView
{
    if (!_leftView) {
        _leftView = [[UIImageView alloc] init];
        _leftView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _leftView;
}

-(UIImageView *)rightView
{
    if (!_rightView) {
        _rightView = [[UIImageView alloc] init];
        _rightView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _rightView;
}


-(UIImageView *)centerView
{
    if (!_centerView) {
        _centerView = [[UIImageView alloc] init];
        _centerView.contentMode = UIViewContentModeScaleAspectFit;
        _centerView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickBtn)];
        [_centerView addGestureRecognizer:tap];
    }
    return _centerView;
}
-(UIPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - 30, self.bounds.size.width, 20)];
        _pageControl.pageIndicatorTintColor = [UIColor greenColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor blueColor];
        _pageControl.backgroundColor = [UIColor clearColor];
    }
    return _pageControl;
}




@end
