//
//  YXScrollPhotoView.h
//  YXProgressHUD
//
//  Created by Color on 2018/4/16.
//  Copyright © 2018年 ColorBlue. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YXScrollPhotoView;
@protocol YXScrollPhotoViewDelegate <NSObject>

@optional

-(void)scrollView:(YXScrollPhotoView *)photoView clickIndex:(NSInteger)index;

@end


@interface YXScrollPhotoView : UIView <UIScrollViewDelegate>

@property (nonatomic , strong) NSArray *imgUrls;

/** UI  */
@property (nonatomic , strong) UIImageView *leftView;

@property (nonatomic , strong) UIImageView *rightView;

@property (nonatomic , strong) UIImageView *centerView;

@property (nonatomic , strong) UIPageControl *pageControl;

@property (nonatomic , strong) UIScrollView *scrollView;
/** 不可以修改 */
@property (nonatomic , strong) NSTimer *timer;

@property (nonatomic , assign) NSInteger currentPage;

/** 代理 */

@property (nonatomic , copy) id <YXScrollPhotoViewDelegate> delegate;

-(instancetype)initWithFrame:(CGRect)frame imgUrls:(NSArray *)imgUrls;


@end
