//
//  ShortcutDataController.h
//  Text Shortcuts
//
//  Created by Ken Szubzda on 4/19/12.
//  Copyright (c) 2012 University of California, Berkeley. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Shortcut;

@interface ShortcutDataController : NSObject {

}

@property (nonatomic, copy) NSMutableArray *masterShortcutList;

-(id)initWithPath:(NSString *)path;
-(void) initializeDefaultDataListwithPath:(NSString*)path;
-(NSUInteger)countOfMasterShortcutList;
-(Shortcut *) objectInMasterShortcutListAtIndex:(NSUInteger)index;
-(void)addShortcutWithName:(NSString *)inputNickname 
                  phoneNum:(NSString *)number 
                   message:(NSString *)message;
-(void)addShortcutWithName:(NSString *)inputNickname phoneNum:(NSString *)number message:(NSString *)message atIndex:(NSInteger)index;

@end
