//
//  HomeViewController.m
//  Instagram
//
//  Created by Ogo-Oluwasobomi Popoola on 7/4/20.
//  Copyright © 2020 Ogo-Oluwasobomi Popoola. All rights reserved.
//

#import "HomeViewController.h"
#import "LoginViewController.h"
#import "CameraViewController.h"
#import "AppDelegate.h"
#import "Parse/Parse.h"

@interface HomeViewController ()

@property (nonatomic, strong) NSString *cameraType;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)cameraButton:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle: @"Camera"
           message:@"Choose Source"
    preferredStyle:(UIAlertControllerStyleActionSheet)];
    
    UIAlertAction *cameraSource = [UIAlertAction actionWithTitle:@"Camera"
                                                           style: UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * _Nonnull action) {
                                                           self.cameraType = @"Camera";
                                                           [self performSegueWithIdentifier: @"cameraSegue" sender: nil];
    }];
    
    UIAlertAction *librarySource = [UIAlertAction actionWithTitle: @"Photo Library"
                                                            style: UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * _Nonnull action) {
                                                          self.cameraType = @"Photo Library";
                                                          [self performSegueWithIdentifier: @"cameraSegue" sender: nil];
    }];
    
    [alert addAction: cameraSource];
    [alert addAction: librarySource];
    
    [self presentViewController: alert animated:YES completion:^{}];
}


- (IBAction)logoutButton:(id)sender {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
       AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
       UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        appDelegate.window.rootViewController = loginViewController;
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString: @"cameraSegue"]){
        CameraViewController *cameraController = [segue destinationViewController];
        cameraController.cameraType = self.cameraType;
    }
}

@end
