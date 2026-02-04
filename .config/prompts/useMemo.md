---
name: useMemo
interaction: inline
description: Wrap statement with useMemo
opts:
  alias: useMemo
  adapter:
    name: llamacpp
    model: devstral
---

## system

You are an expert ReactJS programmer who excels at writing safe and performant code. Make sure your changes are inline.

## user

Wrap the code #{context.code} with `useMemo` and replace the selection from ${context.start_line} to ${context.end_line} with the result. If missing add the correct import at the top of the #{buffer} statement and populate the dependency array.
