//
//  ViewController.m
//  YXScrollImgCode
//
//  Created by Color on 2018/4/17.
//  Copyright © 2018年 ColorBlue. All rights reserved.
//

#import "ViewController.h"

#import "YXScrollPhotoView/YXScrollPhotoView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
   
    NSArray *imgArr = @[@"1",@"2",@"3",@"4"];
    YXScrollPhotoView *scrolView = [[YXScrollPhotoView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200) imgUrls:imgArr];
    scrolView.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width *3, 200);
    scrolView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:scrolView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
