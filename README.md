##PYDropMenu

PYDropMenu is an easy way to add a dropping effect menu to parent view. 

<img src="https://github.com/Doubletaps76/PYDropMenu/blob/master/demo.gif" alt="PYDropMenu Screenshot" width="320" height="568">

## Usage

```obj-c
//setup
_dropMenu = [[PYDropMenu alloc] initWithTargetView:self.view];
_dropMenu.delegate = self;
_dropMenu.dataSource = self;

//show/hide the menu
[_dropMenu toggleMenu];
```

Then respond to the required methods:
```obj-c
//delegate
@required
- (void)pyDropMenuDidButtonClick:(PYDropMenu*)dropMenu withIndex:(NSInteger)index andSubIndex:(NSInteger)subIndex;

@optional
- (void)pyDropMenu:(PYDropMenu*)dropMenu getPYDropMenuButton:(UIButton*)button withIndex:(NSInteger)index;

- (void)pyDropMenu:(PYDropMenu*)dropMenu getPYDropMenuSubButton:(UIButton*)subbutton withIndex:(NSInteger)index andSubIndex:(NSInteger)subIndex;

//datasource
@required
- (NSInteger)numberOfButtonsInPYDropMenu:(PYDropMenu*)dropMenu;

- (NSString*)titleForButtonAtIndex:(NSInteger)buttonIndex withPYDropMenu:(PYDropMenu*)dropMenu;

@optional
- (NSInteger)numberOfSubBtnsInButton:(NSInteger)buttonIndex withPYDropMenu:(PYDropMenu*)dropMenu;

- (NSString*)titleForSubBtnsAtSubIndex:(NSInteger)subbuttonIndex andIndex:(NSInteger)buttonIndex withPYDropMenu:(PYDropMenu*)dropMenu;

```

##Adding to your project
```
platform :ios, '7'
    pod 'PYDropMenu'
```

##MIT License
-----------

Copyright (c) 2015 Tsau,Po-Yuan (tsaupoyuan.com)
Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
		
