//
//  NSString+UrlEncoding.m
//  SurfNewsHD
//
//  Created by yujiuyin on 13-1-5.
//  Copyright (c) 2013年 apple. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "NSString+Extensions.h"

@implementation NSString (UrlEncoding)

//utf8 encoding by default
-(NSString*) urlEncodedString
{
    CFStringRef str = CFURLCreateStringByAddingPercentEscapes(NULL,(CFStringRef)self,NULL,(CFStringRef)@"!*'();:@&=+$,/?%#[]",kCFStringEncodingUTF8);
    NSString *encodedString = [((__bridge NSString *)str) copy];
    CFRelease(str);
    return encodedString;
}

-(NSString*) urlEncodedGbkString
{
    CFStringRef str = CFURLCreateStringByAddingPercentEscapes(NULL,(CFStringRef)self,NULL,(CFStringRef)@"!*'();:@&=+$,/?%#[]",kCFStringEncodingGB_18030_2000);
    NSString *encodedString = [((__bridge NSString *)str) copy];
    CFRelease(str);
    return encodedString;
}

//utf8 encoding by default
-(NSString*) urlDecodedString
{
    CFStringRef str = CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                              (__bridge CFStringRef) self,
                                                                              CFSTR(""),
                                                                              kCFStringEncodingUTF8);
    NSString* ret = [(__bridge NSString *)str copy];
    CFRelease(str);
        return ret ;
}


@end

typedef struct {
    __unsafe_unretained NSString *escapeSequence;
    unichar uchar;
} HTMLEscapeMap;

