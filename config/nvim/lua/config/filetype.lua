vim.filetype.add({
    pattern  = {
        [".*/.cloud/helm/.*.gotmpl"] = "helm",
        [".*/k8s/app/.*.gotmpl"] = "helm",
   },
})
