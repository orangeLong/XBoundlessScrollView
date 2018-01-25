//
//  ViewController.m
//  XBoundlessScrollView
//
//  Created by LiX i n long on 2018/1/25.
//  Copyright © 2018年 LiX i n long. All rights reserved.
//

#import "ViewController.h"

#import "XBoundlessScrollView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initLongView];
    [self initMultipleView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initLongView
{
    XBoundlessScrollView *scrollView = [[XBoundlessScrollView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 200)];
    scrollView.boundlessBlock = ^(CHDLQBoundlessBlockType blockType, NSInteger index) {
        NSLog(@"longView:%lu-----%ld", (unsigned long)blockType, (long)index);
    };
    [self.view addSubview:scrollView];
    
    NSMutableArray *showArray = @[].mutableCopy;
    for (int i = 1; i < 3; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"long%d.jpg", i]]];
        [showArray addObject:imageView];
    }
    scrollView.showViews = showArray;
}

- (void)initMultipleView
{
    XBoundlessScrollView *scrollView = [[XBoundlessScrollView alloc] initWithFrame:CGRectMake(0, 350, self.view.frame.size.width, 250)];
    scrollView.boundlessBlock = ^(CHDLQBoundlessBlockType blockType, NSInteger index) {
        NSLog(@"multipleView:%lu-----%ld", (unsigned long)blockType, (long)index);
    };
    [self.view addSubview:scrollView];
    
    NSMutableArray *showArray = @[].mutableCopy;
    for (int i = 1; i < 12; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg", i]]];
        [showArray addObject:imageView];
    }
    scrollView.showViews = showArray;
}


@end
