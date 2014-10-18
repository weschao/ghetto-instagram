//
//  PhotosViewController.m
//  Ghetto Instagram
//
//  Created by Wes Chao on 10/15/14.
//  Copyright (c) 2014 Facebook. All rights reserved.
//

#import "PhotosViewController.h"
#import "PhotoDetailsViewController.h"
#import "PhotoCell.h"
#import "UIImageView+AFNetworking.h"

@interface PhotosViewController ()<UITableViewDataSource, UITableViewDelegate>
@property NSArray* popularMedia;

@property UIRefreshControl *refreshControl;
@end

@implementation PhotosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // set the table view model to self
    self.photoTableView.delegate = self;
    self.photoTableView.dataSource = self;
    
    [self.photoTableView registerNib: [UINib nibWithNibName:@"PhotoCell" bundle: nil]
         forCellReuseIdentifier:@"PhotoCell"];
    self.photoTableView.rowHeight = 320;
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(onRefresh) forControlEvents:UIControlEventValueChanged];
    [self.photoTableView insertSubview:self.refreshControl atIndex:0];
    
    // make a request for data
    NSURL *url = [NSURL URLWithString:@"https://api.instagram.com/v1/media/popular?client_id=98d50a520d6d4402bd3fa2a734d5dde1"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];

        self.popularMedia = responseDictionary[@"data"];
        [self.photoTableView reloadData];
    }];

}

- (void)onRefresh {
    NSURL *url = [NSURL URLWithString:@"https://api.instagram.com/v1/media/popular?client_id=98d50a520d6d4402bd3fa2a734d5dde1"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.popularMedia = responseDictionary[@"data"];
        [self.photoTableView reloadData];
        
        [self.refreshControl endRefreshing];
    }];
}

//setting section headers: viewForHeaderInSection

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.popularMedia.count;

}

- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath: indexPath animated:YES];
    PhotoDetailsViewController* pdvc = [[PhotoDetailsViewController alloc] init];
    pdvc.photoDetails = self.popularMedia[indexPath.row];
    [self.navigationController pushViewController:pdvc animated:YES];
}

- (UITableViewCell *) tableView: (UITableView *) tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PhotoCell *cell = [[PhotoCell alloc] init];
    
    cell = [self.photoTableView dequeueReusableCellWithIdentifier:@"PhotoCell"];
    
    NSDictionary *photo = self.popularMedia[indexPath.row];
    
    NSString *photoUrl = [photo valueForKeyPath:@"images.standard_resolution.url"];
    
//    NSLog(@"response: %@", self.popularMedia);
//    NSLog(@"url: %@", photoUrl);
    
    [cell.photoView setImageWithURL:[NSURL URLWithString:photoUrl]];
    
    
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
