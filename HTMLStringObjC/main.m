#import <Foundation/Foundation.h>
@import HTMLString;

@interface HTMLStringObjCTests : NSObject

@end

@implementation HTMLStringObjCTests

+ (void) invokeAll {
    
    [self testStringASCIIEscaping];
    [self testStringUnicodeEscaping];
    [self testUnescaping];
    
}

///
/// Tests escaping a string for ASCII.
///

+ (void) testStringASCIIEscaping {
    
    NSString *namedEscape = [@"Fish & Chips" stringByEscapingForASCIIHTML];
    NSLog(@"%hhd", [namedEscape  isEqual: @"Fish &#38; Chips"]);
    
    NSString *namedDualEscape = [@"a ⪰̸ b" stringByEscapingForASCIIHTML];
    NSLog(@"%hhd", [namedDualEscape  isEqual: @"a &#10928;&#824; b"]);
    
    NSString *emojiEscape = [@"Hey 🙃" stringByEscapingForASCIIHTML];
    NSLog(@"%hhd", [emojiEscape  isEqual: @"Hey &#128579;"]);
    
    NSString *doubleEmojiEscape = [@"Going to the 🇺🇸 next June" stringByEscapingForASCIIHTML];
    NSLog(@"%hhd", [doubleEmojiEscape  isEqual: @"Going to the &#127482;&#127480; next June"]);
    
}

///
/// Tests escaping a string for Unicode.
///

+ (void) testStringUnicodeEscaping {
    
    NSString *requiredEscape = [@"Fish & Chips" stringByEscapingForUnicodeHTML];
    NSLog(@"%hhd", [requiredEscape  isEqual: @"Fish &#38; Chips"]);
    
    NSString *namedDualEscape = [@"a ⪰̸ b" stringByEscapingForUnicodeHTML];
    NSLog(@"%hhd", [namedDualEscape  isEqual: @"a ⪰̸ b"]);
    
    NSString *emojiEscape = [@"Hey 🙃!" stringByEscapingForUnicodeHTML];
    NSLog(@"%hhd", [emojiEscape  isEqual: @"Hey 🙃&#33;"]);
    
    NSString *doubleEmojiEscape = [@"Going to the 🇺🇸 next June" stringByEscapingForUnicodeHTML];
    NSLog(@"%hhd", [doubleEmojiEscape  isEqual: @"Going to the 🇺🇸 next June"]);
    
}

// MARK: - Unescaping

///
/// Tests unescaping sequences.
///

+ (void) testUnescaping {
    
    NSString *withoutMarker = [@"Hello, world." stringByUnescapingFromHTML];
    NSLog(@"%hhd", [withoutMarker  isEqual: @"Hello, world."]);
    
    NSString *noSemicolon = [@"Fish & Chips" stringByUnescapingFromHTML];
    NSLog(@"%hhd", [noSemicolon  isEqual: @"Fish & Chips"]);
    
    NSString *decimal = [@"My phone number starts with a &#49;" stringByUnescapingFromHTML];
    NSLog(@"%hhd", [decimal  isEqual: @"My phone number starts with a 1"]);
    
    NSString *invalidDecimal = [@"My phone number starts with a &#4_9;!" stringByUnescapingFromHTML];
    NSLog(@"%hhd", [invalidDecimal  isEqual: @"My phone number starts with a &#4_9;!"]);
    
    NSString *hex = [@"Let's meet at the caf&#xe9;" stringByUnescapingFromHTML];
    NSLog(@"%hhd", [hex  isEqual: @"Let's meet at the café"]);
    
    NSString *invalidHex = [@"Let's meet at the caf&#xzi;!" stringByUnescapingFromHTML];
    NSLog(@"%hhd", [invalidHex  isEqual: @"Let's meet at the caf&#xzi;!"]);
    
    NSString *invalidUnicodePoint = [@"What is this character ? -> &#xd8ff;" stringByUnescapingFromHTML];
    NSLog(@"%hhd", [invalidUnicodePoint  isEqual: @"What is this character ? -> &#xd8ff;"]);
    
    NSString *badSequence = [@"I love &swift;" stringByUnescapingFromHTML];
    NSLog(@"%hhd", [badSequence  isEqual: @"I love &swift;"]);
    
    NSString *goodSequence = [@"Do you know &aleph;?" stringByUnescapingFromHTML];
    NSLog(@"%hhd", [goodSequence  isEqual: @"Do you know ℵ?"]);
    
    NSString *twoSequences = [@"a &amp;&amp; b" stringByUnescapingFromHTML];
    NSLog(@"%hhd", [twoSequences  isEqual: @"a && b"]);
    
    NSString *doubleEmojiEscape = [@"Going to the &#127482;&#127480; next June" stringByUnescapingFromHTML];
    NSLog(@"%hhd", [doubleEmojiEscape  isEqual: @"Going to the 🇺🇸 next June"]);
    
}

@end

#pragma mark Run

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        [HTMLStringObjCTests invokeAll];
    }
    return 0;
}
