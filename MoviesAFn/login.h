//
//  login.h
//  project1
//
//  Created by Sayed Abdo on 9/10/17.
//  Copyright © 2017 Sayed Abdo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface login : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *paas;

@property (weak, nonatomic) IBOutlet UIImageView *pic;

@property (weak, nonatomic) IBOutlet UIButton *log;

@property (weak, nonatomic) IBOutlet UIButton *sign;

@property (strong , nonatomic) NSString *databasePath;
@property (nonatomic) sqlite3 *contactDB;
@property  const char *dbpath;
@property (strong , nonatomic) NSString *docsDir;
@property bool loggedIn;
@property (strong, nonatomic) NSUserDefaults *memo;
@property NSUserDefaults *storage ;
@end
