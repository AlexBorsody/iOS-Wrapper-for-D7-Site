//
//  LoginViewController.m
//  JUICEGURU
//
//  Created by user on 23/07/14.
//  Copyright (c) 2014 Digipowers. All rights reserved.
//

#import "LoginViewController.h"
#import "WebsiteViewController.h"
#import "ForgetPasswordViewController.h"
#import "SignUpViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
NSUserDefaults *userDefault;
NSString *email,*pass;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _emailET.layer.borderWidth = 1;
    _emailET.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    _passwordET.layer.borderWidth = 1;
    _passwordET.layer.borderColor = [[UIColor lightGrayColor] CGColor];
     userDefault = [NSUserDefaults standardUserDefaults];
   // [_login.layer setCornerRadius:4.0f];
    _login.layer.borderWidth = 1;
    _login.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    _forgotPassword.layer.borderWidth = 1;
    _forgotPassword.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    _signUp.layer.borderWidth = 1;
    _signUp.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    UITapGestureRecognizer *gestureForgot = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Forgot:)];
    _forgotPassword.userInteractionEnabled = YES;
    [_forgotPassword addGestureRecognizer:gestureForgot];
   
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)Login{
    //////////////////////////////////////////////
    NSString *URL = @"http://om-msmartwoman.com/is_valid";
    NSURL *theURL = [NSURL URLWithString:URL];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:theURL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30.0f];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [theRequest setValue:@"MEDTELAPP2013" forHTTPHeaderField:@"X_MEDTELAPP_KEY"];
    
    NSString *authuser = @"username=";
    NSString *authpass = @"&pass=";
    NSString *concatenate1 = [authuser stringByAppendingString:email];
    NSString *concatenate2 = [authpass stringByAppendingString:pass];
    NSString *Post = [concatenate1 stringByAppendingString:concatenate2];
    
    NSLog(@"UDID:: %@", Post);
    //NSString *post = [URL stringByAppendingString:stringWithoutSpaces];
    NSData *postData = [Post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    [theRequest setHTTPBody:postData];
    
    [NSURLConnection sendAsynchronousRequest:theRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        // if(data != nil){
        NSString *noti = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        //NSString *newStr = [noti substringWithRange:NSMakeRange(0, [noti length]-4)];
        NSLog(@"trimmedString:: %@", noti);
        if(data!=nil){
            if([noti  isEqual: @"0"]){
                _loginError.hidden = NO;
            }else{
                _loginError.hidden = YES;
                [userDefault setValue:noti forKey:@"website"];
                [userDefault setValue:_emailET.text forKey:@"email"];
                [userDefault setValue:_passwordET.text forKey:@"password"];
                [userDefault setValue:@"1" forKey:@"login"];
                [userDefault synchronize];
                WebsiteViewController *viewController = [[WebsiteViewController alloc] initWithNibName:@"WebsiteViewController" bundle:nil];
                [self.navigationController pushViewController:viewController animated:YES];
            }
           
        }else{
            // [self _showAlert2:@"Por favor,conectarse a Internet"];
            _loginError.text = @"No internet connection";
            _loginError.hidden = NO;
        }
    }];
}


- (void)Forgot:(UITapGestureRecognizer *)recognizer {
    
    [userDefault setValue:_emailET.text forKey:@"email"];
    [userDefault synchronize];
    
    ForgetPasswordViewController *viewController = [[ForgetPasswordViewController alloc] initWithNibName:@"ForgetPasswordViewController" bundle:nil];
    [self.navigationController pushViewController:viewController animated:YES];
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField: textField up: YES];
    
    if([textField isEqual:_emailET]){
    _emailET.placeholder = nil;
         _loginError.hidden = YES;
    }
    
    if([textField isEqual:_passwordET]){
        _passwordET.placeholder = nil;
         _loginError.hidden = YES;
    }
   
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
    if([textField isEqual:_emailET]){
        _emailET.placeholder = @"Email";

    }
    
    if([textField isEqual:_passwordET]){
        _passwordET.placeholder = @"Password";
    }
    
    [self animateTextField: textField up: NO];
}

- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    const int movementDistance = 80; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}



- (IBAction)loginBT:(id)sender {
     email = _emailET.text;
     pass = _passwordET.text;
    if(_emailET.text.length == 0){
         _emailET.layer.borderColor = [UIColor redColor].CGColor;
        UIColor *color = [UIColor redColor];
        _emailET.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Email" attributes:@{NSForegroundColorAttributeName: color}];
        _passwordET.layer.borderColor = [UIColor lightGrayColor].CGColor;
        
    } else if (_passwordET.text.length == 0){
        _emailET.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _passwordET.layer.borderColor = [UIColor redColor].CGColor;
         UIColor *color = [UIColor redColor];
        _passwordET.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: color}];
    }else{
        _emailET.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _passwordET.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [self Login];
    }
}

- (IBAction)signUPTouch:(id)sender {
    SignUpViewController *viewcontroller = [[SignUpViewController alloc] initWithNibName:@"SignUpViewController" bundle:nil];
    [self.navigationController pushViewController:viewcontroller animated:YES];
}
@end
