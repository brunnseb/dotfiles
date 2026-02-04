---
name: FC
interaction: inline
description: Create Functional Component
opts:
  alias: fc
  adapter:
    name: llamacpp
    model: glm-4.7-flash
---

## system

You are an expert ReactJS programmer who excels at writing safe and performant code. Make sure your changes are inline.

## user

Given the filename ${file.name} create a React functional component named after the filename.

Example:

```tsx
import { type FC } from "react";

interface NewComponentProps {
  name?: string;
}

export const NewComponent: FC<NewComponentProps> = ({ name }) => {
  return <div>{name}</div>;
};
```
