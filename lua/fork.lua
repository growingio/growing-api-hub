local http = require "resty.http"

local pairs = pairs
local log = ngx.log
local ERR = ngx.ERR
local setmetatable = setmetatable
local encode_args = ngx.encode_args

local _M = {
    _VERSION = "1.0.0",
    _AUTHOR = "Andy Ai"
}

local mt = { __index = _M }

function _M.exec(self)
    ngx.req.read_body()
    local args = ngx.req.get_uri_args()
    local non_empty = false
    for _, _ in pairs(args) do
        non_empty = true
        break
    end
    local query_string
    if non_empty then
        query_string = "?" .. encode_args(args)
    else
        query_string = ""
    end
    local headers = ngx.req.get_headers()
    headers["X-Real-IP"] = ngx.var.remote_addr

    if ngx.req.get_method() == 'POST' then
        local data = ngx.req.get_body_data()
        if data then
            body = data
        else
            local filename = ngx.req.get_body_file()
            if filename then
                handle = io.open(filename)
                body = handle:read '*a'
            else
                body = nil
            end
        end

        if not body then
            log(ERR, "Request Body is nil")
            return
        end

        local httpc = http.new()
        local res, err = httpc:request_uri("http://" .. self.host .. ngx.var.uri .. query_string, {
            method = "POST",
            body = body,
            headers = headers
        })
        if not res then
            log(ERR, "Fork :", err)
        end
    end

    if ngx.req.get_method() == 'GET' then
        local httpc = http.new()
        local res, err = httpc:request_uri("http://" .. self.host .. ngx.var.uri .. query_string, {
            method = "GET",
            headers = headers
        })
        if not res then
            log(ERR, "Fork :", err)
        end
    end


end

function _M.new(opts)
    local self = {
        host = opts.host or "127.0.0.1"
    }
    return setmetatable(self, mt)
end

return _M
