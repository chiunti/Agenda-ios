//
//  DBManager.m
//  Agenda
//
//  Created by Chiunti on 04/02/15.
//  Copyright (c) 2015 Chiunti. All rights reserved.
//

#import "DBManager.h"

static NSString    *dataBaseFile = @"pushCounter.db";
static const char  *CreateTable  = "create table if not exists Users (id integer primary key autoincrement, name text, status text, song text, photo blob)";
static DBManager *sharedInstance = nil;
static sqlite3         *database = nil;
static sqlite3_stmt   *statement = nil;


@implementation DBManager
+(DBManager*)getSharedInstance{
    if (!sharedInstance) {
        sharedInstance = [[super allocWithZone:NULL]init];
        [sharedInstance createDB];
    }
    return sharedInstance;
}

-(BOOL)createDB{
    NSString *docsDir;
    NSArray *dirPaths;
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    //docsDir = [dirPaths objectAtIndex:0];
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString:
                    [docsDir stringByAppendingPathComponent: dataBaseFile ]];
    BOOL isSuccess = YES;
    NSFileManager *filemgr = [NSFileManager defaultManager];
    if ([filemgr fileExistsAtPath: databasePath ] == NO)
    {
        const char *dbpath = [databasePath UTF8String];
        if (sqlite3_open(dbpath, &database) == SQLITE_OK)
        {
            char *errMsg;
            const char *sql_stmt = CreateTable;
            if (sqlite3_exec(database, sql_stmt, NULL, NULL, &errMsg)
                != SQLITE_OK)
            {
                isSuccess = NO;
                NSLog(@"Failed to create table %s",errMsg);
            }
            sqlite3_close(database);
            return  isSuccess;
        }
        else {
            isSuccess = NO;
            NSLog(@"Failed to open/create database");
        }
    }
    return isSuccess;
}


-(NSMutableArray*) executeQueryWithString:(NSString*)querySQL;
{
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(database,query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            NSMutableArray *resultArray = [[NSMutableArray alloc]init];
            int intColumnCount = sqlite3_column_count(statement);
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSMutableArray *msRec = [[NSMutableArray alloc]init];
                for (int intCol=0; intCol < intColumnCount; intCol++) {
                    switch (sqlite3_column_type(statement, intCol)) {
                        case SQLITE_NULL:
                            [msRec addObject:nil];
                        case SQLITE_INTEGER:
                            [msRec addObject:[[NSNumber alloc] initWithInt: sqlite3_column_int(statement, intCol)]];
                            break;
                        case SQLITE_FLOAT:
                            [msRec addObject:[[NSNumber alloc] initWithFloat: sqlite3_column_double(statement, intCol)]];
                            break;
                        case SQLITE_TEXT:
                            [msRec addObject:[[NSString alloc ] initWithUTF8String:(const char *)sqlite3_column_text(statement, intCol)]];
                            break;
                        case SQLITE_BLOB:
                            [msRec addObject:[[NSData alloc] initWithBytes:sqlite3_column_blob(statement, intCol) length:sqlite3_column_bytes(statement, intCol)]];
                            break;
                            
                        default:
                            break;
                    }
                    
                }
                [resultArray addObject:msRec];
            }
            sqlite3_reset(statement);
            return resultArray;
        }
    }
    return nil;
    
}


@end