//
//  PhotoDetailsViewController.h
//  Ghetto Instagram
//
//  Created by Wes Chao on 10/15/14.
//  Copyright (c) 2014 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoDetailsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *photoDetailsTableView;
@property NSDictionary* photoDetails;
@end
