Name = "aiprompts"
NamePretty = "AI Prompts"
Icon = "google-chat"
Cache = true
HideFromProviderlist = false
Description = "Select from a list of AI prompts to use"
SearchName = true

local cachePromptPath = os.getenv("HOME") .. "/.cache/elephant/aiprompts.csv"

function DownloadPrompts()
    local prompts_url = "https://raw.githubusercontent.com/f/awesome-chatgpt-prompts/refs/heads/main/prompts.csv"
    os.execute("mkdir -p " .. os.getenv("HOME") .. "/.cache/elephant")
    os.execute("curl -o " .. cachePromptPath .. " " .. prompts_url)
end

function GetEntries()
    if not io.open(cachePromptPath, "r") then
        DownloadPrompts()
    end

    local entries = {}
    local file = io.open(cachePromptPath, "r")
    if not file then
        return entries
    end
    for line in file:lines() do
        local title, prompt, forDev = line:match('^"(.*)","(.*)",(.*)')
        if not title then
            goto continue
        end
        local encoded_prompt = string.gsub(prompt, "[^A-Za-z0-9_.-]", function(c)
            return string.format("%%%02X", string.byte(c))
        end)
        local actions = {
            chatgpt = "xdg-open https://chatgpt.com/?prompt=" .. encoded_prompt,
            copilot = "xdg-open https://github.com/copilot?prompt=" .. encoded_prompt,
        }
        table.insert(entries, {
            Text = title,
            Preview = prompt,
            PreviewType = "text",
            Actions = actions,
        })
        ::continue::
    end
    file:close()

    return entries
end
