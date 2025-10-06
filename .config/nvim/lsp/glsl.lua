---@brief
---
--- https://github.com/nolanderc/glsl_analyzer
---
--- Language server for GLSL

---@type vim.lsp.Config
return {
    cmd = { 'glsl_analyzer' },
    filetypes = { 'glsl', 'vert', 'vs', 'tesc', 'tese', 'frag', 'fs', 'geom', 'comp' },
    root_markers = { '.git' },
    capabilities = {},
}
