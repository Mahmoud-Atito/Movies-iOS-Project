//
//  JETSDBConnection.m
//  DBAndCachingApp
//
//  Created by AM_Alsherpiny on 9/8/17.
//  Copyright (c) 2017 JETS. All rights reserved.
//
//@^_^-AM_Alsherpiny-^_^@//

#import "JETSDBConnection.h"

@implementation JETSDBConnection

/*-!! atteention
 see what will happen when i create two objects
 */
//- init function -//
//1- here i created the movieDB.db and get its path.
//2- then i create a table on the DB to cach the data within it.
- (id)init
{
    self = [super init];
    if (self) {
    //- that is the step NO_1 -//
        // create a folder in the document directory for image
        
        // retrive all the avilable paths in the phone to store the DB
        // then get the first path and append it by the name of the DB
        NSArray *myAvilable = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        _DBPath = [[NSString alloc] initWithString:[[myAvilable objectAtIndex:0] stringByAppendingPathComponent:@"dataBase00.db"]];
        
        // create a folder for img and paths
        //_imgDirectPath = [[NSString alloc] initWithString:[myAvilable objectAtIndex:0]];

        //NSLog(@"that is the path %@\n", _DBPath);
        
    //- that is the step NO_2 -//
        // first i will try to connect on the DB if succeded i will.
        // the caching table.
    
        //NSLog(@"that is the value of my path %@", _DBPath);
        //NSLog(@"that is the value of my connection %d", sqlite3_open([_DBPath UTF8String], &_DBCon));
        
        if (sqlite3_open([_DBPath UTF8String], &_DBCon) == SQLITE_OK ) {
            
            NSLog(@"connection happened on create");
            // create the sql statement
            NSString *sqlStmt = @"CREATE TABLE IF NOT EXISTS MOVIES (NAME TEXT, RATE INTEGER, PHOTO TEXT, DETAILS TEXT, YEAR INTEGER)";
            // execute the sql statement
            char *errorMsg;
            if (sqlite3_exec(_DBCon, [sqlStmt UTF8String], NULL, NULL, &errorMsg) != SQLITE_OK) {
                NSLog(@"failed to create table get that error %s", errorMsg);
            }
            sqlite3_close(_DBCon);
        } else {
            NSLog(@"failed to connect to the DB");
        }
    }
    return self;
    
    
}//# the end of init function #//


/* @....atteention....@
    need for editing use the mechanizm of
    editing in a table
 */
//- refreshDB function -//
// use this function when the user log out.
-(void)refreshDB {
    if (sqlite3_open([_DBPath UTF8String], &_DBCon)) {
        NSString *sqlStmt = @"DROP TABLE IF EXIST MOVIES";
        
        char *errorMsg;
        if (sqlite3_exec(_DBCon, [sqlStmt UTF8String], NULL, NULL, &errorMsg) != SQLITE_OK) {
            NSLog(@"failed to create table get that error %s", errorMsg);
        }
        sqlite3_close(_DBCon);
    } else {
        NSLog(@"failed to connect to the DB");
    }
}//# the end of refreshDB function #//


//- addRaw function -//
// this func take an object of type movie and
// put the detail of it in the data base
-(void)addRow:(JETSMovie *)movieRow {
    printf("that is the result of add row %d", sqlite3_open([_DBPath UTF8String], &_DBCon));
    if (sqlite3_open([_DBPath UTF8String], &_DBCon) == SQLITE_OK) {
        NSString *sqlStmt = [NSString stringWithFormat:@"INSERT INTO MOVIES (NAME, RATE, DETAILS, PHOTO, YEAR) VALUES (\"%@\", \"%i\", \"%@\", \"%@\", \"%i\")", [movieRow name], [movieRow rate], [movieRow details], [movieRow photo], [movieRow year]];
        // to add in any table i use this mechanisme
        // not like creating a table
        /* ....the mechanizm explaination....
           - at first i create my sql statement.
           - then i use the func sqlite3_prepare_v2.
           - then i use the func sqlite3_step.
           - then i use finalize method to commit the editing.
         */
        sqlite3_stmt *mySqlStmt;
        sqlite3_prepare_v2(_DBCon, [sqlStmt UTF8String], -1, &mySqlStmt, nil);
        
        if (sqlite3_step(mySqlStmt) == SQLITE_DONE) {
            NSLog(@"you have just added a new row");
        } else {
            NSLog(@"couldn't add the new row");
        }
        sqlite3_finalize(mySqlStmt);
        sqlite3_close(_DBCon);
    } else {
        NSLog(@"failed to connect to the DB");
    }
    
    
}//# the end of addRow function #//

-(NSMutableArray *)retriveRows {
    NSMutableArray *movies = [NSMutableArray new];
    JETSMovie *myMovie;
    sqlite3_stmt *mySqlStmt;
    NSString *sqlStmt;
    if (sqlite3_open([_DBPath UTF8String], &_DBCon) == SQLITE_OK) {
        sqlStmt = @"select name, rate, details, photo, year from movies";
        if (sqlite3_prepare_v2(_DBCon, [sqlStmt UTF8String], -1, &mySqlStmt, nil) == SQLITE_OK) {
            while (sqlite3_step(mySqlStmt) == SQLITE_ROW) {
                myMovie = [JETSMovie new];
                
                myMovie.name = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(mySqlStmt, 0)];
                myMovie.rate = [[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(mySqlStmt, 1)] intValue];
                myMovie.details = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(mySqlStmt, 2)];
                myMovie.photo = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(mySqlStmt, 3)];
                
                myMovie.year = [[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(mySqlStmt, 4)] intValue];
                
                [movies addObject:myMovie];
            }
        } else {
            NSLog(@"failed at retriving");
        }
    } else {
        NSLog(@"failed to open DB at retriving");
    }
    
    return movies;
}

@end
