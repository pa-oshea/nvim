local status_ok, numtoggle = pcall(require, "numbertoggle")
if not status_ok then
	return
end

numtoggle.setup()
