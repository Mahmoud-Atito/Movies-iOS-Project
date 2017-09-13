//
//  JETSDBConnection.h
//  DBAndCachingApp
//
//  Created by AM_Alsherpiny on 9/8/17.
//  Copyright (c) 2017 JETS. All rights reserved.
//

//@^_^-AM_Alsherpiny-^_^@//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "JETSMovie.h"
#import "SDWebImageDownloader.h"

@interface JETSDBConnection : NSObject

@property NSString *DBPath;
@property NSString *imgDirectPath;
// creating it as nonatomic to support multi threading
@property (nonatomic) sqlite3 *DBCon;

-(void) refreshDB;
-(void) addRow:(JETSMovie*) movieRow;
-(NSMutableArray*) retriveRows;



@end
