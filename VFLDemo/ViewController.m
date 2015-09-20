//
//  ViewController.m
//  VFLDemo
//
//  Created by user on 15/9/20.
//  Copyright © 2015年 lcg. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"

@interface ViewController ()
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self layoutWithVFL];
    [self layoutWithMasonry];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)layoutWithMasonry{
    //注意：代码约束需要设置视图的translatesAutoresizingMaskIntoConstraints属性为NO
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dog.jpg"]];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:imageView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.textColor = [UIColor darkGrayColor];
    label.text = @"This is a lovely dog";
    label.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:label];
    
    //设置图片的水平方向距父视图左右两边都为10像素，图片的宽与高的比例为5:7
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(10);
        make.right.equalTo(self.view.mas_right).with.offset(-10);
        make.top.equalTo(self.view.mas_top).with.offset(10);
        make.height.equalTo(imageView.mas_width).with.multipliedBy(1.4);
    }];
    
    //文字描述水平居中，并且处于图片与屏幕底部中间
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(imageView.mas_bottom);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}


- (void)layoutWithVFL{
    //注意：代码约束需要设置视图的translatesAutoresizingMaskIntoConstraints属性为NO
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dog.jpg"]];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:imageView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.textColor = [UIColor darkGrayColor];
    label.text = @"This is a lovely dog";
    label.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:label];
    
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(imageView, label);
    
    //设置图片的水平方向距父视图左右两边都为10像素
    NSArray *constraintArr1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[imageView]-10-|" options:0 metrics:nil views:viewsDictionary];
    [self.view addConstraints:constraintArr1];
    
    /*
     //设置图片垂直方向距父视图顶部10像素，底部100像素
     NSArray *constraintArr2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[imageView]-100-|" options:0 metrics:nil views:viewsDictionary];
     [self.view addConstraints:constraintArr2];
     
     //设置label的约束
     NSArray *constraintArr3 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[imageView]-30-[label]" options:0 metrics:nil views:viewsDictionary];
     [self.view addConstraints:constraintArr3];
     */
    
    //设置图片的宽与高的比例为5:7
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:imageView attribute:NSLayoutAttributeWidth multiplier:1.4 constant:0];
    [self.view addConstraint:constraint1];
    
    //设置图片距顶部10像素，文字描述处于图片与屏幕底部中间
    NSArray *constraintArr3 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[imageView]-[label]-|" options:0 metrics:nil views:viewsDictionary];
    [self.view addConstraints:constraintArr3];
    
    //描述文本水平居中
    NSLayoutConstraint *constraint2 = [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    [self.view addConstraint:constraint2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
