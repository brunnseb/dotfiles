---
name: Doc
interaction: inline
description: Add docstring or comment to selection
opts:
  alias: doc
  adapter:
    name: llamacpp
    model: devstral
---

## system

You are an expert programmer who excels at writing helpful and concise documentation. Make sure your changes are inline.

## user

Given the filetype ${context.filetype} write concise and helpful documentation for ${context.code}. Prepend the resulting documentation one line above the selection. Only add documentation to the top-level element of the selection and not to the internals.
