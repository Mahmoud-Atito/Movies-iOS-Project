//
//  signup.m
//  project1
//
//  Created by Sayed Abdo on 9/9/17.
//  Copyright © 2017 Sayed Abdo. All rights reserved.
//

#import "signup.h"
#import "Table1.h"
#import "MoviesTableTableViewController.h"

@interface signup ()

@end

@implementation signup

- (void)viewDidLoad {
    [super viewDidLoad];
   UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"backg.png"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"user1.png"]];
    [usrpic addSubview:imageView];
    
    
    
    _email.layer.cornerRadius=10.0;
    _passw.layer.cornerRadius=10.5;
    _name.layer.cornerRadius=10.0;
    _confirm.layer.cornerRadius=10.5;
    _sign.layer.cornerRadius=10.5;
    _btnbrowes.layer.cornerRadius=10.5;
    imageview.layer.cornerRadius=10.5;
    // Do any additional setup after loading the view.
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
        "CREATE TABLE IF NOT EXISTS MYUSER3 (name TEXT,pass TEXT,email TEXT  PRIMARY KEY)";
        
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
- (IBAction)signup:(id)sender {
    NSString *name    =   _name.text;
    NSString *email   =   _email.text;
    NSString *pass    =   _passw.text;
    NSString *confirm = _confirm.text;
    if([name isEqualToString:@""]||[email isEqualToString:@""]||
      [pass isEqualToString:@""]||
       [confirm isEqualToString:@""]||![pass isEqualToString:confirm]
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
    }
    else{
    const char *dbpath1 = [_databasePath UTF8String];
    sqlite3_stmt    *statement;
    if (sqlite3_open(dbpath1, &_contactDB) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat:
                               @"INSERT INTO MYUSER3 (name,pass,confirm) VALUES (\"%@\",\"%@\",\"%@\")",
                               _name.text,_passw.text,_email.text];
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(_contactDB, insert_stmt, -1, &statement, NULL);
        if (sqlite3_step(statement)==SQLITE_DONE)
        {
            _ta = [Table1 new];
            [_ta setD:self];
            //[self.navigationController pushViewController:_ta animated:YES];
           // UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
           //Table1 *vc = [storyboard instantiateViewControllerWithIdentifier:@"load"];
           // [self presentViewController:vc animated:YES completion:nil];
            
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


            
        }
        
        else {
            UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"error" message:@"email already exist" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *alertaction = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:alertaction];
            [self presentViewController:alert animated:YES completion:nil];

        }
        sqlite3_finalize(statement);
        sqlite3_close(_contactDB);
    }
    
}
}
/*- (void)resetDefaults {
    NSUserDefaults * defs = [NSUserDefaults standardUserDefaults];
    NSDictionary * dict = [defs dictionaryRepresentation];
    for (id key in dict) {
        [defs removeObjectForKey:key];
    }
    [defs synchronize];
}*/
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)browse:(id)sender {
    picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    [picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController:picker animated:YES completion:NULL];
    usrpic.hidden = YES;
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [imageview setImage:image];
    [self dismissViewControllerAnimated:YES completion:NULL];
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:NULL];
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
