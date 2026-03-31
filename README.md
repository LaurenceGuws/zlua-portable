# zlua-portable

Small reusable Zig helpers for embedding Lua 5.4 through the C API.

Current surface:

- `api.State`: Lua state lifecycle and stack helpers
- `api.TableIter`: table iteration
- `reader.Reader`: typed table access helpers for config-style Lua tables

## Status

This package is intentionally small. It extracts the generic Lua runtime pieces
from `zbar` so other Zig projects such as `zide` can depend on one shared code
path instead of copying the same helpers.

## Requirements

- Zig `0.15.2`
- Lua 5.4 development headers and library available through `pkg-config`

## Usage

Add the package as a dependency, then import it from your build graph:

```zig
const lua_pkg = b.dependency("zlua_portable", .{
    .target = target,
    .optimize = optimize,
});

exe.root_module.addImport("zlua_portable", lua_pkg.module("zlua_portable"));
exe.linkLibC();
exe.root_module.linkSystemLibrary("lua5.4", .{ .use_pkg_config = .force });
```

Then in Zig:

```zig
const zlua_portable = @import("zlua_portable");
const api = zlua_portable.api;
const reader = zlua_portable.reader;
```
