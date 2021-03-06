//
//  Created by Jesse Squires
//  http://www.hexedbits.com
//
//
//  Documentation
//  http://cocoadocs.org/docsets/JSQMessagesViewController
//
//
//  GitHub
//  https://github.com/jessesquires/JSQMessagesViewController
//
//
//  License
//  Copyright (c) 2014 Jesse Squires
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

#import "JSQMessage.h"

@implementation JSQMessage

#pragma mark - Initialization

+ (instancetype)messageWithText:(NSString *)text sender:(NSString *)sender identifier:(NSNumber *)identifier
{
    return [[JSQMessage alloc] initWithText:text sender:sender date:[NSDate date] identifier:identifier];
}

- (instancetype)initWithText:(NSString *)text
                      sender:(NSString *)sender
                        date:(NSDate *)date
				  identifier:(NSNumber *)identifier
{
    NSParameterAssert(text != nil);
    NSParameterAssert(sender != nil);
    NSParameterAssert(date != nil);
	NSParameterAssert(identifier != nil);
    
    self = [self init];
    if (self) {
        _text = text;
        _sender = sender;
        _date = date;
		_identifier = identifier;
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _text = @"";
        _sender = @"";
        _date = [NSDate date];
		_identifier = [NSNumber numberWithInt:0];
    }
    return self;
}

- (void)dealloc
{
    _text = nil;
    _sender = nil;
    _date = nil;
	_identifier = nil;
}

#pragma mark - JSQMessage

- (BOOL)isEqualToMessage:(JSQMessage *)aMessage
{
    return [self.text isEqualToString:aMessage.text]
            && [self.sender isEqualToString:aMessage.sender]
            && ([self.date compare:aMessage.date] == NSOrderedSame)
			&& [self.identifier isEqualToNumber:aMessage.identifier];
}

#pragma mark - NSObject

- (BOOL)isEqual:(id)object
{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    
    return [self isEqualToMessage:(JSQMessage *)object];
}

- (NSUInteger)hash
{
    return [self.text hash] ^ [self.sender hash] ^ [self.date hash] ^ [self.identifier hash];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@>[ %@, %@, %@, %@ ]", [self class], self.sender, self.date, self.text, self.identifier];
}

#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        _text = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(text))];
        _sender = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(sender))];
        _date = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(date))];
		_identifier = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(identifier))];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.text forKey:NSStringFromSelector(@selector(text))];
    [aCoder encodeObject:self.sender forKey:NSStringFromSelector(@selector(sender))];
    [aCoder encodeObject:self.date forKey:NSStringFromSelector(@selector(date))];
	[aCoder encodeObject:self.identifier forKey:NSStringFromSelector(@selector(identifier))];
}

#pragma mark - NSCopying

- (instancetype)copyWithZone:(NSZone *)zone
{
    return [[[self class] allocWithZone:zone] initWithText:[self.text copy]
                                                    sender:[self.sender copy]
                                                      date:[self.date copy]
												identifier:[self.identifier copy]];
}

@end
