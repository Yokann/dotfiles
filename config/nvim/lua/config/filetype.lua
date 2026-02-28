vim.filetype.add({
    pattern  = {
        [".*/.cloud/helm/.*.gotmpl"] = "helm",
        [".*/.cloud/charts/.*.gotmpl"] = "helm",
        [".*/k8s/app/.*.gotmpl"] = "helm",
    },
})
