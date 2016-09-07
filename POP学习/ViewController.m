//
//  ViewController.m
//  POP学习
//
//  Created by 王一 on 16/9/7.
//  Copyright © 2016年 wangyi. All rights reserved.
//

#import "ViewController.h"
#import <POP.h>
#import "POPSpringAnimation.h"
#import "Masonry.h"
#import "BButton.h"

@interface ViewController ()<UITextFieldDelegate>
/** 输入框 */
@property(nonatomic,strong)UITextField *textField;
/** 发送按钮 */
@property(nonatomic,strong)BButton *sendBtn;
/** 赞按钮 */
@property(nonatomic,strong)BButton *zanBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建控件
    [self setupControl];
    
    self.sendBtn.hidden = YES;
}

/**
 *  创建控件
 */
-(void)setupControl{
    //输入框
    self.textField = [[UITextField alloc] init];
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    self.textField.font = [UIFont systemFontOfSize:15];
    self.textField.placeholder = @"enter text";
    self.textField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.textField.keyboardType = UIKeyboardTypeDefault;
    self.textField.returnKeyType = UIReturnKeyDone;
    self.textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.textField.delegate = self;
    [self.view addSubview:self.textField];
    //send
    self.sendBtn = [[BButton alloc]initWithFrame:CGRectMake(0, 0, 0, 0) type:BButtonTypeSuccess icon:0 fontSize:13];
    [self.sendBtn setTitle:@"send" forState:UIControlStateNormal];
    [self.view addSubview:self.sendBtn];
    //赞
    self.zanBtn = [[BButton alloc]initWithFrame:CGRectMake(0, 0, 0, 0) type:BButtonTypePrimary icon:0 fontSize:13];
    [self.zanBtn setTitle:@"赞" forState:UIControlStateNormal];
    [self.view addSubview:self.zanBtn];
    
    //输入框
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(100);
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
    }];
    //send
    [self.sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.textField.mas_right);
        make.top.equalTo(self.textField.mas_bottom).offset(10);
        make.width.equalTo(@50);
        make.height.equalTo(@30);
    }];
    //赞
    [self.zanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.textField.mas_right);
        make.top.equalTo(self.textField.mas_bottom).offset(10);
        make.width.equalTo(@50);
        make.height.equalTo(@30);
    }];
}

//发送按钮
-(void)setupSendBtn{
    if (self.sendBtn.isHidden) {
        self.zanBtn.hidden = YES;
        self.sendBtn.hidden = NO;
        POPSpringAnimation *sprintAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
        sprintAnimation.velocity = [NSValue valueWithCGPoint:CGPointMake(8, 8)];
        sprintAnimation.springBounciness = 20.f;
        [self.sendBtn pop_addAnimation:sprintAnimation forKey:@"sendAnimation"];
    }
}

//赞按钮
-(void)setupZanBtn{
    self.zanBtn.hidden = NO;
    self.sendBtn.hidden = YES;
    POPSpringAnimation *spin = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerRotation];
    spin.fromValue = @(M_PI / 4);
    spin.toValue = @(0);
    spin.springBounciness = 20;
    spin.velocity = @(10);
    [self.zanBtn.layer pop_addAnimation:spin forKey:@"likeAnimation"];
}


//textField代理方法
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSString *comment;
    
    if(range.length == 0){
        comment = [NSString stringWithFormat:@"%@%@", textField.text, string];
    }else{
        comment = [textField.text substringToIndex:textField.text.length - range.length];
    }
    
    if (comment.length == 0) {
        [self setupZanBtn];
    }else{
        [self setupSendBtn];
    }
    
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
