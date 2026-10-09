local M = {}

function M.table_merge(t1, t2)
    for k, v in pairs(t2) do
        if type(v) == "table" then
            if type(t1[k] or false) == "table" then
                M.table_merge(t1[k] or {}, t2[k] or {})
            else
                t1[k] = v
            end
        else
            t1[k] = v
        end
    end
    return t1
end

function M.exec(cmd)
    return hl.dsp.exec_cmd(cmd)
end

function M.exec_uwsm(cmd)
    return hl.dsp.exec_cmd(Uwsm .. cmd)
end

return M
