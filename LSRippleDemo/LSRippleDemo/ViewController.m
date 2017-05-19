//
//  ViewController.m
//  LSRippleDemo
//
//  Created by hanfeng.li on 2017/5/19.
//  Copyright © 2017年 hanfeng.li. All rights reserved.
//

#import "ViewController.h"
#import "LSRippleButton.h"
#import "LSRippleView.h"


@interface ViewController ()
@property (strong, nonatomic) LSRippleView *rippleView;
@property (strong, nonatomic) LSRippleButton *rippleButton;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self rippleView];
    [self rippleButton];
}

- (LSRippleButton *)rippleButton {
    if (!_rippleButton) {
        CGFloat width = 200.0f;
        CGFloat height = 100.0f;
        _rippleButton = [[LSRippleButton alloc] initWithFrame:CGRectMake(0, 200, width, height)];
        [_rippleButton setBackgroundColor:[UIColor colorWithWhite:0.9 alpha:1]];
        _rippleButton.layer.cornerRadius = 5.0f;
        [_rippleButton addTarget:self action:@selector(onButton) forControlEvents:UIControlEventTouchUpInside];
        _rippleButton.center = CGPointMake(self.view.bounds.size.width * 0.5, 300);
        [self.view addSubview:_rippleButton];
    }
    return _rippleButton;
}

- (LSRippleView *)rippleView {
    if (!_rippleView) {
        CGFloat width = 200.0f;
        CGFloat height = 100.0f;
        _rippleView = [[LSRippleView alloc] initWithFrame:CGRectMake(self.rippleButton.frame.origin.x, self.rippleButton.frame.origin.y + self.rippleButton.frame.size.height + 50, width, height)];
        [_rippleView setBackgroundColor:[UIColor colorWithWhite:0.9 alpha:1]];
        _rippleView.layer.cornerRadius = 5.0f;
        [_rippleView setRippleColor:[UIColor redColor]];
        [self.view addSubview:_rippleView];
    }
    return _rippleView;
}

- (void)onButton {
    NSLog(@"=======");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
