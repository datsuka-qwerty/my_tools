local app_name = "VlcPrevNext"
local app_sig = "[" .. app_name .. "]"
local app_version = "0.1.2"
local app_title = app_name .. " " .. app_version
local app_description = "Adds previous and next files from the same directory to the playlist."
local app_short_desc = "Load prev/next file"

local media_extensions = {".mp4", ".mkv", ".avi", ".mov", ".mp3", ".flac", ".m4v", ".wmv", ".mpeg", ".mpg"}

-- VLC HOOKS
---------------------------
function descriptor()
    return {
        title = app_title,
        version = app_version,
        author = "djomlastic / Cross-platform Fix",
        description = app_description,
        shortdesc = app_short_desc,
        capabilities = {"input-listener"}
    }
end

function activate()
    log(" active.")
    input_changed()
end

function deactivate()
    log(" over and out.")
end

function meta_changed()
    return false
end

function input_changed()
    local item = vlc.item or vlc.input.item()
    if not item then
        log(" didn't find vlc.item.")
        return
    end

    if item:metas()[app_name] then
        return
    end

    load_prev_next(item)
    item:set_meta(app_name, "File processed.")
end

-- FUNCTIONS
------------------------------------------------------------------------------
function load_prev_next(item)
    if not clean_vlc_playlist() then
        log(" could not clean vlc playlist.")
        return
    end

    local dir_path = get_directory_path(item)
    local dir_file_names = vlc.net.opendir(dir_path)
    
    if not dir_file_names then
        log(" could not open directory: " .. tostring(dir_path))
        return
    end

    local media_file_names = get_valid_files(dir_file_names, media_extensions)
    local media_files_count = #media_file_names

    if media_files_count < 2 then
        log(" didn't find adjacent media files.")
        return
    end

    table.sort(media_file_names, is_first_string_less)

    local current_media_file_index = find_key(get_file_name(item), media_file_names)
    if not current_media_file_index then
        log(" current file not found within valid media files.")
        return
    end

    if media_file_names[current_media_file_index - 1] then
        add_file_to_playlist(media_file_names[current_media_file_index - 1], dir_path)
        last_file_to_first_position()
    elseif media_files_count >= 3 then
        add_file_to_playlist(media_file_names[media_files_count], dir_path)
        last_file_to_first_position()
    end

    if media_file_names[current_media_file_index + 1] then
        add_file_to_playlist(media_file_names[current_media_file_index + 1], dir_path)
    elseif media_files_count >= 3 then
        add_file_to_playlist(media_file_names[1], dir_path)
    end
end

-- WindowsとLinuxのパスの違いをURI文字列の正規表現で直接吸収
function get_directory_path(item)
    local dir_uri = item:uri():match("(.*[/\\])")
    local decoded_uri = vlc.strings.decode_uri(dir_uri)
    
    -- Windows判定 (例: file:///C:/...)
    if decoded_uri:match("^file:///[a-zA-Z]:") then
        return decoded_uri:sub(9) 
    end
    
    -- Linux/Unix判定 (例: file:///home/...)
    if decoded_uri:match("^file:///") then
        return decoded_uri:sub(8) 
    end
    
    return decoded_uri:gsub("^file://", "")
end

function get_file_name(item)
    local file_name = item:uri():match("([^/\\]*)$")
    return vlc.strings.decode_uri(file_name)
end

function get_valid_files(files, valid_extensions)
    local valid_files = {}
    for key, file_path in pairs(files) do
        if is_file_extension_valid(file_path, valid_extensions) then
            table.insert(valid_files, file_path)
        end
    end
    return valid_files
end

function is_file_extension_valid(file_path, valid_extensions)
    local extension = file_path:match("(%.[^%.]*)$")
    if not extension or extension == "" then return false end
    
    extension = extension:lower()
    for key, value in pairs(valid_extensions) do
        if value == extension then return true end
    end
    return false
end

function clean_vlc_playlist()
    local current_item_id = vlc.playlist.current()
    if not current_item_id then return false end

    local playlist = vlc.playlist.get("playlist")
    if not playlist or not playlist.children then return false end

    for index, item in pairs(playlist.children) do
        if item.id and item.id ~= current_item_id then
            vlc.playlist.delete(item.id)
        end
    end
    return true
end

-- プレイリスト追加時もパス形式に応じたURIを動的に生成
function add_file_to_playlist(file_name, directory_path)
    local item = {}
    local full_path = directory_path .. file_name
    
    -- Windows形式のパスかどうかで分岐
    if full_path:match("^[a-zA-Z]:") then
        item.path = "file:///" .. full_path:gsub("\\", "/")
    else
        item.path = "file://" .. full_path
    end
    
    vlc.playlist.enqueue({item})
end

function last_file_to_first_position()
    local playlist = vlc.playlist.get("playlist")
    if not playlist or not playlist.id or not playlist.children or #playlist.children < 2 then return end
    vlc.playlist.move(playlist.children[#playlist.children].id, playlist.id)
end

-- HELPERS
------------------------------------------------------------------------------
function is_first_string_less(first, second)
    local first_length = #first
    local second_length = #second
    local counter = (first_length < second_length) and first_length or second_length

    for i = 1, counter do
        if first:sub(i, i) ~= second:sub(i, i) then
            return first:sub(i, i) < second:sub(i, i)
        end
    end
    return first_length < second_length
end

function find_key(needle, haystack)
    if type(haystack) ~= "table" then return nil end
    for key, value in pairs(haystack) do
        if value == needle then return key end
    end
    return nil
end

function log(message)
    vlc.msg.dbg(app_sig .. message)
end

function dump(var)
    if type(var) == "table" then
        local output = "{ "
        for key, value in pairs(var) do
            if type(key) ~= "number" then key = "\"" .. key .. "\"" end
            output = output .. "["..key.."] = " .. dump(value) .. ","
        end
        return output .. "} "
    else
        return tostring(var)
    end
end