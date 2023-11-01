local Logger = {}

local log = require('structlog')

Logger.name = 'dev'

Logger.pipelines = {
  {
    level = log.level.INFO,
    processors = {},
    formatter = log.formatters.Format(
      '%s',
      { 'msg' },
      { blacklist = { 'level', 'logger_name' } }
    ),
    ---@diagnostic disable-next-line: no-unknown
    sink = log.sinks.NvimNotify(),
  },
  {
    level = log.level.TRACE,
    processors = {
      log.processors.StackWriter({ 'line', 'file' }, { max_parents = 3 }),
      log.processors.Timestamper('%H:%M:%S'),
    },
    formatter = log.formatters.Format(
      '%s [%s] %s: %-30s',
      { 'timestamp', 'level', 'logger_name', 'msg' }
    ),
    ---@diagnostic disable-next-line: no-unknown
    sink = log.sinks.File(vim.fn.stdpath('config') .. '/log.txt'),
  },
}
log.configure({
  [Logger.name] = {
    pipelines = Logger.pipelines,
  },
})

Logger.logger = log.get_logger(Logger.name)

Logger.get_logger = function()
  if not Logger.logger then
    log.configure({
      [Logger.name] = {
        pipelines = Logger.pipelines,
      },
    })

    Logger.logger:trace('Created logger ', { name = Logger.name })
    return Logger.logger
  end

  return Logger.logger
end

---@type fun(msg: string, events: table<string, any>?)
Logger.error = function(msg, events)
  Logger.get_logger():error(msg, events)
end

---@type fun(msg: string, events: table<string, any>?)
Logger.warn = function(msg, events)
  Logger.get_logger():warn(msg, events)
end

---@type fun(msg: string, events: table<string, any>?)
Logger.info = function(msg, events)
  Logger.get_logger():info(msg, events)
end

---@type fun(msg: string, events: table<string, any>?)
Logger.trace = function(msg, events)
  Logger.get_logger():trace(msg, events)
end

return Logger
