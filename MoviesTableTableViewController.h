//
//  MoviesTableTableViewController.h
//  MoviesAFn
//
//  Created by Mahmoud Ismaeil Atito on 9/10/17.
//  Copyright © 2017 Mahmoud Ismaeil Atito. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "JSONModelLib.h"


@interface MoviesTableTableViewController : UITableViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UILabel *year;

//@property NSMutableArray *Movies;

@end


