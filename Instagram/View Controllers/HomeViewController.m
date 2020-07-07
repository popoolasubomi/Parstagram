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
#import "HomeCell.h"
#import "SceneDelegate.h"
#import "Parse/Parse.h"
#import "Post.h"

@interface HomeViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSString *cameraType;
@property (nonatomic, strong) NSArray *posts;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action: @selector(loadPosts) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    
    [self loadPosts];
}

- (void)loadPosts{
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query includeKey: @"author"];
    [query orderByDescending: @"createdAt"];
    query.limit = 20;
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            self.posts = posts;
            [self.tableView reloadData];
            [self.refreshControl endRefreshing];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
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
       SceneDelegate *myDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;
       UIStoryboard *storyboard = [UIStoryboard storyboardWithName: @"Main" bundle: nil];
       LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
       myDelegate.window.rootViewController = loginViewController;
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString: @"cameraSegue"]){
        UINavigationController *navigationController = [segue destinationViewController];
        CameraViewController *cameraController = (CameraViewController *)navigationController.topViewController;
        cameraController.cameraType = self.cameraType;
    }
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier: @"HomeCell"];
    Post *post = self.posts[indexPath.row];
    [cell setPost: post];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.posts.count;
}

@end
