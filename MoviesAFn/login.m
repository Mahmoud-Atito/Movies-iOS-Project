//
//  login.m
//  project1
//
//  Created by Sayed Abdo on 9/10/17.
//  Copyright © 2017 Sayed Abdo. All rights reserved.
//

#import "login.h"
#import "Table1.h"
#import "MoviesTableTableViewController.h"
#import "JETSMovie.h"
#import "JETSDBConnection.h"
#import "UIImageView+WebCache.h"



@interface login () {
    NSMutableArray *M;
    AFHTTPSessionManager *manager;
}

@property JETSMovie *myMovie;
@property JETSDBConnection *DBMangement;
@property NSMutableArray *allData;
@property JETSMovie *returnedMovie;

@end

@implementation login

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"backg.png"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];

    _email.layer.cornerRadius=10.0;
    _paas.layer.cornerRadius=10.5;
    _log.layer.cornerRadius=10.5;
    _sign.layer.cornerRadius=10.5;
    NSArray *dirPaths;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(
                                                   NSDocumentDirectory, NSUserDomainMask, YES);
    
    _docsDir = dirPaths[0];
    
    // Build the path to the database file
    _databasePath = [[NSString alloc]
                     initWithString: [_docsDir stringByAppendingPathComponent:
                                      @"myContact1.db"]];
    
    
    _dbpath = [_databasePath UTF8String];
    
    if (sqlite3_open(_dbpath, &_contactDB) == SQLITE_OK)
    {
        char *errMsg;
        const char *sql_stmt =
        "CREATE TABLE IF NOT EXISTS MYUSER3 (name TEXT,pass TEXT,confirm TEXT  PRIMARY KEY)";
        
        if (sqlite3_exec(_contactDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
        {
            //_status.text = @"Failed to create table";
            printf("Failed to create table");
        }
        sqlite3_close(_contactDB);
    } else {
        //_status.text = @"Failed to open/create database";
        printf("Failed to open/create database");
    }
    

}
- (BOOL) validateEmail: (NSString *) candidate {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    // printf("the value of emailValidate %i\n ", [emailTest evaluateWithObject:candidate]);
    return [emailTest evaluateWithObject:candidate];
}


- (IBAction)login:(id)sender {
    if([_email.text isEqualToString:@""]||[_paas.text isEqualToString:@""]
       ){
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"error" message:@"not valid" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alertaction = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:alertaction];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else if(![self validateEmail:[_email text]]) {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"error" message:@"email not valid" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alertaction = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:alertaction];
        [self presentViewController:alert animated:YES completion:nil];
    }    else{
    const char *dbpath = [_databasePath UTF8String];
    sqlite3_stmt    *statement;
    
    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT name FROM MYUSER3 WHERE confirm=\"%@\"",_email.text];
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(_contactDB,
                               query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                Table1 *t = [Table1 new];
                [t setD:self];
               // [self.navigationController pushViewController:t animated:YES];
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
                //Table1 *vc = [storyboard instantiateViewControllerWithIdentifier:@"load"];
                MoviesTableTableViewController *mt=[storyboard instantiateViewControllerWithIdentifier:@"movies table"];
                
                [self presentViewController:mt animated:YES completion:nil];
                _memo = [NSUserDefaults standardUserDefaults];
                _loggedIn = true;
                [_memo setBool:_loggedIn forKey:@"logged"];
                
                
                //- nsuserdefalut -//
                NSUserDefaults *myDef = [NSUserDefaults standardUserDefaults];
                [myDef setBool:YES forKey:@"loadOnline"];
                
            //- loading data here-//
              
                
            }
            
            
            else {
                printf("from else");
                UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"error" message:@"email or password wrong" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *alertaction = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:nil];
                [alert addAction:alertaction];
                [self presentViewController:alert animated:YES completion:nil];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(_contactDB);
    }
    }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
