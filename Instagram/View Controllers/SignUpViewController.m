//
//  SignUpViewController.m
//  Instagram
//
//  Created by Ogo-Oluwasobomi Popoola on 7/4/20.
//  Copyright © 2020 Ogo-Oluwasobomi Popoola. All rights reserved.
//

#import "SignUpViewController.h"
#import "Parse/Parse.h"

@interface SignUpViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *buildButton;
@property (weak, nonatomic) IBOutlet UILabel *signUpLabel;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addConstraints];
}

-(void) addConstraints{
//    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:self.usernameField
//                                                            attribute:NSLayoutAttributeLeft
//                                                            relatedBy: NSLayoutRelationEqual
//                                                               toItem: self.passwordField
//                                                            attribute: NSLayoutAttributeLeft multiplier:1 constant:100];
    //Constraints For Scroll View
    
    
    //Constraint For Cancel Button
    [self.stopButton setTranslatesAutoresizingMaskIntoConstraints: NO];
    [self.stopButton.topAnchor constraintEqualToAnchor: self.view.topAnchor constant: 20].active = YES;
    [self.stopButton.leadingAnchor constraintEqualToAnchor: self.view.leadingAnchor constant: 20].active = YES;
    [self.stopButton.heightAnchor constraintEqualToConstant: 56].active = YES;
    [self.stopButton.widthAnchor constraintEqualToConstant: 46].active = YES;
    
    //Constraint For SignUp Label
    [self.signUpLabel setTranslatesAutoresizingMaskIntoConstraints: NO];
    [self.signUpLabel.topAnchor constraintEqualToAnchor: self.stopButton.bottomAnchor constant: 40].active = YES;
    [self.signUpLabel.leadingAnchor constraintEqualToAnchor: self.view.leadingAnchor constant: 0].active = YES;
    [self.signUpLabel.trailingAnchor constraintEqualToAnchor: self.view.trailingAnchor constant: 0].active = YES;
    
    //Constraint For UsernameField
    [self.usernameField setTranslatesAutoresizingMaskIntoConstraints: NO];
    [self.usernameField.topAnchor constraintEqualToAnchor: self.signUpLabel.bottomAnchor constant: 70].active = YES;
    [self.usernameField.leadingAnchor constraintEqualToAnchor: self.view.leadingAnchor constant: 0].active = YES;
    [self.usernameField.trailingAnchor constraintEqualToAnchor: self.view.trailingAnchor constant: 0].active = YES;
    
    //Constraint for Email Field
    [self.emailField setTranslatesAutoresizingMaskIntoConstraints: NO];
    [self.emailField.topAnchor constraintEqualToAnchor: self.usernameField.bottomAnchor constant: 70].active = YES;
    [self.emailField.leadingAnchor constraintEqualToAnchor: self.view.leadingAnchor constant: 0].active = YES;
    [self.emailField.trailingAnchor constraintEqualToAnchor: self.view.trailingAnchor constant: 0].active = YES;
    
    //Constraint For PasswordField
    [self.passwordField setTranslatesAutoresizingMaskIntoConstraints: NO];
    [self.passwordField.topAnchor constraintEqualToAnchor: self.emailField.bottomAnchor constant: 70].active = YES;
    [self.passwordField.leadingAnchor constraintEqualToAnchor: self.view.leadingAnchor constant: 0].active = YES;
    [self.passwordField.trailingAnchor constraintEqualToAnchor: self.view.trailingAnchor constant: 0].active = YES;
    
    //Constraint For SignUpButton
    [self.buildButton setTranslatesAutoresizingMaskIntoConstraints: NO];
    [self.buildButton.topAnchor constraintEqualToAnchor: self.passwordField.bottomAnchor constant: 70].active = YES;
    [self.buildButton.leadingAnchor constraintEqualToAnchor: self.view.leadingAnchor constant: 0].active = YES;
    [self.buildButton.trailingAnchor constraintEqualToAnchor: self.view.trailingAnchor constant: 0].active = YES;
}

- (void) invalidDetailAlert{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle: @"Details Required"
           message: @"Please fill in the appropriate fields"
    preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction *okAlert = [UIAlertAction actionWithTitle:@"Ok"
                                                           style: UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * _Nonnull action) {}];
    
    [alert addAction: okAlert];
    [self presentViewController: alert animated:YES completion:^{}];
}

- (void) signUpError{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle: @"SignUp Error"
           message: @"Unsucessful SignUp"
    preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction *okAlert = [UIAlertAction actionWithTitle:@"Ok"
                                                           style: UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * _Nonnull action) {}];
    
    [alert addAction: okAlert];
    [self presentViewController: alert animated:YES completion:^{}];
}

- (void)registerUser {
    if ([self.usernameField.text isEqual:@""] || [self.passwordField.text isEqual:@""] || [self.emailField.text isEqual:@""]){
        [self invalidDetailAlert];
    }
    else{
        PFUser *newUser = [PFUser user];
        newUser.username = self.usernameField.text;
        newUser.email = self.emailField.text;
        newUser.password = self.passwordField.text;
        [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
            if (error != nil) {
                NSLog(@"Error: %@", error.localizedDescription);
                [self signUpError];
            } else {
                NSLog(@"User registered successfully");
                [self performSegueWithIdentifier: @"loginSegue" sender: nil];
            }
        }];
    }
}

- (IBAction)signUpButton:(id)sender {
    [self registerUser];
}

- (IBAction)cancelSignUpButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing: YES];
}

@end
