---
name: useCallback
interaction: inline
description: Wrap statement with useCallback
opts:
  alias: useCallback
  adapter:
    name: llamacpp
    model: devstral
---

## system

You are an expert ReactJS programmer who excels at writing safe and performant code. Make sure your changes are inline.

## user

Wrap the code #{context.code} with `useCallback` and replace the selection from ${context.start_line} to ${context.end_line} with the result. If missing add the correct import statement at the top of the #{buffer} and populate the dependency array.