// Taken from http://www.w3.org/TR/xhtml1/dtds.html#a_dtd_Special_characters
// Ordered by uchar lowest to highest for bsearching
static HTMLEscapeMap gAsciiHTMLEscapeMap[] = {
    // A.2.2. Special characters
    { @"&quot;", 34 },
    { @"&amp;", 38 },
    { @"&apos;", 39 },
    { @"&lt;", 60 },
    { @"&gt;", 62 },
    
    // A.2.1. Latin-1 characters
    { @"&nbsp;", 160 },
    { @"&iexcl;", 161 },
    { @"&cent;", 162 },
    { @"&pound;", 163 },
    { @"&curren;", 164 },
    { @"&yen;", 165 },
    { @"&brvbar;", 166 },
    { @"&sect;", 167 },
    { @"&uml;", 168 },
    { @"&copy;", 169 },
    { @"&ordf;", 170 },
    { @"&laquo;", 171 },
    { @"&not;", 172 },
    { @"&shy;", 173 },
    { @"&reg;", 174 },
    { @"&macr;", 175 },
    { @"&deg;", 176 },
    { @"&plusmn;", 177 },
    { @"&sup2;", 178 },
    { @"&sup3;", 179 },
    { @"&acute;", 180 },
    { @"&micro;", 181 },
    { @"&para;", 182 },
    { @"&middot;", 183 },
    { @"&cedil;", 184 },
    { @"&sup1;", 185 },
    { @"&ordm;", 186 },
    { @"&raquo;", 187 },
    { @"&frac14;", 188 },
    { @"&frac12;", 189 },
    { @"&frac34;", 190 },
    { @"&iquest;", 191 },
    { @"&Agrave;", 192 },
    { @"&Aacute;", 193 },
    { @"&Acirc;", 194 },
    { @"&Atilde;", 195 },
    { @"&Auml;", 196 },
    { @"&Aring;", 197 },
    { @"&AElig;", 198 },
    { @"&Ccedil;", 199 },
    { @"&Egrave;", 200 },
    { @"&Eacute;", 201 },
    { @"&Ecirc;", 202 },
    { @"&Euml;", 203 },
    { @"&Igrave;", 204 },
    { @"&Iacute;", 205 },
    { @"&Icirc;", 206 },
    { @"&Iuml;", 207 },
    { @"&ETH;", 208 },
    { @"&Ntilde;", 209 },
    { @"&Ograve;", 210 },
    { @"&Oacute;", 211 },
    { @"&Ocirc;", 212 },
    { @"&Otilde;", 213 },
    { @"&Ouml;", 214 },
    { @"&times;", 215 },
    { @"&Oslash;", 216 },
    { @"&Ugrave;", 217 },
    { @"&Uacute;", 218 },
    { @"&Ucirc;", 219 },
    { @"&Uuml;", 220 },
    { @"&Yacute;", 221 },
    { @"&THORN;", 222 },
    { @"&szlig;", 223 },
    { @"&agrave;", 224 },
    { @"&aacute;", 225 },
    { @"&acirc;", 226 },
    { @"&atilde;", 227 },
    { @"&auml;", 228 },
    { @"&aring;", 229 },
    { @"&aelig;", 230 },
    { @"&ccedil;", 231 },
    { @"&egrave;", 232 },
    { @"&eacute;", 233 },
    { @"&ecirc;", 234 },
    { @"&euml;", 235 },
    { @"&igrave;", 236 },
    { @"&iacute;", 237 },
    { @"&icirc;", 238 },
    { @"&iuml;", 239 },
    { @"&eth;", 240 },
    { @"&ntilde;", 241 },
    { @"&ograve;", 242 },
    { @"&oacute;", 243 },
    { @"&ocirc;", 244 },
    { @"&otilde;", 245 },
    { @"&ouml;", 246 },
    { @"&divide;", 247 },
    { @"&oslash;", 248 },
    { @"&ugrave;", 249 },
    { @"&uacute;", 250 },
    { @"&ucirc;", 251 },
    { @"&uuml;", 252 },
    { @"&yacute;", 253 },
    { @"&thorn;", 254 },
    { @"&yuml;", 255 },
    
    // A.2.2. Special characters cont'd
    { @"&OElig;", 338 },
    { @"&oelig;", 339 },
    { @"&Scaron;", 352 },
    { @"&scaron;", 353 },
    { @"&Yuml;", 376 },
    
    // A.2.3. Symbols
    { @"&fnof;", 402 },
    
    // A.2.2. Special characters cont'd
    { @"&circ;", 710 },
    { @"&tilde;", 732 },
    
    // A.2.3. Symbols cont'd
    { @"&Alpha;", 913 },
    { @"&Beta;", 914 },
    { @"&Gamma;", 915 },
    { @"&Delta;", 916 },
    { @"&Epsilon;", 917 },
    { @"&Zeta;", 918 },
    { @"&Eta;", 919 },
    { @"&Theta;", 920 },
    { @"&Iota;", 921 },
    { @"&Kappa;", 922 },
    { @"&Lambda;", 923 },
    { @"&Mu;", 924 },
    { @"&Nu;", 925 },
    { @"&Xi;", 926 },
    { @"&Omicron;", 927 },
    { @"&Pi;", 928 },
    { @"&Rho;", 929 },
    { @"&Sigma;", 931 },
    { @"&Tau;", 932 },
    { @"&Upsilon;", 933 },
    { @"&Phi;", 934 },
    { @"&Chi;", 935 },
    { @"&Psi;", 936 },
    { @"&Omega;", 937 },
    { @"&alpha;", 945 },
    { @"&beta;", 946 },
    { @"&gamma;", 947 },
    { @"&delta;", 948 },
    { @"&epsilon;", 949 },
    { @"&zeta;", 950 },
    { @"&eta;", 951 },
    { @"&theta;", 952 },
    { @"&iota;", 953 },
    { @"&kappa;", 954 },
    { @"&lambda;", 955 },
    { @"&mu;", 956 },
    { @"&nu;", 957 },
    { @"&xi;", 958 },
    { @"&omicron;", 959 },
    { @"&pi;", 960 },
    { @"&rho;", 961 },
    { @"&sigmaf;", 962 },
    { @"&sigma;", 963 },
    { @"&tau;", 964 },
    { @"&upsilon;", 965 },
    { @"&phi;", 966 },
    { @"&chi;", 967 },
    { @"&psi;", 968 },
    { @"&omega;", 969 },
    { @"&thetasym;", 977 },
    { @"&upsih;", 978 },
    { @"&piv;", 982 },
    
    // A.2.2. Special characters cont'd
    { @"&ensp;", 8194 },
    { @"&emsp;", 8195 },
    { @"&thinsp;", 8201 },
    { @"&zwnj;", 8204 },
    { @"&zwj;", 8205 },
    { @"&lrm;", 8206 },
    { @"&rlm;", 8207 },
    { @"&ndash;", 8211 },
    { @"&mdash;", 8212 },
    { @"&lsquo;", 8216 },
    { @"&rsquo;", 8217 },
    { @"&sbquo;", 8218 },
    { @"&ldquo;", 8220 },
    { @"&rdquo;", 8221 },
    { @"&bdquo;", 8222 },
    { @"&dagger;", 8224 },
    { @"&Dagger;", 8225 },
    // A.2.3. Symbols cont'd
    { @"&bull;", 8226 },
    { @"&hellip;", 8230 },
    
    // A.2.2. Special characters cont'd
    { @"&permil;", 8240 },
    
    // A.2.3. Symbols cont'd
    { @"&prime;", 8242 },
    { @"&Prime;", 8243 },
    
    // A.2.2. Special characters cont'd
    { @"&lsaquo;", 8249 },
    { @"&rsaquo;", 8250 },
    
    // A.2.3. Symbols cont'd
    { @"&oline;", 8254 },
    { @"&frasl;", 8260 },
    
    // A.2.2. Special characters cont'd
    { @"&euro;", 8364 },
    
    // A.2.3. Symbols cont'd
    { @"&image;", 8465 },
    { @"&weierp;", 8472 },
    { @"&real;", 8476 },
    { @"&trade;", 8482 },
    { @"&alefsym;", 8501 },
    { @"&larr;", 8592 },
    { @"&uarr;", 8593 },
    { @"&rarr;", 8594 },
    { @"&darr;", 8595 },
    { @"&harr;", 8596 },
    { @"&crarr;", 8629 },
    { @"&lArr;", 8656 },
    { @"&uArr;", 8657 },
    { @"&rArr;", 8658 },
    { @"&dArr;", 8659 },
    { @"&hArr;", 8660 },
    { @"&forall;", 8704 },
    { @"&part;", 8706 },
    { @"&exist;", 8707 },
    { @"&empty;", 8709 },
    { @"&nabla;", 8711 },
    { @"&isin;", 8712 },
    { @"&notin;", 8713 },
    { @"&ni;", 8715 },
    { @"&prod;", 8719 },
    { @"&sum;", 8721 },
    { @"&minus;", 8722 },
    { @"&lowast;", 8727 },
    { @"&radic;", 8730 },
    { @"&prop;", 8733 },
    { @"&infin;", 8734 },
    { @"&ang;", 8736 },
    { @"&and;", 8743 },
    { @"&or;", 8744 },
    { @"&cap;", 8745 },
    { @"&cup;", 8746 },
    { @"&int;", 8747 },
    { @"&there4;", 8756 },
    { @"&sim;", 8764 },
    { @"&cong;", 8773 },
    { @"&asymp;", 8776 },
    { @"&ne;", 8800 },
    { @"&equiv;", 8801 },
    { @"&le;", 8804 },
    { @"&ge;", 8805 },
    { @"&sub;", 8834 },
    { @"&sup;", 8835 },
    { @"&nsub;", 8836 },
    { @"&sube;", 8838 },
    { @"&supe;", 8839 },
    { @"&oplus;", 8853 },
    { @"&otimes;", 8855 },
    { @"&perp;", 8869 },
    { @"&sdot;", 8901 },
    { @"&lceil;", 8968 },
    { @"&rceil;", 8969 },
    { @"&lfloor;", 8970 },
    { @"&rfloor;", 8971 },
    { @"&lang;", 9001 },
    { @"&rang;", 9002 },
    { @"&loz;", 9674 },
    { @"&spades;", 9824 },
    { @"&clubs;", 9827 },
    { @"&hearts;", 9829 },
    { @"&diams;", 9830 }
};

