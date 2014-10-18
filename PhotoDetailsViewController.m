//
//  PhotoDetailsViewController.m
//  Ghetto Instagram
//
//  Created by Wes Chao on 10/15/14.
//  Copyright (c) 2014 Facebook. All rights reserved.
//

#import "PhotoDetailsViewController.h"
#import "PhotoCell.h"
#import "UIImageView+AFNetworking.h"

@interface PhotoDetailsViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation PhotoDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    // set the table view model to self
    self.photoDetailsTableView.delegate = self;
    self.photoDetailsTableView.dataSource = self;
    [self.photoDetailsTableView registerNib: [UINib nibWithNibName:@"PhotoCell" bundle: nil]
              forCellReuseIdentifier:@"PhotoCell"];
    self.photoDetailsTableView.rowHeight = 320;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *) tableView: (UITableView *) tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PhotoCell *cell = [[PhotoCell alloc] init];
    cell = [self.photoDetailsTableView dequeueReusableCellWithIdentifier:@"PhotoCell"];

    NSString *photoUrl = [self.photoDetails valueForKeyPath:@"images.standard_resolution.url"];
    
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
