// Generated by Apple Swift version 2.1 (swiftlang-700.1.101.6 clang-700.1.76)
#pragma clang diagnostic push

#if defined(__has_include) && __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wauto-import"
#include <objc/NSObject.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#if defined(__has_include) && __has_include(<uchar.h>)
# include <uchar.h>
#elif !defined(__cplusplus) || __cplusplus < 201103L
typedef uint_least16_t char16_t;
typedef uint_least32_t char32_t;
#endif

typedef struct _NSZone NSZone;

#if !defined(SWIFT_PASTE)
# define SWIFT_PASTE_HELPER(x, y) x##y
# define SWIFT_PASTE(x, y) SWIFT_PASTE_HELPER(x, y)
#endif
#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
#endif

#if defined(__has_attribute) && __has_attribute(objc_runtime_name)
# define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
#else
# define SWIFT_RUNTIME_NAME(X)
#endif
#if defined(__has_attribute) && __has_attribute(swift_name)
# define SWIFT_COMPILE_NAME(X) __attribute__((swift_name(X)))
#else
# define SWIFT_COMPILE_NAME(X)
#endif
#if !defined(SWIFT_CLASS_EXTRA)
# define SWIFT_CLASS_EXTRA
#endif
#if !defined(SWIFT_PROTOCOL_EXTRA)
# define SWIFT_PROTOCOL_EXTRA
#endif
#if !defined(SWIFT_ENUM_EXTRA)
# define SWIFT_ENUM_EXTRA
#endif
#if !defined(SWIFT_CLASS)
# if defined(__has_attribute) && __has_attribute(objc_subclassing_restricted) 
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# else
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# endif
#endif

#if !defined(SWIFT_PROTOCOL)
# define SWIFT_PROTOCOL(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
# define SWIFT_PROTOCOL_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
#endif

#if !defined(SWIFT_EXTENSION)
# define SWIFT_EXTENSION(M) SWIFT_PASTE(M##_Swift_, __LINE__)
#endif

#if !defined(OBJC_DESIGNATED_INITIALIZER)
# if defined(__has_attribute) && __has_attribute(objc_designated_initializer)
#  define OBJC_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
# else
#  define OBJC_DESIGNATED_INITIALIZER
# endif
#endif
#if !defined(SWIFT_ENUM)
# define SWIFT_ENUM(_type, _name) enum _name : _type _name; enum SWIFT_ENUM_EXTRA _name : _type
#endif
typedef float swift_float2  __attribute__((__ext_vector_type__(2)));
typedef float swift_float3  __attribute__((__ext_vector_type__(3)));
typedef float swift_float4  __attribute__((__ext_vector_type__(4)));
typedef double swift_double2  __attribute__((__ext_vector_type__(2)));
typedef double swift_double3  __attribute__((__ext_vector_type__(3)));
typedef double swift_double4  __attribute__((__ext_vector_type__(4)));
typedef int swift_int2  __attribute__((__ext_vector_type__(2)));
typedef int swift_int3  __attribute__((__ext_vector_type__(3)));
typedef int swift_int4  __attribute__((__ext_vector_type__(4)));
#if defined(__has_feature) && __has_feature(modules)
@import UIKit;
@import CoreGraphics;
@import Foundation;
#endif

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"
@class NSCoder;
@class FormViewController;

SWIFT_CLASS("_TtC6Eureka8BaseCell")
@interface BaseCell : UITableViewCell
@property (nonatomic, copy) CGFloat (^ __nullable height)(void);
- (nullable instancetype)initWithCoder:(NSCoder * __nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString * __nullable)reuseIdentifier OBJC_DESIGNATED_INITIALIZER;
- (FormViewController * __nullable)formViewController;
- (void)setup;
- (void)update;
- (void)didSelect;
- (void)highlight;
- (void)unhighlight;
- (BOOL)cellCanBecomeFirstResponder;
- (BOOL)cellBecomeFirstResponder;
- (BOOL)cellResignFirstResponder;
@end

@class UITableView;
@class NavigationAccessoryView;
@class NSBundle;
@class UIStoryboardSegue;

