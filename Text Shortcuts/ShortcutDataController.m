//
//  ShortcutDataController.m
//  Text Shortcuts
//
//  Created by Ken Szubzda on 4/19/12.
//  Copyright (c) 2012 University of California, Berkeley. All rights reserved.
//

#import "ShortcutDataController.h"
#import "Shortcut.h"

@implementation ShortcutDataController
@synthesize masterShortcutList = _masterShortcutList;

-(id) initWithPath:(NSString *)path {
    if (self = [super init]) {
        [self initializeDefaultDataListwithPath:path];
        return self;
    } 
    return nil;
}

- (void) initializeDefaultDataListwithPath:(NSString *)path {
    NSMutableArray *shortCutList = [[NSMutableArray alloc] init];
    shortCutList = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    NSLog(@"%d", [shortCutList count]);
    self.masterShortcutList = shortCutList;
}


- (void)setMasterShortcutList:(NSMutableArray *)newList {
    if (_masterShortcutList != newList) {
        _masterShortcutList = [newList mutableCopy];
    }
}

- (NSUInteger) countOfMasterShortcutList {
    return [self.masterShortcutList count];
}

- (Shortcut *) objectInMasterShortcutListAtIndex:(NSUInteger)index {
    return [self.masterShortcutList objectAtIndex:index];
}

- (void) addShortcutWithName:(NSString *)inputNickname phoneNum:(NSString *)number message:(NSString *)message {
    Shortcut *shortcut;
    shortcut = [[Shortcut alloc] initWithNickName:inputNickname number:number message:message];
    [self.masterShortcutList addObject:shortcut];
}

- (void) addShortcutWithName:(NSString *)inputNickname phoneNum:(NSString *)number message:(NSString *)message atIndex:(NSInteger) index {
    Shortcut *shortcut;
    shortcut = [[Shortcut alloc] initWithNickName:inputNickname number:number message:message];
    [self.masterShortcutList insertObject:shortcut atIndex:index];
}



@end
