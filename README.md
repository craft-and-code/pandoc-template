# 📚 Pandoc Template for Document Layout

This Pandoc template provides a complete and elegant solution for converting Markdown files into professional-quality PDF and HTML documents. Perfect for creating books, technical documentation, academic reports, or training materials.

## 📋 Overview

This template focuses on:

- Professional document generation from Markdown,
- Support for both PDF and HTML outputs,
- Customizable layouts with typography optimization,
- Extended features through Lua filters,
- Comprehensive asset management.

## 📦 Installation

### Required Fonts

- [Anton](https://fonts.google.com/specimen/Anton) - Headings,
- [Glegoo](https://fonts.google.com/specimen/Glegoo) - Body text,
- [Lora](https://fonts.google.com/specimen/Lora) - Emphasis text,
- [Hack](https://sourcefoundry.org/hack/#download) - Source code,
- [Noto Emoji](https://fonts.google.com/noto/specimen/Noto+Emoji) - Emoji support,
- [Noto Sans Symbols](https://fonts.google.com/noto/specimen/Noto+Sans+Symbols) - Shortcuts support,
- [Noto Sans Symbols 2](https://fonts.google.com/noto/specimen/Noto+Sans+Symbols+2) - Shortcuts support.

### Required Tools

- [Pandoc](https://pandoc.org) (version ≥ 3.6.3)
- [Git](https://git-scm.com) (optional)

## 🚀 Quick Start

1. Clone the repository:
    ```bash
    git clone https://github.com/craft-and-code/pandoc-template.git
    ```
2. Install required dependencies (see Installation section)
3. Place your Markdown files in the `md/` folder
    > **Important**: Files must be numbered to ensure correct order (e.g., 01-intro.md, 02-chapter1.md)
4. Place your images in the `images/` folder at the root level
5. Generate your document:
    - For PDF: `pandoc -d defaults-pdf.yaml md/**/*.md -o book.pdf`
    - For HTML: `pandoc -d defaults-html.yaml md/**/*.md -o index.html`

## 🎯 Features

This template significantly enhances Pandoc’s default output by offering:

- Book-oriented layouts,
- Native emoji support,
- Professional rendering using LaTeX,
- Refined typography with reading-optimized fonts,
- Visually attractive and customizable alert blocks.

## ⚙️ Configuration & Advanced Features

### PDF Configuration

- `./assets/templates/template.tex`: Main LaTeX template,
- `./defaults-pdf.yaml`: Pandoc PDF configuration,
- `./sample.pdf`: Example output.

Before generating your PDF, open the `template.tex` file and update the *metadata* information.
In the `defaults-pdf.yaml` file, modify the `lang` parameter. Punctuation rules and quotation marks will be adjusted automatically based on the selected language.
If you want to change the table of contents title, update the `toc-title` parameter.

Important: If you change the main font, make sure it supports both *italic* and **bold** styles — or define a separate font for *italics*, as currently configured.

### HTML Configuration

- `./assets/templates/template.html`: HTML structure,
- `./defaults-html.yaml`: Pandoc HTML configuration,
- `./index.html`: Example output.

Open the `defaults-html.yaml` file and adjust the *metadata* parameter according to your document.

### Available Filters

- `alert-html`: Custom alert blocks for HTML,
- `alert`: Custom alert blocks (PDF),
- `center-images`: Automatic image centering (PDF),
- `emoji`: Full emoji support (PDF),
- `newpage`: Page break management,

### Custom Covers

The `assets/covers/` folder contains cover templates:

- `backcover.png`: Replace with your back cover image,
- `cover.png`: Replace with your front cover image.

An Inkscape source file (`assets/inkscape/cover.svg`) is provided for easy customization.

If you change the book format (e.g., page size or orientation), make sure to update the cover images accordingly to match the new dimensions.

### Page Breaks

You can insert manual page breaks in your Markdown files by using `+++` on a new line. This will create a page break in the PDF output. Please note that these `+++` markers will not appear in the generated HTML output.

### Typography Rules

The following typographic enhancements apply specifically to the PDF output:

- Automatic table of contents,
- Dynamic headers based on section titles,
- Optimized page numbering for binding,
- Smart punctuation handling based on language.

## 💧 Watermark (optional)

To enable the SPECIMEN watermark in the PDF, simply add `-V watermark` to your command. See the LaTeX template to adjust watermark settings (text, scale, angle, etc.).

## 🎨 Project Structure

### Assets Organization

The `assets/` directory contains all generation-related files:

- `covers/`: Contains cover images,
- `css/`: Stylesheets for HTML output customization,
- `filters/`: Lua filters for extended functionality,
- `html/`: HTML-specific files and partials for template composition,
- `icons/`: Various icons used in the documentation and templates,
- `inkscape/`: Source files for customizable vector graphics,
- `js/`: JavaScript files for HTML interactivity,
- `templates/`: Pandoc templates for both PDF and HTML outputs.

## 🤝 Contributing

We welcome all contributions! Here's how you can help:

1. **Report Bugs**: Use GitHub issues
2. **Suggest Improvements**: Open a discussion
3. **Code Contributions**:
    - Fork the repository,
    - Create a branch (`git checkout -b feature/improvement`),
    - Make your changes,
    - Push to your fork,
    - Open a Pull Request.

### Contribution Guidelines

- Follow existing code conventions,
- Add documentation for new features,
- Update documentation, `index.html` and `sample.pdf` when necessary,
- Test your changes in both PDF and HTML outputs.

## 📝 License

This project is licensed under the MIT License. See the `LICENSE.txt` file for details.
