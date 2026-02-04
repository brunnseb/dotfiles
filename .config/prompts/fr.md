---
name: FR
interaction: inline
description: Translate to French
opts:
  alias: fr
  adapter:
    name: llamacpp
    model: devstral
---

## system

You are an expert translator who excels at translating technical texts to French. Make sure your changes are inline.

## user

Translate the text ${context.code} to French and replace the selection with the result.
