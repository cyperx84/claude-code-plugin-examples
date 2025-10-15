# Code Snippets Plugin

Code generation and refactoring commands demonstrating namespaced organization.

## Features

### Code Analysis
- `/explain @file` - Detailed code explanation with structure and suggestions

### Code Generation (Namespaced: /snippets/*)
- `/snippets/function [language] [name]` - Generate function templates
- `/snippets/class [language] [name]` - Generate class templates
- `/snippets/test @file` - Generate comprehensive test suites

### Refactoring (Namespaced: /refactor/*)
- `/refactor/extract [description]` - Extract code into reusable functions
- `/refactor/simplify @file` - Simplify complex code

## Installation

```bash
/plugin marketplace add /path/to/examples/01-beginner/code-snippets-plugin
/plugin install code-snippets-plugin@local
```

## Usage Examples

### Explain Code
```bash
# Analyze a specific file
/explain @src/utils/parser.ts

# Get comprehensive breakdown
/explain @components/UserProfile.tsx
```

### Generate Functions
```bash
# TypeScript function
/snippets/function typescript calculateTotal

# Python function
/snippets/function python process_data

# With interactive prompts
/snippets/function
```

### Generate Classes
```bash
# TypeScript class
/snippets/class typescript UserManager

# Python class
/snippets/class python DatabaseConnection

# Java class
/snippets/class java OrderProcessor
```

### Generate Tests
```bash
# Test a specific file
/snippets/test @src/auth/login.ts

# Test a function
/snippets/test calculateTotal

# Test a class
/snippets/test UserManager
```

### Refactoring
```bash
# Extract duplicated code
/refactor/extract calculate tax logic

# Simplify complex function
/refactor/simplify @src/utils/validator.ts
```

## Learning Points

This plugin demonstrates:

- ✅ **Namespaced commands** - Organize commands in subdirectories
  - `commands/snippets/` → `/snippets/function`
  - `commands/refactor/` → `/refactor/extract`

- ✅ **File references** - Using @filename syntax
  - `/explain @file.ts`
  - `/snippets/test @component.tsx`

- ✅ **Template generation** - Creating boilerplate code

- ✅ **Multi-language support** - Adapting to different languages

- ✅ **Code analysis** - Understanding and explaining existing code

- ✅ **Refactoring patterns** - Common code improvements

## Namespacing Benefits

Organizing commands in subdirectories:

```
commands/
├── explain.md               → /explain
├── snippets/
│   ├── function.md         → /snippets/function
│   ├── class.md            → /snippets/class
│   └── test.md             → /snippets/test
└── refactor/
    ├── extract.md          → /refactor/extract
    └── simplify.md         → /refactor/simplify
```

**Advantages:**
- Logical grouping of related commands
- Clearer command purposes
- Easier to discover related commands
- Better organization for large plugins

## Supported Languages

- **TypeScript/JavaScript** - Full support
- **Python** - Full support
- **Go** - Function and test generation
- **Rust** - Function templates
- **Java** - Class and test generation
- **C++** - Basic templates

## File Structure

```
code-snippets-plugin/
├── .claude-plugin/
│   └── plugin.json
├── commands/
│   ├── explain.md
│   ├── snippets/           # Namespaced: /snippets/*
│   │   ├── function.md
│   │   ├── class.md
│   │   └── test.md
│   └── refactor/           # Namespaced: /refactor/*
│       ├── extract.md
│       └── simplify.md
└── README.md
```

## Best Practices

1. **Always provide examples** in generated code
2. **Match project style** - Check existing code first
3. **Include documentation** - JSDoc, docstrings, etc.
4. **Add error handling** - Try/catch, error messages
5. **Generate tests** - Ensure code is testable
6. **Preserve behavior** - Don't break existing functionality

## Next Steps

Try:
1. Adding more language templates (Ruby, PHP, Swift)
2. Creating component generators (React, Vue, Angular)
3. Adding database model generators
4. Creating API endpoint templates
5. Moving to intermediate examples with agents