// Taken from http://www.w3.org/TR/xhtml1/dtds.html#a_dtd_Special_characters
// This is table A.2.2 Special Characters
static HTMLEscapeMap gUnicodeHTMLEscapeMap[] = {
    // C0 Controls and Basic Latin
    { @"&quot;", 34 },
    { @"&amp;", 38 },
    { @"&apos;", 39 },
    { @"&lt;", 60 },
    { @"&gt;", 62 },
    
    // Latin Extended-A
    { @"&OElig;", 338 },
    { @"&oelig;", 339 },
    { @"&Scaron;", 352 },
    { @"&scaron;", 353 },
    { @"&Yuml;", 376 },
    
    // Spacing Modifier Letters
    { @"&circ;", 710 },
    { @"&tilde;", 732 },
    
    // General Punctuation
    { @"&ensp;", 8194 },
    { @"&emsp;", 8195 },
    { @"&thinsp;", 8201 },
    { @"&zwnj;", 8204 },
    { @"&zwj;", 8205 },
    { @"&lrm;", 8206 },
    { @"&rlm;", 8207 },
    { @"&ndash;", 8211 },
    { @"&mdash;", 8212 },
    { @"&lsquo;", 8216 },
    { @"&rsquo;", 8217 },
    { @"&sbquo;", 8218 },
    { @"&ldquo;", 8220 },
    { @"&rdquo;", 8221 },
    { @"&bdquo;", 8222 },
    { @"&dagger;", 8224 },
    { @"&Dagger;", 8225 },
    { @"&permil;", 8240 },
    { @"&lsaquo;", 8249 },
    { @"&rsaquo;", 8250 },
    { @"&euro;", 8364 },
};