SWIFT_CLASS("_TtC6Eureka18FormViewController")
@interface FormViewController : UIViewController
@property (nonatomic, strong) IBOutlet UITableView * __nullable tableView;
@property (nonatomic, strong) NavigationAccessoryView * __nonnull navigationAccessoryView;
- (nonnull instancetype)initWithStyle:(UITableViewStyle)style;
- (nonnull instancetype)initWithNibName:(NSString * __nullable)nibNameOrNil bundle:(NSBundle * __nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * __nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
- (void)viewDidLoad;
- (void)viewWillAppear:(BOOL)animated;
- (void)viewDidDisappear:(BOOL)animated;
- (void)prepareForSegue:(UIStoryboardSegue * __nonnull)segue sender:(id __nullable)sender;
@end

@class UIScrollView;

@interface FormViewController (SWIFT_EXTENSION(Eureka)) <UIScrollViewDelegate>
- (void)scrollViewWillBeginDragging:(UIScrollView * __nonnull)scrollView;
@end

@class NSNotification;

@interface FormViewController (SWIFT_EXTENSION(Eureka))
- (void)keyboardWillShow:(NSNotification * __nonnull)notification;
- (void)keyboardWillHide:(NSNotification * __nonnull)notification;
@end

@class NSIndexPath;

@interface FormViewController (SWIFT_EXTENSION(Eureka)) <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView * __nonnull)tableView;
- (NSInteger)tableView:(UITableView * __nonnull)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell * __nonnull)tableView:(UITableView * __nonnull)tableView cellForRowAtIndexPath:(NSIndexPath * __nonnull)indexPath;
- (NSString * __nullable)tableView:(UITableView * __nonnull)tableView titleForHeaderInSection:(NSInteger)section;
- (NSString * __nullable)tableView:(UITableView * __nonnull)tableView titleForFooterInSection:(NSInteger)section;
@end


@interface FormViewController (SWIFT_EXTENSION(Eureka))
@end


@interface FormViewController (SWIFT_EXTENSION(Eureka))
@end

@class UIView;

@interface FormViewController (SWIFT_EXTENSION(Eureka)) <UITableViewDelegate>
- (void)tableView:(UITableView * __nonnull)tableView willDisplayCell:(UITableViewCell * __nonnull)cell forRowAtIndexPath:(NSIndexPath * __nonnull)indexPath;
- (NSIndexPath * __nullable)tableView:(UITableView * __nonnull)tableView willSelectRowAtIndexPath:(NSIndexPath * __nonnull)indexPath;
- (void)tableView:(UITableView * __nonnull)tableView didSelectRowAtIndexPath:(NSIndexPath * __nonnull)indexPath;
- (CGFloat)tableView:(UITableView * __nonnull)tableView heightForRowAtIndexPath:(NSIndexPath * __nonnull)indexPath;
- (CGFloat)tableView:(UITableView * __nonnull)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath * __nonnull)indexPath;
- (UIView * __nullable)tableView:(UITableView * __nonnull)tableView viewForHeaderInSection:(NSInteger)section;
- (UIView * __nullable)tableView:(UITableView * __nonnull)tableView viewForFooterInSection:(NSInteger)section;
- (CGFloat)tableView:(UITableView * __nonnull)tableView heightForHeaderInSection:(NSInteger)section;
- (CGFloat)tableView:(UITableView * __nonnull)tableView heightForFooterInSection:(NSInteger)section;
@end


SWIFT_CLASS("_TtC6Eureka21ImagePickerController")
@interface ImagePickerController : UIImagePickerController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, copy) void (^ __nullable completionCallback)(UIViewController * __nonnull);
- (void)viewDidLoad;
- (void)imagePickerController:(UIImagePickerController * __nonnull)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *, id> * __nonnull)info;
- (void)imagePickerControllerDidCancel:(UIImagePickerController * __nonnull)picker;
- (nonnull instancetype)initWithNavigationBarClass:(Class __nullable)navigationBarClass toolbarClass:(Class __nullable)toolbarClass OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithRootViewController:(UIViewController * __nonnull)rootViewController OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithNibName:(NSString * __nullable)nibNameOrNil bundle:(NSBundle * __nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * __nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


@interface NSExpression (SWIFT_EXTENSION(Eureka))
@end


@interface NSPredicate (SWIFT_EXTENSION(Eureka))
@end


@interface NSURL (SWIFT_EXTENSION(Eureka))
@end

@class UIBarButtonItem;
@class UITouch;
@class UIEvent;

SWIFT_CLASS("_TtC6Eureka23NavigationAccessoryView")
@interface NavigationAccessoryView : UIToolbar
@property (nonatomic, strong) UIBarButtonItem * __nonnull previousButton;
@property (nonatomic, strong) UIBarButtonItem * __nonnull nextButton;
@property (nonatomic, strong) UIBarButtonItem * __nonnull doneButton;
- (nonnull instancetype)initWithFrame:(CGRect)frame OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * __nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
- (void)touchesBegan:(NSSet<UITouch *> * __nonnull)touches withEvent:(UIEvent * __nullable)event;
@end


@interface UIView (SWIFT_EXTENSION(Eureka))
- (UIView * __nullable)findFirstResponder;
- (BaseCell * __nullable)formCell;
@end

#pragma clang diagnostic pop
