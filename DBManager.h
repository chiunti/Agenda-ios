//
//  DBManager.h
//  Agenda
//
//  Created by Chiunti on 04/02/15.
//  Copyright (c) 2015 Chiunti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DBManager : NSObject
{
    NSString *databasePath;
}
+(DBManager*)getSharedInstance;
-(BOOL)createDB;
-(NSMutableArray*) executeQueryWithString:(NSString*)querySQL;
@end