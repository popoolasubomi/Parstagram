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
    
    [self populateView];
    [self loadPosts];
}

- (void) populateView{
    PFUser *user = PFUser.currentUser;
    if ([user objectForKey: @"image"] != nil){
        self.descriptionLabel.text = [user objectForKey: @"description"];
        self.displayName.text = [user objectForKey: @"displayName"];
        self.profilePicture.layer.cornerRadius = 112;
        self.profilePicture.layer.masksToBounds = YES;
        self.profilePicture.image = [UIImage imageNamed:@"image_placeholder"];
        PFFileObject *imageData = [user objectForKey: @"image"];
        NSString *imageUrlString = imageData.url;
        NSURL *imageUrl = [NSURL URLWithString: imageUrlString];
        [self.profilePicture setImageWithURL: imageUrl];
    }
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
