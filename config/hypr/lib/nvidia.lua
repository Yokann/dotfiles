local M = {}

M.loadEnv = function()
    -- Nvidia specific env vars
    hl.env("GBM_BACKEND", "nvidia-drm", true)
    hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia", true)
    hl.env("LIBVA_DRIVER_NAME", "nvidia", true)
    hl.env("WLR_NO_HARDWARE_CURSORS", "1", true)

    -- next line require libva-vdpau-driver
    hl.env("NVD_BACKEND", "direct", true)
end

return M
