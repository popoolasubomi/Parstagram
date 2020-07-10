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
@property (weak, nonatomic) IBOutlet UIView *contentView;

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Did not implement code constraints due to effects on scroll view
    //[self addConstraints];
}

-(void) addConstraints{
    //Constraint For Cancel Button
    [self.stopButton setTranslatesAutoresizingMaskIntoConstraints: NO];
    [self.stopButton.topAnchor constraintEqualToAnchor: self.contentView.topAnchor constant: 20].active = YES;
    [self.stopButton.leadingAnchor constraintEqualToAnchor: self.contentView.leadingAnchor constant: 20].active = YES;
    [self.stopButton.heightAnchor constraintEqualToConstant: 56].active = YES;
    [self.stopButton.widthAnchor constraintEqualToConstant: 46].active = YES;

    //Constraint For SignUp Label
    [self.signUpLabel setTranslatesAutoresizingMaskIntoConstraints: NO];
    [self.signUpLabel.topAnchor constraintEqualToAnchor: self.stopButton.bottomAnchor constant: 40].active = YES;
    [self.signUpLabel.leadingAnchor constraintEqualToAnchor: self.contentView.leadingAnchor constant: 0].active = YES;
    [self.signUpLabel.trailingAnchor constraintEqualToAnchor: self.contentView.trailingAnchor constant: 0].active = YES;

    //Constraint For UsernameField
    [self.usernameField setTranslatesAutoresizingMaskIntoConstraints: NO];
    [self.usernameField.topAnchor constraintEqualToAnchor: self.signUpLabel.bottomAnchor constant: 70].active = YES;
    [self.usernameField.leadingAnchor constraintEqualToAnchor: self.contentView.leadingAnchor constant: 0].active = YES;
    [self.usernameField.trailingAnchor constraintEqualToAnchor: self.contentView.trailingAnchor constant: 0].active = YES;

    //Constraint for Email Field
    [self.emailField setTranslatesAutoresizingMaskIntoConstraints: NO];
    [self.emailField.topAnchor constraintEqualToAnchor: self.usernameField.bottomAnchor constant: 70].active = YES;
    [self.emailField.leadingAnchor constraintEqualToAnchor: self.contentView.leadingAnchor constant: 0].active = YES;
    [self.emailField.trailingAnchor constraintEqualToAnchor: self.contentView.trailingAnchor constant: 0].active = YES;

    //Constraint For PasswordField
    [self.passwordField setTranslatesAutoresizingMaskIntoConstraints: NO];
    [self.passwordField.topAnchor constraintEqualToAnchor: self.emailField.bottomAnchor constant: 70].active = YES;
    [self.passwordField.leadingAnchor constraintEqualToAnchor: self.contentView.leadingAnchor constant: 0].active = YES;
    [self.passwordField.trailingAnchor constraintEqualToAnchor: self.contentView.trailingAnchor constant: 0].active = YES;

    //Constraint For SignUpButton
    [self.buildButton setTranslatesAutoresizingMaskIntoConstraints: NO];
    [self.buildButton.topAnchor constraintEqualToAnchor: self.passwordField.bottomAnchor constant: 70].active = YES;
    [self.buildButton.leadingAnchor constraintEqualToAnchor: self.contentView.leadingAnchor constant: 0].active = YES;
    [self.buildButton.trailingAnchor constraintEqualToAnchor: self.contentView.trailingAnchor constant: 0].active = YES;
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
