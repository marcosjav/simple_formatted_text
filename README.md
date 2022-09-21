<p align="center">
<img src="https://github.com/marcosjav/simple_formatted_text/blob/master/img/example.jpg?raw=true" alt="Animated switch" />
</p>

---

Simple text widget to show formated text, including link text
</br>
Simple formatted text was made to allow you to customize text style with special chars. 

[![style: lint](https://img.shields.io/badge/style-lint-4BC0F5.svg)](https://pub.dev/packages/lint)   [![](https://img.shields.io/github/license/marcosjav/simple_formatted_text)](https://github.com/marcosjav/simple_formatted_text/blob/main/LICENSE) [![](https://img.shields.io/pub/v/simple_formatted_text)](https://img.shields.io/pub/v/simple_formatted_text)

---
## Quick Start

Import this library into your project:

```yaml
simple_formatted_text: ^latest_version
```

Or do:
```console
$ flutter pub add simple_formatted_text
```

## Basic Implementation

```dart

SimpleFormattedText("Text with *bold* word")

```


#### More possibilities

- Open URL
    ```dart
    SimpleFormattedText(    
        "Open [Google](https://google.com/) to search things",
        onLinkTap: (link) {
            // .. do stuff, not need to be only web links
            url_launch(link);
        },
    )
    ```
    <p align="center">
    <img src="https://github.com/marcosjav/simple_formatted_text/blob/master/img/link.jpg?raw=true" alt="Animated switch"/>
    </p>
</br>

- Text actions, with different text style
    ```dart
    SimpleFormattedText(
        "Do [action 1](action 1) or [action 2](action 2)",
        linkTextStyle: TextStyle(color: Colors.green),
        onLinkTap: (actionStr) {
            switch(actionStr) {
                case "action 1":
                    //...
                    break;
                case "action 2":
                    //...
                    break;
            },
        },
    )
    ```
    <p align="center">
    <img src="https://github.com/marcosjav/simple_formatted_text/blob/master/img/actions.jpg?raw=true" alt="Animated switch"/>
    </p>
</br>

- Change color and size, with an initial textstyle
    ```dart
    SimpleFormattedText(    
        "This is a _[big and red](addSize:4,color:#FFFF0000)_ string",
        style: TextStyle(color: Colors.deepPurple, fontSize: 20),
    )
    ```
    <p align="center">
    <img src="https://github.com/marcosjav/simple_formatted_text/blob/master/img/big_red.jpg?raw=true" alt="Animated switch"/>
    </p>
</br>
