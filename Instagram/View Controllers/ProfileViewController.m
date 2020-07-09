//
//  ProfileViewController.m
//  Instagram
//
//  Created by Ogo-Oluwasobomi Popoola on 7/7/20.
//  Copyright © 2020 Ogo-Oluwasobomi Popoola. All rights reserved.
//

#import "ProfileViewController.h"
#import "UIImageView+AFNetworking.h"
#import "HomeCell.h"
#import "Post.h"

@interface ProfileViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray* posts;
@property (nonatomic, strong) NSMutableArray *tableViewData;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self fetchProfileData];
    [self loadPosts];
}

- (void) populateView{
    if (self.posts.count > 0){
        NSDictionary *post = [self.posts objectAtIndex: 0];
        self.descriptionLabel.text = post[@"description"];
        self.displayName.text = post[@"displayName"];
        self.profilePicture.layer.cornerRadius = 112;
        self.profilePicture.layer.masksToBounds = YES;
        PFFileObject *imageData = post[@"image"];
        NSString *imageUrlString = imageData.url;
        NSURL *imageUrl = [NSURL URLWithString: imageUrlString];
        [self.profilePicture setImageWithURL: imageUrl];
    }
}

- (void) updateParseData{
    if (self.posts.count > 0){
        NSDictionary *post = [self.posts objectAtIndex: 0];
        PFQuery *query = [PFQuery queryWithClassName:@"GameScore"];
        [query getObjectInBackgroundWithId: post[@"objectId"]
                                     block:^(PFObject *profileData, NSError *error) {
            NSString *displayName = post[@"displayName"];
            profileData[@"displayName"] = displayName;
            NSString *description = post[@"description"];
            profileData[@"score"] = description;
            PFFileObject *Image = post[@"image"];
            profileData[@"image"] = Image;
            [profileData saveInBackground];
        }];
    }
}

-(void) fetchProfileData{
    NSString *username = [PFUser currentUser].username;
    PFQuery *query = [PFQuery queryWithClassName: @"user_profile"];
    [query includeKey: @"author"];
    [query orderByDescending: @"createdAt"];
    [query whereKey:@"name" equalTo: username];
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            self.posts = posts;
            [self updateParseData];
            [self populateView];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

- (void)loadPosts{
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query includeKey: @"author"];
    [query orderByDescending: @"createdAt"];
    [query whereKey:@"author" equalTo: [PFUser currentUser]];
    query.limit = 20;
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            self.tableViewData = (NSMutableArray *) posts;
            [self.tableView reloadData];
        } else {
            NSLog(@"error: %@", error.localizedDescription);
        }
    }];
}

- (IBAction)editButton:(id)sender {
    [self performSegueWithIdentifier: @"editSegue" sender: nil];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    HomeCell *cell = [self.tableView dequeueReusableCellWithIdentifier: @"HomeCell"];
    [cell setPost: self.tableViewData[indexPath.row]];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableViewData.count;
}

@end
