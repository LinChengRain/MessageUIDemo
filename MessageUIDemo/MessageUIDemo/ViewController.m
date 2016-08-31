//
//  ViewController.m
//  MessageUIDemo
//
//  Created by qunqu on 16/8/24.
//  Copyright © 2016年 YuChanglin. All rights reserved.
//

#import "ViewController.h"
#import <MessageUI/MessageUI.h>

@interface ViewController ()<MFMessageComposeViewControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(100, 200, 50, 30);
    [btn setTitle:@"发短信" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(senderAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
}

#pragma mark - Draw UI
- (void) showMessageView
{
    
    //判断设备能否发短信
    if ([MFMessageComposeViewController canSendText]) {
        MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
        
        //设置代理
        picker.messageComposeDelegate = self;
        
        //默认信息内容
        picker.body = @"Hello World";
        
        //默认发件人
        picker.recipients = [NSArray arrayWithObject:@"12345678910"];
        
        [self presentViewController:picker animated:YES completion:nil];
        
    }else{
        
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"提示信息" message:@"该设备不支持短信" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alterView show];
    }
    
}
#pragma mark - Click Action
-(void)senderAction{
    
    [self showMessageView];
}
#pragma mark -
#pragma mark - MFMessageComposeViewController Delegate
-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    
    switch (result) {
        case MessageComposeResultCancelled:
            NSLog(@"取消发送");
            break;
        case MessageComposeResultSent:
            NSLog(@"发送成功");
            break;
        case MessageComposeResultFailed:
            NSLog(@"发送失败");
            break;
        default:
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