// Utility function for Bsearching table above
static int EscapeMapCompare(const void *ucharVoid, const void *mapVoid) {
    const unichar *uchar = (const unichar*)ucharVoid;
    const HTMLEscapeMap *map = (const HTMLEscapeMap*)mapVoid;
    int val;
    if (*uchar > map->uchar) {
        val = 1;
    } else if (*uchar < map->uchar) {
        val = -1;
    } else {
        val = 0;
    }
    return val;
}

@implementation NSString (HtmlEncoding)

- (NSString *)stringByEscapingHTMLUsingTable:(HTMLEscapeMap*)table
                                          ofSize:(NSUInteger)size
                                 escapingUnicode:(BOOL)escapeUnicode {
    NSUInteger length = [self length];
    if (!length) {
        return self;
    }
    
    NSMutableString *finalString = [NSMutableString string];
    NSMutableData *data2 = [NSMutableData dataWithCapacity:sizeof(unichar) * length];
    
    // this block is common between GTMNSString+HTML and GTMNSString+XML but
    // it's so short that it isn't really worth trying to share.
    const unichar *buffer = CFStringGetCharactersPtr((CFStringRef)self);
    if (!buffer) {
        // We want this buffer to be autoreleased.
        NSMutableData *data = [NSMutableData dataWithLength:length * sizeof(UniChar)];
        if (!data) {
            // COV_NF_START  - Memory fail case
            //_GTMDevLog(@"couldn't alloc buffer");
            return nil;
            // COV_NF_END
        }
        [self getCharacters:[data mutableBytes]];
        buffer = [data bytes];
    }
    
    if (!buffer || !data2) {
        // COV_NF_START
        //_GTMDevLog(@"Unable to allocate buffer or data2");
        return nil;
        // COV_NF_END
    }
    
    unichar *buffer2 = (unichar *)[data2 mutableBytes];
    
    NSUInteger buffer2Length = 0;
    
    for (NSUInteger i = 0; i < length; ++i) {
        HTMLEscapeMap *val = bsearch(&buffer[i], table,
                                     size / sizeof(HTMLEscapeMap),
                                     sizeof(HTMLEscapeMap), EscapeMapCompare);
        if (val || (escapeUnicode && buffer[i] > 127)) {
            if (buffer2Length) {
                CFStringAppendCharacters((CFMutableStringRef)finalString,
                                         buffer2,
                                         buffer2Length);
                buffer2Length = 0;
            }
            if (val) {
                [finalString appendString:val->escapeSequence];
            }
            else {
                //_GTMDevAssert(escapeUnicode && buffer[i] > 127, @"Illegal Character");
                [finalString appendFormat:@"&#%d;", buffer[i]];
            }
        } else {
            buffer2[buffer2Length] = buffer[i];
            buffer2Length += 1;
        }
    }
    if (buffer2Length) {
        CFStringAppendCharacters((CFMutableStringRef)finalString,
                                 buffer2,
                                 buffer2Length);
    }
    return finalString;
}

- (NSString *)stringByEscapingForHTML {
    return [self stringByEscapingHTMLUsingTable:gUnicodeHTMLEscapeMap
                                             ofSize:sizeof(gUnicodeHTMLEscapeMap)
                                    escapingUnicode:NO];
} // gtm_stringByEscapingHTML

- (NSString *)stringByEscapingForAsciiHTML {
    return [self stringByEscapingHTMLUsingTable:gAsciiHTMLEscapeMap
                                             ofSize:sizeof(gAsciiHTMLEscapeMap)
                                    escapingUnicode:YES];
} // gtm_stringByEscapingAsciiHTML

