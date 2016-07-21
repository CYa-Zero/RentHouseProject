//
//  RegisterViewController.m
//  RentHouseProject
//
//  Created by conandi on 16/7/20.
//  Copyright © 2016年 Chenyang. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameText;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordText;
@property (weak, nonatomic) IBOutlet UITextField *emailText;
@property (weak, nonatomic) IBOutlet UITextField *mobileText;
@property (weak, nonatomic) IBOutlet UITextField *birthdayText;
@property (weak, nonatomic) IBOutlet UITextField *address1Text;
@property (weak, nonatomic) IBOutlet UITextField *address2Text;
@property (weak, nonatomic) IBOutlet UIButton *sellerBtn;
@property (weak, nonatomic) IBOutlet UIButton *buyerBtn;
@property (weak, nonatomic) IBOutlet UIView *subView;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePickerView;

- (IBAction)sellerBtn_Tapped:(UIButton *)sender;
- (IBAction)buyerBtn_Tapped:(UIButton *)sender;
- (IBAction)cancelBtn_Tapped:(UIButton *)sender;
- (IBAction)submitBtn_Tapped:(UIButton *)sender;
- (IBAction)datePicker_Action:(UIDatePicker *)sender;
- (IBAction)pickerCancelBtn_Tapped:(UIBarButtonItem *)sender;
- (IBAction)pickerDoneBtn_Tapped:(UIBarButtonItem *)sender;

@property (strong, nonatomic) NSString *userType;
@property (strong, nonatomic) NSString *dateString;
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)callRegisterAPI{
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:[self getNSURLRequest] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"%@",str);
            dispatch_sync(dispatch_get_main_queue(), ^{
                if ([str isEqualToString:@"bool(true)\n"]) {
                    //[self showAlertwithText:@"Register Successfully!"];
                    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
                    [userDefault setObject:_emailText.text forKey:@"kemail"];
                    [userDefault setObject:_passwordText.text forKey:@"kpass"];
                    [userDefault synchronize];
                    [self dismissViewControllerAnimated:YES completion:nil];
                }else{
                    [self showAlertwithText:@"Register fail, Please try later"];
                }
            });
            
        }
    }]resume];
}

-(NSURLRequest *)getNSURLRequest{
    
    NSMutableDictionary* _params = [[NSMutableDictionary alloc] init];
    [_params setObject:[NSString stringWithFormat:@"%@",_userNameText.text] forKey:@"username"];
    [_params setObject:[NSString stringWithFormat:@"%@",_passwordText.text] forKey:@"password"];
    [_params setObject:[NSString stringWithFormat:@"%@",_emailText.text] forKey:@"email"];
    [_params setObject:[NSString stringWithFormat:@"%@",_mobileText.text] forKey:@"mobile"];
    [_params setObject:[NSString stringWithFormat:@"%@",_birthdayText.text] forKey:@"dob"];
    [_params setObject:[NSString stringWithFormat:@"%@",_address1Text.text] forKey:@"address1"];
    [_params setObject:[NSString stringWithFormat:@"%@",_address2Text.text] forKey:@"address2"];
    [_params setObject:[NSString stringWithFormat:@"%@",_userType] forKey:@"usertype"];
    [_params setObject:[NSString stringWithFormat:@"yes"] forKey:@"userstatus"];
    
    // the boundary string : a random string, that will not repeat in post data, to separate post data fields.
    NSString *BoundaryConstant = @"----------V2ymHFg03ehbqgZCaKO6jy";
    
    // the server url to which the image (or the media) is uploaded. Use your server url here
    NSURL* requestURL = [NSURL URLWithString:@"http://rjtmobile.com/realestate/register.php?signup"];
    
    // create request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPShouldHandleCookies:NO];
    [request setTimeoutInterval:30];
    [request setHTTPMethod:@"POST"];
    
    // set Content-Type in HTTP header
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", BoundaryConstant];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    // post body
    NSMutableData *body = [NSMutableData data];
    
    // add params (all params are strings)
    for (NSString *param in _params) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", param] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@\r\n", [_params objectForKey:param]] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    // add image data
    
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // setting the body of the post to the reqeust
    [request setHTTPBody:body];
    
    // set the content-length
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[body length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    // set URL
    [request setURL:requestURL];
    return request;
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - textField

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}// return NO to disallow editing.
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if(textField == _address1Text || textField == _address2Text)
    {
        [self animatedTextFieldMove:textField UP:YES];
    }
    if (textField == _birthdayText) {
        [_subView setHidden:NO];
    }
}// became first responder
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    return YES;
}// return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if(textField == _address1Text || textField == _address2Text)
    {
        [self animatedTextFieldMove:textField UP:NO];
    }
}// may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    return YES;
}// return NO to not change text

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    if(textField == _userNameText)
    {
        [_passwordText becomeFirstResponder];
    }
    else if(textField == _passwordText)
    {
        [_confirmPasswordText becomeFirstResponder];
    }
    else if (textField == _confirmPasswordText)
    {
        [_emailText becomeFirstResponder];
    }
    else if (textField == _emailText)
    {
        [_mobileText becomeFirstResponder];
    }
    else if(textField == _mobileText)
    {
        [_birthdayText resignFirstResponder];
    }
    else if(textField == _birthdayText)
    {
        [_address1Text resignFirstResponder];
    }
    else if(textField == _address1Text)
    {
        [_address2Text resignFirstResponder];
    }
    else{
        [_address2Text resignFirstResponder];
    }
    
    return YES;
}// called when clear button pressed. return NO to ignore (no notifications)
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return YES;
}// called when 'return' key pressed. return NO to ignore.

