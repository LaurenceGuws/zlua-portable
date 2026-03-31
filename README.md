# zlua-portable

Small reusable Zig helpers for embedding Lua 5.4 through the C API.

[![Release](https://img.shields.io/github/v/release/LaurenceGuws/zlua-portable?include_prereleases&label=release)](https://github.com/LaurenceGuws/zlua-portable/releases)
[![Used By](https://img.shields.io/badge/used%20by-zide-1f6feb)](https://github.com/LaurenceGuws/Zide)
[![Used By](https://img.shields.io/badge/used%20by-zbar-bb6b20)](https://github.com/LaurenceGuws/zbar)

Current surface:

- `api.State`: Lua state lifecycle and stack helpers
- `api.TableIter`: table iteration
- `reader.Reader`: typed table access helpers for config-style Lua tables

## Related Projects

- [Zide](https://github.com/LaurenceGuws/Zide) consumes `zlua-portable` as the
  shared low-level Lua package for its config layer.
- [zbar](https://github.com/LaurenceGuws/zbar) consumes `zlua-portable` for its
  schema-backed Lua config loading path.

## Status

This package is intentionally small. It extracts the generic Lua runtime pieces
from `zbar` so other Zig projects such as `zide` can depend on one shared code
path instead of copying the same helpers.

Current published version line:

- package version: `0.1.0-beta.1`
- release tag: `v0.1.0-beta.1`

## Requirements

- Zig `0.15.2`
- Lua 5.4 development headers and library available through `pkg-config`

## Usage

For local sibling development:

```zig
.zlua_portable = .{
    .path = "../zlua-portable",
},
```

For pinned release-tag consumption:

```bash
zig fetch --save git+https://github.com/LaurenceGuws/zlua-portable#v0.1.0-beta.1
```

Then wire the dependency into your build graph:

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

Release notes:

- [v0.1.0-beta.1](docs/releases/v0.1.0-beta.1.md)
