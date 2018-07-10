# Wordpress Learning Note

Wordpress version: 4.9.6

## Create theme

All themes for worpdress are located in `wordpress\wp-content\themes\` directory. To create a new theme, at first, you should create a directory inside it, for example `wordpress\wp-content\themes\minhgdd\`.

Sample directory tree

```
.
├───wp-admin
├───wp-content
│   ├───themes
│   │   ├───minhgdd
│   │   │   ├───css
│   │   │   ├───js
│   │   │   └───template-parts
│   │   ├───twentyfifteen
│   │   │   ├───css
│   │   │   ├───genericons
│   │   │   ├───inc
│   │   │   └───js
│   │   ├───twentyseventeen
│   │   │   ├───assets
│   │   │   │   ├───css
│   │   │   │   ├───images
│   │   │   │   └───js
│   │   │   ├───inc
│   │   │   └───template-parts
│   │   │       ├───footer
│   │   │       ├───header
│   │   │       ├───navigation
│   │   │       ├───page
│   │   │       └───post
│   │   └───twentysixteen
│   │       ├───css
│   │       ├───genericons
│   │       ├───inc
│   │       ├───js
│   │       └───template-parts
│   └───uploads
│       └───2018
│           └───06
└───wp-includes
```

### Files explanation

|       File       |                                        Description                                        |
| ---------------- | ----------------------------------------------------------------------------------------- |
| `style.css`      | Required. This file is required for Wordpress to detect this directory a theme directory. |
| `screenshot.png` | Optional. This image displays on admin-site as a sample screenshot.                       |

#### style.css (required)

```css
/*
Theme Name: MinhGDD First Theme
Theme URI: http://example.com/minhgdd
Author: MinhGDD
Author URI: http://example.com/minhgdd
Description: This is MinhGDD's first theme for learning
Version: 1.0
License: GNU General Public License v2 or later
License URI: http://www.gnu.org/licenses/gpl-2.0.html
Tags: learning, minhgdd
Text Domain: minhgdd

This theme, like WordPress, is licensed under the GPL.
Use it to make something cool, have fun, and share what you've learned with others.

Source: https://codex.wordpress.org/Theme_Development#Theme_Stylesheet
*/
```