- (NSString *)stringByUnescapingFromHTML {
    NSRange range = NSMakeRange(0, [self length]);
    NSRange subrange = [self rangeOfString:@"&" options:NSBackwardsSearch range:range];
    
    // if no ampersands, we've got a quick way out
    if (subrange.length == 0) return self;
    NSMutableString *finalString = [NSMutableString stringWithString:self];
    do {
        NSRange semiColonRange = NSMakeRange(subrange.location, NSMaxRange(range) - subrange.location);
        semiColonRange = [self rangeOfString:@";" options:0 range:semiColonRange];
        range = NSMakeRange(0, subrange.location);
        // if we don't find a semicolon in the range, we don't have a sequence
        if (semiColonRange.location == NSNotFound) {
            continue;
        }
        NSRange escapeRange = NSMakeRange(subrange.location, semiColonRange.location - subrange.location + 1);
        NSString *escapeString = [self substringWithRange:escapeRange];
        NSUInteger length = [escapeString length];
        // a squence must be longer than 3 (&lt;) and less than 11 (&thetasym;)
        if (length > 3 && length < 11) {
            if ([escapeString characterAtIndex:1] == '#') {
                unichar char2 = [escapeString characterAtIndex:2];
                if (char2 == 'x' || char2 == 'X') {
                    // Hex escape squences &#xa3;
                    NSString *hexSequence = [escapeString substringWithRange:NSMakeRange(3, length - 4)];
                    NSScanner *scanner = [NSScanner scannerWithString:hexSequence];
                    unsigned value;
                    if ([scanner scanHexInt:&value] &&
                        value < USHRT_MAX &&
                        value > 0
                        && [scanner scanLocation] == length - 4) {
                        unichar uchar = (unichar)value;
                        NSString *charString = [NSString stringWithCharacters:&uchar length:1];
                        [finalString replaceCharactersInRange:escapeRange withString:charString];
                    }
                    
                } else {
                    // Decimal Sequences &#123;
                    NSString *numberSequence = [escapeString substringWithRange:NSMakeRange(2, length - 3)];
                    NSScanner *scanner = [NSScanner scannerWithString:numberSequence];
                    int value;
                    if ([scanner scanInt:&value] && 
                        value < USHRT_MAX &&
                        value > 0 
                        && [scanner scanLocation] == length - 3) {
                        unichar uchar = (unichar)value;
                        NSString *charString = [NSString stringWithCharacters:&uchar length:1];
                        [finalString replaceCharactersInRange:escapeRange withString:charString];
                    }
                }
            } else {
                // "standard" sequences
                for (unsigned i = 0; i < sizeof(gAsciiHTMLEscapeMap) / sizeof(HTMLEscapeMap); ++i) {
                    if ([escapeString isEqualToString:gAsciiHTMLEscapeMap[i].escapeSequence]) {
                        [finalString replaceCharactersInRange:escapeRange withString:[NSString stringWithCharacters:&gAsciiHTMLEscapeMap[i].uchar length:1]];
                        break;
                    }
                }
            }
        }
    } while ((subrange = [self rangeOfString:@"&" options:NSBackwardsSearch range:range]).length != 0);
    return finalString;
} // gtm_stringByUnescapingHTML

@end

@implementation NSString (OtherExtentions)

+(BOOL) isString:(NSString*)s1 logicallEqualsToString:(NSString*)s2
{
    if(s1 == nil || [s1 isEmptyOrBlank]) {
        if(s2 == nil || [s2 isEmptyOrBlank]) {
            return YES;
        } else {
            return NO;
        }
    } else {
        if(s2 == nil || [s2 isEmptyOrBlank]) {
            return NO;
        } else {
            return [s1 isEqualToString:s2];
        }
    }
}

-(NSString*) completeUrl
{
    if([self hasPrefixCaseInsensitive:@"http://"] || [self hasPrefixCaseInsensitive:@"https://"] || [self hasPrefixCaseInsensitive:@"ftp://"])
        return [self trim];
    else
        return [[@"http://" stringByAppendingString:self] trim];
}

-(NSString*) trim
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

-(NSString*) trimLeft
{
    NSInteger i = 0;
    NSCharacterSet* cs = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    while ((i < [self length])
           && [cs characterIsMember:[self characterAtIndex:i]]) {
        i++;
    }
    return [self substringFromIndex:i];
}

