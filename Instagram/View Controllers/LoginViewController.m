//
//  LoginViewController.m
//  Instagram
//
//  Created by Ogo-Oluwasobomi Popoola on 7/4/20.
//  Copyright © 2020 Ogo-Oluwasobomi Popoola. All rights reserved.
//

#import "LoginViewController.h"
#import "Parse/Parse.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *buildButton;
@property (weak, nonatomic) IBOutlet UIButton *createButton;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundView;
@property (weak, nonatomic) IBOutlet UIImageView *logoView;
@property (weak, nonatomic) IBOutlet UILabel *infoView;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addConstraints];
}

-(void) addConstraints{
    //Constraint For loginButton
    [self.buildButton setTranslatesAutoresizingMaskIntoConstraints: NO];
    [self.buildButton.topAnchor constraintEqualToAnchor: self.passwordField.bottomAnchor constant: 70].active = YES;
    [self.buildButton.leadingAnchor constraintEqualToAnchor: self.view.leadingAnchor constant: 0].active = YES;
    [self.buildButton.trailingAnchor constraintEqualToAnchor: self.view.trailingAnchor constant: 0].active = YES;
    
    //Constraint For BackgroundView
    [self.backgroundView setTranslatesAutoresizingMaskIntoConstraints: NO];
    [self.backgroundView.topAnchor constraintEqualToAnchor: self.view.topAnchor constant: 0].active = YES;
    [self.backgroundView.trailingAnchor constraintEqualToAnchor: self.view.trailingAnchor constant: 0].active = YES;
    [self.backgroundView.heightAnchor constraintEqualToConstant: 224].active = YES;
    [self.backgroundView.widthAnchor constraintEqualToConstant: 414].active = YES;
    
    //Constraint For Instagram Logo
    [self.logoView setTranslatesAutoresizingMaskIntoConstraints: NO];
    [self.logoView.topAnchor constraintEqualToAnchor: self.view.topAnchor constant: 0].active = YES;
    [self.logoView.leadingAnchor constraintEqualToAnchor: self.view.leadingAnchor constant: 0].active = YES;
    [self.logoView.heightAnchor constraintEqualToConstant: 224].active = YES;
    [self.logoView.widthAnchor constraintEqualToConstant: 414].active = YES;
    
    //Constraint For UsernameField
    [self.usernameField setTranslatesAutoresizingMaskIntoConstraints: NO];
    [self.usernameField.topAnchor constraintEqualToAnchor: self.backgroundView.bottomAnchor constant: 100].active = YES;
    [self.usernameField.leadingAnchor constraintEqualToAnchor: self.view.leadingAnchor constant: 0].active = YES;
    [self.usernameField.trailingAnchor constraintEqualToAnchor: self.view.trailingAnchor constant: 0].active = YES;
 
    //Constraint for Password field
    [self.passwordField setTranslatesAutoresizingMaskIntoConstraints: NO];
    [self.passwordField.topAnchor constraintEqualToAnchor: self.usernameField.bottomAnchor constant: 70].active = YES;
    [self.passwordField.leadingAnchor constraintEqualToAnchor: self.view.leadingAnchor constant: 0].active = YES;
    [self.passwordField.trailingAnchor constraintEqualToAnchor: self.view.trailingAnchor constant: 0].active = YES;
    
    //Constraint for infoLabel
    [self.infoView setTranslatesAutoresizingMaskIntoConstraints: NO];
    [self.infoView.topAnchor constraintEqualToAnchor: self.buildButton.bottomAnchor constant: 78].active = YES;
    [self.infoView.leadingAnchor constraintEqualToAnchor: self.view.leadingAnchor constant: 85].active = YES;
    [self.infoView.trailingAnchor constraintEqualToAnchor: self.createButton.leadingAnchor constant: 8].active = YES;
    
    //Constraint for signUpButton
    [self.createButton setTranslatesAutoresizingMaskIntoConstraints: NO];
    [self.createButton.topAnchor constraintEqualToAnchor: self.buildButton.bottomAnchor constant: 70].active = YES;
    [self.createButton.trailingAnchor constraintEqualToAnchor: self.view.trailingAnchor constant: -90].active = YES;
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

- (void) wrongUserAlert{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle: @"Invalid Details"
           message:@"Could not find User"
    preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction *okAlert = [UIAlertAction actionWithTitle:@"Ok"
                                                           style: UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * _Nonnull action) {}];
    
    [alert addAction: okAlert];
    [self presentViewController: alert animated:YES completion:^{}];
}

- (void)loginUser {
    if ([self.usernameField.text isEqual:@""] || [self.passwordField.text isEqual:@""]){
        [self invalidDetailAlert];
    }
    else {
        NSString *username = self.usernameField.text;
        NSString *password = self.passwordField.text;
        
        [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
            if (error != nil) {
                NSLog(@"User log in failed: %@", error.localizedDescription);
                [self wrongUserAlert];
            } else {
                NSLog(@"User logged in successfully");
                [self performSegueWithIdentifier: @"loginSegue" sender: nil];
            }
        }];
    }
}

- (IBAction)loginButton:(id)sender {
    [self loginUser];
}

- (IBAction)onTapp:(id)sender {
    [self.view endEditing:YES];
}

@end
