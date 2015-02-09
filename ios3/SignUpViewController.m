//
//  SignUpViewController.m
//  SMARTWOMEN
//
//  Created by user on 07/02/15.
//  Copyright (c) 2015 Digipowers. All rights reserved.
//

#import "SignUpViewController.h"
#import "LoginViewController.h"
#import "UIImage+animatedGIF.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSURL *url2 = [[NSBundle mainBundle] URLForResource:@"638" withExtension:@"gif"];
    self.imageView.image = [UIImage animatedImageWithAnimatedGIFURL:url2];
    

    NSURL *url = [NSURL URLWithString:@"http://om-msmartwoman.com/member/register"];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:urlRequest];
    NSString *currentURL2 = [_webView stringByEvaluatingJavaScriptFromString:@"window.location.href"];
    NSLog(@"%@",currentURL2);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    //  activityIndicator.hidden = NO;
    NSString *currentURL;
    NSString *currentURL2 = [_webView stringByEvaluatingJavaScriptFromString:@"window.location.href"];
    currentURL = [[NSString alloc] initWithFormat:@"%@", webView.request.URL];
    NSLog(@"%@",currentURL);
    NSLog(@"%@",currentURL2);
    //webView3.hidden = NO ;
    _imageView.hidden = NO;
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    //webView3.hidden = YES ;
    _imageView.hidden = YES;
    //activityIndicator.hidden = YES;
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Though our app offers some offline features , in order to stay actively connected to the smartWoman community in realtime you need an internet connection, please tap here to check your settings or wait till you have connection." message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    alertView.tag = 10;
    [alertView show];
}


- (void)alertView:(UIAlertView *)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 10) {
        switch(buttonIndex){
            case 0:
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=General&path=ACCESSIBILITY"]];
                break;
            default:
                break;
        }
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSURL *currentURL = [[webView request] URL];
    NSLog(@"%@",[currentURL description]);
    _imageView.hidden = YES;
    
   // webView3.hidden = YES ;
    // activityIndicator.hidden = YES;
}


- (IBAction)backBT:(id)sender {
    LoginViewController *viewController = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
    [self.navigationController pushViewController:viewController animated:YES];
}
@end