-(NSUInteger) indexOfString:(NSString*)str
{
    return [self rangeOfString:str].location;
}

-(BOOL) contains:(NSString*)str
{
    return [self rangeOfString:str].location != NSNotFound;
}

-(BOOL) containsCasInsensitive:(NSString*)str
{
    return [self rangeOfString:str options:NSCaseInsensitiveSearch].location != NSNotFound;
}

-(NSUInteger) lastIndexOfString:(NSString*)str
{
    return [self rangeOfString:str options:NSBackwardsSearch].location;
}

-(BOOL) isEqualToStringCaseInsensitive:(NSString *)aString
{
    return [self caseInsensitiveCompare:aString] == NSOrderedSame;
}

-(BOOL) hasPrefixCaseInsensitive:(NSString*)prefix
{
    return [self rangeOfString:prefix options:NSCaseInsensitiveSearch].location == 0;
}
-(BOOL) hasSuffixCaseInsensitive:(NSString *)suffix
{
    return [self rangeOfString:suffix options:NSCaseInsensitiveSearch | NSBackwardsSearch].location == ([self length] - [suffix length]);
}
-(BOOL) isEmptyOrBlank
{
    if([self length] == 0) { //string is empty or nil
        return YES;
    }
    
    if(![[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length])
    {
        //string is all whitespace
        return YES;
    }
    
    return NO;
}

- (BOOL)isEmailValid{
    NSString* regex = @"^[A-Za-z0-9._%+-]+@[A-Za-z0-9._%+-]+\\.[A-Za-z0-9._%+-]+$";
    NSPredicate *regextest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    if ([regextest evaluateWithObject:self] == YES) {
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)isMobileNumber{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:self] == YES)
        || ([regextestcm evaluateWithObject:self] == YES)
        || ([regextestct evaluateWithObject:self] == YES)
        || ([regextestcu evaluateWithObject:self] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}


-(NSStringEncoding) convertToStringEncoding
{
    CFStringEncoding cfEncoding = CFStringConvertIANACharSetNameToEncoding((CFStringRef) self);
    return CFStringConvertEncodingToNSStringEncoding(cfEncoding);
}

-(BOOL)isChinaMobileNumber
{
    NSString *regexString = @"^[1][3-8]\\d{9}$";
    NSPredicate *emailFormat = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexString];
    return [emailFormat evaluateWithObject:self];
}

-(BOOL) isVersionLowerThan:(NSString*)version
{
    return [self compare:version options:NSNumericSearch] == NSOrderedAscending;
}
-(BOOL) isVersionLowerThanOrEqualsTo:(NSString*)version
{
    return [self compare:version options:NSNumericSearch] != NSOrderedDescending;
}
-(BOOL) isVersionEqualsTo:(NSString*)version
{
    return [self compare:version options:NSNumericSearch] == NSOrderedSame;
}
-(BOOL) isVersionHigherThan:(NSString*)version
{
    return [self compare:version options:NSNumericSearch] == NSOrderedDescending;
}
-(BOOL) isVersionHigherThanOrEqualsTo:(NSString*)version
{
    return [self compare:version options:NSNumericSearch] != NSOrderedAscending;
}
+(NSString*) readableStringWithBytes:(long long)bytes
{
    if(bytes > 1024 * 1024 * 1024)
    {
        return [NSString stringWithFormat:@"%.2fGB",bytes * 1.0 / 1024 / 1024 / 1024];
    }
    else if(bytes > 1024 * 1024)
    {
        return [NSString stringWithFormat:@"%.2fMB",bytes * 1.0 / 1024 / 1024];
    }
    else if(bytes > 1024)
    {
        return [NSString stringWithFormat:@"%.2fkB",bytes * 1.0 / 1024];
    }
    else
        return [NSString stringWithFormat:@"%dB",(int)bytes];
}

+ (NSString *)generateUniqueString:(NSString *)string
{
    CFUUIDRef uuidRef =CFUUIDCreate(NULL);
    
    CFStringRef uuidStringRef =CFUUIDCreateString(NULL, uuidRef);
    
    CFRelease(uuidRef);
    
    return [NSString stringWithFormat:@"%@%@", string, (__bridge NSString *)uuidStringRef];
}
@end