-(void) animatedTextFieldMove:(UITextField *)textField UP:(BOOL)up{
    
    const int movementDistance = 80;
    const float movementDuration = 0.3f;
    int movement = (up ? -movementDistance:movementDistance);
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    
    [UIView beginAnimations:@"animation" context:nil];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.userNameText resignFirstResponder];
    [self.passwordText resignFirstResponder];
    [self.confirmPasswordText resignFirstResponder];
    [self.emailText resignFirstResponder];
    [self.mobileText resignFirstResponder];
    [self.birthdayText resignFirstResponder];
    [self.address1Text resignFirstResponder];
    [self.address2Text resignFirstResponder];
}

-(void)checkTextFieldValidation{
    // check password
    if ([_passwordText.text isEqualToString: _confirmPasswordText.text]) {
        NSLog(@"password Success");
    }else{
        [self showAlertwithText:@"please reenter your password"];
    }
    // check Email
    NSString *emailRegex = @"[A-z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    if ([emailTest evaluateWithObject:_emailText.text]) {
        NSLog(@"Email Success");
    }else{
        [self showAlertwithText:@"Please reenter your Email"];
    }
}

#pragma mark - buttonAction

- (IBAction)sellerBtn_Tapped:(UIButton *)sender {
    _sellerBtn = sender;
    _sellerBtn.selected = !_sellerBtn.selected;
    _userType = nil;
    _userType = @"seller";
    [_buyerBtn setSelected:NO];
}

- (IBAction)buyerBtn_Tapped:(UIButton *)sender {
    _buyerBtn = sender;
    _buyerBtn.selected = !_buyerBtn.selected;
    _userType = nil;
    _userType = @"buyer";
    [_sellerBtn setSelected:NO];
}

- (IBAction)cancelBtn_Tapped:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)submitBtn_Tapped:(UIButton *)sender {
    [self checkTextFieldValidation];
    [self callRegisterAPI];
}

#pragma mark - datePicker

- (IBAction)datePicker_Action:(UIDatePicker *)sender {
    
    NSDateFormatter *dateFormate = [[NSDateFormatter alloc]init];
    [dateFormate setDateFormat:@"yyyy'-'MM'-'dd'"];
    _dateString = [dateFormate stringFromDate:self.datePickerView.date];
}

- (IBAction)pickerCancelBtn_Tapped:(UIBarButtonItem *)sender {
    [_subView setHidden:YES];
}

- (IBAction)pickerDoneBtn_Tapped:(UIBarButtonItem *)sender {
    if([_dateString length]){
        _birthdayText.text = _dateString;
    }
    else{
        NSDateFormatter *dateFormate = [[NSDateFormatter alloc]init];
        [dateFormate setDateFormat:@"yyyy'-'MM'-'dd'"];
        NSDate *date = [NSDate date];
        _birthdayText.text = [dateFormate stringFromDate:date];
    }
    [_subView setHidden:YES];
    [_birthdayText resignFirstResponder];
}

-(void) showAlertwithText:(NSString *)message{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alert" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:alertAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
@end
