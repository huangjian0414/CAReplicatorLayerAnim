//
//  ViewController.m
//  CAReplicatorLayerAnim
//
//  Created by huangjian on 2020/6/23.
//  Copyright © 2020 huangjian. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadAnim];
    //[self loadAnim1];
    //[self loadAnim2];
}
-(void)loadAnim{
    self.view.backgroundColor = [UIColor blackColor];
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(100, 200, 100, 100)];
    [self.view addSubview:v];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(50, 50) radius:20 startAngle:M_PI*5/6+M_PI/6 endAngle:M_PI * 3/2 clockwise:YES];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = [UIColor whiteColor].CGColor;
    layer.lineWidth = 5;
    layer.lineCap = @"round";
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = [NSNumber numberWithFloat:0];
    animation.toValue = [NSNumber numberWithFloat: 1];
    animation.duration = 0.66;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    anim.fromValue = [NSNumber numberWithFloat:0];
    anim.toValue = [NSNumber numberWithFloat: 0.95];
    anim.duration = 0.66;
    anim.beginTime = 0.66+0.2;
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations =@[animation,anim];
    group.fillMode = kCAFillModeForwards;
    group.duration = (0.66+0.2)*2;
    group.repeatCount = MAXFLOAT;
    [layer addAnimation:group forKey:nil];
    
    CAReplicatorLayer *replicatorrLayer = [CAReplicatorLayer layer];
    replicatorrLayer.frame = v.bounds;
    [v.layer addSublayer:replicatorrLayer];
    
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation1.fromValue = [NSNumber numberWithFloat:0];
    animation1.toValue = [NSNumber numberWithFloat:M_PI*2/3];
    animation1.duration = 0.66;
    animation1.removedOnCompletion = NO;
    animation1.fillMode = kCAFillModeForwards;
    
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation2.fromValue = [NSNumber numberWithFloat:0];
    animation2.toValue = [NSNumber numberWithFloat:M_PI*2/3+M_PI/6];
    animation2.duration = 0.66;
    animation2.beginTime = 0.66+0.2;
    animation2.removedOnCompletion = NO;
    animation2.fillMode = kCAFillModeForwards;
    
    CAAnimationGroup *group1 = [CAAnimationGroup animation];
    group1.animations =@[animation1,animation2];
    group1.duration = (0.66+0.2)*2;
    group1.repeatCount = MAXFLOAT;
    [replicatorrLayer addAnimation:group1 forKey:nil];
    
    
    [replicatorrLayer addSublayer:layer];
    
    replicatorrLayer.instanceCount = 3; //复制 sublayer 的个数，包括创建的第一个sublayer 在内的个数
    replicatorrLayer.instanceDelay = 0; //设置动画延迟执行的时间
    replicatorrLayer.instanceAlphaOffset = 0;   //设置透明度递减
    replicatorrLayer.instanceTransform = CATransform3DMakeRotation(M_PI*2/3, 0, 0, 1);
}
-(void)loadAnim1{
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(100, 200, 50, 50)];
    [self.view addSubview:v];
    
    CAShapeLayer *shape                = [CAShapeLayer layer];
    shape.backgroundColor = [UIColor redColor].CGColor;
    shape.cornerRadius = 50/3/2;
    shape.frame                        = CGRectMake(0, 0, 50/3, 50/3);
    shape.strokeColor                  = [UIColor redColor].CGColor;
    shape.fillColor                    = [UIColor redColor].CGColor;
    shape.lineWidth                    = 1;

    CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform"];
    CATransform3D toValue   = CATransform3DTranslate(CATransform3DIdentity, 50 - 50 / 3.0, 0.0, 0.0);
    toValue                 = CATransform3DRotate(toValue,2*M_PI/3.0, 0.0, 0.0, 1.0);
    scale.toValue           = [NSValue valueWithCATransform3D:toValue];
    scale.repeatCount       = MAXFLOAT;
    scale.timingFunction    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    scale.duration          = 0.8;
    
    [shape addAnimation:scale forKey:@"rotateAnimation"];
    
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.frame              = CGRectMake(0, 0, 50/3, 50/3);
    replicatorLayer.instanceDelay      = 0.0;
    replicatorLayer.instanceCount      = 3;
    CATransform3D trans3D              = CATransform3DIdentity;
    trans3D                            = CATransform3DTranslate(trans3D, 50-50/3, 0, 0);
    trans3D                            = CATransform3DRotate(trans3D, 2*M_PI/3, 0.0, 0.0, 1.0);
    replicatorLayer.instanceTransform  = trans3D;
    [replicatorLayer addSublayer:shape];
    
    [v.layer addSublayer:replicatorLayer];
    
}
-(void)loadAnim2{
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(100, 200, 100, 100)];
    [self.view addSubview:v];

    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = CGRectMake(20, 20, 10, 10);
    layer.backgroundColor = [UIColor orangeColor].CGColor;
    layer.cornerRadius = 5;
    layer.transform = CATransform3DMakeScale(0.01, 0.01, 0.01);
    
    CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scale.toValue = @0.1;
    scale.fromValue = @1;
    scale.duration = 1.f;
    scale.repeatCount = MAXFLOAT;
    [layer addAnimation:scale forKey:nil];

    CAReplicatorLayer *replicatorrLayer = [CAReplicatorLayer layer];
    replicatorrLayer.frame = v.bounds;
    [v.layer addSublayer:replicatorrLayer];
    
    [replicatorrLayer addSublayer:layer];

    replicatorrLayer.instanceCount = 15; //复制 sublayer 的个数，包括创建的第一个sublayer 在内的个数
    replicatorrLayer.instanceDelay = 1.f/15.f; //设置动画延迟执行的时间
    replicatorrLayer.instanceTransform = CATransform3DMakeRotation(2*M_PI/15, 0, 0, 1);
    
}
@end
