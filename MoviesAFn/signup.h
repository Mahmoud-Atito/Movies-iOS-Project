//
//  signup.h
//  project1
//
//  Created by Sayed Abdo on 9/9/17.
//  Copyright © 2017 Sayed Abdo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "Table1.h"
@interface signup : UIViewController<UIImagePickerControllerDelegate ,
 UINavigationControllerDelegate,UIAlertViewDelegate>{
    
    UIImagePickerController *picker;
    UIImage *image;
    
     __weak IBOutlet UIImageView *usrpic;
     __weak IBOutlet UIImageView *imageview;
}
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *passw;
@property (weak, nonatomic) IBOutlet UITextField *confirm;
@property (weak, nonatomic) IBOutlet UIButton *btnbrowes;

@property (weak, nonatomic) IBOutlet UIButton *sign;
@property (strong , nonatomic) NSString *databasePath;
@property (nonatomic) sqlite3 *contactDB;
@property  const char *dbpath;
@property (strong , nonatomic) NSString *docsDir;

@property (strong, nonatomic) Table1 *ta;
@property bool loggedIn;
@property (strong, nonatomic) NSUserDefaults *memo;
@property NSUserDefaults *storage ;
@end
